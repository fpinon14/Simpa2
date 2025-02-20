-------------------------------------------------------------------
--
-- Fichier              :       AGENCE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des agences dans SIMPA2
--
-- Procédures           :       DW_S01_AGENCE_LSTDET
-- 				PS_S01_AGENCE
-------------------------------------------------------------------
-- sysadm.DW_S01_AGENCE_LSTDET
-- sysadm.PS_CTRLE_ID_FOUR_FCT_V01
-- sysadm.PS_S01_AGENCE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_AGENCE_LSTDET
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table AGENCE
-- Références           :       Utilis‚ dans W_T_SP_BANQUE (Liste d‚tail)
--
-- Arguments            :       @sIdBq          Varchar (  5 )                  (Val)
--                      :       @sIdAg          Varchar (  5 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_AGENCE_LSTDET' AND type = 'P' )
        DROP procedure sysadm.DW_S01_AGENCE_LSTDET
GO

CREATE procedure sysadm.DW_S01_AGENCE_LSTDET
        @sIdBq          Varchar (  5 ),
        @sIdAg          Varchar (  5 )
AS

If @sIdAg <> '-1' 
 Begin 
	 SELECT agence.id_bq,
		agence.id_ag,
		agence.lib_ag,
		agence.adr_1,
		agence.adr_2,
		agence.adr_cp,
		agence.adr_ville,
		agence.lib_service
	 FROM   sysadm.agence
	 WHERE  agence.id_bq like @sIdBq                AND
		agence.id_ag like @sIdAg
  End
Else
 Begin 
	 SELECT agence.id_bq,
		agence.id_ag,
		agence.lib_ag,
		agence.adr_1,
		agence.adr_2,
		agence.adr_cp,
		agence.adr_ville,
		agence.lib_service
	 FROM   sysadm.agence
	 WHERE  agence.id_bq like @sIdBq

  End

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_AGENCE
-- Auteur               :       Fabry JF
-- Date                 :       10/04/2009
-- Libellé              :        
-- Commentaires         :       [FNAC_PROD_ECH_TECH]  
-- Références           :       
--
-- Arguments            :       @sIdBq          Varchar (  5 )                  (Val)
--                      :       @sIdAg          Varchar (  5 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_AGENCE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_AGENCE
GO

CREATE procedure sysadm.PS_S01_AGENCE
        @sIdBq          Varchar (  5 ),
        @sIdAg          Varchar (  5 ),
	@sRetour Varchar ( 50 ) OUTPUT,
	@sOk Varchar ( 1 ) OUTPUT -- O ou N
As

If @sIdBq in ( '101', '181', '182' ) 
	Begin
	 	Set @sOk = 'O'
	 	Set @sRetour = ''
	 	Return
	End 

If Exists (
	Select  *
	From 	sysadm.agence a
	Where	a.id_bq = @sIdBq
	And 	a.id_ag = @sIdAg
	 )
	 Begin
	 	Set @sOk = 'O'
	 	Set @sRetour = ''
	 End 
Else
	 Begin
		Set @sOk = 'N'
		Set @sRetour = '(Société comptable inexistante)'
	 End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_CTRLE_ID_FOUR_FCT
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2016
-- Libellé              :        
-- Commentaires         :       [VDOC22083]  
-- Références           :       
--
-- Arguments            :       @sIdBq          Varchar (  5 )                  (Val)
--                      :       @sIdAg          Varchar (  5 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      07/06/2016   [DT227]
-- JFF      13/01/2017   [PM363-1]
-- JFF      29/05/2017   [PC151259-2]
-- JFF      14/11/2017   Ajout gestion TOI
-- JFF      20/06/2022   [RS3220_MODDEGR_TELST]
-- JFF      18/02/2025   [202502181556]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CTRLE_ID_FOUR_FCT_V02' AND type = 'P' )
        DROP procedure sysadm.PS_CTRLE_ID_FOUR_FCT_V02
GO

CREATE procedure sysadm.PS_CTRLE_ID_FOUR_FCT_V02
	@adcIdSin Decimal ( 10 ),
	@aiIdSeq  Integer, -- [202502181556]
	@asIdFourFct VarChar ( 3 ),
	@asIdFourAG VarChar ( 3 ) OUTPUT
As

If @asIdFourFct is null Set @asIdFourFct = ''

Select	@asIdFourAG = id_ag
From	sysadm.agence 
where	id_bq = @asIdFourFct

If @asIdFourAG is null Set @asIdFourAG = ''

-- Cas part

-- Ajout gestion TOI
If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande c
		Where	s.id_sin = @adcIdSin
		And		c.id_sin = s.id_sin
		And		c.id_four = 'OMT'
		And		@asIdFourFct = 'TOI'
	)
	Begin
		Return 1
	End 


-- [DT288]
If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande c
		Where	s.id_sin = @adcIdSin
		And		c.id_sin = s.id_sin
		And		c.id_four = 'COR'
		And		@asIdFourFct = 'OSC'
	)
	Begin
		Return 1
	End 
-- [/DT288]

-- [PM363-1]
If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande c
		Where	s.id_sin = @adcIdSin
		And		c.id_sin = s.id_sin
		And		c.id_four = 'BLC'
		And		@asIdFourFct = 'O2M'
	)
	Begin
		Return 1
	End 

