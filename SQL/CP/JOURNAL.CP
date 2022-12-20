-------------------------------------------------------------------
--
-- Fichier              :       JOURNAL.CP
-- Auteur               :       Fabry JF
-- Date                 :       22/05/2019
--
-- Commentaires         :       
--
-- Proc‚dures           :      
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Proc‚dure            :       PS_S_JOURNAL
-- Auteur               :       Fabry JF
-- Date                 :       22/05/2019
-- Libell‚              :
-- Commentaires         :       Lecture du journal.
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_JOURNAL_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_JOURNAL_V01
GO


CREATE procedure sysadm.PS_S_JOURNAL_V01
AS

Declare @dtDtePivot DateTime

Set @dtDtePivot = DateAdd ( Year, -50, Getdate() )

Select	id_cle,
		dte_effet,
		ch_prod,
		objet,
		txt_1,
		txt_2,
		cree_le,
		maj_le,
		maj_par,
		ftu

From   sysadm.journal with (nolock)
Where  dte_effet >= @dtDtePivot

Go

--------------------------------------------------------------------
-- Proc‚dure            :       PS_I_JOURNAL
-- Auteur               :       Fabry JF
-- Date                 :       22/05/2019
-- Libell‚              :
-- Commentaires         :       Insertion dans le journal + Mail MEP.
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
/* Ex d'Appel
	---------------------------
	-- Début section Journal --
	---------------------------
		Exec sysadm.PS_I_JOURNAL
		-- Libellé du projet
		@asLibProjet_PR = 'DT9999',  

		-- Date de livraison en recette
		@asDateLivrRecette_PR = '12/05/2019',

		-- Nom FTU sans chemin, juste le nom du fichier, à copier sur E:\SIMPA2\FTU sous la forme FTU_PM260-5.docx, en Word2016, en bloquant la modification et en lecture seule. null si aucune doc
		@asFTU = 'FTU_PM260-5.docx'

		-- Demandeur sous la forme 'DPG (C. Quertier)' ou 'DPG (C. Quertier, D. Nigaise) et DIF (V. Clapson)'
		@asDemandeur_PR = 'DPG (C. Quertier)',

		-- Prénom(s) demandeur(s) 'Christine' ou 'Christine, Victoria'
		@asPrenomDemandeur_PR = 'Christine',

		-- Adresse(s) mail(s) du demandeur(s) 'cquertier@spb.eu' ou 'cquertier@spb.eu,vclapson@spb.eu'
		@asAdrMailDemandeur_PR = 'cquertier@spb.eu',

		-- Prénom(s) du(des) développeur(s) 'Jean-François' ou 'Jean-François et Fabien' ou 'Jean-François, Fabien'
		@asPrenomDev_PR = 'Jean-François',

		-- Adresse mail du développeur (1 seule adresse !!)
		@asAdrMailDev_PR = 'jff@spb.fr',

		-- Vide '' ou 255 char max, commençant et finissant par un virgule << , >>
		-- Si besoin de plus de place pour les produits, faire un deuxième appel identique en changeant juste la ligne produit.
		@asProduitImpacte_PR = ',9122,9110,9111,9112,9116,9117,9118,9119,9129,9139,9140,9141,9142,9143,51618,51619,51620,51624,51625,51626,51627,51635,9113,9114,9115,9123,9124,9125,9126,9136,9137,9149,9150,51621,51622,51623,51629,51630,51631,51632,9127,9128,9134,9135,51633,51634,9120,',

		-- 100 char, mais Attention à la longueur, ajuster après test d'insertion.
		@asDescriptionCourtProjet_PR = 'Nouvelle notion de Client Premium sur Orange', 

		-- La description détaillé du projet, 255 char max (pas d'espace à la fin ,i lne sera pas interprété) ...demande à xxxxxle textexxxxx, ajuster après test d'insertion
		@asDescriptionLongProjet1_PR = ' ce qu''une nouvelle notion de Client Premium soit créée en plus des Client VIP. Cette notion ne servira uniquement qu''à des fins statistiques pour le DSR. La donnée vient directement',

		-- La suite, 255 char max (gérer l'espace au début si besoin pour le raccord), sinon '', ajuster après test d'insertion
		@asDescriptionLongProjet2_PR = ' des adhésions et se trouve transmise à SIMPA2 par SHERPA, aucune saisie ni modification manuelle.'
	---------------------------
	-- Fin section Journal --
	---------------------------
*/

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_JOURNAL' AND type = 'P' )
        DROP procedure sysadm.PS_I_JOURNAL
