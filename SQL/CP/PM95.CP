-------------------------------------------------------------------
--
-- Fichier              :       PM95.CP
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
--
-- Commentaires         :       PS affèrant au PM95
--  sysadm.DW_S11_COMMANDE
--  sysadm.PS_I_PM95_PARAMETRAGE_AUTO
--  sysadm.PS_S_PM95_ALERTE_1
--  sysadm.PS_S_PM95_ALERTE_10
--  sysadm.PS_S_PM95_ALERTE_11
--  sysadm.PS_S_PM95_ALERTE_12
--  sysadm.PS_S_PM95_ALERTE_13
--  sysadm.PS_S_PM95_ALERTE_14
--  sysadm.PS_S_PM95_ALERTE_15
--  sysadm.PS_S_PM95_ALERTE_16
--  sysadm.PS_S_PM95_ALERTE_17
--  sysadm.PS_S_PM95_ALERTE_18
--  sysadm.PS_S_PM95_ALERTE_19
--  sysadm.PS_S_PM95_ALERTE_2
--  sysadm.PS_S_PM95_ALERTE_20
--  sysadm.PS_S_PM95_ALERTE_21
--  sysadm.PS_S_PM95_ALERTE_22
--  sysadm.PS_S_PM95_ALERTE_3
--  sysadm.PS_S_PM95_ALERTE_4
--  sysadm.PS_S_PM95_ALERTE_5
--  sysadm.PS_S_PM95_ALERTE_6
--  sysadm.PS_S_PM95_ALERTE_7
--  sysadm.PS_S_PM95_ALERTE_8
--  sysadm.PS_S_PM95_ALERTE_9
--  sysadm.PS_S_PM95_FICHIER_SORTIE_XLS
--  sysadm.PS_S_PM95_RECH_ALERTE_ACTIVE
--  sysadm.PS_U_PM95_BATCH_LANCEMENT
--  sysadm.PS_U_PM95_EPURATION_DOUBLON
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM95_BATCH_LANCEMENT
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF  15/10/2012  [PM95-2]
-- JFF  19/12/2012  [VDOC9815]
-- JFF  19/12/2012  [VDOC9779] 
-- JFF  25/06/2013  [VDOC11482]
-- JFF  04/12/2013  [VDOC13006]
-- JFF  15/06/2015  [DT154]
-- JFF  14/03/2016  [PM287-2]
-- JFF  26/05/2016  [PM287-2][MANTIS20794]
-- JFF  12/02/2016  [PI062]
-- JFF  15/05/2017  [PC13321-3]
-- JFF  28/02/2022  [RS1985]
-- JFF	10/09/2024  [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM95_BATCH_LANCEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM95_BATCH_LANCEMENT
GO

CREATE procedure sysadm.PS_U_PM95_BATCH_LANCEMENT
AS

Declare @sDteExtr  VarChar ( 50 )
Declare @sIdFour   VarChar ( 3 )
Declare @sFicOutOrig  VarChar(255)
Declare @sFicOut   VarChar(255)
Declare @sFicOut2   VarChar(255)
Declare @iCpt      Integer
Declare @sOsqlOption VarChar(255)
Declare @sNomServeur VarChar(255)
Declare @sBase		 VarChar ( 15 )
Declare @sFichierRelance1 VarChar ( 255 )
Declare @sFichierRelance2EtPLUS VarChar ( 255 )
Declare @sCheminR1    VarChar ( 255 )
Declare @sCheminR2    VarChar ( 255 )
Declare @sCheminR3	 VarChar ( 255 )
Declare @sCheminR4	 VarChar ( 255 )
Declare @sRequeteOrig VarChar ( 255 )
Declare @sRequete    VarChar ( 255 )
Declare @sCommande	 VarChar ( 255 )
Declare @iRetOsql    integer
Declare @iFileExist  integer
Declare @sMessage    Varchar(1000)
Declare @sMessContact  Varchar(255)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)
Declare @dcIdSin	 decimal ( 10 ) -- [PI062]
Declare @iIdSeq		 integer
Declare @iIdCle		 integer
Declare @iCptRel	 integer
Declare @iIdAlerte	 integer
Declare @iIdAlerte2	 integer
Declare @iIdCt	 integer
Declare @sNatAlerte varchar(255)
Declare @iRetour	integer 
Declare @sChaineAlerte VarChar ( 50 )
Declare @sIdSecteur VarChar ( 10 )
Declare @RecProd VarChar ( 10 )
Declare @DemRec7 VarChar ( 50 )
Declare @asCasRetour VarChar ( 255 ) -- [DT154]
Declare @sAdrMail VarChar ( 200 )
Declare @iTypContact Integer -- [PM287-2]
Declare @dtMaintenant DateTime
Declare @iAttente Integer

Set @RecProd = 'PROD'
-- Set @RecProd = 'REC7'
-- Set @DemRec7 = 'PM287-5'

DECLARE @tb TABLE 
	( id_four	Varchar ( 3 ) null ,
	  id_secteur Varchar ( 10 ) null ,
	  marquage	integer null 
	)

DECLARE @tb2 TABLE 
	( id_alerte integer null,
	  marquage	integer null 
	)

-----------------------------
-- paramètrage automatique --
-----------------------------
Exec sysadm.PS_I_PM95_PARAMETRAGE_AUTO

--------------------------
-- Repérage des alertes --
--------------------------

-- Nettoyage de la table de travail
Delete From sysadm.w_alerte_frn

-- Alerte n°1 Confirmation RDV pour enlèvement
-- Exec sysadm.PS_S_PM95_ALERTE_1 'TRT_AUTO', null, null, @iRetour OUTPUT

-- Alerte n°2 Confirmation envoi emballage
-- Exec sysadm.PS_S_PM95_ALERTE_2 'TRT_AUTO', null, null, @iRetour OUTPUT

-- Alerte n°3 Retour réception suite RDV
-- Exec sysadm.PS_S_PM95_ALERTE_3 'TRT_AUTO', null, null, @iRetour OUTPUT
		
-- Alerte n°4 Retour diagnostic suite réception 
Exec sysadm.PS_S_PM95_ALERTE_4 'TRT_AUTO', null, null, @iRetour OUTPUT

-- Alerte n°5 Retour diagnostic suite panne aléatoire
Exec sysadm.PS_S_PM95_ALERTE_5 'TRT_AUTO', null, null, @iRetour OUTPUT

/*		
-- Alerte n°6 Retour livraison TV chez O2M
Exec sysadm.PS_S_PM95_ALERTE_6 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- Alerte n°7 Confirmation RDV pour réexpédition
Exec sysadm.PS_S_PM95_ALERTE_7 'TRT_AUTO', null, null, @iRetour OUTPUT	
			
-- Alerte n°8 Retour réexpédition suite RDV 
Exec sysadm.PS_S_PM95_ALERTE_8 'TRT_AUTO', null, null, @iRetour OUTPUT	
		
-- Alerte n°9 Retour renvoi appareil suite demande 
Exec sysadm.PS_S_PM95_ALERTE_9 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- Alerte n°10 Confirmation commande en cours 
Exec sysadm.PS_S_PM95_ALERTE_10 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- Alerte n°11 Confirmation envoi de la commande
Exec sysadm.PS_S_PM95_ALERTE_11 'TRT_AUTO', null, null, @iRetour OUTPUT	
	
-- Alerte n°12 Proposition de remplacement non effectuée suite diagnostic SBE
Exec sysadm.PS_S_PM95_ALERTE_12 'TRT_AUTO', null, null, @iRetour OUTPUT	
		
-- Alerte n°13 Envoi de la commande non confirmé suite validation de la proposition O2M
Exec sysadm.PS_S_PM95_ALERTE_13 'TRT_AUTO', null, null, @iRetour OUTPUT	
*/

-- [PM95-2]
-- [PM287-2]
-- Alerte n°14 relancer le retour de réparation suite réception de l'appareil hors proximité forcée, dés lors que J+2 dépassé

/* [VDOC13006] Shunt des alertes 14 à 19 suite vDoc 13006 d'Olivier Havard le 02/12/2013 (Mep 05/12/2013) */
-- [DT154] Réactivation
Exec sysadm.PS_S_PM95_ALERTE_14 'TRT_AUTO', null, null, @iRetour OUTPUT	

/*
-- Alerte n°15 relancer l'expédition d'un appareil à l'assuré suite commande par SPB, dès lors que J+1 dépassé
Exec sysadm.PS_S_PM95_ALERTE_15 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- Alerte n°16 relancer la demande d'information concernant la réception de l'appareil suite expédition par le fournisseur, dès lors que J+2 dépassé
Exec sysadm.PS_S_PM95_ALERTE_16 'TRT_AUTO', null, null, @iRetour OUTPUT	
*/

-- Alerte n°17 relancer le diagnostic téléphonie hors gti 15 et 18, suite réception de l'appareil, dès lors que J+1 dépassé
Exec sysadm.PS_S_PM95_ALERTE_17 'TRT_AUTO', null, null, @iRetour OUTPUT

-- Alerte n°18 relancer le diagnostic téléphonie hors gti 15 et 18, suite réception de l'appareil, dès lors que J+1 dépassé
Exec sysadm.PS_S_PM95_ALERTE_18 'TRT_AUTO', null, null, @iRetour OUTPUT

-- Alerte n°19 relancer la réexpédition téléphonie hors gti 15 et 18 suite demande SPB, dès lors que J+1 dépassé
Exec sysadm.PS_S_PM95_ALERTE_19 'TRT_AUTO', null, null, @iRetour OUTPUT


-- Alerte n°20 relancer la réexpédition nomade hors gti 15 et 18 suite demande SPB, dès lors que J+1 dépassé
Exec sysadm.PS_S_PM95_ALERTE_20 'TRT_AUTO', null, null, @iRetour OUTPUT

-- [PM287-2]
-- Alerte n°21 relancer le retour de réparation suite réception de l'appareil en proximité forcée, dés lors que J+2 dépassé
Exec sysadm.PS_S_PM95_ALERTE_21 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- [PC13321-3]
-- Alerte n°22 Suite commande de remplacement (de tout type : BA, Chq Cadeau, Tel, TPC, etc...), pas de retour fournisseur (au niveau du statut ) dans le délai attendu.
Exec sysadm.PS_S_PM95_ALERTE_22 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- [RS1985]
-- Alerte n°23 Relancer retour de réparation hors proximité forcée, suite 1er retour 153/154 avec ensuite envoi « à réparer forcé » d''spb, dès que délai attendu dépassé
Exec sysadm.PS_S_PM95_ALERTE_23 'TRT_AUTO', null, null, @iRetour OUTPUT	

