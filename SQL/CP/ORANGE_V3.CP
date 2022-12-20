-------------------------------------------------------------------
--
-- Fichier              :       ORANGE_V3.CP
-- Auteur               :       FABRY JF
-- Date                 :       29/05/2013
--
-- Commentaires         :       Gestion de la table ORANGE_V3
--
-- Procédures           :       
--
-- sysadm.PS_IU_INCR_TENT_DEBIT_CAUTION
-- sysadm.PS_MAJ_XML_COUR_ORANGEV3 
-- sysadm.PS_S_COUR_RESTIT_1REL_PRET_HV
-- sysadm.PS_S_COUR_RESTIT_2REL_PRET_HV
-- sysadm.PS_S_COUR_RESTIT_PRET_HV
-- sysadm.PS_S_COURKSL_GEOLOCATION_DT150
-- sysadm.PS_S_COURKSL_PM287_3_INFO_MANQUANTE
-- sysadm.PS_S_DOS_ELIG_ENCAISS_PAYBOX
-- sysadm.PS_S_DOS_ELIG_RECREDIT_PAYBOX
-- sysadm.PS_S_DOS_ELIG_REL_PAYBOX
-- sysadm.PS_S_REL_COUR_PCE_PROC_VERB
-- sysadm.PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS
-- sysadm.PS_S_XML_COUR_CONF_CMDE_HONOREE
-- sysadm.PS_S_XML_COUR_ENCAISS_PAYBOX
-- sysadm.PS_S_XML_COUR_ORANGEV3 
-- sysadm.PS_S_XML_COUR_RECREDIT_PAYBOX
-- sysadm.PS_S_XML_COUR_RECUP_PRET_SUR_BRIS
-- sysadm.PS_S_XML_ECHEC_DISTRIB_M2_M3
-- sysadm.PS_U_COUR_CONF_CMDE_HONOREE -- N'est plus utilisé
-- sysadm.PS_U_COUR_RECUP_PRET_SUR_BRIS -- N'est plus utilisé
-- sysadm.PS_U_COUR_RESTIT_1REL_PRET_HV -- Dernier 04/12/2019
-- sysadm.PS_U_COUR_RESTIT_2REL_PRET_HV -- Dernier 04/12/2019
-- sysadm.PS_U_COUR_RESTIT_PRET_HV -- Dernier 04/12/2019
-- sysadm.PS_U_COURKSL_GEOLOCATION_DT150 -- N'est plus utilisé
-- sysadm.PS_U_COURKSL_PM287_3_INFO_MANQUANTE -- !!! Utilisé !!! en lien avec KSL
-- sysadm.PS_U_PAYBOX_RETOUR_DEBIT -- Il y a des données mais sûrement écrite par SIMPA2 (l'appli) pas par la PS
-- sysadm.PS_U_PAYBOX_RETOUR_NUMTRANS -- Il y a des données mais sûrement écrite par SIMPA2 (l'appli) pas par la PS
-- sysadm.PS_U_RCP_PROCES_VERBAL -- !!! Utilisé !!! sans lien avec KSL
-- sysadm.PS_U_REL_COUR_PCE_ENVOYEE -- N'est plus utilisé
-- sysadm.PS_U_REL_COUR_REF_ENVOYEE -- N'est plus utilisé
-- sysadm.PS_U_XML_ECHEC_DISTRIB_M2_M3 -- N'est plus utilisé
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PAYBOX_RETOUR_NUMTRANS
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PAYBOX_RETOUR_NUMTRANS' AND type = 'P' )
        DROP procedure sysadm.PS_U_PAYBOX_RETOUR_NUMTRANS
GO

CREATE procedure sysadm.PS_U_PAYBOX_RETOUR_NUMTRANS
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asNumTrans	 VarChar ( 35 ) 
AS

Declare @sNumTransWrk VarChar ( 35 ) 
Declare @sNomZone VarChar ( 35 ) 
Declare @iFin 	Integer

Set @iFin = 0

If @asNumTrans is null Return -1
If LTRIM ( RTRIM ( @asNumTrans )) = '' Return -2
If LEN ( LTRIM ( RTRIM ( @asNumTrans )) ) > 35 Return -3

-- Num 1
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_1')
	 Begin

		Select @sNumTransWrk = wds.val_car
		From   sysadm.w_div_sin wds
		Where  wds.id_sin = @adcIdSin
		And    wds.nom_zone = 'num_trans_paybox_1' 
		If @sNumTransWrk is null Set @sNumTransWrk = ''
		
		If RTRIM ( @sNumTransWrk ) = '' 
		  Begin
		   Update sysadm.w_div_sin 
		   Set val_car = LTRIM ( rtrim( @asNumTrans	)), 
			   maj_le = 
				   Case @asNumTrans
						When 'ECHEC' Then maj_le 
						Else GETDATE()
				   End,
			   maj_par = 'EW' 
		   Where id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_1'
		   
		   Set @iFin = 1
		  End 
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'num_trans_paybox_1', 'Numéro Transaction PayBox (1)', '-XX', 'N', 'C', 'N', 'O', 640, null, null, null, LTRIM ( rtrim( @asNumTrans	)), 0, getdate(), getdate(), 'EW' ) 
	   Set @iFin = 1			   
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_1')
	 Begin

		Select @sNumTransWrk = wds.val_car
		From   sysadm.div_sin wds
		Where  wds.id_sin = @adcIdSin
		And    wds.nom_zone = 'num_trans_paybox_1' 
		If @sNumTransWrk is null Set @sNumTransWrk = ''
		
		If RTRIM ( @sNumTransWrk ) = '' 
		  Begin
		   Update sysadm.div_sin 
		   Set val_car = LTRIM ( rtrim( @asNumTrans	)), 
		   maj_le = 
				   Case @asNumTrans
						When 'ECHEC' Then maj_le 
						Else GETDATE()
				   End,
		   maj_par = 'EW' 
		   Where id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_1'
		   
		   Set @iFin = 1
		  End 
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'num_trans_paybox_1', 'Numéro Transaction PayBox (1)', '-XX', 'N', 'C', 'N', 'O', 640, null, null, null, LTRIM ( rtrim( @asNumTrans	)), getdate(), getdate(), 'EW', getdate(), 'EW' )        
	   Set @iFin = 1			   
	 End
  End

-- Num 2
If @iFin = 0 
 Begin 
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_2')
		 Begin

			Select @sNumTransWrk = wds.val_car
			From   sysadm.w_div_sin wds
			Where  wds.id_sin = @adcIdSin
			And    wds.nom_zone = 'num_trans_paybox_2' 
			If @sNumTransWrk is null Set @sNumTransWrk = ''
			
			If RTRIM ( @sNumTransWrk ) = '' 
			  Begin
			   Update sysadm.w_div_sin 
			   Set val_car = LTRIM ( rtrim( @asNumTrans	)), 
				   maj_le = 
				   Case @asNumTrans
						When 'ECHEC' Then maj_le 
						Else GETDATE()
				   End,
				maj_par = 'EW' 
			    Where id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_2'
			    
			    Set @iFin = 1
			  End 
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, 'num_trans_paybox_2', 'Numéro Transaction PayBox (2)', '-XX', 'N', 'C', 'N', 'O', 650, null, null, null, LTRIM ( rtrim( @asNumTrans	)), 0, getdate(), getdate(), 'EW' ) 
		   Set @iFin = 1			   
		 End
	  End


	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_2')
		 Begin

			Select @sNumTransWrk  = wds.val_car
			From   sysadm.div_sin wds
			Where  wds.id_sin = @adcIdSin
			And    wds.nom_zone = 'num_trans_paybox_2' 
			If @sNumTransWrk  is null Set @sNumTransWrk  = ''
			
			If RTRIM ( @sNumTransWrk  ) = '' 
			  Begin
			   Update sysadm.div_sin 
			   Set val_car = LTRIM ( rtrim( @asNumTrans	)), 
			   maj_le = 
				   Case @asNumTrans
						When 'ECHEC' Then maj_le 
						Else GETDATE()
				   End,
			   maj_par = 'EW' 
			   Where id_sin = @adcIdSin And nom_zone = 'num_trans_paybox_2'
			   
			   Set @iFin = 1
			  End 
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, 'num_trans_paybox_2', 'Numéro Transaction PayBox (2)', '-XX', 'N', 'C', 'N', 'O', 640, null, null, null, LTRIM ( rtrim( @asNumTrans	)), getdate(), getdate(), 'EW', getdate(), 'EW' )        
		   Set @iFin = 1			   
		 End
	  End
 End

-- Num1 ou Num2 en fct date maj_le
If @iFin = 0 
 Begin 
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2') )
		 Begin

			Select @sNomZone = wds.nom_zone
			From   sysadm.w_div_sin wds
			Where  wds.id_sin = @adcIdSin
			And    wds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' )
			And    wds.maj_le = ( 
							Select MAX ( maj_le ) 
							From   sysadm.w_div_sin wds
							Where  wds.id_sin = @adcIdSin
							And    wds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' )
							)
			
			If @sNomZone is null Set @sNomZone = ''
		
			
			If RTRIM ( @sNomZone ) <> '' 
			  Begin
			   Update sysadm.w_div_sin Set val_car = LTRIM ( rtrim( @asNumTrans	)), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = @sNomZone
			   Set @iFin = 1
			  End 
		 End 
		Else
		 Begin	 
		   If @sNomZone = 'num_trans_paybox_1' 
		    Begin
			   Insert into sysadm.w_div_sin values ( @adcIdSin, 'num_trans_paybox_1', 'Numéro Transaction PayBox (1)', '-XX', 'N', 'C', 'N', 'O', 640, null, null, null, LTRIM ( rtrim( @asNumTrans	)), 0, getdate(), getdate(), 'EW' ) 
			   Set @iFin = 1			   
			End

		   If @sNomZone = 'num_trans_paybox_2' 
		    Begin
			   Insert into sysadm.w_div_sin values ( @adcIdSin, 'num_trans_paybox_2', 'Numéro Transaction PayBox (2)', '-XX', 'N', 'C', 'N', 'O', 650, null, null, null, LTRIM ( rtrim( @asNumTrans	)), 0, getdate(), getdate(), 'EW' ) 
			   Set @iFin = 1			   
			End
	
		 End
	  End

	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2'))
		 Begin

			Select @sNomZone = wds.nom_zone
			From   sysadm.div_sin wds
			Where  wds.id_sin = @adcIdSin
			And    wds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' )
			And    wds.maj_le = ( 
							Select MAX ( maj_le ) 
							From   sysadm.div_sin wds
							Where  wds.id_sin = @adcIdSin
							And    wds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' )
							)
			
			If @sNomZone is null Set @sNomZone = ''
		
			
			If RTRIM ( @sNomZone ) <> '' 
			  Begin
			   Update sysadm.div_sin Set val_car = LTRIM ( rtrim( @asNumTrans	)), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = @sNomZone
			   Set @iFin = 1
			  End 
		 End 
		Else
		 Begin	 
		   If @sNomZone = 'num_trans_paybox_1' 
		    Begin
			   Insert into sysadm.div_sin values ( @adcIdSin, 'num_trans_paybox_1', 'Numéro Transaction PayBox (1)', '-XX', 'N', 'C', 'N', 'O', 640, null, null, null, LTRIM ( rtrim( @asNumTrans	)), getdate(), getdate(), 'EW', getdate(), 'EW' ) 
			   Set @iFin = 1			   
			End

		   If @sNomZone = 'num_trans_paybox_2' 
		    Begin
			   Insert into sysadm.div_sin values ( @adcIdSin, 'num_trans_paybox_2', 'Numéro Transaction PayBox (2)', '-XX', 'N', 'C', 'N', 'O', 650, null, null, null, LTRIM ( rtrim( @asNumTrans	)), getdate(), getdate(), 'EW', getdate(), 'EW' ) 
			   Set @iFin = 1			   
			End
	
		 End
	  End
 End
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DOS_ELIG_REL_PAYBOX 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DOS_ELIG_REL_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_S_DOS_ELIG_REL_PAYBOX
GO

CREATE procedure sysadm.PS_S_DOS_ELIG_REL_PAYBOX
AS

Select  ws.id_sin,
		ws.nom,
		ws.prenom,
		( Select wds.val_mt From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'mt_val_publique' ) 'mt_caution',
		'Relancer l''obtention d''un nouveau numéro de transaction (PV)'
From	sysadm.w_piece wp, 
		sysadm.det_pro dp,
		sysadm.w_sin ws
Where   ws.id_sin = wp.id_sin
And		wp.id_pce = 275
And     wp.id_gti = 10
-- (normal)  And     Not Exists ( Select * From sysadm.w_queue wq Where wq.id_sin = wp.id_sin And wq.trv_maj_par = 'GED' )
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'pce_pv_recu' and val_car = 'O' )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
-- And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car Not in ( 'AUCDEB', 'DEBKO', 'RECRED') )
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car = 'O' )
And     ( Select DateAdd ( day, 6, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'num_trans_paybox_1' and wds.val_car is not null and wds.val_car <> '' ) <= GETDATE()
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'num_trans_paybox_2' and wds.val_car is not null and wds.val_car <> '' )
And     Exists ( Select * From sysadm.w_commande wc Where wc.id_sin = wp.id_sin and wc.id_gti = 10 and wc.cod_etat <> 'ANN' and sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( info_spb_frn_cplt ) , ';' ) = 'PRET' )
Union
Select  ws.id_sin,
		ws.nom,
		ws.prenom,
		( Select wds.val_mt From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_val_publique' ) 'mt_caution',
		'Relancer l''obtention d''un nouveau numéro de transaction (Restit prêt)'
From	sysadm.det_pro dp,
		sysadm.w_sin ws
Where   dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'dte_der_rel_rest_pret' and wds.val_dte is not null )
And     ( Select DateAdd ( day, 1, wds.val_dte ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'dte_der_rel_rest_pret' ) >= GETDATE()
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And     Exists ( Select * From sysadm.w_commande wc Where wc.id_sin = ws.id_sin and wc.id_gti = 10 and wc.cod_etat <> 'ANN' and sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( info_spb_frn_cplt ) , ';' ) = 'PRET' )

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_U_RCP_PROCES_VERBAL
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_RCP_PROCES_VERBAL' AND type = 'P' )
        DROP procedure sysadm.PS_U_RCP_PROCES_VERBAL 
GO

CREATE procedure sysadm.PS_U_RCP_PROCES_VERBAL
	@adcIdSin	Decimal (10) -- [PI062]
AS


If Not Exists ( 
	Select *
	From	sysadm.det_pro dp, 
			sysadm.w_sin ws,
			sysadm.w_piece wp 
	Where   ws.id_sin = @adcIdSin
	And     wp.id_sin = ws.id_sin
	And		wp.id_pce = 275
	And     wp.id_gti = 10
	And		dp.id_prod = ws.id_prod
	And     dp.id_code_dp = 239 
	And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = wp.id_sin and wds.nom_zone = 'pce_pv_recu' and val_car = 'O' )
	)
  Begin
	Return 0 -- Produit non éligible, on passe
  End 