If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s
		Where	s.id_sin = @adcIdSin
		And		s.id_prod between 23400 and 23499
		And		@asIdFourFct = 'CAS'
	)
	Begin
		Return 1
	End 

If @asIdFourFct = 'SOG'
	Begin
		Return 1
	End 

If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande_type ct
		Where	s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		@asIdFourFct in ( '101', '181', '182' ) 
		And		ct.id_code_frn = 'FNC'
		)
	Begin
		Return 1 
	End

If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande_type ct
		Where	s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		@asIdFourFct = 'CDS'
		And		ct.id_code_frn = 'VPP'
		)
	Begin
		Return 1 
	End

-- [PC151259-2]
If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.commande_type ct
		Where	s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		@asIdFourFct = 'ADV'
		And		ct.id_code_frn in ( 'EKO', 'NET', 'DGC', 'RAV', 'RTP', 'BK2', 'SFG' )
		)
	Begin
		Return 1 
	End

-- [RS3220_MODDEGR_TELST]
If Exists ( 
	Select	Top 1 1 
	From	sysadm.sinistre s,
			sysadm.commande c
	Where	s.id_sin = @adcIdSin
	And		c.id_sin = s.id_sin
	And		c.id_four = 'O2M'
	And     c.id_typ_art in ( 'TEL', 'TPC', 'RST' ) 
	And     sysadm.FN_CLE_VAL ( 'RS3220', c.info_spb_frn_cplt, ';' ) = 'TLS'
	And		@asIdFourFct = 'TL1'
)
Begin
	Return 1
End 

-- [202502181556] Cas HUB
If Exists ( 
		Select Top 1 1 
		From sysadm.commande c,
			 sysadm.famille_car fc
		Where c.id_sin = @adcIdSin
		And   c.id_seq = @aiIdSeq
		And   Len ( sysadm.FN_CLE_VAL ( 'ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' )) > 0 -- C'est une presta HUB
		And   fc.id_fam = 1
		And   fc.id_typ_code = '-FR'
		And   fc.id_code = @asIdFourFct  -- le fourn fact appartient à la famille des fourns du Hub
	)
	Begin
		Return 1 
	End
 
-- Défaut
If Exists ( 
		Select	Top 1 1 
		From	sysadm.sinistre s,
				sysadm.agence a,
				sysadm.commande_type ct
		Where	s.id_sin = @adcIdSin
		And		ct.id_prod = s.id_prod
		And		a.id_bq = @asIdFourFct
		And		ct.id_code_frn = a.id_ag
		)
	Begin
		Return 1 
	End