-- [RS1985]
-- Alerte n°24 Relancer retour de réparation en proximité forcée, suite 1er retour 153/154 avec ensuite envoi « à réparer forcé » d''spb, dès que délai attendu dépassé
Exec sysadm.PS_S_PM95_ALERTE_24 'TRT_AUTO', null, null, @iRetour OUTPUT	


------------------------------------------------------------------------------------------------
-- Mantis 1998																				  --
-- DEMANDE :																				  --
-- Lors des extractions de relances, ne pas extraire les commandes générés de plus de 3 mois. --
------------------------------------------------------------------------------------------------
Delete from sysadm.w_alerte_frn where cmd_gen_le < DateAdd ( Month, -4, GETDATE() ) 
/* [VDOC11482]
.....And id_alerte < 14
Delete from sysadm.w_alerte_frn where cmd_gen_le < DateAdd ( Day, -15, GETDATE() ) And id_alerte between 14 and 20
*/

-- [PM287-2]
Delete sysadm.w_alerte_frn 
from sysadm.w_alerte_frn w,
	 sysadm.date_pivot dt
where dt.id_cle = 'PM287-2'
And   w.cmd_gen_le < dt.dte_1


-- [VDOC9779] 
Exec sysadm.PS_U_PM95_EPURATION_DOUBLON

----------------------------
-- Complèment des données --
----------------------------
Update	sysadm.w_alerte_frn
Set		nat_alerte = p.nat_alerte,
		marquage = 0
From	sysadm.param_alerte_frn_def p
Where   p.id_alerte = w_alerte_frn.id_alerte

Update	sysadm.w_alerte_frn
Set		typ_app = -- [VDOC9815]
		Case 
			When w_alerte_frn.id_alerte in ( 15, 16 ) Then
				( Select c.id_typ_art
				  From   sysadm.commande c
				  Where  c.id_sin = w_alerte_frn.id_sin
				  And    c.id_seq = w_alerte_frn.id_seq
				 )
			Else rtrim ( sysadm.FN_CODE_CAR ( ds.val_car, '-AR' ))
		End ,
		marq_app = -- [VDOC9815]
		Case 
			When w_alerte_frn.id_alerte in ( 15, 16 ) Then
				( Select c.id_marq_art
				  From   sysadm.commande c
				  Where  c.id_sin = w_alerte_frn.id_sin
				  And    c.id_seq = w_alerte_frn.id_seq
				 )
			Else s.marq_port
		End, 
		modl_app = -- [VDOC9815]
		Case 
			When w_alerte_frn.id_alerte in ( 15, 16 ) Then
				( Select c.id_modl_art
				  From   sysadm.commande c
				  Where  c.id_sin = w_alerte_frn.id_sin
				  And    c.id_seq = w_alerte_frn.id_seq
				 )
			Else s.modl_port
		End, 
		num_serie = -- [VDOC9815] 
		Case 
			When w_alerte_frn.id_alerte in ( 15, 16 ) Then ''
			Else s.num_imei_port
		End, 
		lib_prod = sysadm.FN_LIB_PROD ( s.id_prod ),
		nom_ass = RTrim ( replace (nom_ass, char (9), ' '))
From	sysadm.param_alerte_frn p,
		sysadm.div_sin ds,
		sysadm.sinistre s
Where   ds.id_sin = w_alerte_frn.id_sin
And		ds.nom_zone = 'type_app'
And		s.id_sin = ds.id_sin


---------------------------
-- Ecriture des fichiers --
---------------------------

Set @iCpt = 1

If @RecProd = 'PROD' 
  Begin 
	-- [20240910162546267]
	-- Set @sCheminR1 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\PM287_Rel_Four\Relance1\' -- [PM287-2]
	Set @sCheminR1 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\PM287_Rel_Four\Relance1\' -- [PM287-2]

	-- [20240910162546267]
	-- Set @sCheminR2 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\PM287_Rel_Four\Relance2\' -- [PM287-2]
	Set @sCheminR2 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\PM287_Rel_Four\Relance2\' -- [PM287-2]

	Set @sCheminR3 = '\\F4T\Simpa2\PSM\fic_relances\Relance1\' -- [PM287-2][MANTIS20794]
  End
Else
  Begin 
	-- [20240910162546267]
	-- Set @sCheminR1 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Recette_PM287\Relance1\'-- [PM287-2]
	Set @sCheminR1 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Recette_PM287\Relance1\'-- [PM287-2]

	-- [20240910162546267]
	-- Set @sCheminR2 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Recette_PM287\Relance2\'  -- [PM287-2]
	Set @sCheminR2 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Recette_PM287\Relance2\'  -- [PM287-2]
  End

Set @sFichierRelance1 = '[DATE]_R1_[FOUR]_[SECT].xls'
Set @sFichierRelance2EtPLUS = '[DATE]_R2_ETPLUS_[FOUR]_[SECT].xls'

Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

Select @sDteExtr = Convert( VarChar ( 4 ), YEAR ( Getdate() ) ) +
	   Right ( '00' + Convert( VarChar ( 2 ), Month ( Getdate() ) ) , 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), Day ( Getdate() ) ), 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), DatePart( hour, Getdate() ) ), 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), DatePart( minute, Getdate() ) ), 2 ) 