If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'pce_pv_recu')
	 Begin
	   Update sysadm.w_div_sin Set val_car = 'O', maj_le = GETDATE(), maj_par = 'GED' Where id_sin = @adcIdSin And nom_zone = 'pce_pv_recu'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'pce_pv_recu', 'Pièce procès-verbal reçue', '-XX', 'N', 'X', 'N', 'O', 620, null, null, null, 'O', 0, getdate(), getdate(), 'GED' ) 
	 End
  End

If @@ERROR <> 0 Return @@ERROR 

If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'pce_pv_recu')
	 Begin
	   Update sysadm.div_sin Set val_car = 'O', maj_le = GETDATE(), maj_par = 'GED' Where id_sin = @adcIdSin And nom_zone = 'pce_pv_recu'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'pce_pv_recu', 'Pièce procès-verbal reçue', '-XX', 'N', 'X', 'N', 'O', 620, null, null, null, 'O', getdate(), getdate(), 'GED', getdate(), 'GED' ) 
	 End
  End

If @@ERROR <> 0 Return @@ERROR 

Delete from sysadm.w_piece Where id_sin = @adcIdSin and id_pce = 275

If @@ERROR <> 0 Return @@ERROR 

Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DOS_ELIG_ENCAISS_PAYBOX
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [DT081_EVOL_PRET_BRIS] 
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      20/01/2015   [DT81-2]
-- JFF		18/02/2015	 [VDOC16906]
-- JFF      31/03/2015   [DT081-4]
-- JFF      12/02/2016   [PI062]
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DOS_ELIG_ENCAISS_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_S_DOS_ELIG_ENCAISS_PAYBOX
GO


CREATE procedure sysadm.PS_S_DOS_ELIG_ENCAISS_PAYBOX
	@adcIdSin Decimal (10) -- [PI062]
		/* Les Cas
		 1 : 'NON_RESTIT_APP_PRET'
		 2 : 'NON_RCP_PV_275' 
		 3 : 'APP_PRET_ENDOMMAGE'
		 4 : 'NON_RCP_PV_275_APR_REL'
		 5 : 'NON_RESTIT_APP_PRET_HV'
		 6 : 'APP_PRET_ENDOMMAGE_HV'
		*/
AS

-- Shunt sur ITSM Hélène, n°304297 le 02/07/2014
-- réactivation sur ITSM Hélène, n°306979 le 15/07/2014

--1

Select  ws.id_sin,
		( Select nom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'nom',
		( Select prenom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'prenom',
		'DEBIT_TOTAL' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_val_publique' ) 'mt_a_debiter',
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'NON_RESTIT_APP_PRET'
From	sysadm.det_pro dp,
		sysadm.sinistre ws,
		sysadm.div_sin ds
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		ds.id_sin = ws.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And		Exists ( Select 1 From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car = 'O' )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And     Not Exists ( Select 1 From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And		( ( IsNull (( Select wds.val_nbre From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And     ( Exists ( 
			 Select 1 
			 From   sysadm.commande c
			 Where  c.id_sin = ws.id_sin
			 And    c.id_four = 'PSM'
			 And	c.id_gti  = 10
			 And    c.id_typ_art = 'REL'
			 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
			 And	c.cod_etat <> 'ANN'
			 And	c.status_gc = 262
			 And    c.dte_env_cli is not null
			 And    ( Select DateAdd ( day, 11, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and val_car = 'O' ) <= GETDATE()
			)
		  Or
		  ( Not Exists ( 
					 Select 1 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'PSM'
					 And	c.id_gti  = 10
					 And    c.id_typ_art = 'REL'
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And	c.cod_etat <> 'ANN' )
					 
			And  Exists ( 
					 Select 1 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'O2M'
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And    c.cod_etat <> 'ANN'
					 And    c.id_typ_art not in ( 'PRS', 'EDI' )
					 And	c.status_gc in ( 262, 233 )
					 And    c.dte_env_cli is not null
					 And    ( Select DateAdd ( day, 11, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and val_car = 'O' ) <= GETDATE()
					)
		   )
		  
		) 
Union --2
Select  ws.id_sin,
		ws.nom,
		ws.prenom,
		'DEBIT_TOTAL' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_val_publique' ) 'mt_a_debiter',
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'NON_RCP_PV_275' 
From	sysadm.det_pro dp,
		sysadm.w_sin ws,
		sysadm.w_div_sin ds,
		sysadm.w_piece wp
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		ds.id_sin = ws.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.w_div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And		( ( IsNull (( Select wds.val_nbre From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And		Not Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'pce_pv_recu' and wds.val_car = 'O' )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		wp.id_sin = ws.id_sin And wp.id_pce = 275 And wp.id_gti = 10
And     ws.cod_etat = 100
And		Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_rel_pce' and wds.val_nbre >= 1 )
And     Not Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
--And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car Not in ( 'AUCDEB', 'DEBKO', 'RECRED' ) )
And    ( Select DateAdd ( day, 6, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_rel_pce' and wds.val_nbre >= 1 ) <= GETDATE()
Union --3 
Select  ws.id_sin,
		( Select nom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'nom',
		( Select prenom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'prenom',
		'DEBIT_PARTIEL' 'type_debit',
		( Select Round ( wds.val_mt * (CONVERT ( decimal (11,2), sysadm.FN_CLE_VAL ( 'PCT_ENDOMM', rtrim( c.info_frn_spb_cplt ), ';')) / 100), 2 )
		  From sysadm.div_sin wds, 
			   sysadm.commande c
		  Where wds.id_sin = ws.id_sin 
		  And   wds.nom_zone = 'mt_val_publique' 
		  And	c.id_sin = wds.id_sin
		  And	c.status_gc = 263
		  And   IsNull ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ), '' ) <> ''
		  And   sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) = 'ENDOMMAGE'
		  And   IsNull ( sysadm.FN_CLE_VAL ( 'PCT_ENDOMM', rtrim( c.info_frn_spb_cplt ), ';') , '' ) <> ''
		  ) 'mt_a_debiter',
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'APP_PRET_ENDOMMAGE'
From	sysadm.det_pro dp,
		sysadm.sinistre ws,
		sysadm.div_sin ds
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		ds.id_sin = ws.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		( ( IsNull (( Select wds.val_nbre From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And     Not Exists ( Select 1 From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And     ( Exists ( 
			 Select 1 
			 From   sysadm.commande c
			 Where  c.id_sin = ws.id_sin
			 And    c.id_four = 'PSM'
			 And	c.id_gti  = 10
			 And    c.id_typ_art = 'REL'
			 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
			 And	c.cod_etat <> 'ANN'
			 And	c.status_gc = 263
			 And    IsNull ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ), '' ) <> ''
			 And    sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) = 'ENDOMMAGE'
			 And    IsNull ( sysadm.FN_CLE_VAL ( 'PCT_ENDOMM', rtrim( c.info_frn_spb_cplt ), ';') , '' ) <> ''
			)
		  Or
		  ( Not Exists ( 
					 Select 1 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'PSM'
					 And	c.id_gti  = 10
					 And    c.id_typ_art = 'REL'
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And	c.cod_etat <> 'ANN' )
					 
			And  Exists ( 
					 Select 1 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'O2M'
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And    c.cod_etat <> 'ANN'
					 And    c.id_typ_art not in ( 'PRS', 'EDI' )
					 And	c.status_gc = 263
					 And    IsNull ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ), '' ) <> ''
					 And    sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) = 'ENDOMMAGE'
					 And    IsNull ( sysadm.FN_CLE_VAL ( 'PCT_ENDOMM', rtrim( c.info_frn_spb_cplt ), ';') , '' ) <> ''
					)
		   )
		  
		) 

Union --4
Select  ws.id_sin,
		ws.nom,
		ws.prenom,
		'DEBIT_TOTAL' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_val_publique' ) 'mt_a_debiter',
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'NON_RCP_PV_275_APR_REL'
From	sysadm.det_pro dp,
		sysadm.w_sin ws,
		sysadm.w_div_sin ds,
		sysadm.w_piece wp
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		ds.id_sin = ws.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.w_div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And		Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'num_trans_paybox_1' and wds.val_car <> '' )
And		Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'num_trans_paybox_2' and wds.val_car <> '' )
And		Not Exists ( Select 1 From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car = 'O' )
And		Not Exists ( Select 1 From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'pce_pv_recu' and wds.val_car = 'O' )
And		( ( IsNull (( Select wds.val_nbre From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		wp.id_sin = ws.id_sin And wp.id_pce = 275 And wp.id_gti = 10
And     ws.cod_etat = 100
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And    ( Select DateAdd ( day, 6, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'num_trans_paybox_2' and wds.val_car <> '' ) <= GETDATE()
And     ( Exists ( 
			 Select 1 
			 From   sysadm.w_commande c
			 Where  c.id_sin = ws.id_sin
			 And    c.id_four = 'PSM'
			 And	c.id_gti  = 10
			 And    c.id_typ_art = 'REL'
			 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
			 And	c.cod_etat <> 'ANN'
			 And	c.status_gc = 262
			 And    c.dte_env_cli is not null
			)
		  Or
		  ( Not Exists ( 
					 Select 1 
					 From   sysadm.w_commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'PSM'
					 And	c.id_gti  = 10
					 And    c.id_typ_art = 'REL'
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And	c.cod_etat <> 'ANN' )
					 
			And  Exists ( 
					 Select 1 
					 From   sysadm.w_commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'O2M'
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And    c.cod_etat <> 'ANN'
					 And    c.id_typ_art not in ( 'PRS', 'EDI' )
					 And	c.status_gc in ( 262, 233 )
					 And    c.dte_env_cli is not null
					)
		   )
		  
		) 

Union --5 -- [DT081_EVOL_PRET_BRIS] 
Select  s.id_sin,
		p.nom,
		p.prenom,
		'DEBIT_TOTAL' 'type_debit',
		( Select Top 1 Convert ( decimal ( 11, 2 ), IsNull ( sysadm.FN_CLE_VAL ( 'MT_CAUTION', RTRIM ( dp1.val_car), ';' ) , '0' ) )
		  From   sysadm.det_pro dp1
		  Where  dp1.id_prod = s.id_prod
		  And    id_code_dp = 259
		  And    sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM ( dp1.val_car), ';') = sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) 
		) 'mt_a_debiter', -- MT_CAUTION
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'NON_RESTIT_APP_PRET_HV'
From	sysadm.det_pro dp,
		sysadm.sinistre s,
		sysadm.div_sin ds,
		sysadm.personne p,
		sysadm.commande cpret
Where	( s.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		p.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And		Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'num_trans_paybox_1' and ds.val_car <> '' )
And		( ( IsNull (( Select wds.val_nbre From sysadm.div_sin wds Where wds.id_sin = s.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And     dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		cpret.id_sin = s.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And     sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) <> 'ENTREE_GAM'
And		Not Exists ( 
			Select * 
			From	sysadm.gar_sin g
			Where	g.id_sin = s.id_sin
			And     g.id_gti in ( 10 )
		) 
And    (
				Exists ( 
						  Select 1
						  From	 sysadm.reglement r,
								 sysadm.reg_gti rg
						  Where  r.id_sin = s.id_sin
						  And	 r.cod_inter = 'A'
						  And	 r.cod_mot_reg = 'RN'
						  And	 rg.id_sin = r.id_sin
						  And    rg.id_reg = r.id_reg
						  And    rg.id_gti > 0 
						  And    rg.id_gti not in ( 8 )
						  And    GetDate() > DateAdd ( day, 18, r.cree_le ) -- 18 jour Débit
						)  
		Or 
				Exists (
						Select 1
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )		
						and     c1.cod_etat <> 'ANN' 
						And    GetDate() > DateAdd ( day, 18, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 18 jour Débit + le délai de départ de 5 jours
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		Or		
				Exists (
						Select 1 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art in ( 'PRS' )		
						and c1.cod_etat <> 'ANN' 
						And ( c1.status_gc in ( 2, 22 ) 
							  Or 
							  -- [VDOC27123]BVID/BVIP/BVIT
						      ( c1.status_gc in ( 21,23 ) and CHARINDEX ( '[BVIE]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVID]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIP]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIT]', c1.comment_frn ) <= 0 And CHARINDEX ( '[PIE]', c1.comment_frn ) <= 0 ) -- [VDOC16906] Rempl BVIEOX par PIE
							)  
						And    GetDate() > DateAdd ( day, 18, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 18 jour Débit + le délai de départ de 5 jours
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		
		)		
		
And     Not Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'etat_caution_paybox' and ds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And		Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_rest_pret_HV' and ds.val_dte is not null)
And		Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_1rel_cour_rest_pret_HV' and ds.val_dte is not null )
And		Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_2rel_cour_rest_pret_HV' and ds.val_dte is not null )
And     Not Exists ( 
			 Select 1
			 From   sysadm.commande c
			 Where  c.id_sin = s.id_sin
			 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
			 And    c.cod_etat <> 'ANN'
			)

Union --6 -- [DT081_EVOL_PRET_BRIS] 
Select  s.id_sin,
		p.nom,
		p.prenom,
		'DEBIT_TOTAL' 'type_debit',
		( Select Top 1 Convert ( decimal ( 11, 2 ), IsNull ( sysadm.FN_CLE_VAL ( 'MT_CAUTION', RTRIM ( dp1.val_car), ';' ) , '0' ) )
		  From   sysadm.det_pro dp1
		  Where  dp1.id_prod = s.id_prod
		  And    id_code_dp = 259
		  And    sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM ( dp1.val_car), ';') = sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) 
		) 'mt_a_debiter', -- MT_CAUTION
		ds.val_car 'num_trans',
		'Encaisser la caution' 'action',
		'APP_PRET_ENDOMMAGE_HV'
From	sysadm.det_pro dp,
		sysadm.sinistre s,
		sysadm.div_sin ds,
		sysadm.personne p,
		sysadm.commande cpret
Where	( s.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		p.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin  
And     ds.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
And     ds.maj_le = ( 
				Select MAX ( ds1.maj_le )
				From sysadm.div_sin ds1
				Where ds1.id_sin = ds.id_sin
				And   ds1.nom_zone in ( 'num_trans_paybox_1', 'num_trans_paybox_2' ) 
					)
And		Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'num_trans_paybox_1' and ds.val_car <> '' )
And		( ( IsNull (( Select wds.val_nbre From sysadm.div_sin wds Where wds.id_sin = s.id_sin and wds.nom_zone = 'cpt_tent_debit' ), 0 ) < 2 )) -- [DT81-2]
And     dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		cpret.id_sin = s.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And		( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', cpret.info_frn_spb_cplt, ';' ) ) > 0 
		Or cpret.dte_rcp_mob_cli is not null ) -- [VDOC16906]
And     sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) <> 'ENTREE_GAM'
And		Not Exists ( 
			Select 1 
			From	sysadm.gar_sin g
			Where	g.id_sin = s.id_sin
			And     g.id_gti in ( 10 )
		) 
And     Not Exists ( Select 1 From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'etat_caution_paybox' and ds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And 	Exists ( 
				 Select 1 
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
				 And    c.cod_etat <> 'ANN'
				 And   sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) = 'ENDOMMAGE'
				)
		
		
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PAYBOX_RETOUR_DEBIT 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      29/09/2014   [DT081-1_CREDIMM]
-- JFF      20/01/2015   [DT81-2]
-- JFF      16/03/2015   [DT081-3]
-- JFF      20/01/2015   [DT81-2][MANTIS15027]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PAYBOX_RETOUR_DEBIT' AND type = 'P' )
        DROP procedure sysadm.PS_U_PAYBOX_RETOUR_DEBIT 
GO


CREATE procedure sysadm.PS_U_PAYBOX_RETOUR_DEBIT
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asTypDebit   VarChar ( 35 ),
        @adcMtDebit   Decimal ( 11,2 )
        
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iResContact	integer	

-- @asTypDebit
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'etat_caution_paybox')
	 Begin
	   Update sysadm.w_div_sin Set val_car = @asTypDebit, maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'etat_caution_paybox'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'etat_caution_paybox', 'Etat caution PayBox', '-W4', 'O', 'LC', 'N', 'O', 660, null, null, null, @asTypDebit, 0, getdate(), getdate(), 'EW' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'etat_caution_paybox')
	 Begin
	   Update sysadm.div_sin Set val_car = @asTypDebit, maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'etat_caution_paybox'	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'etat_caution_paybox', 'Etat caution PayBox', '-W4', 'O', 'LC', 'N', 'O', 660, null, null, null, @asTypDebit, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
	 End
  End

-- @adcMtDebit
If @asTypDebit Not In ( 'RECRED')
 Begin
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'mt_debit_caution_paybox')
		 Begin
		   Update sysadm.w_div_sin Set val_mt = @adcMtDebit, maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'mt_debit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, 'mt_debit_caution_paybox', 'Montant débit caution PayBox', '-1', 'N', 'S', 'N', 'O', 680, null, @adcMtDebit, null, null, 0, getdate(), getdate(), 'EW' ) 
		 End
	  End


	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'mt_debit_caution_paybox')
		 Begin
		   Update sysadm.div_sin Set val_mt = @adcMtDebit, maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'mt_debit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, 'mt_debit_caution_paybox', 'Montant débit caution PayBox', '-1', 'N', 'S', 'N', 'O', 680, null, @adcMtDebit, null, null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
		 End
	  End

	-- @dte_debit
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_debit_caution_paybox')
		 Begin
		   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_debit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_debit_caution_paybox', 'Date débit caution PayBox', '-1', 'N', 'D', 'N', 'O', 670, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EW' ) 
		 End
	  End


	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_debit_caution_paybox')
		 Begin
		   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_debit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_debit_caution_paybox', 'Date débit caution PayBox', '-1', 'N', 'D', 'N', 'O', 670, null, null, GETDATE(), null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
		 End
	  End
 End

-- [DT081-1_CREDIMM]
If @asTypDebit in ( 'DEBKO', 'RECRKO' )
 Begin
		If @asTypDebit = 'RECRKO' Set @sMess = 'Recrédit caution impossible !! reprendre le dossier'
		If @asTypDebit = 'DEBKO' 
		  Begin	
			Set @sMess = 'Débit caution impossible !! reprendre le dossier'
		
			-- [DT81-2]
			Exec sysadm.PS_IU_INCR_TENT_DEBIT_CAUTION @adcIdSin, 'ECHEC'
		  End 

		-- [DT81-2][MANTIS15027]
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 0 -- [DT081_EVOL_PRET_BRIS]
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 0 -- [DT081_EVOL_PRET_BRIS]
		END
 End 

If @asTypDebit In ( 'DEBTOT', 'DEBPAR')
 Begin
 
	-- [DT81-2]
	Exec sysadm.PS_IU_INCR_TENT_DEBIT_CAUTION @adcIdSin, 'SUCCES'
 
	Update sysadm.commande 
	Set cod_etat = 'RPC', info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'RPC_SUR_DEBCAUT', 'OUI', rTrim ( info_spb_frn_cplt ) , ';' )
	Where id_sin = @adcIdSin
	and   id_four in ( 'PSM', 'O2M' )
	and   sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( info_spb_frn_cplt ) , ';') = 'PRET'
	
	-- [DT081_EVOL_PRET_BRIS]
	Update sysadm.w_commande 
	Set cod_etat = 'RPC', info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'RPC_SUR_DEBCAUT', 'OUI', rTrim ( info_spb_frn_cplt ) , ';' )
	Where id_sin = @adcIdSin
	and   id_four in ( 'PSM', 'O2M' )
	and   sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( info_spb_frn_cplt ) , ';') = 'PRET'

	Exec sysadm.PS_U_REGUL_CAUTION_ASSUREUR @adcIdSin, 'RM', @adcMtDebit

	-- [DT081_EVOL_PRET_BRIS]
	Set @iResContact = 763
	
	If Exists ( Select *
				From	commande cpret
				Where   cpret.id_sin = @adcIdSin
				And     sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( cpret.info_frn_spb_cplt ), ';' ) = 'ENDOMMAGE'
			   )
		Begin
			Set @iResContact = 764
		End 
 
	Set @sMess = 'Caution débitée, '	+ CONVERT ( VarChar ( 20 ), @adcMtDebit ) + '€'
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, @iResContact -- [DT081_EVOL_PRET_BRIS]
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, @iResContact  -- [DT081_EVOL_PRET_BRIS]
	END
	
 End 

If @asTypDebit In ( 'RECRED')
 Begin
	
	/*
	Update sysadm.commande 
	Set cod_etat = 'ECT', info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'RPC_SUR_RECCAUT', 'NON', rTrim ( info_spb_frn_cplt ) , ';' )
	Where id_sin = @adcIdSin
	and   id_four in ( 'PSM', 'O2M' )
	and   sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( info_spb_frn_cplt ) , ';') = 'PRET'
*/
	-- [DT081-1_CREDIMM]
	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_recredit_caution_paybox')
		 Begin
		   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_recredit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_recredit_caution_paybox', 'Date recrédit caution PayBox', '-1', 'N', 'D', 'N', 'O', 670, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EW' ) 
		 End
	  End


	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_recredit_caution_paybox')
		 Begin
		   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'dte_recredit_caution_paybox'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_recredit_caution_paybox', 'Date recrédit caution PayBox', '-1', 'N', 'D', 'N', 'O', 670, null, null, GETDATE(), null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
		 End
	  End

	Exec sysadm.PS_U_REGUL_CAUTION_ASSUREUR @adcIdSin, 'RP', @adcMtDebit

	Set @sMess = 'Caution recréditée, '	+ CONVERT ( VarChar ( 20 ), @adcMtDebit ) + '€'
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 765 -- [DT081_EVOL_PRET_BRIS]
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 765 -- [DT081_EVOL_PRET_BRIS]
	END
	
 End 
Go

grant execute on sysadm.PS_U_PAYBOX_RETOUR_DEBIT to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_COUR_ENCAISS_PAYBOX
-- Auteur               :       JFF/FPI
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      12/02/2016   [PI062]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_ENCAISS_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_ENCAISS_PAYBOX 
GO


CREATE procedure sysadm.PS_S_XML_COUR_ENCAISS_PAYBOX
	@adcIdSin	Decimal ( 10 ), -- [PI062]
	@asCasencaiss VarChar ( 30 )  -- 'NON_RCP_PV_275_APR_REL', 
								  -- 'APP_PRET_ENDOMMAGE', 
								  -- 'NON_RCP_PV_275', 
								  -- 'NON_RESTIT_APP_PRET', 
								  -- 'NON_OBT_RENV_NUM_TRANS', 
								  -- 'CONS_APP_SUITE_REF' 
								  -- 'NON_RESTIT_APP_PRET_HV' -- [DT081_EVOL_PRET_BRIS]
								  -- 'APP_PRET_ENDOMMAGE_HV' -- [DT081_EVOL_PRET_BRIS]
								  -- pour la chaine XML.
AS

Declare @xmlResult varchar(max) 

SET NOCOUNT ON

delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  date_refus,
	  code_maquette,
	  adr_mail,
	  typ_app_pret 
	  )
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(pe.cod_civ,'-CI') as civilite, 
	Case When pe.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pe.cod_civ,'-CL') 
	End as civilite_longue, 
	pe.nom, 
	pe.prenom,
	pe.adr_1, 
	pe.adr_2, 
	Case pe.adr_cp When '00000' then '' Else pe.adr_cp End as adr_cp, 
	pe.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	Case 
		When @asCasencaiss in ( 'NON_RESTIT_APP_PRET_HV', 'APP_PRET_ENDOMMAGE_HV' ) Then
			(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox')			
		Else 
			(select val_mt from sysadm.w_div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique')
	End as mt_caution, -- [DT081_EVOL_PRET_BRIS]

	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.w_div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	(select convert(varchar(10),wds.maj_le,20) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ),
	Case @asCasencaiss
		When 'NON_RCP_PV_275_APR_REL' Then 'debit_CB_docs_non_recus'
		When 'APP_PRET_ENDOMMAGE' Then 'debit_CB_refus_app_pret_casse'
		When 'NON_RCP_PV_275' Then 'debit_CB_docs_non_recus'
		When 'NON_RESTIT_APP_PRET' Then 'debit_CB_refus'
		--When 'SOUHAIT_CONS_APP_PRET' Then 'debit_CB_refus_app_pret_conserve'
		When 'CONS_APP_SUITE_REF' Then 'debit_CB_refus_app_pret_conserve'
		When 'NON_RESTIT_APP_PRET_HV' Then 'debit_CB_restit_pret_hors_vol' -- [DT081_EVOL_PRET_BRIS]
		When 'APP_PRET_ENDOMMAGE_HV'  Then 'debit_CB_app_pret_casse_incomplet' -- [DT081_EVOL_PRET_BRIS]
	End as code_maquette,
	wi.adr_mail,
	( Select Top 1 IsNull ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( c.info_spb_frn_cplt ), ';' ), '' ) as typ_app_pret
	  From  sysadm.commande c
	  Where c.id_sin = ws.id_sin
	  And   LEN ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( c.info_spb_frn_cplt ), ';' ) ) > 0 
	) as typ_app_pret -- [DT081_EVOL_PRET_BRIS]