GO


CREATE procedure sysadm.PS_I_JOURNAL
	@asLibProjet_PR VarChar ( 100 ),
	@asDateLivrRecette_PR VarChar ( 100 ),
	@asDescriptionCourtProjet_PR VarChar ( 100 ),
	@asProduitImpacte_PR VarChar ( 255 ),
	@asDescriptionLongProjet1_PR VarChar ( 255 ),
	@asDescriptionLongProjet2_PR VarChar ( 255 ),
	@asDemandeur_PR VarChar ( 100 ),
	@asPrenomDemandeur_PR VarChar ( 100 ),
	@asAdrMailDemandeur_PR VarChar ( 100 ),
	@asAdrMailDev_PR VarChar ( 100 ),
	@asPrenomDev_PR  VarChar ( 100 ),
	@asTestMail VarChar ( 10 ),
	@asFTU Varchar ( 255 ) = null

AS

Declare @sMEPR7_PR VarChar ( 20 )
Declare @sSubjectMail_PR VarChar ( 255 )
Declare @sFrom_PR VarChar ( 128)
Declare @sBodyMail_PR VarChar ( 8000 )
Declare @asRetourErr_PR varchar(255)
Declare @sSaut	VarChar (10) 
Declare @sDuDeLa_PR VarChar ( 20 )
Declare @sTaVotre_PR VarChar ( 20 )
Declare @sVdoc_PR VarChar ( 10 )

Set @sSaut = Char (10)
Set @asLibProjet_PR = Upper ( @asLibProjet_PR ) 
Set @sVdoc_PR = Left ( @asLibProjet_PR, 4) 
Set @asFTU = lTrim ( rTrim ( Upper ( @asFTU )))

If @sVdoc_PR = 'VDOC' 
  Begin
	Set @asDescriptionLongProjet1_PR = 'La ' + @asLibProjet_PR + ' pilotée par ' + @asDemandeur_PR + ' demande à ' + @asDescriptionLongProjet1_PR
  End 
Else
  Begin
	Set @asDescriptionLongProjet1_PR = 'Le ' + @asLibProjet_PR + ' piloté par ' + @asDemandeur_PR + ' demande à ' + @asDescriptionLongProjet1_PR
  End 

If ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) <> 'SIMPA2_PRO' And @asTestMail <> 'OUI'
 Begin
	Set @sMEPR7_PR = 'RECETTE'
	Set @asDateLivrRecette_PR = ' (' + @asDateLivrRecette_PR + ')'
 End

If ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) = 'SIMPA2_PRO' Or @asTestMail = 'OUI'
 Begin
	Set @sMEPR7_PR = 'MEP'
	Set @asDateLivrRecette_PR = ''

	If @asTestMail = 'OUI' Set @asAdrMailDemandeur_PR = @asAdrMailDev_PR

	If @sVdoc_PR = 'VDOC' Set @sDuDeLa_PR = 'de la' Else Set @sDuDeLa_PR = 'du'
	IF CharIndex ( ',', @asPrenomDemandeur_PR ) > 0 Set @sTaVotre_PR = 'votre' Else Set @sTaVotre_PR = 'ta'

	Set @sFrom_PR = 'MEP SIMPA2<' + @asAdrMailDev_PR + '>'

	Set	@sSubjectMail_PR = N'MEP SIMPA2 : Mise en production ' + @sDuDeLa_PR + ' ' + @asLibProjet_PR
	Set @sBodyMail_PR = 'Bonjour ' + @asPrenomDemandeur_PR + ',' + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + 'La mise en production ' + @sDuDeLa_PR + ' ' + @asLibProjet_PR + ' a été faite ce matin ' + Convert ( varchar, Getdate(), 103 ) + '.' + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + 'Voici un descriptif rapide de ' + @sTaVotre_PR + ' demande qui pourra être consulté dans le journal des modifications SIMPA2 (pour cela consulter un dossier et cliquer sur le bouton « journal ») : ' + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sMEPR7_PR + ' ' + @asLibProjet_PR + @asDateLivrRecette_PR + ' : ' + @asDescriptionCourtProjet_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @asDescriptionLongProjet1_PR + @asDescriptionLongProjet2_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut

	If @asProduitImpacte_PR <> '' 
		Begin 
			Set @sBodyMail_PR = @sBodyMail_PR + 'Périmètre produits : ' + STUFF ( Left ( @asProduitImpacte_PR , Len ( @asProduitImpacte_PR ) - 1 ), 1, 1, '' ) + @sSaut
			Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
		End 

	Set @sBodyMail_PR = @sBodyMail_PR + 'Cordialement,' + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @sSaut
	Set @sBodyMail_PR = @sBodyMail_PR + @asPrenomDev_PR

	EXEC		 master.dbo.SPB_PS_MAIL
				 @asRetourErr = @asRetourErr_PR OUTPUT,
				 @asTo = @asAdrMailDemandeur_PR,
				 @asTextBody = @sBodyMail_PR,
				 @asSubject = @sSubjectMail_PR,
				 @asFrom = @sFrom_PR,
				 @asCc = @asAdrMailDev_PR,
				 @asFicAttach = NULL,
				 @asQuery = NULL,
				 @asFicQueryOut = NULL,
				 @aiTypeQuery = NULL,
				 @asNomBaseQuery = NULL,
				 @asBcc = NULL

 End 

If @asTestMail <> 'OUI'
  Begin
	Insert into sysadm.journal values ( getdate(), 
	@asProduitImpacte_PR,
	@sMEPR7_PR + ' ' + @asLibProjet_PR + @asDateLivrRecette_PR + ' : ' + @asDescriptionCourtProjet_PR,
	@asDescriptionLongProjet1_PR,
	@asDescriptionLongProjet2_PR,
	getdate(), getdate(), 'JFF',
	@asFTU ) 
  End 
Go


--------------------------------------------------------------------
-- Proc‚dure            :       PS_I_TRACE_JOURNAL
-- Auteur               :       Fabry JF
-- Date                 :       27/09/2019
-- Libell‚              :
-- Commentaires         :       Trace les accès au journal.
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_JOURNAL' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_JOURNAL
GO


CREATE procedure sysadm.PS_I_TRACE_JOURNAL
	@sIdOper Varchar ( 4 ),
	@sTypAction VarChar (20)
AS

Insert sysadm.trace_journal values ( @sIdOper, @sTypAction, getdate(), getdate(), 'JFF' )

GO

--------------------------------------------------------------------
-- Proc‚dure            :       PS_S_TRACE_JOURNAL_DELAI
-- Auteur               :       Fabry JF
-- Date                 :       27/09/2019
-- Libell‚              :
-- Commentaires         :       Trace les accès au journal.
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TRACE_JOURNAL_DELAI' AND type = 'P' )
        DROP procedure sysadm.PS_S_TRACE_JOURNAL_DELAI
GO


CREATE procedure sysadm.PS_S_TRACE_JOURNAL_DELAI
AS

If Exists ( 
		Select Top 1 1  
		From sysadm.journal with (nolock)
		Where DateDiff ( day, dte_effet, getdate ()) <= 3 
	)
	Begin
		Return 1
	End

Return 0

GO