-- [PM287-2][MANTIS20794]
While ( @iCpt <= 3 And @RecProd = 'PROD' ) Or ( @iCpt <= 2 ) -- OR ( @iCpt <= 4 And @RecProd <> 'PROD' ) -- pour du test -- [PM287-2][MANTIS20794
 Begin
	Select @sFicOutOrig = Case @iCpt
						When 1 Then @sCheminR1 + @sFichierRelance1
						When 2 Then @sCheminR2 + @sFichierRelance2EtPLUS
						When 3 Then @sCheminR3 + @sFichierRelance1 -- [PM287-2][MANTIS20794
						When 4 Then @sCheminR4 + @sFichierRelance2EtPLUS -- [PM287-2][MANTIS20794
					  End 
	Set @sFicOutOrig = Replace ( @sFicOutOrig, '[DATE]', @sDteExtr )
	Set	@sRequeteOrig = 'PS_S_PM95_FICHIER_SORTIE_XLS ''[FOUR]'' , ''[SECT]'', ''[CAS]'''

	
	If @iCpt in ( 1, 3 ) -- [PM287-2][MANTIS20794
	 Begin
		Delete From @tb
		Insert into @tb
		Select  Distinct 
				id_four, 
				id_secteur,
				0
		From  sysadm.w_alerte_frn
		Where cpt_rel = 1

		Set @sRequeteOrig = Replace ( @sRequeteOrig, '[CAS]', 'PREMIERE' )

	 End 
	 
	If @iCpt in ( 2,4 ) -- [PM287-2][MANTIS20794
	 Begin
		Delete From @tb
		Insert into @tb
		Select  Distinct 
				id_four, 
				id_secteur,
				0
		From  sysadm.w_alerte_frn
		Where cpt_rel > 1
		
		Set @sRequeteOrig = Replace ( @sRequeteOrig, '[CAS]', 'SECONDE_ET_PLUS' )		

	 End 

	While Exists ( Select * From @tb where marquage = 0 )
	 Begin
		Select 	Top 1 
			    @sIdFour = rTrim ( id_four ),
			    @sIdSecteur = rTrim ( id_secteur )
		From	@tb
		Where	marquage = 0

		Set @sFicOut = Replace ( @sFicOutOrig, '[FOUR]', @sIdFour )
		Set @sRequete = Replace ( @sRequeteOrig, '[FOUR]', @sIdFour )
		Set @sFicOut = Replace ( @sFicOut, '[SECT]', @sIdSecteur )
		Set @sRequete = Replace ( @sRequete, '[SECT]', @sIdSecteur )

		If right ( rtrim ( @sFicOut), 5 ) = '_.xls'
		 Begin
			Set @sFicOut = Replace ( @sFicOut, '_.xls', '.xls' )
		 End 

		SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				 @sBase + '.sysadm.' + @sRequete + ' ' + 
				 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption

		EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

		-- Pourquoi en PRO ? car il faut être connecté en sa ou sysadmin pour que ça marche, sinon c'est tjs 0
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			Begin
			
				-- 10 d'attente
				/*
				Set @dtMaintenant = GetDate()
				While DATEDIFF ( SECOND, @dtMaintenant, GETDATE() ) <= 10
				 Begin
					Set @iAttente = 1 -- Il faut au moins un ligne de code dans la boucle, code bidon
				 End
			 	*/
				-- EXECUTE xp_fileexist @sFicOut, @iFileExist Output

				-- exec @iFileExist = sysadm.PS_FILE_EXISTS @sFicOut

				Set @iFileExist = 1

			End
		Else
			Begin
				Set @iFileExist = 1
			End

		If @iFileExist in (-1, 0 )
			Begin
				If @RecProd = 'PROD'
				  Begin
					Set @sObjet = 'Traitement PM287 en erreur' -- [PM287-2]
					Set @sAdrMail = 'jff@spb.fr,GG_DSI-DO-PI@spb.eu,GG_DSI-DPG-PROJMET@spb.eu'
				  End 
				Else
				  Begin
					Set @sObjet = 'Traitement PM287 !! RECETTE ' + @DemRec7 + ' !! en erreur' -- [PM287-2]
					Set @sAdrMail = 'jff@spb.fr,fpi@spb.fr'
				  End 
				
				Set @sMessage  = @sObjet + '.'
				Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
				Set @sMessage  = @sMessage + 'Le fichier suivant : ' + @sFicOut + ' ne s''est pas écrit sur disque, le traitement est stoppé.'
				Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
				Set @sMessage  = @sMessage + 'Il peut être relancer sans problème, aucun marquage en base n''a été fait à ce stade du traitement.'

				-- [PM287-2] adresses mail modifiées
				EXEC master.dbo.SPB_PS_MAIL 
						@sRetourErrMail OUTPUT, 
						@sAdrMail,
						@sMessage, 
						@sObjet, 
						'Relance fournisseur PM287-2', 
						'', 
						@sFicOut2, 
						NULL, 
						NULL, 
						NULL, 
						NULL
			
				Return -1
			End 	

		Update @tb
		Set marquage = 1
		Where id_four = @sIdFour
		And   id_secteur = @sIdSecteur
	 End

	Set @iCpt = @iCpt + 1

 End 

----------------------------
-- Marquage des compteurs --
----------------------------
-- [PM95-2]
Insert into sysadm.alerte_frn  (
   id_sin,
   id_seq,
   id_four,
   id_secteur,
   id_alerte,
   cpt_rel,
   cree_le,
   maj_le,
   maj_par    	
)
Select w.id_sin,
	   w.id_seq,
	   w.id_four,
	   w.id_secteur,
	   w.id_alerte,
	   w.cpt_rel,
	   GETDATE(),
	   GETDATE(),
	   'P287' -- [PM287-2]
From sysadm.w_alerte_frn w

-- [PM95-2]	

While Exists ( Select * From sysadm.w_alerte_frn where marquage = 0 )
 Begin
	Select 	Top 1 
			@iIdCle  = id_cle,
		    @dcIdSin = id_sin,
			@iIdSeq = id_seq,
			@iCptRel = cpt_rel,
			@iIdAlerte = id_alerte,
			@sNatAlerte = nat_alerte
	From	sysadm.w_alerte_frn 
	Where	marquage = 0

	Delete From @tb2
	Insert into @tb2
	Select  Distinct
			id_alerte,
			0
	From	sysadm.w_alerte_frn 
	Where	id_sin = @dcIdSin 
	And		id_seq = @iIdSeq

	Set @sChaineAlerte = ''
	While Exists ( Select * From @tb2 where marquage = 0 )
	 Begin
		Select 	Top 1 
			    @iIdAlerte2 = id_alerte
		From	@tb2
		Where	marquage = 0

		Set @sChaineAlerte = @sChaineAlerte + '#' + rTrim ( Convert ( varChar ( 5 ), @iIdAlerte2 ))
		
		Update @tb2
		Set marquage = 1
		Where id_alerte = @iIdAlerte2
	 End
	If @sChaineAlerte <> '' Set @sChaineAlerte = @sChaineAlerte  + '#' 
		
	Update sysadm.commande
	Set    info_spb_frn_cplt = 
					sysadm.FN_CLE_VAL_E ( 'ALERTE', @sChaineAlerte,
					sysadm.FN_CLE_VAL_E ( 'CPT_REL_PM95', convert ( VarChar ( 5 ), @iCptRel), rtrim ( info_spb_frn_cplt) , ';' )
					,';' )
	Where  id_sin = @dcIdSin
	And    id_seq = @iIdSeq
	
	Update sysadm.w_commande
	Set    info_spb_frn_cplt = 					
					sysadm.FN_CLE_VAL_E ( 'ALERTE', @sChaineAlerte,
					sysadm.FN_CLE_VAL_E ( 'CPT_REL_PM95', convert ( VarChar ( 5 ), @iCptRel), rtrim ( info_spb_frn_cplt) , ';' )
					,';' )
	Where  id_sin = @dcIdSin
	And    id_seq = @iIdSeq

	-- [DT154]
	-- [PM287-2] ajout 21
	If @iCptRel = 1 And ( CHARINDEX ( '#14#', @sChaineAlerte ) > 0 Or CHARINDEX ( '#21#', @sChaineAlerte ) > 0 )
	  Begin
		Exec sysadm.PS_S_MAILPUSH_PM95_ALERTE_14 @dcIdSin, @iIdSeq, @asCasRetour OUTPUT
	  End
	-- [DT154]


	-- Contact sans travail uniquement pour la première
	If @iCptRel Between 1 and 2
		Begin
			Set @sMessContact = 'L''alerte suivante a été déclenchée sur ce dossier par l''équipe Gestion Des Prestataires.'
			Set @sMessContact = @sMessContact + Char ( 13 ) + 'Alerte numéro ' + Convert ( VarChar ( 3 ), @iIdAlerte ) + ' : ' + @sNatAlerte 
			
			-- [PM287-2]
			Set @iTypContact = 71 -- 1 ère alerte
			If @iCptRel > 1 
			  Begin 
				Set @iTypContact = 72 -- 2 et plus
			  End 

			IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
			BEGIN
				Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01
								 	-1,		/* Le Client est trouvé automatiquement par la proc */
									3,		/* Famille : Autre */
									@iTypContact,		/* Type de Contact : Information */ -- [PM287-2]
									'I',		/* Canal : Internet */
									@dcIdSin,	/* N° de Sinistre */
									2,		/* Application : Simpa2 */
									@sMessContact,	/* Le message du Contact */
									'P287',		/* Trig. Virtuel PM95*/
									300, 		/* Etat : Contact Clos */
									@iIdCt OUTPUT,	/* le N° de Ct crée, non utilisé */
									577	 /* Résultat de contact */
			END
			ELSE
			BEGIN
				Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	
								 	-1,		/* Le Client est trouvé automatiquement par la proc */
									3,		/* Famille : Autre */
									@iTypContact,		/* Type de Contact : Information */ -- [PM287-2]
									'I',		/* Canal : Internet */
									@dcIdSin,	/* N° de Sinistre */
									2,		/* Application : Simpa2 */
									@sMessContact,	/* Le message du Contact */
									'P287',		/* Trig. Virtuel PM95*/
									300, 		/* Etat : Contact Clos */
									@iIdCt OUTPUT,	/* le N° de Ct crée, non utilisé */
									577	 /* Résultat de contact */
			END
		
		End 

	Update sysadm.w_alerte_frn Set marquage = 1 Where id_cle = @iIdCle

 End

-- Mail de succès
If @RecProd = 'PROD'
	Begin
		Set @sObjet = 'Traitement PM287 terminé avec succès'
		Set @sAdrMail = 'gguisse@spb.eu 
						,pdeotto@spb.eu 
						,acangeli@spb.eu 
						,momont@spb.eu 
						,vandre@spb.eu 
						,msale@spb.eu 
						,kgrenier@spb.eu 
						,sanquetil@spb.eu 
						,pfermey@spb.eu 
						,jsoissons@spb.eu 
						,crighetti@spb.eu 
						,cmechara@spb.eu 
						,fmazouz@spb.eu 
						,eolivier@spb.eu 
						,classale@spb.eu 
						,nhamzaoui@spb.eu 
						,mlebigre@spb.eu 
						,ahaize@spb.eu 
						,cgrout@spb.eu 
						,eduboc@spb.eu 
						,sdelesque@spb.eu 
						,radam@spb.eu 
						,wsaintjorre@spb.eu 
						,mdeschamps@spb.eu' -- [PM287-2]

	End
Else
	Begin
		Set @sObjet = 'Traitement PM287 !! RECETTE ' + @DemRec7 + ' !! terminé avec succès'
		Set @sAdrMail = 'jff@spb.fr,fpi@spb.fr,mdeschamps@spb.eu' -- [PM287-2]
	End
	
Set @sMessage  = @sObjet + '.'
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Les fichiers de première relance se trouvent sur : ' + @sCheminR1
Set @sMessage  = @sMessage + CHAR ( 13 )  
Set @sMessage  = @sMessage + 'Ils ont été envoyés automatiquement aux prestataires concernés.' 
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Les fichiers de deuxième relance (et plus) se trouvent sur : ' + @sCheminR2
Set @sMessage  = @sMessage + CHAR ( 13 )  
Set @sMessage  = @sMessage + 'Ils sont à votre disposition (et vous ont été envoyés par mail).'  -- [PM287-2]
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'ATTENTION : Les fichiers ne peuvent pas être ressortis, ne les perdez pas, travaillez toujours sur une copie.'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		@sAdrMail, -- [PM287-2]
		@sMessage, 
		@sObjet, 
		'Relance fournisseur PM287-2', 
		'', 
		@sFicOut2, 
		NULL, 
		NULL, 
		NULL, 
		NULL

/*
If ( Select SERVERPROPERTY('ServerName' ) ) = 'SQL14DEV\SIMSINISTRES' 
	begin 
		Exec sysadm.PS_U_PM95_BATCH_LANCEMENT
	End
*/

Return 0

Go

grant execute on sysadm.PS_U_PM95_BATCH_LANCEMENT to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I_PM95_PARAMETRAGE_AUTO
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF  15/10/2012  [PM95-2]
-- JFF  07/12/2012  [PM95-2][VDOC9692]
-- JFF	09/01/2011	[VDOC9771]
-- JFF	22/01/2013  [VDOC10072] 
-- JFF  15/06/2015  [DT154]
-- JFF  14/03/2016  [PM287-2]
-- JFF  26/05/2016  [PM287-2][MANTIS20794]
-- JFF  17/10/2016  [VDOC22165]
-- JFF  15/05/2017  [PC13321-3]
-- JFF  08/01/2018  [PM287-5]
-- JFF  28/02/2022  [RS1985]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM95_PARAMETRAGE_AUTO' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM95_PARAMETRAGE_AUTO
GO

CREATE procedure sysadm.PS_I_PM95_PARAMETRAGE_AUTO
AS

-- [VDOC10072]
Delete	sysadm.param_alerte_frn
From	sysadm.param_alerte_frn pf, 
		sysadm.produit p
Where   p.id_prod = pf.id_prod
And		( pf.maj_le = pf.cree_le
		  Or 
		  p.id_corb = 999
		)
-- [VDOC10072]

-- [PM95-2]
-- Alerte 1
-- Passage à 10 en délai, vDoc9024
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
		When 'MS1' Then c.id_code_frn
		When 'SB1' Then c.id_code_frn				
		Else '-1'
	End,     
	1,
	Case c.id_code_frn
		When 'O2M' Then 10 -- vDoc9024
		When 'MS1' Then 10 -- vDoc9024		
		When 'SB1' Then 4 -- vDoc9024				
		Else 4 -- vDoc9024
	End,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' ) )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							When 'MS1' Then c.id_code_frn
							When 'SB1' Then c.id_code_frn							
							Else '-1'
						  End
		And   p.id_alerte = 1				  
	  )		
*/

-- Alerte 2
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	2,
	Case c.id_code_frn
		When 'O2M' Then 3
		When 'MS1' Then 2
		Else 2
	End,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
		  Or		
		  ( c.id_code_frn in ( 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = Case c.id_code_frn
							When 'O2M' Then c.id_gti
							Else '-1'
						 End    
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 2				  
	  )		

*/

-- Alerte 3
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
		Else '-1'
	End,     
	3,  
	2,  -- [VDOC10072] 1 à 2
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
		  Or		
		  ( c.id_code_frn in ( 'SB1', 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							Else '-1'
						  End
		And   p.id_alerte = 3				  
	  )	
*/

-- Alerte 4
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
	End,     
	4,
	Case 
		When c.id_prod between 41000 and 41099 Or
			 c.id_prod between 41100 and 41199 Or
			 c.id_prod between 45100 and 45199 
-- [PM287-2]	 Or	 c.id_prod between 30300 and 30399 
			 Then 3 -- [VDOC10072] 2 à 3			 
		Else 2 -- [VDOC10072] 1 à 2
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' And c.id_gti  in ( 18, 15 ) )		
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
						  End
		And   p.id_alerte = 4
	  )	


-- Alerte 5
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
	End,     
	5,
	4,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )	)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1    
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
						  End
		And   p.id_alerte = 5
	  )	


-- Alerte 6
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	6,
	14, -- [VDOC10072] 7 à 14
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   c.id_code_frn in ( 'SB1' ) And id_code_art = 'EDI'
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti =  -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 6
	  )	
*/

-- Alerte 7
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1 
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,     
	7,
	Case c.id_code_frn -- [VDOC10072] 3 à 4 juste pour O2M et SB1
		When 'O2M' Then 4
		When 'PSM' Then 4
		Else 3
	End, 
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn in ( 'O2M', 'PSM' ) And id_code_art in ( 'EDI', 'PRS') And c.id_gti not in ( 18, 15 ))
/*		  Or
		  ( c.id_code_frn in ( 'SB1', 'MS1' ) And id_code_art = 'EDI' )
		)*/
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							When 'PSM' Then c.id_code_frn
							Else '-1'
						  End
		And   p.id_alerte = 7
	  )	