From	sysadm.sinistre ws,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi,
		sysadm.personne pe
Where   ws.id_sin=@adcIdSin
and     pe.id_ordre = ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'


-- [DT081_EVOL_PRET_BRIS]
Exec sysadm.PS_S_XML_COUR_ORANGEV3 @adcIdSin, null, @xmlResult  OUTPUT

Select no_dossier_sinistre, 
	@asCasencaiss as cas_encaiss,
	xml_data 
From sysadm.w_cour_xml_orangev3

Go


grant execute on sysadm.PS_S_XML_COUR_ENCAISS_PAYBOX to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_COUR_RECREDIT_PAYBOX
-- Auteur               :       JFF/FPI
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :     -- [DT081_EVOL_PRET_BRIS]  
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_RECREDIT_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_RECREDIT_PAYBOX 
GO


CREATE procedure sysadm.PS_S_XML_COUR_RECREDIT_PAYBOX
	@adcIdSin	Decimal ( 10 ), -- [PI062]
	@asCasRecredit VarChar ( 30 ) -- 'PV_275_RECU', 
							      -- 'RESTIT_PRET' 
							      -- 'RESTIT_PRET_HV' -- [DT081_EVOL_PRET_BRIS]  
AS

Declare @xmlResult varchar(max) 

SET NOCOUNT ON

delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  date_refus,
	  code_maquette,
	  adr_mail,
	  typ_app_pret 
	  )
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(pe.cod_civ,'-CI') as civilite, 
	Case When pe.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pe.cod_civ,'-CL') 
	End as civilite_longue, 
	pe.nom, 
	pe.prenom,
	pe.adr_1, 
	pe.adr_2, 
	Case pe.adr_cp When '00000' then '' Else pe.adr_cp End as adr_cp, 
	pe.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	ds.val_mt as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.w_div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	(select convert(varchar(10),wds.maj_le,20) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ),
	Case @asCasRecredit 
		When 'PV_275_RECU' Then  'recredit_pv275_recu' -- [DT081_EVOL_PRET_BRIS]
		When 'RESTIT_PRET' Then  'recredit_restit_pret_vol' -- [DT081_EVOL_PRET_BRIS]
		When 'RESTIT_PRET_HV' Then  'recredit_restit_pret_HV' -- [DT081_EVOL_PRET_BRIS]
		When 'RECIMM' Then  'recredit_immediat' -- [DT081-1_CREDIMM]		
	End as code_maquette,
	wi.adr_mail,
	( Select Top 1 IsNull ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( c.info_spb_frn_cplt ), ';' ), '' ) as typ_app_pret
	  From  sysadm.commande c
	  Where c.id_sin = ws.id_sin
	  And   LEN ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( c.info_spb_frn_cplt ), ';' ) ) > 0 
	) as typ_app_pret -- [DT081_EVOL_PRET_BRIS]
From	sysadm.sinistre ws,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi,
		sysadm.personne pe,
		sysadm.div_sin ds
Where   ws.id_sin=@adcIdSin
and     pe.id_ordre = ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'
And		ds.id_sin =  ws.id_sin 
And 	ds.nom_zone = 'mt_debit_caution_paybox'

-- [DT081_EVOL_PRET_BRIS]
Exec sysadm.PS_S_XML_COUR_ORANGEV3 @adcIdSin, null, @xmlResult  OUTPUT

Select no_dossier_sinistre, 
	@asCasRecredit as cas_encaiss,
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_XML_COUR_RECREDIT_PAYBOX to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DOS_ELIG_RECREDIT_PAYBOX
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DOS_ELIG_RECREDIT_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_S_DOS_ELIG_RECREDIT_PAYBOX 
GO


CREATE procedure sysadm.PS_S_DOS_ELIG_RECREDIT_PAYBOX
	@adcIdSin Decimal (10)
AS