Return -1 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_AGENCE
-- Auteur               :       Fabry JF
-- Date                 :       10/04/2009
-- Libellé              :        
-- Commentaires         :       [FNAC_PROD_ECH_TECH]  
-- Références           :       
--
-- Arguments            :       @sIdBq          Varchar (  5 )                  (Val)
--                      :       @sIdAg          Varchar (  5 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_AGENCE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_AGENCE
GO

CREATE procedure sysadm.PS_S02_AGENCE
        @sIdBq          Varchar (  5 ),
        @sIdAg          Varchar (  5 )
As

If Exists (
	Select  *
	From 	sysadm.agence a
	Where	a.id_bq = @sIdBq
	And 	a.id_ag = @sIdAg
	 )
	 Begin
		Return 1
	 End 
Else
	 Begin
		Return 0
	 End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_RECH_FOURN_FACTURATION
-- Auteur               :       Fabry JF
-- Date                 :       10/04/2009
-- Libellé              :        
-- Commentaires         :       [RS-506]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- ERREUR				:  
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECH_FOURN_FACTURATION' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECH_FOURN_FACTURATION
GO

CREATE procedure sysadm.PS_S_RECH_FOURN_FACTURATION
	@asIdMagPropreFourn   Varchar ( 50 ), -- Param d'interrogation, obligatoire
	@asIdFourChapeau      Varchar (  3 ), -- Param d'interrogation, obligatoire
	@asNomMagasin		  VarChar ( 35 ), -- Null si aucun, Param de création
	@asAdr1               VarChar ( 35 ), -- Null si aucun, Param de création
	@asAdr2               VarChar ( 35 ), -- Null si aucun, Param de création
	@asAdrCp              VarChar (  5 ), -- Null si aucun, Param de création
	@asAdrVille           VarChar ( 35 ), -- Null si aucun, Param de création
	@asCodeRetourVolcanes VarChar (  3 )  Output -- Retour par référence
As

Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @iRet integer
Declare @iNbre integer

Set @iRet = 0
Set @sMessage = @sMessage + ''

Set @sMessage = 'Bonjour, ' + CHAR ( 10 )

If @asIdMagPropreFourn is null Set @asIdMagPropreFourn = ''
If @asIdFourChapeau is null Set @asIdFourChapeau = ''

If @asNomMagasin is null Set @asNomMagasin = ''
If @asAdr1 is null Set @asAdr1 = ''
If @asAdr2 is null Set @asAdr2 = ''
If @asAdrCp is null Set @asAdrCp = ''
If @asAdrVille is null Set @asAdrVille = ''

Set @asNomMagasin = sysadm.FN_EPURE_CHAINE_V01 ( rtrim ( ltrim ( Upper ( @asNomMagasin ) )), 'EXCL_SLASHX2' ) 
Set @asAdr1 = sysadm.FN_EPURE_CHAINE_V01 ( rtrim ( ltrim ( Upper ( @asAdr1 ) )), 'EXCL_SLASHX2' )  
Set @asAdr2 = sysadm.FN_EPURE_CHAINE_V01 ( rtrim ( ltrim ( Upper ( @asAdr2 ) )), 'EXCL_SLASHX2' )  
Set @asAdrCp = sysadm.FN_EPURE_CHAINE_V01 ( rtrim ( ltrim ( Upper ( @asAdrCp ) )), 'EXCL_SLASHX2' )  
Set @asAdrVille = sysadm.FN_EPURE_CHAINE_V01 ( rtrim ( ltrim ( Upper ( @asAdrVille ) )), 'EXCL_SLASHX2' )  
Set @asIdMagPropreFourn = sysadm.FN_EPURE_CHAINE_V01 ( lTrim ( rtrim ( @asIdMagPropreFourn )), 'EXCL_SLASHX2' ) 
Set @asIdFourChapeau = sysadm.FN_EPURE_CHAINE_V01 ( lTrim ( rtrim ( @asIdFourChapeau )), 'EXCL_SLASHX2' )


If @asIdMagPropreFourn = '' 
 Begin
	Set @sObjet = 'RS-506 > Rejet d''interrogation, pas de création'
	Set @sMessage = 'Le paramètre @asIdMagPropreFourn n''est pas renseigné, c''est un rejet d''interrogation, je n''engage pas de création.'
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
	Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 

	Set @iRet = -1
 End 

 If @iRet >= 0 
  Begin
	 If @asIdFourChapeau = '' 
	  Begin
		Set @sObjet = 'RS-506 > Rejet d''interrogation, pas de création'
		Set @sMessage = 'Le paramètre @asIdFourChapeau n''est pas renseigné, c''est un rejet d''interrogation, je n''engage pas de création.' + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 

		Set @iRet = -2
	  End 
  End 

 If @iRet >= 0 
  Begin
	 If @asIdFourChapeau Not in ( 'AAF', 'HSA' ) 
	  Begin
		Set @sObjet = 'RS-506 > Rejet d''interrogation, pas de création'
		Set @sMessage = 'Le paramètre @asIdFourChapeau n''est un fournisseur chapeau reconnu, c''est un rejet d''interrogation, je n''engage pas de création.' + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Le paramètre @asIdFourChapeau doit être un des fournisseurs chapeaux connus ci-dessous :'  + CHAR ( 10 )
		Set @sMessage = @sMessage + '- AAF (AFFELELOU)'  + CHAR ( 10 )
		Set @sMessage = @sMessage + '- HSA (HOME SALON)'  + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 
		Set @iRet = -3
	  End 
  End 

If @iRet >= 0 
 Begin
	Select @iNbre = count (*)
	From sysadm.agence a with ( nolock ) 
	Where a.id_ag = @asIdFourChapeau
	And CharIndex ( '/' + Upper ( @asIdMagPropreFourn ) + '/' , rtrim ( a.lib_ag ) ) > 0 
	
	If @iNbre <= 0 and ( @asNomMagasin = '' Or @asAdr1 = '' Or @asAdrCp = '' Or @asAdrVille = '' )
	 Begin
		Set @sObjet = 'RS-506 > Code fournisseur non trouvé, pas de création'
		Set @sMessage = 'Le code fournisseur Volcanes lié au code magasin '+ @asIdMagPropreFourn + ' propre au fournisseur, lui-même lié code fournisseur chapeau ' + @asIdFourChapeau + ', n''a pas été trouvé.' + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Je n''engage pas l''analyse de la création de ce code fournisseur car il manque des données permettant la création du fournisseur .'  + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 
	    Set @iRet = -41	
	 End 

	If @iNbre <= 0 And @iRet >= 0
	  Begin
			Set @sObjet = 'RS-506 > Code fournisseur non trouvé, analyse création'
			Set @sMessage = 'Le code fournisseur Volcanes lié au code magasin '+ @asIdMagPropreFourn + ' propre au fournisseur, lui-même lié au code fournisseur chapeau ' + @asIdFourChapeau + ', n''a pas été trouvé.' + CHAR ( 10 )
			Set @sMessage = @sMessage + 'J''engage l''analyse de la création de ce code fournisseur.'  + CHAR ( 10 )
			Set @sMessage = @sMessage + 'Je reviendrai vers toi pour te dire ce qu''il en est en répondant à ce mail.'  + CHAR ( 10 )
			Set @sMessage = @sMessage + CHAR ( 10 )
			Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
			Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 
			Set @sMessage = @sMessage + 'Chaine exploitable : Insert into sysadm.agence values ( ''XXX'', ''' + @asIdFourChapeau + ''', ''' + @asAdr1 + ''', ''' + @asAdr2 + ''', ''' + @asAdrCp + ''', ''' + @asAdrVille + ''', ''' + Left ( @asNomMagasin + ' ' + @asAdrVille, 35 - Len ( '/' + @asIdMagPropreFourn + '/XXX' ) ) + '/' + @asIdMagPropreFourn + '/XXX'', null, null, null, null, null, getdate(), ''JFF'', getdate() )'

			Set @iRet = -4	
	  End 
 End

If @iNbre > 1 and @iRet >= 0 
  Begin
		Set @sObjet = 'RS-506 > Plus d''un Code fournisseur'
		Set @sMessage = 'Le code fournisseur Volcanes lié au code magasin '+ @asIdMagPropreFourn + ', lui-même lié au propre code fournisseur chapeau ' + @asIdFourChapeau + ', ramène ' + Convert ( varchar (5), @iNbre ) + ' codes volcanes.' + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Je regarde le problème et je reviendrai vers toi pour te dire ce qu''il en est en répondant à ce mail.'  + CHAR ( 10 )
		Set @sMessage = @sMessage + CHAR ( 10 )
		Set @sMessage = @sMessage + 'Infos techniques pour JFF :' + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdMagPropreFourn : ' + @asIdMagPropreFourn + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asIdFourChapeau : ' + @asIdFourChapeau + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asNomMagasin : ' + @asNomMagasin + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr1 : ' + @asAdr1 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdr2 : ' + @asAdr2 + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrCp  : ' + @asAdrCp + CHAR ( 10 ) 
		Set @sMessage = @sMessage + '@asAdrVille : ' + @asAdrVille + CHAR ( 10 ) 
		Set @sMessage = @sMessage + 'Chaine exploitable : Insert into sysadm.agence values ( ''XXX'', ''' + @asIdFourChapeau + ''', ''' + @asAdr1 + ''', ''' + @asAdr2 + ''', ''' + @asAdrCp + ''', ''' + @asAdrVille + ''', ''' + Left ( @asNomMagasin + ' ' + @asAdrVille, 35 - Len ( '/' + @asIdMagPropreFourn + '/XXX' ) ) + '/' + @asIdMagPropreFourn + '/XXX'', null, null, null, null, null, getdate(), ''JFF'', getdate() )'

		Set @iRet = -5	
  End 

If @iRet >= 0 
 Begin
	Select Top 1 @asCodeRetourVolcanes = a.id_bq
	From sysadm.agence a with ( nolock ) 
	Where a.id_ag = @asIdFourChapeau
	And CharIndex ( '/' + Upper ( @asIdMagPropreFourn ) + '/' , rtrim ( a.lib_ag ) ) > 0 
 End

If @iRet < 0 
  Begin

    IF @@servername <> master.dbo.SPB_FN_ServerName ('PRO')	
	  Begin 
		 Set @sObjet = '[RECETTE] ' + @sObjet 
	  End 
	
	Set @sMessage = @sMessage + CHAR ( 10 )	  
	Set @sMessage = @sMessage + 'Interrogation faite le ' + Convert ( varchar ( 10), GetDate(), 103 ) + ' à ' + Convert ( varchar ( 10), GetDate(), 108 ) + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Cordialement,' + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Jean-François FABRY' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'DSI/DEI Equipe SIMPA2' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Legacy Application Tech Lead ' + CHAR ( 10 )
	Set @sMessage = @sMessage + '71, Quai Colbert - 76600 Le Havre - France' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Tél. : +33 (0)2 32 74 22 05' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'www.spb.eu' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'SAS au capital de 1 000 000 euros soumise au contrôle de l’ACPR.' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Siège social : 71, quai Colbert - CS 90000 - 76600 Le Havre. Tél. : +33 (0)2 32 74 20 20' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'N° RCS 305 109 779 (Le Havre) – N°ORIAS 07 002 642 (www.orias.fr).' + CHAR ( 10 )

	Set @sMessage = 'Bonjour Angélique, ' + CHAR ( 10 ) + CHAR ( 10 ) + @sMessage 

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'apeuvrel@spb.eu', -- 'jff@spb.fr', 
			@sMessage, 
			@sObjet, 
			'[RS506_INTCREAMAG]', 
			'jff@spb.fr,mcarpentier@spb.eu', -- 'jff@spb.fr',
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL

 End

If @asCodeRetourVolcanes is null Set @asCodeRetourVolcanes = ''

Return @iRet

Go