*/

-- Alerte 8
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
		Else '-1'
	End,     
	8,
	1,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' And c.id_gti  in ( 18, 15 ) )
		  Or		
		  ( c.id_code_frn in ( 'SB1', 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1    
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							Else '-1'
						  End
		And   p.id_alerte = 8
	  )	
*/

-- Alerte 9
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	9,
	Case c.id_code_frn
		When 'O2M' Then 3 -- vDoc9024
		When 'MS1' Then 2 -- vDoc9024		
		Else 3 -- vDoc9024
	End,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' And c.id_gti  in ( 18, 15 ) )
		  Or		
		  ( c.id_code_frn in ( 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 9
	  )	
*/

-- Alerte 10
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
		Else '-1'
	End,     
	10,
	2,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
		  Or		
		  ( c.id_code_frn in ( 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							Else '-1'
						  End
		And   p.id_alerte = 10
	  )	
*/

-- Alerte 11
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,
	Case c.id_code_frn
		When 'O2M' Then c.id_code_frn
		Else '-1'
	End,     
	11,
	15,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
		  Or		
		  ( c.id_code_frn in ( 'MS1' ) And id_code_art = 'EDI' )
		)
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1    
		And   p.id_four = Case c.id_code_frn
							When 'O2M' Then c.id_code_frn
							Else '-1'
						  End
		And   p.id_alerte = 11
	  )	
*/

-- Alerte 12
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	12,
	1,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 12
	  )	
*/

-- Alerte 13
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	13,
	2,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 13
	  )	
*/

-- Alerte 14
-- VDOC9771 Délai 5 PSM 2 O2M
-- [DT154] Délai 2 jour pour PSM
-- [PM287-2][MANTIS20794] PSM Centra 7 jours
-- [PM287-5] ajout nouveau fourn et défaut à 3
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	14,
	Case 
		When c.id_code_frn = 'PSM' Then 7 -- VDOC9771 -- [DT154]  [PM287-2][MANTIS20794]
		When c.id_code_frn = 'O2M' Then 7 -- VDOC9771 [PM287-2] mail Marin 16/08/16: VDOC22165 on pas à 7
		Else 3 -- 2 [PM287-2] mail Marin 16/08/16 -- 3 [PM287-5]
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn In ( 'PSM', 'O2M', 'COR', 'TMT', 'SBE' ) And id_code_art = 'PRS' And c.id_gti not in ( 18, 15 ) )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 14
	  )	

-- Alerte 15
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	15,
	1,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn  in ( 'O2M', 'CIS', 'CEG', 'CDP') And id_code_art Not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI') )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 15
	  )	
*/

-- Alerte 16
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	16,
	Case c.id_code_frn    
		When 'CIS' Then 3  -- [PM95-2][VDOC9692]
		Else 2
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn  in ( 'O2M', 'CIS', 'CEG', 'CDP') And id_code_art Not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI') )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 16
	  )	
*/

-- Alerte 17
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	17,
	1,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c,
		sysadm.det_pro d
Where   ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' And c.id_gti not in ( 18, 15 )) -- [PM287-2] Ajout not in (18,15 )
And d.id_prod = c.id_prod
And d.id_code_dp = 25
And d.id_code_car = 'TEL'
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 17
	  )	

-- Alerte 18
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	18,
	1,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c,
		sysadm.det_pro d
Where   ( c.id_code_frn = 'O2M' And id_code_art = 'EDI' And c.id_gti not in ( 18, 15 ) )
And d.id_prod = c.id_prod
And d.id_code_dp = 25
And d.id_code_car <> 'TEL'
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 18
	  )	

-- Alerte 19
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1 */
/* réactiver le 28/02/2002 suite RS1985 E. Duboc */
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	19,
	4,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c,
		sysadm.det_pro d
Where   c.id_code_frn in ( 'COR', 'O2M', 'PSM', 'SBE' )
And d.id_prod = c.id_prod
And d.id_code_dp = 25
And d.id_code_car = 'TEL'
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 19
	  )	


-- Alerte 20
/* [PM287-2] Shunté car absente du param O2M, PSM, SB1 */
/* réactiver le 28/02/2002 suite RS1985 E. Duboc */
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	20,
	4,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c,
		sysadm.det_pro d
Where   ( c.id_code_frn in ( 'COR', 'O2M', 'PSM', 'SBE' ) And c.id_gti not in ( 18, 15 ) )
And d.id_prod = c.id_prod
And d.id_code_dp = 25
And d.id_code_car <> 'TEL'
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 20
	  )	


-- Alerte 21
-- VDOC9771 Délai 5 PSM 2 O2M
-- [DT154] Délai 2 jour pour PSM
-- [PM287-2][MANTIS20794] PSM Centra 7 jours
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	21,
	Case 
		When c.id_code_frn = 'PSM' Then 3 -- VDOC9771 -- [DT154][PM287-2][MANTIS20794] PSM Centra 7 jours
		Else 3
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn In ( 'PSM' ) And id_code_art = 'PRS' And c.id_gti not in ( 18, 15 ) )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 21
	  )	

-- Alerte 22, [PC13321-3]
-- [PM287-5]
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,
	22,
	Case c.id_code_frn
		When 'ELD' Then 1 -- [PM287-5]
		Else 3 -- [PM287-5]
	End,     
	Case c.id_code_frn
		When 'ELD' Then 'N' -- Une seule relance
		Else 'O'
	End,     
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where    c.id_code_frn in ( 'ELD', 'CDP', 'SBE', 'BK2', 'CEG', 'DME' ) -- 'CIS' pas pour l'instant
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1   
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 22
		)	

-- Alerte 23
-- [RS1985] 7 jours
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	23,
	Case 
		When c.id_code_frn = 'PSM' Then 7 -- VDOC9771 -- [DT154][PM287-2][MANTIS20794] PSM Centra 7 jours
		Else 7
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn In ( 'PSM', 'O2M' ) And id_code_art in ('EDI', 'PRS' ) And c.id_gti not in ( 18, 15 ) )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 23
	  )	

-- Alerte 24
-- [RS1985] 7 jours
Insert into sysadm.param_alerte_frn
Select distinct
	'O',
	c.id_prod,    
	-1,    
	c.id_code_frn,    
	24,
	Case 
		When c.id_code_frn = 'PSM' Then 3 -- VDOC9771 -- [DT154][PM287-2][MANTIS20794] PSM Centra 7 jours
		Else 3
	End ,
	'O',  
	Getdate (),
	Getdate (),
	'PM95'