--1
Select  ws.id_sin,
		( Select nom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'nom',
		( Select prenom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'prenom',
		'RECREDIT' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_debit_caution_paybox' ) 'mt_a_recrediter',
		'Recréditer la caution' 'action',
		'RESTIT_PRET'
From	sysadm.det_pro dp,
		sysadm.sinistre ws
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car = 'O' )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And     Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR' ) )
And     ( Exists ( 
			 Select * 
			 From   sysadm.commande c
			 Where  c.id_sin = ws.id_sin
			 And    c.id_four = 'PSM'
			 And	c.id_gti  = 10
			 And    c.id_typ_art = 'REL'
			 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
			 And	c.cod_etat <> 'ANN'
			 And	c.status_gc = 263
			 And    c.dte_env_cli is not null
			)
		  Or
		  ( Not Exists ( 
					 Select * 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'PSM'
					 And	c.id_gti  = 10
					 And    c.id_typ_art = 'REL'
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And	c.cod_etat <> 'ANN' )
					 
			And  Exists ( 
					 Select * 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'O2M'
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And    c.cod_etat <> 'ANN'
					 And    c.id_typ_art not in ( 'PRS', 'EDI' )
					 And	c.status_gc in ( 263 )
					 And    c.dte_env_cli is not null
					)
		   )
		  
		) 
Union --2
Select  ws.id_sin,
		( Select nom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'nom',
		( Select prenom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'prenom',
		'RECREDIT' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_debit_caution_paybox' ) 'mt_a_recrediter',
		'Recréditer la caution' 'action',
		'PV_275_RECU' 
From	sysadm.det_pro dp,
		sysadm.sinistre ws
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And		Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'pce_pv_recu' and wds.val_car = 'O' )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And     ws.cod_etat = 100
And     Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR' ) )
/*
And     Not Exists ( 
					 Select * 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'RPC_SUR_DEBCAUT', rTrim ( c.info_spb_frn_cplt ) , ';' ) = 'OUI'
					 ) 
*/
Union --3 -- [DT081_EVOL_PRET_BRIS]
Select  ws.id_sin,
		( Select nom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'nom',
		( Select prenom From sysadm.personne p Where p.id_ordre = ws.id_ordre ) 'prenom',
		'RECREDIT' 'type_debit',
		( Select wds.val_mt From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'mt_debit_caution_paybox' ) 'mt_a_recrediter',
		'Recréditer la caution' 'action',
		'RESTIT_PRET_HV'
From	sysadm.det_pro dp,
		sysadm.sinistre ws,
		sysadm.commande cpret
Where	( ws.id_sin = @adcIdSin Or @adcIdSin = -1 )
And     dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And     Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR' ) )
And		Not Exists ( 
			Select * 
			From	sysadm.gar_sin g
			Where	g.id_sin = ws.id_sin
			And     g.id_gti in ( 10 )
		)
And		cpret.id_sin = ws.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And     sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) <> 'ENTREE_GAM'		
And 	Exists ( 
				 Select * 
				 From   sysadm.commande c
				 Where  c.id_sin = ws.id_sin
				 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
				 And    c.cod_etat <> 'ANN'
				 And    sysadm.FN_CLE_VAL ( 'ETAT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ) = 'CONFORME'
				)

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REL_COUR_PCE_PROC_VERB
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REL_COUR_PCE_PROC_VERB' AND type = 'P' )
        DROP procedure sysadm.PS_S_REL_COUR_PCE_PROC_VERB 
GO

CREATE procedure sysadm.PS_S_REL_COUR_PCE_PROC_VERB
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3

-- Relance de demande de pièce 275
Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  code_maquette,
	  adr_mail)
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(ws.cod_civ,'-CI') as civilite, 
	Case When ws.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(ws.cod_civ,'-CL') 
	End as civilite_longue, 
	ws.nom,
	ws.prenom,
	ws.adr_1, 
	ws.adr_2, 
	Case ws.adr_cp When '00000' then '' Else ws.adr_cp End as adr_cp, 
	ws.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=ws.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	'debit_CB_docs_non_recus' as code_maquette,
	wi.adr_mail
From	sysadm.w_piece wp,
		sysadm.w_sin ws,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.w_inter wi
Where   dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		wp.id_sin = ws.id_sin And wp.id_pce = 275 And wp.id_gti = 10
And     ws.cod_etat = 100
And		Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'pce_pv_recu' and wds.val_car = 'O' )
And		Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_rel_pce' and wds.val_nbre > 0 )
And     Not Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO' ) )
And     DateAdd ( day, 6, wp.maj_le ) <= GETDATE()
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And     Exists ( 
				 Select * 
				 From   sysadm.commande c
				 Where  c.id_sin = ws.id_sin
				 And	c.id_gti  = 10
				 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
				 And    c.cod_etat <> 'ANN'
				 And    c.id_typ_art not in ( 'PRS', 'EDI' )
				)
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_REL_COUR_PCE_PROC_VERB to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_REL_COUR_PCE_ENVOYEE 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REL_COUR_PCE_ENVOYEE' AND type = 'P' )
        DROP procedure sysadm.PS_U_REL_COUR_PCE_ENVOYEE 
GO


CREATE procedure sysadm.PS_U_REL_COUR_PCE_ENVOYEE
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 

-- cpt_rel_pce
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_pce')
	 Begin
	   Select @iVal = IsNull ( wds.val_nbre, 0 ) From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_pce'
	   Update sysadm.w_div_sin Set val_nbre = @iVal + 1, maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'etat_caution_paybox'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'cpt_rel_pce', 'Compteur relance pièce PV', '-1', 'N', 'N', 'N', 'O', 625, 1, null, null, null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_pce')
	 Begin
	   Select @iVal = IsNull ( wds.val_nbre, 0 ) From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_pce'
	   Update sysadm.div_sin Set val_nbre = @iVal + 1, maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'cpt_rel_pce'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'cpt_rel_pce', 'Compteur relance pièce PV', '-1', 'N', 'N', 'N', 'O', 625, 1, null, null, null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

-- dte_der_rel
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_der_rel')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_der_rel'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_der_rel', 'Date dernière relance pièce PV', '-1', 'N', 'D', 'N', 'O', 626, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_der_rel')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_der_rel'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_der_rel', 'Date dernière relance pièce PV', '-1', 'N', 'D', 'N', 'O', 626, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End


Set @sMess = 'Relance courrier pièce 275 Procès Verbal envoyé '
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END

Go



--------------------------------------------------------------------
--
-- Procédure            :       PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS' AND type = 'P' )
        DROP procedure sysadm.PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS 
GO

CREATE procedure sysadm.PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS
AS

SET NOCOUNT ON

delete from sysadm.w_cour_xml_orangev3

-- Relance retour appareil de prêt si refus sur le bris
Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  date_refus,
	  code_maquette,
	  adr_mail)
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(ps.cod_civ,'-CI') as civilite, 
	Case When ps.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(ps.cod_civ,'-CL') 
	End as civilite_longue, 
	ps.nom, 
	ps.prenom,
	ps.adr_1, 
	ps.adr_2, 
	Case ps.adr_cp When '00000' then '' Else ps.adr_cp End as adr_cp, 
	ps.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	'O' as app_pret,
	'rempl' as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	(select convert(varchar(10),wds.maj_le,20) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ),
	'debit_CB_refus' as code_maquette,
	 wi.adr_mail
From	sysadm.sinistre ws,
		sysadm.det_pro dp,
		sysadm.personne ps,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi
Where   dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car = 'O' )
And		Not Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'cpt_rel_rest_pret' and wds.val_nbre > 0 )
And     Not Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'etat_caution_paybox' and wds.val_car in ( 'DEBTOT', 'DEBPAR', 'RECRED', 'RECRKO'  ) )
And    ( Select DateAdd ( day, 6, wds.maj_le ) From sysadm.w_div_sin wds Where wds.id_sin = ws.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ) <= GETDATE()
And     ( Exists ( 
			 Select * 
			 From   sysadm.commande c
			 Where  c.id_sin = ws.id_sin
			 And    c.id_four = 'PSM'
			 And	c.id_gti  = 10
			 And    c.id_typ_art = 'REL'
			 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
			 And	c.cod_etat <> 'ANN'
			 And	c.status_gc = 262
			 And    c.dte_env_cli is not null
			)
		  Or
		  ( Not Exists ( 
					 Select * 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'PSM'
					 And	c.id_gti  = 10
					 And    c.id_typ_art = 'REL'
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And	c.cod_etat <> 'ANN' )
					 
			And  Exists ( 
					 Select * 
					 From   sysadm.commande c
					 Where  c.id_sin = ws.id_sin
					 And    c.id_four = 'O2M'
					 And	c.id_gti  = 10
					 And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
					 And    c.cod_etat <> 'ANN'
					 And    c.id_typ_art not in ( 'PRS', 'EDI' )
					 And	c.status_gc in ( 262, 233 )
					 And    c.dte_env_cli is not null
					)
		   )
		  
		) 
And 	ps.id_ordre=ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_REL_COUR_RESTIT_PRET_REFUS_BRIS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_REL_COUR_REF_ENVOYEE 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REL_COUR_REF_ENVOYEE' AND type = 'P' )
        DROP procedure sysadm.PS_U_REL_COUR_REF_ENVOYEE
GO


CREATE procedure sysadm.PS_U_REL_COUR_REF_ENVOYEE
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 

-- cpt_rel_rest_pret
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret')
	 Begin
	   Select @iVal = IsNull ( wds.val_nbre, 0 ) From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret'
	   Update sysadm.w_div_sin Set val_nbre = @iVal + 1, maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'cpt_rel_rest_pret', 'Compteur relance restitution prêt', '-1', 'N', 'N', 'N', 'O', 627, 1, null, null, null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret')
	 Begin
	   Select @iVal = IsNull ( wds.val_nbre, 0 ) From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret'
	   Update sysadm.div_sin Set val_nbre = @iVal + 1, maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'cpt_rel_rest_pret'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'cpt_rel_rest_pret', 'Compteur relance restitution prêt', '-1', 'N', 'N', 'N', 'O', 627, 1, null, null, null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

-- dte_der_rel_rest_pret
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_der_rel_rest_pret')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_der_rel_rest_pret'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_der_rel_rest_pret', 'Date dern. relance restitution prêt', '-1', 'N', 'D', 'N', 'O', 628, 1, null, null, null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_der_rel_rest_pret')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_der_rel_rest_pret'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_der_rel_rest_pret', 'Date dern. relance restitution prêt', '-1', 'N', 'D', 'N', 'O', 628, 1, null, null, null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End


Set @sMess = 'Relance courrier de restitution du matériel de prêt envoyé '
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_COUR_RECUP_PRET_SUR_BRIS
-- Auteur               :       JFF/FPI
-- Date                 :       29/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_RECUP_PRET_SUR_BRIS' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_RECUP_PRET_SUR_BRIS
GO

CREATE procedure sysadm.PS_S_XML_COUR_RECUP_PRET_SUR_BRIS
AS

SET NOCOUNT ON

delete from sysadm.w_cour_xml_orangev3

-- L'appareil est réparé et l'assuré avait eu un appareil de prêt.
-- Un courrier auto doit partir pour lui demander de le restituer.
Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite,
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  code_maquette,
	  adr_mail)
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(ps.cod_civ,'-CI') as civilite, 
	Case When ps.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(ps.cod_civ,'-CL') 
	End as civilite_longue, 
	ps.nom, 
	ps.prenom,
	ps.adr_1, 
	ps.adr_2, 
	Case ps.adr_cp When '00000' then '' Else ps.adr_cp End as adr_cp, 
	ps.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	'O' as app_pret,
	'repa' as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	  isnull(rtrim ( c.adr_nom ), '' ) + ' ' + isnull(rtrim ( c.adr_prenom) ,'') as nom_livraison,
	  isnull(rtrim ( c.adr_livr1), '') as adresse1_livraison,
	  isnull(rtrim ( c.adr_livr2), '') as adresse2_livraison,
	  isnull(rtrim ( c.adr_cp), '') + ' ' + isnull(rtrim ( c.adr_ville ), '') as cp_ville_livraison,
	  'confirmation' as code_maquette,	-- 'RESTITUTION_SUR_REPARATION'
	  wi.adr_mail
From	sysadm.sinistre ws,
		sysadm.det_pro dp,
		sysadm.commande c,
		sysadm.commande c1,
		sysadm.personne ps,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi
Where   dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		c.id_sin = ws.id_sin
And     c.id_typ_art = 'PRS'
And     c.status_gc in ( 2, 22 )
And     c.cod_etat <> 'ANN'
And     c1.id_sin = c.id_sin
And		c1.id_typ_art = 'PST'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ), ';' ) = 'PRET'
And     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_RESTIT', rtrim ( c1.info_spb_frn_cplt ), ';' ) = ''
And 	ps.id_ordre=ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'

-- L'appareil est irréparable suite tentative de réparation et l'assuré avait eu un appareil de prêt.
-- Dès lors qu'O2M nous dit que la commande est honoré, un courrier auto doit être envoyé vers l'assuré
-- pour lui demander de restituer l'appareil de prêt.
Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  app_marque_rempl,
	  app_modele_rempl,
	  code_maquette,
	  adr_mail)
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(ps.cod_civ,'-CI') as civilite, 
	Case When ps.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(ps.cod_civ,'-CL') 
	End as civilite_longue, 
	ps.nom, 
	ps.prenom,
	ps.adr_1, 
	ps.adr_2, 
	Case ps.adr_cp When '00000' then '' Else ps.adr_cp End as adr_cp, 
	ps.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	'O' as app_pret,
	'rempl' as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
    isnull(rtrim ( c.adr_nom ), '' ) + ' ' + isnull(rtrim ( c.adr_prenom) ,'') as nom_livraison,
	isnull(rtrim ( c.adr_livr1), '') as adresse1_livraison,
	isnull(rtrim ( c.adr_livr2), '') as adresse2_livraison,
	isnull(rtrim ( c.adr_cp), '') + ' ' + isnull(rtrim ( c.adr_ville ), '') as cp_ville_livraison,
	c.id_marq_art,
	c.id_modl_art,
	'confirmation' as code_maquette,	-- 'RESTITUTION_SUR_COMMANDE'
	wi.adr_mail
From	sysadm.sinistre ws,
		sysadm.det_pro dp,
		sysadm.commande c,
		sysadm.commande c1,
		sysadm.personne ps,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi
Where   dp.id_prod = ws.id_prod and dp.id_code_dp = 239
And		c.id_sin = ws.id_sin
And     c.id_typ_art not in ( 'RES', 'RST', 'REL', 'PST', 'EDI', 'PRS', 'REA' )
And     c.status_gc = 177
And     c.cod_etat <> 'ANN'
And     c1.id_sin = c.id_sin
And		c1.id_typ_art = 'PST'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ), ';' ) = 'PRET'
And     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_RESTIT', rtrim ( c1.info_spb_frn_cplt ), ';' ) = ''
And 	ps.id_ordre=ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_XML_COUR_RECUP_PRET_SUR_BRIS to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_RECUP_PRET_SUR_BRIS
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_RECUP_PRET_SUR_BRIS' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_RECUP_PRET_SUR_BRIS
GO


CREATE procedure sysadm.PS_U_COUR_RECUP_PRET_SUR_BRIS
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @iIdSeq			integer 

-- L'appareil est réparé et l'assuré avait eu un appareil de prêt.
-- Un courrier auto doit partir pour lui demander de le restituer.
-- On marque l'envoie.
/*
Select Top 1 @iIdSeq = c.id_seq
From   sysadm.commande c,
	   sysadm.commande c1
Where  c.id_sin = @adcIdSin
And	   c.id_typ_art = 'PST'
And    c1.id_sin = c.id_sin
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ), ';' ) = 'PRET'
And     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_RESTIT', rtrim ( c1.info_spb_frn_cplt ), ';' ) = ''

Update sysadm.commande 
Set    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_KSL_RESTIT', convert ( varchar(10), GETDATE(), 103 ), RTRIM ( info_spb_frn_cplt ), ';' )
Where  id_sin = @adcIdSin
And    id_seq = @iIdSeq
*/

Update sysadm.commande 
Set    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_KSL_RESTIT', convert ( varchar(10), GETDATE(), 103 ), RTRIM ( c1.info_spb_frn_cplt ), ';' )
From   sysadm.commande c1
Where  id_sin = @adcIdSin
And	   id_typ_art = 'PST'
And    c1.id_sin = id_sin
And    sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ), ';' ) = 'PRET'
And     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_RESTIT', rtrim ( c1.info_spb_frn_cplt ), ';' ) = ''


Set @sMess = 'Courrier de restitution du matériel de prêt (suite réparation) envoyé '
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
	
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_COUR_CONF_CMDE_HONOREE
-- Auteur               :       JFF/FPI
-- Date                 :       12/06/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_CONF_CMDE_HONOREE' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_CONF_CMDE_HONOREE
GO

CREATE procedure sysadm.PS_S_XML_COUR_CONF_CMDE_HONOREE
AS

-- Cas d'une commande passée à O2M, et honorée par O2M

delete from sysadm.w_cour_xml_orangev3

-- L'appareil est réparé et l'assuré avait eu un appareil de prêt.
-- Un courrier auto doit partir pour lui demander de le restituer.
Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite,
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  app_marque_rempl,
	  app_modele_rempl,
	  code_maquette,
	  adr_mail)
Select ws.id_sin, 
	sysadm.FN_CODE_NUM(ps.cod_civ,'-CI') as civilite, 
	Case When ps.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(ps.cod_civ,'-CL') 
	End as civilite_longue,
	ps.nom, 
	ps.prenom,
	ps.adr_1, 
	ps.adr_2, 
	Case ps.adr_cp When '00000' then '' Else ps.adr_cp End as adr_cp, 
	ps.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=ws.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=ws.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	cie.lib_cie as lib_compagnie,
	sysadm.FN_GET_LIB_POLICE_V01(ws.id_sin,ws.id_prod, ws.id_rev,-1,NULL) as lib_police,
	ws.num_port as num_tel_assure,
	ws.marq_port,
	ws.modl_port,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=ws.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),ws.dte_decl,20) as dte_decl,
	ws.maj_par as code_operateur,
	Case When Exists (select * from sysadm.commande w
		where w.id_sin=ws.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.commande w
		where w.id_sin=ws.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=ws.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	isnull(rtrim ( c.adr_nom ), '' ) + ' ' + isnull(rtrim ( c.adr_prenom) ,'') as nom_livraison,
	isnull(rtrim ( c.adr_livr1), '') as adresse1_livraison,
	isnull(rtrim ( c.adr_livr2), '') as adresse2_livraison,
	isnull(rtrim ( c.adr_cp), '') + ' ' + isnull(rtrim ( c.adr_ville ), '') as cp_ville_livraison,
	c.id_marq_art,
	c.id_modl_art,
	'confirmation' as code_maquette	,
	wi.adr_mail
From	sysadm.commande c,
		sysadm.sinistre ws,
		sysadm.det_pro d,
		sysadm.personne ps,
		sysadm.produit p,
		sysadm.police pol,
		sysadm.compagnie cie,
		sysadm.inter wi
Where   d.id_code_dp = 239
And     d.id_prod = ws.id_prod
And     c.id_sin = ws.id_sin
And     c.id_four = 'O2M'
And     c.id_typ_art not in ( 'RES', 'RST', 'REL', 'PST', 'EDI', 'PRS', 'REA' )
And     c.status_gc = 177
and     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_CONF_CMDE', rtrim ( c.info_spb_frn_cplt ) , ';' ) = ''
And 	ps.id_ordre=ws.id_ordre
And		p.id_prod=ws.id_prod
And		p.id_police=pol.id_police
And 	cie.id_cie=pol.id_cie
And		wi.id_sin=ws.id_sin
And 	wi.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_XML_COUR_CONF_CMDE_HONOREE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_CONF_CMDE_HONOREE
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--								Contrôler le 26/10/2021 => N'est plus utiliser
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_CONF_CMDE_HONOREE' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_CONF_CMDE_HONOREE
GO


CREATE procedure sysadm.PS_U_COUR_CONF_CMDE_HONOREE
        @adcIdSin     Decimal (  10,0 ) -- [PI062]
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @iIdSeq			integer 

-- Cas d'une commande passée à O2M, et honorée par O2M
/*
Select Top 1 @iIdSeq = c.id_seq
From   sysadm.commande c
Where   c.id_sin = @adcIdSin     
And     c.id_four = 'O2M'
And     c.id_typ_art not in ( 'RES', 'RST', 'REL', 'PST', 'EDI', 'PRS' )
And     c.status_gc = 177
and     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_CONF_CMDE', rtrim ( c.info_spb_frn_cplt ) , ';' ) = ''

Update sysadm.commande 
Set    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_KSL_CONF_CMDE', convert ( varchar(10), GETDATE(), 103 ), RTRIM ( info_spb_frn_cplt ), ';' )
Where  id_sin = @adcIdSin
And    id_seq = @iIdSeq

*/

Update sysadm.commande 
Set    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_KSL_CONF_CMDE', convert ( varchar(10), GETDATE(), 103 ), RTRIM ( info_spb_frn_cplt ), ';' )
From   sysadm.commande c
Where   c.id_sin = @adcIdSin     
And     c.id_four = 'O2M'
And     c.id_typ_art not in ( 'RES', 'RST', 'REL', 'PST', 'EDI', 'PRS', 'REA' )
And     c.status_gc = 177
and     sysadm.FN_CLE_VAL ( 'DTE_COUR_KSL_CONF_CMDE', rtrim ( c.info_spb_frn_cplt ) , ';' ) = ''

Set @sMess = 'Courrier de confirmation de commande de matériel envoyé vers l''assuré (courrier envoyé )'
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_COUR_ORANGEV3
-- Auteur               :       FPI
-- Date                 :       12/06/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      13/01/2014   [PM246]
-- FPI - 24/01/2014		[ITSM196583] Correction du replace
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      08/04/2014   [PM255]
-- JFF      07/05/2013   [PM250-1]
-- JFF      12/12/2014   [PC13321]
-- JFF      15/06/2015   [DT154]
-- JFF      08/07/2015   [DT154][MANTIS16226]
-- JFF      31/03/2016   [PM287-3]
-- JFF      12/02/2016   [PI062]
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF      22/05/2017   [PM287-3] ajout evironnement
-- JFF      03/08/2017   [DF006]
-- JFF      25/09/2017   [PM287-6]
-- JFF      14/12/2017   [DF005-1-LOT2]
-- JFF      11/01/2018   [PM287-6][MANTIS26879]
-- JFF      23/01/2018   [PM407-1]
-- JFF      12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_COUR_ORANGEV3' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_COUR_ORANGEV3
GO


CREATE PROCEDURE sysadm.PS_S_XML_COUR_ORANGEV3 
	@dcIdSin decimal(10,0), -- [PI062]
	@iIdSeqXml integer, -- [PM246]
	@xmlResult varchar(max) OUTPUT
AS
	Declare @sEmail varchar(120)
	
	select @xmlResult=(
	select top 1 'C' as 'tech/@canal',
		code_maquette as 'tech/@code_maquette',
		'S' as 'tech/@code_adhsin',
		montant_debite as 'entete/@montant_debite',
		civilite_courte as 'entete/@civilite_courte',
		civilite_courte as 'entete/@civ', -- [PM234-7][M21970]
		civilite_longue as 'entete/@civilite_longue',
		rtrim(nom) as 'entete/@nom',
		rtrim(prenom) as 'entete/@prenom',
		rtrim(adresse1) as 'entete/@adresse1',
		rtrim(adresse2) as 'entete/@adresse2',
		code_postal as 'entete/@code_postal',
		rtrim(ville) as 'entete/@ville',
		code_produit_sinistre as 'entete/@code_produit_sinistre',
		nom_produit as 'entete/@nom_produit',
		nom_produit as 'entete/@nom_produit_cpl',
		lib_opt_produit as 'entete/@lib_opt_produit',
		rtrim(no_tel_spb) as 'entete/@no_tel_spb',
		rtrim(no_tel_spb) as 'entete/@num_tel_prod', -- [PM234-7][M21970]
		rtrim(no_fax_spb) as 'entete/@no_fax_spb',
		rtrim(assureur) as 'entete/@assureur',
		no_police as 'entete/@no_police',
		no_police as 'entete/@police',-- [PM234-7][M21970]
		no_ligne_assuree as 'entete/@no_ligne_assuree',
		cout_telephonique as 'entete/@cout_telephonique',
--		RIGHT('000' + IsNull ( CONVERT(varchar(3), p.cod_prod_dms ), ''),3) 'entete/@code_produit', -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
		Case 
			When sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
				RIGHT('00000' + IsNull ( CONVERT(varchar(5), p.cod_prod_dms ), ''),5)   -- [PI085] passage de 3 à 5
			Else 
				RIGHT('000' + IsNull ( CONVERT(varchar(3), p.cod_prod_dms ), ''),3) -- [PI085] On laisse ainsi mail de P. Fauvel le 25/05/2020 à 09h16 archivé dans le projet.
		End as 'entete/@code_produit', 
		code_operateur as 'entete/@code_gestionnaire',
		no_dossier_sinistre as 'entete/@no_dossier_sinistre',
		rtrim ( ISNULL ( ref_indemnisation, '' )) as 'entete/@ref_indemnisation', -- [PC13321]
		rtrim(ISNULL ( (Select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' )
				From   sysadm.det_pro dp
				Where dp.id_prod = p.id_prod
				And	  dp.id_code_dp = 136 )
	  		  , '' )) as 'entete/@email_produit', -- [DT154][MANTIS16226]
		code_operateur as 'courrier/@code_gestionnaire',
		app_marque as 'courrier/@app_marque',
		app_modele as 'courrier/@app_modele',
		montant_caution as 'courrier/@montant_caution',
		no_dossier_sinistre as 'courrier/@no_dossier_sinistre',
		date_de_declaration as 'courrier/@date_de_declaration',
		nom_produit as 'courrier/@nom_produit',
		rtrim(nom) as 'courrier/@nom',
		rtrim(prenom) as 'courrier/@prenom',
		rtrim(code_operateur) as 'courrier/@code_operateur',
		lib_opt_produit as 'courrier/@lib_opt_produit',
		app_pret as 'courrier/@app_pret',
		type_appareil as 'courrier/@type_appareil',
		'A' as 'courrier/@code_envoi',
		rtrim(app_marque_rempl) as 'courrier/@app_marque_rempl',
		rtrim(app_modele_rempl) as 'courrier/@app_modele_rempl',
		date_refus as 'courrier/@date_refus',
		rtrim( IsNull ( nom_livraison ,'' )) as 'courrier/@nom_livraison',
		rtrim(IsNull ( adresse1_livraison, '')) as 'courrier/@adresse1_livraison',
		rtrim(IsNull ( adresse2_livraison, '')) as 'courrier/@adresse2_livraison',
		rtrim(IsNull ( cp_ville_livraison, '')) as 'courrier/@cp_ville_livraison',
		rtrim(isNull(adr_mail,'')) as 'courrier/@email',
		rtrim(ISNULL ( civ_livraison, '' )) as 'courrier/@civ_livraison', -- [PM246]
		rtrim(ISNULL ( prenom_livraison, '' )) as 'courrier/@prenom_livraison', -- [PM246]
		rtrim(ISNULL ( adressecplt_livraison, '' )) as 'courrier/@adressecplt_livraison',   -- [PM246]
		rtrim(ISNULL ( transporteur, '' )) as 'courrier/@transporteur', -- [PM246]
		rtrim(ISNULL ( num_bon_trans, '' )) as 'courrier/@num_bon_transp', -- [PM246]
		rtrim(ISNULL ( relance, '' )) as 'courrier/@relance', -- [DT081_EVOL_PRET_BRIS]
		rtrim(ISNULL ( typ_app_pret, '' )) as 'courrier/@typ_app_pret', -- [DT081_EVOL_PRET_BRIS]
		rtrim(ISNULL ( code_pick_up, '' )) as 'courrier/@code_pick_up', -- [PM255]
		rtrim(ISNULL ( dte_arr_plateforme, '' )) as 'courrier/@dte_arr_plateforme', -- [PM250-1]
		rtrim(ISNULL ( dte_dep_centre_distrib, '' )) as 'courrier/@dte_dep_centre_distrib', -- [PM250-1]
		rtrim(ISNULL ( Convert ( VarChar ( 20 ), montant_carte_cadeau ), '' )) as 'courrier/@montant_carte_cadeau', -- [PC13321]
		rtrim(ISNULL ( Convert ( VarChar ( 20 ), id_seq_cmde ), '' )) as 'courrier/@id_seq_cmde', -- [PC13321]		
		rtrim(ISNULL ( code_chq_cadeau, '' )) as 'courrier/@code_chq_cadeau', -- [PC13321]
		rtrim(ISNULL ( (Select sysadm.FN_CLE_VAL ( 'URL_ATLAS', RTRIM ( dp.val_car ) + rtrim ( dp.val_car2), ';' )
						From   sysadm.det_pro dp
						Where dp.id_prod = p.id_prod
						And	  dp.id_code_dp = 119 )
			  		  , '' )) as 'courrier/@ZVAR46', -- [DT154] 
		rtrim(ISNULL ( code_acces_securise, '')) as 'courrier/@code_acces_securise', -- [PM287-3]
		rtrim(ISNULL ( imei, '' )) as 'courrier/@imei', -- [PM234-7][M21970]
		rtrim(ISNULL ( w.maj_par, '' )) as 'courrier/@maj_par', -- [PM234-7][M21970]
		'' as 'courrier/@produit_orange', -- [PM234-7][M21970]
		'' as 'courrier/@Mail_Copie_a_1', -- [PM234-7][M21970]
		rtrim(ISNULL ( environnement, '')) as 'courrier/@environnement', -- [PM287-3]
		rtrim(isNull( adr_mail_cc,'')) as 'courrier/@email_cc', -- [DF006]
		rtrim(isNull( code_refus, '' )) as 'courrier/@code_refus', -- [DF005-1-LOT2]
		rtrim(isNull( nature, '' )) as 'courrier/@nature', -- [DF005-1-LOT2]
		rtrim(isNull( var_enum1, '' )) as 'courrier/@var_enum1', -- [PM287-6][MANTIS26879]
		rtrim(isNull( var_enum2, '' )) as 'courrier/@var_enum2', -- [PM287-6][MANTIS26879]
		rtrim(isNull( numero_relance, '' )) as 'courrier/@numero_relance', -- [PM407-1]
		rtrim(isNull( joindre_courrier_orig, '' )) as 'courrier/@joindre_courrier_orig', -- [PM407-1]
		rtrim(isNull( id_arch_orig, '' )) as 'courrier/@id_arch_orig', -- [PM407-1]
		rtrim(isNull( env_en_recommande, '' )) as 'courrier/@env_en_recommande', -- [PM407-1]
		rtrim(isNull( derniere_relance, '' )) as 'courrier/@derniere_relance', -- [PM407-1]
		rtrim(isNull( date_cour_orig, '' )) as 'courrier/@date_cour_orig', -- [PM407-1]
		rtrim(isNull( date_dern_rel, '' )) as 'courrier/@date_dern_rel', -- [PM407-1]
		rtrim(isNull( categorie_relance, '' )) as 'courrier/@categorie_relance', -- [PM407-1]
		rtrim(isNull( id_inter, '' )) as 'courrier/@id_inter', -- [PM407-1]
		rtrim(isNull( id_doc, '' )) as 'courrier/@id_doc', -- [PM407-1]
		rtrim(isNull( env_par_mail, '' )) as 'courrier/@env_par_mail' -- [PM407-1]


	from sysadm.w_cour_xml_orangev3 w
		inner join sysadm.produit p on p.id_prod=w.code_produit_sinistre
	Where ( no_dossier_sinistre=@dcIdSin or @dcIdSin=-1 ) 
		And ( id_seq = @iIdSeqXml Or @iIdSeqXml is null ) -- [PM246] 
	FOR XML PATH('demande'))
	
	select top 1 @sEmail=isnull(adr_mail,'')
	from sysadm.w_cour_xml_orangev3
	Where ( no_dossier_sinistre=@dcIdSin or @dcIdSin=-1 )
	And ( id_seq = @iIdSeqXml Or @iIdSeqXml is null ) -- [PM246]	
	
	--set @xmlResult=REPLACE(@xmlResult,'email="' + @sEmail + '"/>',
	--	'email="' + @sEmail + '"><tableaux><T1></T1><T2></T2><T3></T3><T4></T4><T5></T5><T6></T6></tableaux></courrier>')
	set @xmlResult=REPLACE(@xmlResult,'/></demande>',
		'><tableaux><T1></T1><T2></T2><T3></T3><T4></T4><T5></T5><T6></T6></tableaux></courrier></demande>')
	Set @xmlResult='<?xml version="1.0" encoding="UTF-8"?><liste_demande>' + 
		@xmlResult +
		'</liste_demande>'

	Update sysadm.w_cour_xml_orangev3
	Set xml_data=@xmlResult
	Where ( no_dossier_sinistre=@dcIdSin or @dcIdSin=-1 ) 
	And ( id_seq = @iIdSeqXml Or @iIdSeqXml is null ) -- [PM246]	
Go	

grant execute on sysadm.PS_S_XML_COUR_ORANGEV3 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_MAJ_XML_COUR_ORANGEV3
-- Auteur               :       FPI
-- Date                 :       12/06/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      13/01/2014   [PM246]
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      23/01/2018   [PM407-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_XML_COUR_ORANGEV3' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_XML_COUR_ORANGEV3
GO

CREATE PROCEDURE sysadm.PS_MAJ_XML_COUR_ORANGEV3 
AS
	Declare @dcIdSin decimal(10,0), -- [PI062]
		@xmlResult varchar(max),
		@iIdSeqMail integer,
		@iIdSeqXml integer
	
	Set @dcIdSin=NULL
	Select top 1 @dcIdSin=no_dossier_sinistre,
				 @iIdSeqMail = id_seq_mail, -- [PM246]
				 @iIdSeqXml=id_seq  -- [PM407-1]
	from sysadm.w_cour_xml_orangev3 
	where xml_data is null
	
	While @dcIdSin is not null
	Begin
		
		--Exec sysadm.PS_S_XML_COUR_ORANGEV3 @dcIdSin, @iIdSeqMail, @xmlResult OUTPUT  -- [PM246]
		Exec sysadm.PS_S_XML_COUR_ORANGEV3 @dcIdSin, @iIdSeqXml, @xmlResult OUTPUT  -- [PM246]
		
		Set @dcIdSin=NULL
		Select top 1 @dcIdSin=no_dossier_sinistre,
					 @iIdSeqMail = id_seq_mail, -- [PM246]
					@iIdSeqXml=id_seq -- [PM407-1]
		from sysadm.w_cour_xml_orangev3 
		where xml_data is null
	End
Go

grant execute on sysadm.PS_MAJ_XML_COUR_ORANGEV3 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_XML_ECHEC_DISTRIB_M2_M3
-- Auteur               :       JFF/FPI
-- Date                 :       13/01/2014
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3] [PM246]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- JFF      08/04/2014   [PM255] M2/M3
-- JFF      05/05/2014   [PM250-1] M27/M28
-- JFF      18/08/2014   [PM254_V1] M29
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_XML_ECHEC_DISTRIB_M2_M3' AND type = 'P' )
        DROP procedure sysadm.PS_S_XML_ECHEC_DISTRIB_M2_M3 
GO

CREATE procedure sysadm.PS_S_XML_ECHEC_DISTRIB_M2_M3
AS

Set NoCount On

delete from sysadm.w_cour_xml_orangev3

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  app_marque,
		  app_modele,
		  montant_caution,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  app_pret,
		  type_appareil,
		  montant_debite, 
		  date_refus,
		  code_maquette,
		  adr_mail,
		  id_seq_mail,
		  civ_livraison,
		  nom_livraison,
		  prenom_livraison,
		  adresse1_livraison,
		  adresse2_livraison,		  
		  adressecplt_livraison,
		  cp_ville_livraison,
		  transporteur, 
		  num_bon_trans,
		  code_pick_up,
		  dte_arr_plateforme,
		  dte_dep_centre_distrib )
	Select s.id_sin, 
		sysadm.FN_CODE_NUM(per.cod_civ,'-CI') as civilite, 
		Case When per.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			 Else sysadm.FN_CODE_NUM(per.cod_civ,'-CL') 
		End as civilite_longue,
		per.nom, 
		per.prenom,
		per.adr_1, 
		per.adr_2, 
		Case per.adr_cp When '00000' then '' Else per.adr_cp End as adr_cp, 
		per.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		cie.lib_cie as lib_compagnie,
		sysadm.FN_GET_LIB_POLICE_V01(s.id_sin,s.id_prod, s.id_rev,-1,NULL) as lib_police,
		s.num_port as num_tel_assure,
		s.marq_port,
		s.modl_port,
		(select val_mt from sysadm.w_div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		s.maj_par as code_operateur,
		Case When Exists (select * from sysadm.commande w
			where w.id_sin=s.id_sin and 
				sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
				and w.cod_etat <> 'ANN')
			Then 'O' Else 'N' End as app_pret,
		Case When Exists (select * from sysadm.commande w
			where w.id_sin=s.id_sin and 
				w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
			Else 'rempl' End as type_appareil,
		(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
		(select convert(varchar(10),wds.maj_le,20) From sysadm.w_div_sin wds Where wds.id_sin = s.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ),
		Case m.typ_mail 
			When 'M2' Then 'MAIL_M2_RCP_APP_SIN_EN_CTR'
			When 'M3' Then 'MAIL_M3_ENV_APP_REPARE_VERS_ASS'
			When 'M27' Then 'MAIL_M27_APP_ARRIVEE_EN_PLATFORM' -- [PM250-1]
			When 'M28' Then 'MAIL_M28_APP_DEPART_DU_CENTRE_DISTRIB' -- [PM250-1]			
			When 'M29' Then 'MAIL_M29_APP_NON_RECPT_EN_CTR' -- [PM254_V1]			
		End as code_maquette,
		i.adr_mail,
		m.id_seq,  -- [PM246]
		IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI'), '') ,
		IsNull ( c.adr_nom, ''),
		IsNull ( c.adr_prenom, ''),
		IsNull ( c.adr_livr1, ''),
		IsNull ( c.adr_livr2, ''),	 
		IsNull ( c.adr_livr_cpl, ''),
		IsNull ( c.adr_cp, '') + ' ' + IsNull ( c.adr_ville, ''),
		Case 
			-- [PM255]
			When Len ( IsNull ( sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' ), '') ) > 0 
			 Then 'chronopost relai pickup'

			-- #3 [DCMP080399] UPS => Lien non directement clickable, l'utilisateur saisira son N° de colis.
			When c.adrfc_nom = 'UPS'
			 Then 'ups'

			-- ChronoPost AA931798942FR
			When IsNumeric ( Left (c.id_bon_transp, 2) ) = 0 And IsNumeric ( Right (c.id_bon_transp, 2) ) = 0 And Len ( c.id_bon_transp ) = 13
			 Then 'chronopost'

			-- Coliposte 8L41585398663
			When IsNumeric ( Left (c.id_bon_transp, 2) ) = 0 And IsNumeric ( Right (c.id_bon_transp, 2) ) = 1 And Len ( c.id_bon_transp ) = 13
			 Then 'coliposte'

			-- Ciblex 24955001116149
			When isNumeric ( c.id_bon_transp ) = 1 And Len ( c.id_bon_transp ) = 14
			 Then 'ciblex'

			Else null
		End,
		c.id_bon_transp,
		IsNull ( sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' ), '') as code_pick_up, -- [PM255]
		Case 
			When IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') = '' Then ''
			Else Right ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4 ) + '-' + Substring ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4, 2 ) + '-' + Left ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 2 ) 
		End as DteArrPlatForm, -- [PM250-1]			
		Case 
			When IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') = '' Then ''
			Else Right ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4 ) + '-' + Substring ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4, 2 ) + '-' + Left ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 2 )
		End as DteDepCentrDistrib -- [PM250-1]			

	from TRACE_MAIL_PRO.sysadm.mail_push m,
		 sysadm.det_pro d,
		 sysadm.sinistre s,
		 sysadm.produit p,
		 sysadm.police pol,
		 sysadm.compagnie cie,
		 sysadm.inter i,
		 sysadm.personne per,
		 sysadm.commande c
	where m.id_appli = 'SIMPA2' 
	and ( m.typ_mail in ( 'M2', 'M27', 'M28', 'M29' ) -- [PM250-1] [PM254_V1]
		 Or ( m.typ_mail = 'M3' And c.id_typ_art = 'PRS' and c.status_gc = 2 ) 
		 Or ( m.typ_mail = 'M3' And c.id_typ_art not in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'EDI', 'PRS', 'REA' )) 
		 )
	and m.mail_trt_ok = 'O'
	and m.mail_id_erreur > 0
	and m.id_arch = -1 -- Marqueur repère de traitement
	and d.id_prod = m.id_prod
	and d.id_code_dp = 94
	and sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER')  -- [PC151270_ORANGE_V3]
	And	s.id_sin=m.id_sin
	And	p.id_prod=s.id_prod
	And	p.id_police=pol.id_police
	And cie.id_cie=pol.id_cie
	And	i.id_sin=s.id_sin
	And i.cod_inter='A'
	And per.id_ordre = s.id_ordre
	And c.id_sin = m.id_sin
	And c.id_seq = Case 
					When ISNUMERIC ( m.alt_quarantaine ) > 0 Then Convert ( integer, m.alt_quarantaine ) 
					Else 0
				   End	
	
 End