From	sysadm.commande_type c
Where   ( c.id_code_frn In ( 'PSM' ) And id_code_art in ('EDI', 'PRS' ) And c.id_gti not in ( 18, 15 ) )
-- [PM95-2]
And   Not exists ( 
		Select *
		From sysadm.param_alerte_frn p
		Where p.id_prod = c.id_prod
		And   p.id_gti = -1
		And   p.id_four = c.id_code_frn
		And   p.id_alerte = 24
	  )	

	  
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_1
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF  29/02/2012  VDOC7095 ajout exclusion 159, 169, 162
-- JFF  16/08/2012  [VDOC8323] Ajout 1120
-- JFF      12/02/2016   [PI062]
------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_1' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_1
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_1
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°1 Confirmation RDV pour enlèvement
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 1
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 955, 1255, 1110, 1237, 1120 ) -- [VDOC8323] Ajout 1120
	And		c.status_gc not in ( 156, 159, 169, 162 )  --  VDOC7095 ajout exclusion 159, 169, 162
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j  --ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
	

 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 1
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 955, 1255, 1110, 1237, 1120 ) -- [VDOC8323] Ajout 1120
	And		c.status_gc not in ( 156, 159, 169, 162 )  --  VDOC7095 ajout exclusion 159, 169, 162
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_2
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF  29/02/2011   VDOC6879 - Déclenchement si absence de 163 et absence de 159
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_2
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_2
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°2 Confirmation envoi emballage
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 2
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 935, 936, 940, 941, 1236, 1240 )
	And		c.status_gc not in ( 159, 163 ) -- VDOC6879
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			 ) 
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
  Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End
	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 2
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 935, 936, 940, 941, 1236, 1240 )
	And		c.status_gc not in ( 159, 163 ) -- VDOC6879
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_3
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF  16/08/2012  [VDOC8323] Ajout 1120
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_3' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_3
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_3
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°3 Retour réception suite RDV
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 3
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 955, 1255, 1110, 1237, 1120 ) -- [VDOC8323] Ajout 1120
	And		c.status_gc = 156
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( 
						Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							Else
								Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									Else GETDATE ()
								End
						End,
					   GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 3
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.info_spb_frn in ( 955, 1255, 1110, 1237, 1120 ) -- [VDOC8323] Ajout 1120
	And		c.status_gc = 156
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		sysadm.FN_DATEDIFF ( 
						Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							Else
								Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									Else GETDATE ()
								End
						End,
					   GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_4
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF	20/03/2011	ITSM110314 Pour coller à l'EDB d'origine, je mets Status_gc = 159
-- JFF	16/08/2012	VDOC8130 modif alerte 4
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_4' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_4
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_4
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°4 Retour diagnostic suite réception 
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 4
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
--	And		c.info_spb_frn in ( 955, 1255, 1110, 1237 ) [VDOC8130]
	And		c.status_gc in (0, 159, 309, 310 ) -- ITSM110314 =159 / 0 [VDOC21844]
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		c.dte_rcp_frn is not null
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 4
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
--	And		c.info_spb_frn in ( 955, 1255, 1110, 1237 ) [VDOC8130]
	And		c.status_gc in (0, 159, 309, 310 ) -- ITSM110314 =159 / 0 [VDOC21844]
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		c.dte_rcp_frn is not null
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_5
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_5' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_5
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_5
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°5 Retour diagnostic suite panne aléatoire
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 5
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.status_gc = 162
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		c.dte_rcp_frn is not null
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
  Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.status_gc = 162
	And		c.cod_etat Not in ( 'ANN', 'RFO', 'RPC', 'RSP' )
	And		c.dte_rcp_frn is not null
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
  End
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_6
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF  13/02/2012      [VDOC6449] dte_livr_SBE
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_6' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_6
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_6
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°6 Retour livraison TV chez O2M
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 6
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'PEC_A_RECYCLER'
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	-- [VDOC6449]
	And		IsDate ( sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) ) <> 1 -- Test absence de date valide
	-- /[VDOC6449]
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 6
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'PEC_A_RECYCLER'
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	-- [VDOC6449]
	And		IsDate ( sysadm.FN_CLE_VAL ( 'DTE_LIVR_SBE',c.info_frn_spb_cplt, ';' ) ) <> 1 -- Test absence de date valide
	-- /[VDOC6449]
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_7
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_7' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_7
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_7
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°7 Confirmation RDV pour réexpédition
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 7
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 7
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_8
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_8' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_8
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_8
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°8 Retour réexpédition suite RDV 
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 8
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc = 156
	And		sysadm.FN_DATEDIFF ( 
						Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							Else
								Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									Else GETDATE ()
								End
						End,
						GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End			
 
 If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 8
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc = 156
	And		sysadm.FN_DATEDIFF ( 
						Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 10 ) )
							Else
								Case IsDate ( Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									When 1 Then convert ( Datetime , Left ( sysadm.FN_CLE_VAL ( 'RDV_CONF',c.info_frn_spb_cplt, ';' ), 8 ) )
									Else GETDATE ()
								End
						End,
						GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_9
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF	    05/01/2017   [VDOC25312]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_9' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_9
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_9
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°9 Retour renvoi appareil suite demande 
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 9
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc not in ( 155, 269 )-- [VDOC25312]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)		
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 9
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'REFUSE_A_REEXP'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc not in ( 155, 269 )-- [VDOC25312]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_10
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_10' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_10
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_10
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°10 Confirmation commande en cours 
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 10
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		Left ( c.id_ref_four , 4 ) = 'CMDE'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)				
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 10
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		Left ( c.id_ref_four , 4 ) = 'CMDE'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_11
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_11' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_11
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_11
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°11 Confirmation envoi de la commande
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 11
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		Left ( c.id_ref_four , 4 ) = 'CMDE'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc = 164
	And		sysadm.FN_DATEDIFF ( DateAdd ( day, 2, c.cmd_gen_le) , GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)				
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 11
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		Left ( c.id_ref_four , 4 ) = 'CMDE'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.status_gc = 164
	And		sysadm.FN_DATEDIFF ( DateAdd ( day, 2, c.cmd_gen_le) , GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_12
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_12' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_12
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_12
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°12 Proposition de remplacement non effectuée suite diagnostic SBE
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)
			
	From	sysadm.commande c,
			sysadm.commande c1,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 12
	And		s.id_sin = c.id_sin
	And		c1.id_sin = c.id_sin
	and		c1.id_four = 'SB1'
	and		c1.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c1.status_gc in ( 151, 170 )
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.info_spb_frn in ( 964 )
	And		c.status_gc <> 179 
	And		sysadm.FN_DATEDIFF ( c1.dte_env_cli, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)				
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
 If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.commande c1,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	and		p.alt_actif = 'O'
	And		p.id_alerte = 12
	And		s.id_sin = c.id_sin
	And		c1.id_sin = c.id_sin
	and		c1.id_four = 'SB1'
	and		c1.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c1.status_gc in ( 151, 170 )
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.cod_etat Not in ( 'ANN' )
	And		c.info_spb_frn in ( 964 )
	And		c.status_gc <> 179 
	And		sysadm.FN_DATEDIFF ( c1.dte_env_cli, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_13
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_13' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_13
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_13
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ),-- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°13 Envoi de la commande non confirmé suite validation de la proposition O2M
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB2'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 13
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'DECISION_SPB'
	And		c.info_spb_frn in ( 970 )
	And		c.status_gc <> 165
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 13
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.id_ref_four = 'DECISION_SPB'
	And		c.info_spb_frn in ( 970 )
	And		c.status_gc <> 165
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_14
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF	09/01/2011	VDOC9771
-- JFF  14/03/2016  [PM287-2]
-- JFF  26/05/2016  [PM287-2][MANTIS20794]
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-- JFF		25/11/2016   [VDOC22536]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_14' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_14
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_14
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°14 relancer le retour de réparation suite réception de l'appareil, dés lors que J+2 dépassé, hors info_spb_frn = 2130, donc hors proxi PSM forcée
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB4'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 14
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And		c.status_gc not in ( 266 ) -- [VDOC22536]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 14
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 0, 159, 309, 310  ) -- [VDOC21844]
	And		c.status_gc not in ( 266 ) -- [VDOC22536]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_15
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_15' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_15
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_15
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°15 relancer l'expédition d'un appareil à l'assuré suite commande par SPB, dès lors que J+1 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB5'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 15
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'ALE', 'ACC', 'BAM', 'RES' )
	And     c.dte_env_cli is null
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 15
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'ALE', 'ACC', 'BAM', 'RES' )
	And     c.dte_env_cli is null
	And		c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_16
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF	09/01/2011	VDOC9771
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_16' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_16
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_16
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°16 relancer la demande d'information concernant la réception de l'appareil suite expédition par le fournisseur, dès lors que J+2 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB5'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 16
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'ALE', 'ACC', 'BAM', 'RES' )
	And     c.dte_env_cli is not null
	And   ( 
			(	c.dte_rcp_mob_cli is null
				And	c.cod_etat Not in ( 'ANN' )
				And c.id_four not in ( 'CEG', 'CDP' )
			)
			Or 
			(	c.cod_etat Not in ( 'ANN', 'RPC', 'RFO', 'RSP' )
				And c.id_four in ( 'CEG', 'CDP' )
			)
		  )
	And		sysadm.FN_DATEDIFF ( c.dte_env_cli, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_env_cli ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 16
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art not in ( 'PRS', 'EDI', 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'ALE', 'ACC', 'BAM', 'RES' )
	And     c.dte_env_cli is not null
	And   ( 
			(	c.dte_rcp_mob_cli is null
				And	c.cod_etat Not in ( 'ANN' )
				And c.id_four not in ( 'CEG', 'CDP' )
			)
			Or 
			(	c.cod_etat Not in ( 'ANN', 'RPC', 'RFO', 'RSP'  )
				And c.id_four in ( 'CEG', 'CDP' )
			)
		  )
	And		sysadm.FN_DATEDIFF ( c.dte_env_cli, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_env_cli ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_17
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF	09/01/2011	VDOC9771
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_17' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_17
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_17
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°17 relancer le diagnostic téléphonie hors gti 15 et 18, suite réception de l'appareil, dès lors que J+1 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB1'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 17
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'A_DIAGNOSTIQUER'
	And     c.dte_rcp_frn is not null
	And     c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car = 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 17
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin	
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'A_DIAGNOSTIQUER'
	And     c.dte_rcp_frn is not null
	And     c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car = 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_18
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF	09/01/2011	VDOC9771
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_18' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_18
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_18
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°18 relancer le diagnostic téléphonie hors gti 15 et 18, suite réception de l'appareil, dès lors que J+1 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB3'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 18
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'A_DIAGNOSTIQUER'
	And     c.dte_rcp_frn is not null
	And     c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car <> 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 18
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin	
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'A_DIAGNOSTIQUER'
	And     c.dte_rcp_frn is not null
	And     c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car <> 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_19
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_19' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_19
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_19
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°19 relancer la réexpédition téléphonie hors gti 15 et 18 suite demande SPB, dès lors que J+1 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB1'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 19
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'REFUSE_A_REEXP'
	And     c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car = 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 19
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin	
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'REFUSE_A_REEXP'
	And     c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car = 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_20
-- Auteur               :       FABRY JF
-- Date                 :       15/10/2012
-- Libellé              :        
-- Commentaires         :       [PM95-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF	09/01/2011	ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
-- JFF      12/02/2016   [PI062]
-- JFF      15/09/2016   [VDOC21844]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_20' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_20
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_20
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°20 relancer la réexpédition nomade hors gti 15 et 18 suite demande SPB, dès lors que J+1 dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB3'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 20
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'REFUSE_A_REEXP'
	And     c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car <> 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.div_sin ds,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 20
	And		s.id_sin = c.id_sin
	And		ds.id_sin = s.id_sin	
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_ref_four = 'REFUSE_A_REEXP'
	And     c.status_gc in ( 0, 159 ) -- [VDOC21844]
	And     ds.nom_zone = 'type_app'
	And     ds.val_car <> 'TEL'
	And     c.id_gti not in ( 15, 18 ) 
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_21
-- Auteur               :       FABRY JF
-- Date                 :       14/03/2016
-- Libellé              :        
-- Commentaires         :       [PM287-2]
-- Références           :       
-------------------------------------------------------------------
-- JFF  26/05/2016  [PM287-2][MANTIS20794]
-- JFF      15/09/2016   [VDOC21844]
-- JFF		25/11/2016   [VDOC22536]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_21' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_21
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_21
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°21 relancer le retour de réparation suite réception de l'appareil, dés lors que J+2 dépassé, pour les info_spb_frn = 2130 (proxi PSM obligatoire)
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB4'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 21
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 0, 159, 309, 310  ) -- [VDOC21844]
	And		c.status_gc not in ( 266 ) -- [VDOC22536]
--	And     c.info_spb_frn = 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 21
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 0, 159, 309, 310 ) -- [VDOC21844]
	And		c.status_gc not in ( 266 ) -- [VDOC22536]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_22
-- Auteur               :       FABRY JF
-- Date                 :       17/05/2017
-- Libellé              :        
-- Commentaires         :       [PC13321-3]
-- Références           :       
-------------------------------------------------------------------
-- JFF      08/01/2018   [PM287-5]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_22' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_22
GO

CREATE procedure sysadm.PS_S_PM95_ALERTE_22
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte

-- Alerte n°10 Confirmation commande en cours 
If @sCas = 'TRT_AUTO'
 Begin
 	 With T ( 
				   id_sin,
				   id_seq,
				   id_four,
				   id_secteur,
				   id_ref_four,
				   id_alerte,
				   cpt_rel,
				   info_spb_frn,
				   cmd_gen_le,
				   nom_ass,
				   cmde_rempl )
	As 
	( 
		Select  c.id_sin,
				c.id_seq,
				c.id_four,
				Case c.id_four
					When 'O2M' Then 'SPB2'
					Else ''
				End id_secteur, 
				c.id_ref_four,
				p.id_alerte,
				Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
				c.info_spb_frn,
				c.cmd_gen_le,
				rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom),
				sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' )

		From	sysadm.commande c,
				sysadm.sinistre s,
				sysadm.param_alerte_frn p
			
		Where	p.alt_actif = 'O'
		And		p.id_alerte = 22
		And		s.id_sin = c.id_sin
		And		( s.id_prod = p.id_prod )
		And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
		And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
		And		c.cod_etat Not in ( 'ANN' )
		And		( ( c.status_gc in ( 0 ) And c.id_four not in ( 'DME', 'CEG' ) )-- [VDOC21844]
		          OR 
				  ( c.id_four in ( 'DME', 'CEG' ) And c.cod_etat = 'ECT' ) -- [PM287-5]
				)
		And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 1, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 ; [PC13321-3] Sur demande d'annabelle on rajoute le jour en plus. ELD doit répondre dans la journée, donc le lendemain ils sont déjà en retard.
		And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
		And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
				  Or 
				  (
				   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
				   And
				   p.relance_2 = 'O'
				  )
				)				
		And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
	)
	Insert into sysadm.w_alerte_frn ( 
				id_sin,
				id_seq,
				id_four,
				id_secteur,
				id_ref_four,
				id_alerte,
				cpt_rel,
				info_spb_frn,
				cmd_gen_le,
				nom_ass
				) 
	Select  id_sin,
			id_seq,
			id_four,
			id_secteur,
			id_ref_four,
			id_alerte,
			cpt_rel,
			info_spb_frn,
			cmd_gen_le,
			nom_ass
	From T
	Where T.cmde_rempl = 'A_COMMANDER'

 End