Else
 Begin
	Insert into sysadm.w_cour_xml_orangev3 (
		  no_dossier_sinistre,
		  civilite_courte,
		  civilite_longue,
		  nom,
		  prenom,
		  adresse1,
		  adresse2,
		  code_postal,
		  ville,
		  code_produit_sinistre,
		  nom_produit,
		  lib_opt_produit,
		  no_tel_spb,
		  no_fax_spb,
		  assureur,
		  no_police,
		  no_ligne_assuree,
		  app_marque,
		  app_modele,
		  montant_caution,
		  cout_telephonique,
		  date_de_declaration,
		  code_operateur,
		  app_pret,
		  type_appareil,
		  montant_debite, 
		  date_refus,
		  code_maquette,
		  adr_mail,
		  id_seq_mail,
		  civ_livraison,
		  nom_livraison,
		  prenom_livraison,
		  adresse1_livraison,
		  adresse2_livraison,		  
		  adressecplt_livraison,
		  cp_ville_livraison,
		  transporteur, 
		  num_bon_trans,
		  code_pick_up,
		  dte_arr_plateforme,
		  dte_dep_centre_distrib )
	Select s.id_sin, 
		sysadm.FN_CODE_NUM(per.cod_civ,'-CI') as civilite, 
		Case When per.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			 Else sysadm.FN_CODE_NUM(per.cod_civ,'-CL') 
		End as civilite_longue,
		per.nom, 
		per.prenom,
		per.adr_1, 
		per.adr_2, 
		Case per.adr_cp When '00000' then '' Else per.adr_cp End as adr_cp, 
		per.adr_ville,
		p.id_prod,
		(select rtrim(dp66.val_car) 
		 from sysadm.det_pro dp66 
		 where dp66.id_prod=s.id_prod 
		   and dp66.id_code_dp=66) as lib_produit_assure,
		(select rtrim(dp67.val_car) 
		 from sysadm.det_pro dp67 
		 where dp67.id_prod=s.id_prod 
		   and dp67.id_code_dp=67) as lib_option_produit,
		p.num_tel as num_tel_produit,
		p.num_fax,
		cie.lib_cie as lib_compagnie,
		sysadm.FN_GET_LIB_POLICE_V01(s.id_sin,s.id_prod, s.id_rev,-1,NULL) as lib_police,
		s.num_port as num_tel_assure,
		s.marq_port,
		s.modl_port,
		(select val_mt from sysadm.w_div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_val_publique') as mt_caution,
		(select rtrim(dp70.val_car) 
		 from sysadm.det_pro dp70 
		 where dp70.id_prod=s.id_prod 
		   and dp70.id_code_dp=70) as cout_telephonique,
		convert(varchar(10),s.dte_decl,20) as dte_decl,
		s.maj_par as code_operateur,
		Case When Exists (select * from sysadm.commande w
			where w.id_sin=s.id_sin and 
				sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
				and w.cod_etat <> 'ANN')
			Then 'O' Else 'N' End as app_pret,
		Case When Exists (select * from sysadm.commande w
			where w.id_sin=s.id_sin and 
				w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
			Else 'rempl' End as type_appareil,
		(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
		(select convert(varchar(10),wds.maj_le,20) From sysadm.w_div_sin wds Where wds.id_sin = s.id_sin and wds.nom_zone = 'conf_refus_pec' and wds.val_car <> '' ),
		Case m.typ_mail 
			When 'M2' Then 'MAIL_M2_RCP_APP_SIN_EN_CTR'
			When 'M3' Then 'MAIL_M3_ENV_APP_REPARE_VERS_ASS'
			When 'M27' Then 'MAIL_M27_APP_ARRIVEE_EN_PLATFORM' -- [PM250-1]
			When 'M28' Then 'MAIL_M28_APP_DEPART_DU_CENTRE_DISTRIB' -- [PM250-1]			
			When 'M29' Then 'MAIL_M29_APP_NON_RECPT_EN_CTR' -- [PM254_V1]
		End as code_maquette,
		i.adr_mail,
		m.id_seq,  -- [PM246]
		IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI'), '') ,
		IsNull ( c.adr_nom, ''),
		IsNull ( c.adr_prenom, ''),
		IsNull ( c.adr_livr1, ''),
		IsNull ( c.adr_livr2, ''),	 
		IsNull ( c.adr_livr_cpl, ''),
		IsNull ( c.adr_cp, '') + ' ' + IsNull ( c.adr_ville, ''),
		Case 
			-- [PM255]
			When Len ( IsNull ( sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' ), '') ) > 0 
			 Then 'chronopost relai pickup'

			-- #3 [DCMP080399] UPS => Lien non directement clickable, l'utilisateur saisira son N° de colis.
			When c.adrfc_nom = 'UPS'
			 Then 'ups'

			-- ChronoPost AA931798942FR
			When IsNumeric ( Left (c.id_bon_transp, 2) ) = 0 And IsNumeric ( Right (c.id_bon_transp, 2) ) = 0 And Len ( c.id_bon_transp ) = 13
			 Then 'chronopost'

			-- Coliposte 8L41585398663
			When IsNumeric ( Left (c.id_bon_transp, 2) ) = 0 And IsNumeric ( Right (c.id_bon_transp, 2) ) = 1 And Len ( c.id_bon_transp ) = 13
			 Then 'coliposte'

			-- Ciblex 24955001116149
			When isNumeric ( c.id_bon_transp ) = 1 And Len ( c.id_bon_transp ) = 14
			 Then 'ciblex'

			Else null
		End,
		c.id_bon_transp,
		IsNull ( sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' ), '') as code_pick_up, -- [PM255]		
		Case 
			When IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') = '' Then ''
			Else Right ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4 ) + '-' + Substring ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4, 2 ) + '-' + Left ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 2 ) 
		End as DteArrPlatForm, -- [PM250-1]			
		Case 
			When IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') = '' Then ''
			Else Right ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4 ) + '-' + Substring ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 4, 2 ) + '-' + Left ( IsNull ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM( c.info_frn_spb_cplt ), ';' ), '') , 2 )
		End as DteDepCentrDistrib -- [PM250-1]			

	from TRACE_MAIL_TRT.sysadm.mail_push m,
		 sysadm.det_pro d,
		 sysadm.sinistre s,
		 sysadm.produit p,
		 sysadm.police pol,
		 sysadm.compagnie cie,
		 sysadm.inter i,
		 sysadm.personne per,
		 sysadm.commande c
	where m.id_appli = 'SIMPA2' 
	and ( m.typ_mail in ( 'M2', 'M27', 'M28', 'M29' ) -- [PM250-1] [PM254_V1]
		 Or ( m.typ_mail = 'M3' And c.id_typ_art = 'PRS' and c.status_gc = 2 ) 
		 Or ( m.typ_mail = 'M3' And c.id_typ_art not in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'EDI', 'PRS', 'REA' )) 
		 )
	and m.mail_trt_ok = 'O'
	and m.mail_id_erreur > 0
	and m.id_arch = -1 -- Marqueur repère de traitement
	and d.id_prod = m.id_prod
	and d.id_code_dp = 94
	and sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( d.val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER')  -- [PC151270_ORANGE_V3]) 
	And	s.id_sin=m.id_sin
	And	p.id_prod=s.id_prod
	And	p.id_police=pol.id_police
	And cie.id_cie=pol.id_cie
	And	i.id_sin=s.id_sin
	And i.cod_inter='A'
	And per.id_ordre = s.id_ordre
	And c.id_sin = m.id_sin
	And c.id_seq = Case 
					When ISNUMERIC ( m.alt_quarantaine ) > 0 Then Convert ( integer, m.alt_quarantaine ) 
					Else 0
				   End	

	
 End
  
Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3 

Select no_dossier_sinistre,
	   id_seq_mail, 
	   xml_data 
From sysadm.w_cour_xml_orangev3


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_XML_ECHEC_DISTRIB_M2_M3
-- Auteur               :       JFF/FPI
-- Date                 :       13/01/2014
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3] [PM246]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_XML_ECHEC_DISTRIB_M2_M3' AND type = 'P' )
        DROP procedure sysadm.PS_U_XML_ECHEC_DISTRIB_M2_M3 
GO

CREATE procedure sysadm.PS_U_XML_ECHEC_DISTRIB_M2_M3
	@iIdSeq		Integer
AS

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
	Update TRACE_MAIL_PRO.sysadm.mail_push
	Set id_arch = -2
	Where id_seq = @iIdSeq
 End
Else
 Begin
	Update TRACE_MAIL_TRT.sysadm.mail_push
	Set id_arch = -2
	Where id_seq = @iIdSeq
 End

Go

---- [DT081]

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COUR_RESTIT_PRET_HV
-- Auteur               :       JFF
-- Date                 :       27/03/2014
-- Libellé              :       [DT081_EVOL_PRET_BRIS] 
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      31/03/2015   [DT081-4]
-- JFF      06/11/2018   [PM451-1]
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_RESTIT_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_RESTIT_PRET_HV 
GO

CREATE procedure sysadm.PS_S_COUR_RESTIT_PRET_HV
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3
/*
Détail Scan SQL:
Sur Orange V3 239
Et Gti<>10
Si ( présence d’un réparé (2) non annulée 
 Ou présence d’un remplacement hors vol
 Ou présence d’un règlement assuré sur garantie )
Et Dte du jour > (Dte_env_cli + 5 jours ) ou dte_reg (délai)
Et présence d’un prêt sur bris TYP_RELAI=PRET + Len ( TYP_APP_PRET ) > 0 and TYP_APP_PRET <> « ENTREE_GAM » non annulée
Et absence de premier courrier de demande de restit de prêt
Et Absence de DTE_RESTIT_PRET renseignée
*/

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  code_maquette,
	  adr_mail,
	  typ_app_pret)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case    When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	( Select Top 1 Convert ( decimal ( 11, 2 ), IsNull ( sysadm.FN_CLE_VAL ( 'MT_CAUTION', RTRIM ( dp1.val_car), ';' ) , '0' ) )
		  From   sysadm.det_pro dp1
		  Where  dp1.id_prod = s.id_prod
		  And    id_code_dp = 259
		  And    sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM ( dp1.val_car), ';') = sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) 
	) as mt_caution, -- MT_CAUTION	
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	'restit_pret_hors_vol' as code_maquette,
	i.adr_mail,
	IsNull ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ), '' ) as typ_app_pret
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.commande cpret
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		Not Exists ( 
			Select * 
			From	sysadm.gar_sin g
			Where	g.id_sin = s.id_sin
			And     g.id_gti in ( 10 )
		) 
And     (
				Exists ( 
						  Select r.*
						  From	 sysadm.reglement r,
								 sysadm.reg_gti rg
						  Where  r.id_sin = s.id_sin
						  And	 r.cod_inter = 'A'
						  And	 r.cod_mot_reg = 'RN'
						  And	 rg.id_sin = r.id_sin
						  And    rg.id_reg = r.id_reg
						  And    rg.id_gti > 0 
						  And    rg.id_gti not in ( 8 )
						  And	 r.cree_le > '15/01/2015 0:00' -- Modif suite demande Christine/Lisette
						)  
		Or 
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )		
						and c1.cod_etat <> 'ANN' 
						And GetDate() > DateAdd ( day, 5, c1.dte_env_cli ) 
						And	c1.dte_env_cli > '10/01/2015 0:00' -- Modif suite demande Christine/Lisette
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		Or		
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art in ( 'PRS' )		
						and c1.cod_etat <> 'ANN' 
						And ( c1.status_gc in ( 2, 22 ) 
							  Or 
							  -- [VDOC27123]BVID/BVIP/BVIT
							  ( c1.status_gc in ( 21,23 ) and CHARINDEX ( '[BVIE]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVID]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIP]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIT]', c1.comment_frn ) <= 0 And CHARINDEX ( '[PIE]'  , c1.comment_frn ) <= 0 ) -- [VDOC16906] Rempl BVIEOX par PIE
							)  
						And GetDate() > DateAdd ( day, 5, c1.dte_env_cli )
						And	c1.dte_env_cli > '10/01/2015 0:00' -- Modif suite demande Christine/Lisette
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]

					   )
					   
		)  
And		cpret.id_sin = s.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And		( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', cpret.info_frn_spb_cplt, ';' ) ) > 0 
		Or cpret.dte_rcp_mob_cli is not null ) -- [VDOC16906]
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_rest_pret_HV' )
And     Not Exists ( 
				 Select * 
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
				 And    c.cod_etat <> 'ANN'
				)

And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_RESTIT_PRET_HV to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_RESTIT_PRET_HV 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [DT081_EVOL_PRET_BRIS]
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      20/04/2015   [ITSM288077] Je ne modifie plus le code état
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_RESTIT_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_RESTIT_PRET_HV 
GO


CREATE procedure sysadm.PS_U_COUR_RESTIT_PRET_HV
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_rest_pret_HV')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_rest_pret_HV', 'Date Courrier. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 720, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_rest_pret_HV')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_rest_pret_HV', 'Date Courrier. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 720, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

Update	sysadm.commande
Set		cmd_gen_le = null, 
		cmd_gen_par = null, 
		id_lot_cmd = 0, 
		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT', CONVERT ( VarChar ( 10 ) , getdate(), 103 ),
							sysadm.FN_CLE_VAL_E ( 'PRC_ORIG', Isnull ( convert ( varchar (10), c.info_spb_frn ), '' ), rtrim ( c.info_spb_frn_cplt)
							, ';')
							, ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.inter i,
		sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'

Update	sysadm.w_commande
Set		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT', CONVERT ( VarChar ( 10 ) , getdate(), 103 ),
							sysadm.FN_CLE_VAL_E ( 'PRC_ORIG', Isnull ( convert ( varchar (10), c.info_spb_frn ), '' ), rtrim ( c.info_spb_frn_cplt)
							, ';')
							, ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.w_inter i,
		sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'


Select	@sAdrMailErr = i.adr_mail
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And		i.cod_inter = 'A'

Set @sMess = 'Courrier de restitution de prêt (hors vol) '
If @asCas = 'ECHEC_DISTRIB'
	Begin
		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 760
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 760
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COUR_RESTIT_1REL_PRET_HV
-- Auteur               :       JFF
-- Date                 :       27/03/2014
-- Libellé              :       [DT081_EVOL_PRET_BRIS] 
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF		18/02/2015	 [VDOC16906]
-- JFF      31/03/2015   [DT081-4]
-- JFF      06/11/2018   [PM451-1]
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_RESTIT_1REL_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_RESTIT_1REL_PRET_HV 
GO

CREATE procedure sysadm.PS_S_COUR_RESTIT_1REL_PRET_HV
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3
/*
Détail Scan SQL:
Sur Orange V3 239
Et Gti<>10
Si ( présence d’un réparé (2) non annulée 
 Ou présence d’un remplacement hors vol
 Ou présence d’un règlement assuré sur garantie )
Et Dte du jour > ((Dte_env_cli + 5 jours ) ou dte_reg) + 10 jours (délai)
Et présence d’un prêt sur bris TYP_RELAI=PRET + Len ( TYP_APP_PRET ) > 0 and TYP_APP_PRET <> « ENTREE_GAM » non annulée
Et Présence de courrier restit envoyé
Et absence de premier courrier de relance de demande de restit de prêt
Et Absence de DTE_RESTIT_PRET renseignée
*/

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  code_maquette,
	  adr_mail,
	  relance,
	  typ_app_pret)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case    When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	( Select Top 1 Convert ( decimal ( 11, 2 ), IsNull ( sysadm.FN_CLE_VAL ( 'MT_CAUTION', RTRIM ( dp1.val_car), ';' ) , '0' ) )
		  From   sysadm.det_pro dp1
		  Where  dp1.id_prod = s.id_prod
		  And    id_code_dp = 259
		  And    sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM ( dp1.val_car), ';') = sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) 
	) as mt_caution, -- MT_CAUTION
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	'rel_restit_pret_hors_vol' as code_maquette,
	i.adr_mail,
	'rel1',
	IsNull ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ), '' ) as typ_app_pret
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.commande cpret
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		Not Exists ( 
			Select * 
			From	sysadm.gar_sin g
			Where	g.id_sin = s.id_sin
			And     g.id_gti in ( 10 )
		) 

And    (
				Exists ( 
						  Select r.*
						  From	 sysadm.reglement r,
								 sysadm.reg_gti rg
						  Where  r.id_sin = s.id_sin
						  And	 r.cod_inter = 'A'
						  And	 r.cod_mot_reg = 'RN'
						  And	 rg.id_sin = r.id_sin
						  And    rg.id_reg = r.id_reg
						  And    rg.id_gti > 0 
						  And    rg.id_gti not in ( 8 )
						  And    GetDate() > DateAdd ( day, 10, r.cree_le) -- 10 jour 1ère Rel 
						  And	 r.cree_le > '05/01/2015 0:00' -- Modif suite demande Christine/Lisette
						)  
		Or 
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )		
						and c1.cod_etat <> 'ANN' 
						And GetDate() > DateAdd ( day, 10, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 10 jour 1ère Rel + le délai de départ de 5 jours
						And	c1.dte_env_cli > '31/12/2014 0:00' -- Modif suite demande Christine/Lisette
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		Or		
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art in ( 'PRS' )		
						and c1.cod_etat <> 'ANN' 
						And ( c1.status_gc in ( 2, 22 ) 
							  Or 
							  -- [VDOC27123]BVID/BVIP/BVIT
						    ( c1.status_gc in ( 21,23 ) and CHARINDEX ( '[BVIE]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVID]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIP]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIT]', c1.comment_frn ) <= 0 And CHARINDEX ( '[PIE]', c1.comment_frn ) <= 0 ) -- [VDOC16906] Rempl BVIEOX par PIE
							)  
						And    GetDate() > DateAdd ( day, 10, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 10 jour 1ère Rel + le délai de départ de 5 jours
						And	c1.dte_env_cli > '31/12/2014 0:00' -- Modif suite demande Christine/Lisette						
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
					   
		)
And		cpret.id_sin = s.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And		( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', cpret.info_frn_spb_cplt, ';' ) ) > 0 
		Or cpret.dte_rcp_mob_cli is not null ) -- [VDOC16906]
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_rest_pret_HV' and ds.val_dte is not null)
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_1rel_cour_rest_pret_HV' )
And     Not Exists ( 
				 Select * 
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
				 And    c.cod_etat <> 'ANN'
				)

And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_RESTIT_1REL_PRET_HV to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_RESTIT_1REL_PRET_HV 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [DT081_EVOL_PRET_BRIS]
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      20/04/2015   [ITSM288077] Je ne modifie plus le code état
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_RESTIT_1REL_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_RESTIT_1REL_PRET_HV 
GO


CREATE procedure sysadm.PS_U_COUR_RESTIT_1REL_PRET_HV
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_1rel_cour_rest_pret_HV')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_1rel_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_1rel_cour_rest_pret_HV', 'Date Cour. 1èreRel. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 740, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_1rel_cour_rest_pret_HV')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_1rel_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_1rel_cour_rest_pret_HV', 'Date Cour. 1èreRel. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 740, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

Update	sysadm.commande
Set		cmd_gen_le = null, 
		cmd_gen_par = null, 
		id_lot_cmd = 0, 
		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT_1REL', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.inter i,
		sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'

Update	sysadm.w_commande
Set		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT_1REL', CONVERT ( VarChar ( 10 ), getdate(), 103 ), rtrim ( c.info_spb_frn_cplt) , ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.w_inter i,
		sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'


Select	@sAdrMailErr = i.adr_mail
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And		i.cod_inter = 'A'

Set @sMess = 'Courrier de première relance de restitution de prêt (hors vol) '
If @asCas = 'ECHEC_DISTRIB'
	Begin
		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 
	
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 761
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 761
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	
	
  End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COUR_RESTIT_2REL_PRET_HV
-- Auteur               :       JFF
-- Date                 :       27/03/2014
-- Libellé              :       [DT081_EVOL_PRET_BRIS] 
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF		18/02/2015	 [VDOC16906]
-- JFF      31/03/2015   [DT081-4]
-- JFF      06/11/2018   [PM451-1]
-- JFF      21/11/2018   [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_RESTIT_2REL_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_S_COUR_RESTIT_2REL_PRET_HV 
GO

CREATE procedure sysadm.PS_S_COUR_RESTIT_2REL_PRET_HV
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3
/*
Détail Scan SQL:
Sur Orange V3 239
Et Gti<>10
Si ( présence d’un réparé (2) non annulée 
 Ou présence d’un remplacement hors vol
 Ou présence d’un règlement assuré sur garantie )
Et Dte du jour > ((Dte_env_cli + 5 jours ) ou dte_reg) + 15 jours (délai)
Et présence d’un prêt sur bris TYP_RELAI=PRET + Len ( TYP_APP_PRET ) > 0 and TYP_APP_PRET <> « ENTREE_GAM » non annulée
Et Présence de courrier restit envoyé
Et Présence de premier courrier de relance de demande de restit de prêt
Et absence de deuxième courrier de relance de demande de restit de prêt
Et Absence de DTE_RESTIT_PRET renseignée

*/

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      montant_caution,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  code_maquette,
	  adr_mail,
	  relance,
	  typ_app_pret)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case 	When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	( Select Top 1 Convert ( decimal ( 11, 2 ), IsNull ( sysadm.FN_CLE_VAL ( 'MT_CAUTION', RTRIM ( dp1.val_car), ';' ) , '0' ) )
		  From   sysadm.det_pro dp1
		  Where  dp1.id_prod = s.id_prod
		  And    id_code_dp = 259
		  And    sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM ( dp1.val_car), ';') = sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) 
	) as mt_caution, -- MT_CAUTION
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	'rel_restit_pret_hors_vol' as code_maquette,
	i.adr_mail,
	'rel2',
	IsNull ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ), '' ) as typ_app_pret
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.commande cpret
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		Not Exists ( 
			Select * 
			From	sysadm.gar_sin g
			Where	g.id_sin = s.id_sin
			And     g.id_gti in ( 10 )
		) 