If @sCas = 'SINISTRE'
 Begin

	With T ( id_sin, cmde_rempl )
	As 
	(
	Select	c.id_sin,
			sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' )

	From	sysadm.commande c,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 22
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And		c.cod_etat Not in ( 'ANN' )
	And		( c.status_gc in ( 0 )  -- [VDOC21844]
		          OR 
				  ( c.id_four in ( 'DME', 'CEG' ) And c.cod_etat = 'ECT' ) -- [PM287-5]
			)
	And		sysadm.FN_DATEDIFF ( c.cmd_gen_le, GETDATE (), 1, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 ; [PC13321-3] Sur demande d'annabelle on rajoute le jour en plus. ELD doit répondre dans la journée, donc le lendemain ils sont déjà en retard.
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
	)
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End
	From T
	Where T.cmde_rempl = 'A_COMMANDER'

 End
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_23
-- Auteur               :       FABRY JF
-- Date                 :       28/02/2022
-- Libellé              :        
-- Commentaires         :       [RS1985]
-- Références           :       
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_23' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_23
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_23
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°23 Relancer retour de réparation hors proximité forcée, suite 1er retour 153/154 avec ensuite envoi « à réparer forcé » d''spb, dès que délai attendu dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB4'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.commande c2,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 23
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 153, 154 ) -- [VDOC21844]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And     c2.id_sin = c.id_sin
	And     c2.id_seq > c.id_seq
	And     c2.id_ref_four = 'A_REPARER_FORCE'
	And     c2.cod_etat <> 'ANN'
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.commande c2,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 23
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 153, 154 ) -- [VDOC21844]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And     c2.id_sin = c.id_sin
	And     c2.id_seq > c.id_seq
	And     c2.id_ref_four = 'A_REPARER_FORCE'
	And     c2.cod_etat <> 'ANN'
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go

 --------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_ALERTE_24
-- Auteur               :       FABRY JF
-- Date                 :       28/02/2022
-- Libellé              :        
-- Commentaires         :       [RS1985]
-- Références           :       
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_ALERTE_24' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_ALERTE_24
GO


CREATE procedure sysadm.PS_S_PM95_ALERTE_24
	@sCas	VarChar ( 10 ),
	@dcId_sin	decimal ( 10 ), -- [PI062]
	@iIdSeq	    integer,
	@iRetour	integer OUTPUT
AS

Set @iRetour = 0 -- Pas d'alerte


-- Alerte n°24 Relancer retour de réparation en proximité forcée, suite 1er retour 153/154 avec ensuite envoi « à réparer forcé » d''spb, dès que délai attendu dépassé
If @sCas = 'TRT_AUTO'
 Begin
	Insert into sysadm.w_alerte_frn ( 
			   id_sin,
			   id_seq,
			   id_four,
			   id_secteur,
			   id_ref_four,
			   id_alerte,
			   cpt_rel,
			   info_spb_frn,
			   cmd_gen_le,
			   nom_ass
				) 
	Select  c.id_sin,
			c.id_seq,
			c.id_four,
			Case c.id_four
				When 'O2M' Then 'SPB4'
				Else ''
			End id_secteur, 
			c.id_ref_four,
			p.id_alerte,
			Convert ( Integer , IsNull ( NullIf ( Rtrim ( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';')), '' ), 0 ) ) + 1 'cpt_rel',
			c.info_spb_frn,
			c.cmd_gen_le,
			rtrim ( c.adr_nom ) + ' ' + rtrim (c.adr_prenom)

	From	sysadm.commande c,
			sysadm.commande c2,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	p.alt_actif = 'O'
	And		p.id_alerte = 24
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 153, 154 ) -- [VDOC21844]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And     c2.id_sin = c.id_sin
	And     c2.id_seq > c.id_seq
	And     c2.id_ref_four = 'A_REPARER_FORCE'
	And     c2.cod_etat <> 'ANN'
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		( sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') = ''
			  Or 
			  (
			   sysadm.FN_CLE_VAL ( 'CPT_REL_PM95', rtrim ( c.info_spb_frn_cplt), ';') <> ''	
			   And
			   p.relance_2 = 'O'
			  )
			)
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End
 
If @sCas = 'SINISTRE'
 Begin
	Select  @iRetour = 
				Case 
					When COUNT (*) > 0 Then 1 -- Alerte
					Else 0 -- pas d'alerte
				End

	From	sysadm.commande c,
			sysadm.commande c2,
			sysadm.sinistre s,
			sysadm.param_alerte_frn p
			
	Where	c.id_sin = @dcId_sin
	And		c.id_seq = @iIdSeq
	And		p.alt_actif = 'O'
	And		p.id_alerte = 24
	And		s.id_sin = c.id_sin
	And		( s.id_prod = p.id_prod )
	And		( c.id_gti  = p.id_gti  or ( p.id_gti = -1 and c.id_gti <> p.id_gti   ))
	And		( c.id_four = p.id_four or ( p.id_four = '-1' and c.id_four <> p.id_four ))
	And     c.id_typ_art = 'PRS'
	And     c.dte_rcp_frn is not null
	And		c.status_gc in ( 153, 154 ) -- [VDOC21844]
--	And     c.info_spb_frn <> 2130 -- [PM287-2]
	And     ( c.id_four <> 'PSM'
			  Or
			  ( 
				c.id_four = 'PSM'
				And sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', c.info_frn_spb_cplt, ';' ) = 'OUI'
			  )
			) -- [PM287-2][MANTIS20794]
	And		c.cod_etat Not in ( 'ANN' )
	And     c2.id_sin = c.id_sin
	And     c2.id_seq > c.id_seq
	And     c2.id_ref_four = 'A_REPARER_FORCE'
	And     c2.cod_etat <> 'ANN'
	And		sysadm.FN_DATEDIFF ( c.dte_rcp_frn, GETDATE (), 0, 1, 1 ) > p.del_extr_j -- ITSM97972 on enlève le jour supplèmentaire =>0, 1, 1 VDOC9771 dte_rcp_frn ald cmd_gen_le
	And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'
	And		sysadm.FN_CLE_VAL ( 'PRESTA_REPRISE_BASE_MANUELLE', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI' -- [PM103]
 End

 Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_FICHIER_SORTIE_XLS
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF		14/02/2013	 VDOC10067
-- JFF      14/03/2016   [PM287-2] je trim.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_FICHIER_SORTIE_XLS' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_FICHIER_SORTIE_XLS 
GO

CREATE procedure sysadm.PS_S_PM95_FICHIER_SORTIE_XLS
	@asIdFour VarChar ( 3 ),
	@asIdSecteur VarChar ( 10 ),
	@asCas	  VarChar ( 50 )
AS

-- VDOC10067
If @asIdFour = 'PSM'
	Begin
		Select 
			wa.id_alerte,
			rtrim ( wa.nat_alerte ) 'nat_alerte',
			rtrim ( Convert ( VarChar ( 10), wa.id_sin ) )+ '-' + rtrim ( Convert ( VarChar ( 1) , wa.id_seq )) 'id_sin_seq',
			rtrim ( wa.nom_ass) 'nom_ass',
			rtrim ( wa.typ_app) 'typ_app',
			rtrim ( wa.marq_app) 'marq_app',
			rtrim ( wa.modl_app) 'modl_app',
			'''' + rtrim ( wa.num_serie ) + '''' 'num_serie',
			rtrim ( wa.lib_prod) 'lib_prod',
			rtrim ( wa.id_ref_four) 'id_ref_four',
			'''' + rtrim ( Convert ( VarChar ( 50) , wa.cmd_gen_le, 103 )) + ' ' + rtrim ( Convert ( VarChar ( 50) , wa.cmd_gen_le, 114 )) + '''' 'cmd_gen_le',
			Case 
				When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					Then 'Assuré en pointe de vente'
				When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					Then 'Assuré envoie coli en centralisation'
				Else ''
			End 'pdv_ou_coli_centl',
			Case 
				When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
				When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					Then sysadm.FN_CLE_VAL ( 'NOM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )  -- [PM287-2]
					/*  -- [PM287-2] [VDOC20161]
					Then ( Select Top 1 b.adr_nom
						   From sysadm.boutique b
						   Where b.id_prod = s.id_prod
						   And   Convert ( Integer, b.cod_mag ) = Convert ( Integer, sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ) )
						 )
					*/
				Else ''			
			End 'Nom PSM',
		   Case 
				When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					Then rtrim ( sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' ))
				When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
					-- Then rtrim ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', rtrim( c.info_spb_frn_cplt) , ';' ))
					Then rtrim ( sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )) -- [PM287-2] [VDOC20161]
				Else ''
		   End 'Numéro PSM',
		   rtrim ( c.probleme ) 'probleme' ,
		   rtrim ( Convert ( VarChar ( 10), c.dte_rcp_frn, 103 ) ) 'dte_rcp_frn'

		From	sysadm.w_alerte_frn wa,
				sysadm.commande c,
				sysadm.sinistre s
		Where   wa.id_four = @asIdFour 
		And		wa.id_secteur = @asIdSecteur
		And		( 
					( wa.cpt_rel = 1 And @asCas = 'PREMIERE' )  
				Or  ( wa.cpt_rel > 1 And @asCas = 'SECONDE_ET_PLUS' )  
				)
		And		c.id_sin = wa.id_sin
		And     c.id_seq = wa.id_seq
		And     s.id_sin = wa.id_sin
	End
Else
	Begin
		Select 
			wa.id_alerte,
			rtrim ( wa.nat_alerte ) 'nat_alerte',
			rtrim ( Convert ( VarChar ( 10), wa.id_sin )) + '-' + rtrim ( Convert ( VarChar ( 1) , wa.id_seq )) 'id_sin_seq',
			rtrim ( wa.nom_ass ) 'nom_ass',
			rtrim ( wa.typ_app ) 'typ_app',
			rtrim ( wa.marq_app ) 'marq_app',
			rtrim ( wa.modl_app ) 'modl_app',
			'''' + rtrim ( wa.num_serie ) + '''' 'num_serie',
			rtrim ( wa.lib_prod ) 'lib_prod',
			rtrim ( wa.id_ref_four ) 'id_ref_four',
			'''' + rtrim ( Convert ( VarChar ( 50) , wa.cmd_gen_le, 103 )) + ' ' + rtrim ( Convert ( VarChar ( 50) , wa.cmd_gen_le, 114 )) + '''' 'cmd_gen_le'
		From	sysadm.w_alerte_frn wa,
				sysadm.commande c,
				sysadm.sinistre s
		Where   wa.id_four = @asIdFour 
		And		wa.id_secteur = @asIdSecteur
		And		( 
					( wa.cpt_rel = 1 And @asCas = 'PREMIERE' )  
				Or  ( wa.cpt_rel > 1 And @asCas = 'SECONDE_ET_PLUS' )  
				)
		And		c.id_sin = wa.id_sin
		And     c.id_seq = wa.id_seq
		And     s.id_sin = wa.id_sin		
	End 				
 Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM95_RECH_ALERTE_ACTIVE
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
-------------------------------------------------------------------
-- JFF  15/10/2012  [PM95-2]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM95_RECH_ALERTE_ACTIVE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM95_RECH_ALERTE_ACTIVE
GO


CREATE procedure sysadm.PS_S_PM95_RECH_ALERTE_ACTIVE
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@sChaineRet VarChar ( 500 ) OUTPUT,
	@iRet		Integer	OUTPUT  -- 1 présence du alerte, 0 pas d'alerte
AS

Declare @sChaineAlerte VarChar ( 255 )
Declare @iRetourAlerte integer
Declare @iIdSeq integer
Declare @iCptAlerte integer
Declare @sNatAlerte VarChar ( 255 )
Declare @iNbreAlerte Integer

DECLARE @tb2 TABLE 
	( id_seq integer null,
	  ChaineAlerte VarChar (50) null,
	  marquage	integer null 
	)


Set @iRet = 0

Insert into @tb2
Select  id_seq,
		sysadm.FN_CLE_VAL ( 'ALERTE', Rtrim ( c.info_spb_frn_cplt ), ';' ),
		0
From	sysadm.commande	c
Where   id_sin = @dcIdSin
And     sysadm.FN_CLE_VAL ( 'ALERTE', Rtrim ( c.info_spb_frn_cplt ), ';' ) <> ''
And		sysadm.FN_CLE_VAL ( 'EXCL_REL', rtrim ( c.info_spb_frn_cplt), ';') <> 'OUI'

Set @iRetourAlerte = 0

While Exists ( Select * From @tb2 where marquage = 0 )
 Begin
	Select 	Top 1 
		    @iIdSeq = id_seq,
		    @sChaineAlerte = ChaineAlerte
	From	@tb2
	Where	marquage = 0

	-- [PM95-2]
	Set @iNbreAlerte = 20	 
	-- [PM95-2]
	
	Set @iCptAlerte = 1	 	
	While @iCptAlerte <= @iNbreAlerte 
	 Begin
		If CHARINDEX ( '#' + rTrim ( Convert ( Varchar ( 5), @iCptAlerte )) + '#', @sChaineAlerte, 1 ) > 0 And @iRetourAlerte = 0 
		 Begin
			If @iCptAlerte = 1 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_1 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 2 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_2 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 3
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_4 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 4
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_4 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 5
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_5 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 6
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_6 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 7 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_7 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 8 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_8 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 9 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_9 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 10
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_10 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 11
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_11 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 12
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_12'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 13 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_13 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			-- [PM95-2]
			If @iCptAlerte = 14 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_14 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 15 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_15 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 16 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_16 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 17 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_17 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 18 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_18 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 19 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_19 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			If @iCptAlerte = 20 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_20 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			-- [PM95-2]

			-- [PM287-2]
			If @iCptAlerte = 21 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_21 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 

			-- [PC13321-3]
			-- [PM287-5]
			If @iCptAlerte = 22 
				Begin
					Exec sysadm.PS_S_PM95_ALERTE_22 'SINISTRE', @dcIdSin, @iIdSeq, @iRetourAlerte OUTPUT
					If @iRetourAlerte > 0 Break
				End 
		 End 
		 Set @iCptAlerte  = @iCptAlerte +  1
	 End

	If @iRetourAlerte > 0 Break

	Update @tb2
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

 If @iRetourAlerte > 0 
  Begin
	Set @iRet = 1
	
	Select @sNatAlerte = p.nat_alerte
	From   sysadm.param_alerte_frn_def p
	Where  p.id_alerte = @iCptAlerte 
	
	Set @sChaineRet = 'L''alerte "Rappel Fournisseur" numéro ' + CONVERT ( Varchar ( 5 ), @iCptAlerte ) + ' "' + rTrim ( @sNatAlerte ) + '" est toujours active sur la prestation ' + CONVERT ( VarChar( 10 ), @dcIdSin ) + '-' + CONVERT ( VarChar( 1 ), @iIdSeq ) + '.'
	Set @sChaineRet = @sChaineRet + CHAR ( 13 )
	Set @sChaineRet = @sChaineRet + 'Il est donc impossible de faire un rappel fournisseur classique, vous devez faire un SC24.'
	
  End 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM95_EPURATION_DOUBLON
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------
-- JFF  19/12/2012  [VDOC9779]
-- JFF  12/02/2016  [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM95_EPURATION_DOUBLON' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM95_EPURATION_DOUBLON
GO

CREATE procedure sysadm.PS_U_PM95_EPURATION_DOUBLON
AS

DECLARE @tb TABLE 
	( id_cle	integer identity,
	  id_sin	decimal (10 ), -- [PI062]
	  id_seq	integer,
	  id_alerte integer,
	  nbre      integer,	  
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 ) -- [PI062]
Declare @iIdSeq integer
Declare @iIdCle integer
Declare @iIdAlerte integer

Insert into @tb
select id_sin, 
	   id_seq, 
	   id_alerte, 
	   count(*),
	   0
from sysadm.w_alerte_frn 
group by id_sin, id_seq, id_alerte
Having COUNT (*) > 1

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdCle = id_cle,		
		@dcIdSin = id_sin,
		@iIdSeq = id_seq
	From	@tb
	Where	marquage = 0

	Delete sysadm.w_alerte_frn 
	From sysadm.w_alerte_frn wa
	Where wa.id_sin = @dcIdSin 
	And   wa.id_seq = @iIdSeq 
	And   wa.id_cle <> ( Select MIN ( wa2.id_cle )
						 From  sysadm.w_alerte_frn wa2
						 Where wa2.id_sin = wa.id_sin
						 And   wa2.id_seq = wa.id_seq
						 And   wa2.id_alerte = wa.id_alerte
						)

	Update @tb
	Set marquage = 1
	Where id_cle = @iIdCle 
 End

Go

--------------------------------------------------------------------
--
-- Procédure            :       PM95_PM287_PS_REECRIRE_LES_FICHIERS
-- Auteur               :       FABRY JF
-- Date                 :       02/01/2017
-- Libellé              :        
-- Commentaires         :       [PM287-2]
-- Références           :      -- Regénère les fichiers à partir de ce qu'il y a dans w_alerte.
--
-------------------------------------------------------------------
-- JFF  19/12/2012  [VDOC9779]
-- JFF  12/02/2016  [PI062]
-- JFF	10/09/2024  [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PM95_PM287_PS_REECRIRE_LES_FICHIERS' AND type = 'P' )
        DROP procedure sysadm.PM95_PM287_PS_REECRIRE_LES_FICHIERS
GO


CREATE procedure sysadm.PM95_PM287_PS_REECRIRE_LES_FICHIERS
AS

-- Regénère les fichiers à partir de ce qu'il y a dans w_alerte.

Declare @sDteExtr  VarChar ( 50 )
Declare @sIdFour   VarChar ( 3 )
Declare @sFicOutOrig  VarChar(255)
Declare @sFicOut   VarChar(255)
Declare @sFicOut2   VarChar(255)
Declare @iCpt      Integer
Declare @sOsqlOption VarChar(255)
Declare @sNomServeur VarChar(255)
Declare @sBase		 VarChar ( 15 )
Declare @sFichierRelance1 VarChar ( 255 )
Declare @sFichierRelance2EtPLUS VarChar ( 255 )
Declare @sCheminR1    VarChar ( 255 )
Declare @sCheminR2    VarChar ( 255 )
Declare @sCheminR3	 VarChar ( 255 )
Declare @sCheminR4	 VarChar ( 255 )
Declare @sRequeteOrig VarChar ( 255 )
Declare @sRequete    VarChar ( 255 )
Declare @sCommande	 VarChar ( 255 )
Declare @iRetOsql    integer
Declare @iFileExist  integer
Declare @sMessage    Varchar(1000)
Declare @sMessContact  Varchar(255)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)
Declare @dcIdSin	 decimal ( 10 ) -- [PI062]
Declare @iIdSeq		 integer
Declare @iIdCle		 integer
Declare @iCptRel	 integer
Declare @iIdAlerte	 integer
Declare @iIdAlerte2	 integer
Declare @iIdCt	 integer
Declare @sNatAlerte varchar(255)
Declare @iRetour	integer 
Declare @sChaineAlerte VarChar ( 50 )
Declare @sIdSecteur VarChar ( 10 )
Declare @RecProd VarChar ( 10 )
Declare @DemRec7 VarChar ( 50 )
Declare @asCasRetour VarChar ( 255 ) -- [DT154]
Declare @sAdrMail VarChar ( 200 )
Declare @iTypContact Integer -- [PM287-2]
Declare @dtMaintenant DateTime
Declare @iAttente Integer

Set @RecProd = 'PROD'
--Set @RecProd = 'REC7'
Set @DemRec7 = 'PM287-2'

DECLARE @tb TABLE 
	( id_four	Varchar ( 3 ) null ,
	  id_secteur Varchar ( 10 ) null ,
	  marquage	integer null 
	)

DECLARE @tb2 TABLE 
	( id_alerte integer null,
	  marquage	integer null 
	)


---------------------------
-- Ecriture des fichiers --
---------------------------

Set @iCpt = 1

If @RecProd = 'PROD' 
  Begin 
	-- [20240910162546267]
	-- Set @sCheminR1 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\PM287_Rel_Four\Relance1\' -- [PM287-2]
	Set @sCheminR1 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\PM287_Rel_Four\Relance1\' -- [PM287-2]

	-- [20240910162546267]
	-- Set @sCheminR2 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\PM287_Rel_Four\Relance2\' -- [PM287-2]
	Set @sCheminR2 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\PM287_Rel_Four\Relance2\' -- [PM287-2]

	Set @sCheminR3 = '\\F4T\Simpa2\PSM\fic_relances\Relance1\' -- [PM287-2][MANTIS20794]
  End
Else
  Begin 
	-- [20240910162546267]
	-- Set @sCheminR1 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Recette_PM287\Relance1\'-- [PM287-2]
	Set @sCheminR1 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Recette_PM287\Relance1\'-- [PM287-2]

	-- [20240910162546267]
	-- Set @sCheminR2 = '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Recette_PM287\Relance2\'  -- [PM287-2]
	Set @sCheminR2 = sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Recette_PM287\Relance2\'  -- [PM287-2]
  End

Set @sFichierRelance1 = '[DATE]_R1_[FOUR]_[SECT].xls'
Set @sFichierRelance2EtPLUS = '[DATE]_R2_ETPLUS_[FOUR]_[SECT].xls'

Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

Select @sDteExtr = Convert( VarChar ( 4 ), YEAR ( Getdate() ) ) +
	   Right ( '00' + Convert( VarChar ( 2 ), Month ( Getdate() ) ) , 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), Day ( Getdate() ) ), 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), DatePart( hour, Getdate() ) ), 2 ) +
	   Right ( '00' + Convert( VarChar ( 2 ), DatePart( minute, Getdate() ) ), 2 ) 