And    (
				Exists ( 
						  Select r.*
						  From	 sysadm.reglement r,
								 sysadm.reg_gti rg
						  Where  r.id_sin = s.id_sin
						  And	 r.cod_inter = 'A'
						  And	 r.cod_mot_reg = 'RN'
						  And	 rg.id_sin = r.id_sin
						  And    rg.id_reg = r.id_reg
						  And    rg.id_gti > 0 
						  And    rg.id_gti not in ( 8 )
						  And    GetDate() > DateAdd ( day, 15, r.cree_le ) -- 15 jour 2ème Rel 
						  And	 r.cree_le > '31/12/2014 0:00' -- Modif suite demande Christine/Lisette						  
						)  
		Or 
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', 'PRS', 'EDI' )		
						and c1.cod_etat <> 'ANN' 
						And GetDate() > DateAdd ( day, 15, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 15 jour 2eme Rel + le délai de départ de 5 jours
						And	c1.dte_env_cli > '25/12/2014 0:00' -- Modif suite demande Christine/Lisette						
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		Or		
				Exists (
						Select * 
						from sysadm.commande c1
						Where c1.id_sin = s.id_sin
						and c1.id_typ_art in ( 'PRS' )		
						and c1.cod_etat <> 'ANN' 
						And ( c1.status_gc in ( 2, 22 ) 
							  Or 
							  -- [VDOC27123]BVID/BVIP/B
							  ( c1.status_gc in ( 21,23 ) and CHARINDEX ( '[BVIE]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVID]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIP]', c1.comment_frn ) <= 0 and CHARINDEX ( '[BVIT]', c1.comment_frn ) <= 0 And CHARINDEX ( '[PIE]', c1.comment_frn ) <= 0 ) -- [VDOC16906] Rempl BVIEOX par PIE
							)  
						And    GetDate() > DateAdd ( day, 15, DateAdd ( day, 5, c1.dte_env_cli ) ) -- 15 jour 2eme Rel + le délai de départ de 5 jours
						And	c1.dte_env_cli > '25/12/2014 0:00' -- Modif suite demande Christine/Lisette												
						And ( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', c1.info_frn_spb_cplt, ';' ) ) > 0 
						      Or c1.dte_rcp_mob_cli is not null ) -- [VDOC16906]
					   )
		)
And		cpret.id_sin = s.id_sin		
And		cpret.id_typ_art = 'PST'
And		cpret.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( cpret.info_spb_frn_cplt ), ';' ) = 'PRET'
And     Len ( rtrim ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim( cpret.info_spb_frn_cplt ), ';' ) ) ) > 0 
And		( Len ( sysadm.FN_CLE_VAL ( 'DTE_RCP_MOB_CLI', cpret.info_frn_spb_cplt, ';' ) ) > 0 
		Or cpret.dte_rcp_mob_cli is not null ) -- [VDOC16906]
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_rest_pret_HV' and ds.val_dte is not null)
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_1rel_cour_rest_pret_HV' and ds.val_dte is not null )
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_2rel_cour_rest_pret_HV' )
And     Not Exists ( 
				 Select * 
				 From   sysadm.commande c
				 Where  c.id_sin = s.id_sin
				 And    Len ( rtrim ( sysadm.FN_CLE_VAL ( 'DTE_RESTIT_APP_PRET', rtrim( c.info_frn_spb_cplt ), ';' ))) > 0
				 And    c.cod_etat <> 'ANN'
				)

And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_RESTIT_2REL_PRET_HV to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COUR_RESTIT_2REL_PRET_HV 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [DT081_EVOL_PRET_BRIS]
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COUR_RESTIT_2REL_PRET_HV' AND type = 'P' )
        DROP procedure sysadm.PS_U_COUR_RESTIT_2REL_PRET_HV 
GO

CREATE procedure sysadm.PS_U_COUR_RESTIT_2REL_PRET_HV
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_2rel_cour_rest_pret_HV')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_2rel_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_2rel_cour_rest_pret_HV', 'Date Cour. 2èmeRel. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 760, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_2rel_cour_rest_pret_HV')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_2rel_cour_rest_pret_HV'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_2rel_cour_rest_pret_HV', 'Date Cour. 2èmeRel. restit. prêt HV', '-1', 'N', 'D', 'N', 'N', 760, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

Update	sysadm.commande
Set		cmd_gen_le = null, 
		cmd_gen_par = null, 
		id_lot_cmd = 0, 
		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT_2REL', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.inter i,
		sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'

Update	sysadm.w_commande
Set		id_ref_four = 'DEM_RESTIT',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_COUR_RESTIT_2REL', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';'),
		info_spb_frn = Case
							When i.adr_mail is null Then 910
							Else 912
						 End 
From	sysadm.w_inter i,
		sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_typ_art = 'PST'
And     c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim( c.info_spb_frn_cplt ), ';' ) = 'PRET'
And		i.id_sin = c.id_sin
And     i.cod_inter = 'A'

Select	@sAdrMailErr = i.adr_mail
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And		i.cod_inter = 'A'


Set @sMess = 'Courrier de deuxième relance de restitution de prêt (hors vol) '
If @asCas = 'ECHEC_DISTRIB'
	Begin
		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 
	
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 762
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT, 762
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_IU_INCR_TENT_DEBIT_CAUTION  
-- Auteur               :       JFF
-- Date                 :       21/01/2015
-- Libellé              :       [DT81_2]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_IU_INCR_TENT_DEBIT_CAUTION' AND type = 'P' )
        DROP procedure sysadm.PS_IU_INCR_TENT_DEBIT_CAUTION 
GO

CREATE procedure sysadm.PS_IU_INCR_TENT_DEBIT_CAUTION
        @adcIdSin     Decimal ( 10,0 ),  -- [PI062]
        @sResult	  VarChar ( 30 )
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )
Declare @iValNbre			integer	

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_tent_debit')
	 Begin
	   Update sysadm.w_div_sin Set val_nbre = Isnull ( val_nbre, 0 ) + 1 , maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'cpt_tent_debit'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'cpt_tent_debit', 'Compteur tentative de débit', '-1', 'N', 'N', 'N', 'N', 665, 1, null, null, null, 0, getdate(), getdate(), 'EW' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'cpt_tent_debit')
	 Begin
	   Update sysadm.div_sin Set val_nbre = Isnull ( val_nbre, 0 ) + 1 , maj_le = GETDATE(), maj_par = 'EW' Where id_sin = @adcIdSin And nom_zone = 'cpt_tent_debit'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'cpt_tent_debit', 'Compteur tentative de débit', '-1', 'N', 'N', 'N', 'N', 665, 1, null, null, null, getdate(), getdate(), 'EW', getdate(), 'EW' ) 
	 End
  End

Select @iValNbre = ds.val_nbre
From sysadm.div_sin ds
Where ds.id_sin = @adcIdSin
And   ds.nom_zone = 'cpt_tent_debit'
If @iValNbre is null Or @iValNbre <= 0 Set @iValNbre = 1

If upper ( ltrim( rtrim( @sResult ))) = 'SUCCES'
  Begin
	Set @sMess = 'La tentative numéro ' + convert ( Varchar ( 10), @iValNbre ) + ' de débit de caution a été effectuée. La tentative s''est effectuée avec succès.'
  End 
Else
  Begin
	Set @sMess = 'La tentative numéro ' + convert ( Varchar ( 10), @iValNbre ) + ' de débit de caution a été effectuée. La tentative s''est terminée en échec.'
  End 

	
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT, 762
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EW', 300, @iIdCt OUTPUT, 762
END

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COURKSL_GEOLOCATION_DT150
-- Auteur               :       JFF
-- Date                 :       21/07/2015
-- Libellé              :       [DT150] 
-- Commentaires         :        
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      31/03/2015   [DT081-4]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COURKSL_GEOLOCATION_DT150' AND type = 'P' )
        DROP procedure sysadm.PS_S_COURKSL_GEOLOCATION_DT150 
GO

CREATE procedure sysadm.PS_S_COURKSL_GEOLOCATION_DT150
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      app_pret,
      type_appareil,
      montant_debite, 
	  code_maquette,
	  adr_mail)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case 	When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( w.info_spb_frn_cplt ), ';' ) = 'PRET'
			and w.cod_etat <> 'ANN')
		Then 'O' Else 'N' End as app_pret,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	(select val_mt from sysadm.div_sin d where d.id_sin=s.id_sin and d.nom_zone='mt_debit_caution_paybox') as montant_debite,
	'COURKSL_GEOLOCATION_DT150' as code_maquette,
	i.adr_mail
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.commande c
Where   pers.id_ordre = s.id_ordre
And		c.id_sin = s.id_sin		
And		c.cod_etat <> 'ANN'
And     sysadm.FN_CLE_VAL ( 'GEOLOC', rtrim( c.info_frn_spb_cplt ), ';' ) = 'A_SUPP'
And		c.dte_rcp_frn is not null
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_geolocation' )

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COUR_RESTIT_PRET_HV to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COURKSL_GEOLOCATION_DT150
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [DT150]
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      20/04/2015   [ITSM288077] Je ne modifie plus le code état
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COURKSL_GEOLOCATION_DT150' AND type = 'P' )
        DROP procedure sysadm.PS_U_COURKSL_GEOLOCATION_DT150 
GO


CREATE procedure sysadm.PS_U_COURKSL_GEOLOCATION_DT150
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_geolocation')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_geolocation'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_geolocation', 'Date courrier géolocalisation', '-1', 'N', 'D', 'N', 'N', 765, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_geolocation')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_geolocation'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_geolocation', 'Date courrier géolocalisation', '-1', 'N', 'D', 'N', 'N', 765, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

Select	@sAdrMailErr = i.adr_mail
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And		i.cod_inter = 'A'

Set @sMess = 'Courrier de demande de dé-géolocalisation envoyé.'
If @asCas = 'ECHEC_DISTRIB'
	Begin
		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_COURKSL_PM287_3_INFO_MANQUANTE
-- Auteur               :       JFF
-- Date                 :       21/07/2015
-- Libellé              :       [PM287-3] 
-- Commentaires         :        
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      31/03/2015   [DT081-4]
-- JFF      22/05/2017   [PM287-3] ajout variable environnement
-- JFF      25/09/2017   [PM287-6]
-- JFF      11/01/2018   [PM287-6][MANTIS26879]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COURKSL_PM287_3_INFO_MANQUANTE' AND type = 'P' )
        DROP procedure sysadm.PS_S_COURKSL_PM287_3_INFO_MANQUANTE
GO

CREATE procedure sysadm.PS_S_COURKSL_PM287_3_INFO_MANQUANTE
AS

SET NOCOUNT ON

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      type_appareil,
	  code_maquette,
	  adr_mail,
	  code_acces_securise,
	  environnement,
	  var_enum1,
	  var_enum2)
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case    When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
			Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	'COURKSL_INFO_MANQUANTE_PM287_3' as code_maquette,
	i.adr_mail,
	sysadm.FN_CORR_NUM_CARTE ( 
	Right ( replicate ( '0', 10  ) + Convert ( VarChar ( 10 ) , s.id_sin ), 10 ) +
	'1' +
	Replace ( Right ( Convert ( VarChar ( 50), getdate(), 121 ), 5 ), '.', '' ),
	Getdate() ) as code_acces_securise,
	Case RIGHT( db_name( db_id() ), 3 )
		When 'PRO' Then 'PRODUCTION'
		Else 'RECETTE'
	End as environnement,	 -- [PM287-3] ajout variable environnement
	Case -- [PM287-6][MANTIS26879]
		When CharIndex ( '#305', sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', rtrim ( ltrim ( info_frn_spb_cplt )), ';' ) ) > 0 
			Then '- la fonction « Localiser mon Iphone » est activée sur votre appareil.'
	End,
	Case -- [PM287-6][MANTIS26879]
		When CharIndex ( '#232', sysadm.FN_CLE_VAL ( 'IFDNMQ_RET', rtrim ( ltrim ( info_frn_spb_cplt )), ';' ) ) > 0 
			Then '- votre code verrou ne nous a pas été communiqué.'
	End

From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds,
		sysadm.commande c
Where   pers.id_ordre = s.id_ordre
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'
And     ds.id_sin = i.id_sin
And     ds.nom_zone = 'action_ksl_ec_PM287_3'
And     ds.val_car = 'O'
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_PM287_3_InfoManq' )
And		c.id_sin = s.id_sin
And		c.status_gc = 308

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

grant execute on sysadm.PS_S_COURKSL_PM287_3_INFO_MANQUANTE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_COURKSL_PM287_3_INFO_MANQUANTE
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :       [PM287-3] 
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      20/04/2015   [ITSM288077] Je ne modifie plus le code état
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_COURKSL_PM287_3_INFO_MANQUANTE' AND type = 'P' )
        DROP procedure sysadm.PS_U_COURKSL_PM287_3_INFO_MANQUANTE 
GO

CREATE procedure sysadm.PS_U_COURKSL_PM287_3_INFO_MANQUANTE
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @asCas 	VarChar (35) = null

AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )
Declare @sSaut	VarChar (10)

Set @sSaut = Char (10)

Delete w_div_sin Where id_sin = @adcIdSin and nom_zone = 'action_ksl_ec_PM287_3'
Delete div_sin Where id_sin = @adcIdSin and nom_zone = 'action_ksl_ec_PM287_3'

-- dte_cour_rest_pret_HV
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_PM287_3_InfoManq')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_PM287_3_InfoManq'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_PM287_3_InfoManq', 'Date courr. info manquante PM287-3', '-1', 'N', 'D', 'N', 'N', 765, null, null, GETDATE(), null, 0, getdate(), getdate(), 'EDS' ) 
	 End
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_PM287_3_InfoManq')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_PM287_3_InfoManq'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_PM287_3_InfoManq', 'Date courr. info manquante PM287-3', '-1', 'N', 'D', 'N', 'N', 765, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End
  End

Select	@sAdrMailErr = i.adr_mail
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And		i.cod_inter = 'A'


Set @sMess = '(PM287-3) Courrier KSL automatique de demande d''informations ou de données manquantes sur la prestation, envoyé à l''assuré.'

If @asCas = 'ECHEC_DISTRIB'
	Begin
		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 
Go