-- [PM287-2][MANTIS20794]
While ( @iCpt <= 3 And @RecProd = 'PROD' ) Or ( @iCpt <= 2 ) -- OR ( @iCpt <= 4 And @RecProd <> 'PROD' ) -- pour du test -- [PM287-2][MANTIS20794
 Begin
	Select @sFicOutOrig = Case @iCpt
						When 1 Then @sCheminR1 + @sFichierRelance1
						When 2 Then @sCheminR2 + @sFichierRelance2EtPLUS
						When 3 Then @sCheminR3 + @sFichierRelance1 -- [PM287-2][MANTIS20794
						When 4 Then @sCheminR4 + @sFichierRelance2EtPLUS -- [PM287-2][MANTIS20794
					  End 
	Set @sFicOutOrig = Replace ( @sFicOutOrig, '[DATE]', @sDteExtr )
	Set	@sRequeteOrig = 'PS_S_PM95_FICHIER_SORTIE_XLS ''[FOUR]'' , ''[SECT]'', ''[CAS]'''

	
	If @iCpt in ( 1, 3 ) -- [PM287-2][MANTIS20794
	 Begin
		Delete From @tb
		Insert into @tb
		Select  Distinct 
				id_four, 
				id_secteur,
				0
		From  sysadm.w_alerte_frn
		Where cpt_rel = 1

		Set @sRequeteOrig = Replace ( @sRequeteOrig, '[CAS]', 'PREMIERE' )

	 End 
	 
	If @iCpt in ( 2,4 ) -- [PM287-2][MANTIS20794
	 Begin
		Delete From @tb
		Insert into @tb
		Select  Distinct 
				id_four, 
				id_secteur,
				0
		From  sysadm.w_alerte_frn
		Where cpt_rel > 1
		
		Set @sRequeteOrig = Replace ( @sRequeteOrig, '[CAS]', 'SECONDE_ET_PLUS' )		

	 End 

	While Exists ( Select * From @tb where marquage = 0 )
	 Begin
		Select 	Top 1 
			    @sIdFour = rTrim ( id_four ),
			    @sIdSecteur = rTrim ( id_secteur )
		From	@tb
		Where	marquage = 0

		Set @sFicOut = Replace ( @sFicOutOrig, '[FOUR]', @sIdFour )
		Set @sRequete = Replace ( @sRequeteOrig, '[FOUR]', @sIdFour )
		Set @sFicOut = Replace ( @sFicOut, '[SECT]', @sIdSecteur )
		Set @sRequete = Replace ( @sRequete, '[SECT]', @sIdSecteur )

		If right ( rtrim ( @sFicOut), 5 ) = '_.xls'
		 Begin
			Set @sFicOut = Replace ( @sFicOut, '_.xls', '.xls' )
		 End 

		SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				 @sBase + '.sysadm.' + @sRequete + ' ' + 
				 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption

		EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

		-- Pourquoi en PRO ? car il faut être connecté en sa ou sysadmin pour que ça marche, sinon c'est tjs 0
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			Begin
			
				-- 10 d'attente
				/*
				Set @dtMaintenant = GetDate()
				While DATEDIFF ( SECOND, @dtMaintenant, GETDATE() ) <= 10
				 Begin
					Set @iAttente = 1 -- Il faut au moins un ligne de code dans la boucle, code bidon
				 End
			 	*/
				-- EXECUTE xp_fileexist @sFicOut, @iFileExist Output

				-- exec @iFileExist = sysadm.PS_FILE_EXISTS @sFicOut

				Set @iFileExist = 1

			End
		Else
			Begin
				Set @iFileExist = 1
			End

		If @iFileExist in (-1, 0 )
			Begin
				If @RecProd = 'PROD'
				  Begin
					Set @sObjet = 'Traitement PM287 en erreur' -- [PM287-2]
					Set @sAdrMail = 'jff@spb.fr,GG_DSI-DO-PI@spb.eu'
				  End 
				Else
				  Begin
					Set @sObjet = 'Traitement PM287 !! RECETTE ' + @DemRec7 + ' !! en erreur' -- [PM287-2]
					Set @sAdrMail = 'jff@spb.fr'
				  End 
				
				Set @sMessage  = @sObjet + '.'
				Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
				Set @sMessage  = @sMessage + 'Le fichier suivant : ' + @sFicOut + ' ne s''est pas écrit sur disque, le traitement est stoppé.'
				Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
				Set @sMessage  = @sMessage + 'Il peut être relancer sans problème, aucun marquage en base n''a été fait à ce stade du traitement.'

				-- [PM287-2] adresses mail modifiées
				EXEC master.dbo.SPB_PS_MAIL 
						@sRetourErrMail OUTPUT, 
						@sAdrMail,
						@sMessage, 
						@sObjet, 
						'Relance fournisseur PM287-2', 
						'', 
						@sFicOut2, 
						NULL, 
						NULL, 
						NULL, 
						NULL
			
				Return -1
			End 	

		Update @tb
		Set marquage = 1
		Where id_four = @sIdFour
		And   id_secteur = @sIdSecteur
	 End

	Set @iCpt = @iCpt + 1

 End 
 
-- Mail de succès
If @RecProd = 'PROD'
	Begin
		Set @sObjet = 'Traitement PM287 terminé avec succès'
		Set @sAdrMail = 'gguisse@spb.eu 
						,pdeotto@spb.eu 
						,acangeli@spb.eu 
						,momont@spb.eu 
						,vandre@spb.eu 
						,msale@spb.eu 
						,kgrenier@spb.eu 
						,sanquetil@spb.eu 
						,pfermey@spb.eu 
						,jsoissons@spb.eu 
						,crighetti@spb.eu 
						,cmechara@spb.eu 
						,fmazouz@spb.eu 
						,eolivier@spb.eu 
						,classale@spb.eu 
						,nhamzaoui@spb.eu 
						,mlebigre@spb.eu 
						,ahaize@spb.eu 
						,cgrout@spb.eu 
						,eduboc@spb.eu 
						,sdelesque@spb.eu 
						,radam@spb.eu 
						,wsaintjorre@spb.eu 
						,mdeschamps@spb.eu ' -- [PM287-2]

	End
Else
	Begin
		Set @sObjet = 'Traitement PM287 !! RECETTE ' + @DemRec7 + ' !! terminé avec succès'
		Set @sAdrMail = 'jff@spb.fr,fpi@spb.fr,mdeschamps@spb.eu' -- [PM287-2]
	End
	
Set @sMessage  = @sObjet + '.'
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Les fichiers de première relance se trouvent sur : ' + @sCheminR1
Set @sMessage  = @sMessage + CHAR ( 13 )  
Set @sMessage  = @sMessage + 'Ils ont été envoyés automatiquement aux prestataires concernés.' 
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'Les fichiers de deuxième relance (et plus) se trouvent sur : ' + @sCheminR2
Set @sMessage  = @sMessage + CHAR ( 13 )  
Set @sMessage  = @sMessage + 'Ils sont à votre disposition (et vous ont été envoyés par mail).'  -- [PM287-2]
Set @sMessage  = @sMessage + CHAR ( 13 ) +  CHAR ( 13 ) 
Set @sMessage  = @sMessage + 'ATTENTION : Les fichiers ne peuvent pas être ressortis, ne les perdez pas, travaillez toujours sur une copie.'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		@sAdrMail, -- [PM287-2]
		@sMessage, 
		@sObjet, 
		'Relance fournisseur PM287-2', 
		'', 
		@sFicOut2, 
		NULL, 
		NULL, 
		NULL, 
		NULL

/*
If ( Select SERVERPROPERTY('ServerName' ) ) = 'SQL14DEV\SIMSINISTRES' 
	begin 
		Exec sysadm.PS_U_PM95_BATCH_LANCEMENT
	End
*/

Return 0

Go

grant execute on sysadm.PM95_PM287_PS_REECRIRE_LES_FICHIERS to rolebddsinistres
Go