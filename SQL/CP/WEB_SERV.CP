-------------------------------------------------------------------
--
-- Fichier              :       WEB_SERV.CP
-- Auteur               :       FPI
-- Date                 :       25/10/2011
--
-- Commentaires         :       PS à disposition de Webservices SPB
-------------------------------------------------------------------
-- PS_WEBSERV_MAJ_CMD_GAME	FPI 25/10/2011 [PR09] Contrôle & mise à jour de commande GAME
-- PS_WEBSERV_CTRL_CMD_GAME	FPI 16/11/2011 [PR09] Contrôle de commande GAME
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSERV_MAJ_CMD_GAME
-- Auteur               :       F. PINON
-- Date                 :       25/10/2011 
-- Libelle              :        
-- Commentaires         :       Procédure de contrôle & mise à jour de commande GAME
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNoBon		Varchar(50)		(Val) Numéro de bon
--				@asCodeRetour           VarChar (  2 )          (Réf) Message à afficher en retour
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 1 = OK
--                                                      0 = NOK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSERV_MAJ_CMD_GAME' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSERV_MAJ_CMD_GAME
GO


CREATE PROCEDURE sysadm.PS_WEBSERV_MAJ_CMD_GAME
	@asIdSin               VarChar(10), -- [PI062]
	@asNoBon		Varchar(50),
	@asCodeRetour           VarChar (  2 ) OUTPUT,
	@asRetourMess           VarChar (  2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 7 ), -- [PI062]
	@sInfoSpbFrnCplt Varchar(800),
	@dteConsomBon	Datetime

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Select @iRet=1, @asRetourMess = 'OK', @asCodeRetour='00'

exec @iRet=sysadm.PS_WEBSERV_CTRL_CMD_GAME @asIdSin, @asNoBon,
	@asCodeRetour OUTPUT,
	@asRetourMess OUTPUT
	
-- Mise à jour
If @iRet=1
Begin
  Update sysadm.w_commande 
  Set dte_rcp_mob_cli=getdate(), cod_etat='RPC'
   where id_sin=@dcIdSin and id_four='GAM' and id_typ_art='CAF'  and cod_etat <> 'ANN'
   
  Update sysadm.commande 
  Set dte_rcp_mob_cli=getdate(), cod_etat='RPC'
   where id_sin=@dcIdSin and id_four='GAM' and id_typ_art='CAF'  and cod_etat <> 'ANN'
   
   If @@RowCount = 0 Select @iRet=0, @asRetourMess = 'Erreur technique', @asCodeRetour='04'
End

Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSERV_CTRL_CMD_GAME
-- Auteur               :       F. PINON
-- Date                 :       16/11/2011 
-- Libelle              :        
-- Commentaires         :       Procédure de contrôle de commande GAME
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNoBon		Varchar(50)		(Val) Numéro de bon
--				@asCodeRetour           VarChar (  2 )          (Réf) Message à afficher en retour
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 1 = OK
--                                                      0 = NOK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSERV_CTRL_CMD_GAME' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSERV_CTRL_CMD_GAME
GO


CREATE PROCEDURE sysadm.PS_WEBSERV_CTRL_CMD_GAME
	@asIdSin               VarChar(10), -- [PI062]
	@asNoBon		Varchar(50),
	@asCodeRetour           VarChar (  2 ) OUTPUT,
	@asRetourMess           VarChar (  2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ),
	@sInfoSpbFrnCplt Varchar(800),
	@sInfoFrnSpbCplt Varchar(800),
	@dteConsomBon	Datetime

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
Select @iRet=1, @asRetourMess = 'OK', @asCodeRetour='00'

-- Contrôle existence sinistre
If Not exists (select * from sysadm.commande where id_sin=@dcIdSin and id_four='GAM' and id_typ_art='CAF' and cod_etat <> 'ANN')
Begin
  Select @iRet=0, @asRetourMess = 'No sinistre incorrect', @asCodeRetour='01'
End

-- Contrôle binome n° bon
If @iRet=1
Begin
   Select @sInfoSpbFrnCplt=info_spb_frn_cplt,
	@sInfoFrnSpbCplt=info_frn_spb_cplt,
	@dteConsomBon=dte_elv_mobile 
   From sysadm.commande 
   where id_sin=@dcIdSin and id_four='GAM' and id_typ_art='CAF'  and cod_etat <> 'ANN'
   
   If sysadm.FN_CLE_VAL('NO_BON', @sInfoFrnSpbCplt,';') <> @asNoBon Select @iRet=0, @asRetourMess = 'Incohérence binôme n° de bon-référence sinistre', @asCodeRetour='02'
   
End

-- Contrôle consommation du bon
If @iRet=1
Begin
  If @dteConsomBon is not null Select @iRet=0, @asRetourMess = 'Bon déjà consommé', @asCodeRetour='03'
End

Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSERV_DONNEES_PAYBOX
-- Auteur               :       F. PINON
-- Date                 :       06/11/2012
-- Libelle              :        
-- Commentaires         :       Procédure de lecture pour le site Paybox
--                               
-- References           :       [PC801]
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				
--
-- Retourne             :      
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSERV_DONNEES_PAYBOX' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSERV_DONNEES_PAYBOX
GO


CREATE PROCEDURE sysadm.PS_WEBSERV_DONNEES_PAYBOX
	@asIdSin               VarChar(10), -- [PI062]
	@aiRetour			   Integer OUTPUT

AS
  DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]

  Select @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ), -- [PI062]
	@aiRetour=0

  If (select count(*) From sysadm.w_sin s
      inner join sysadm.div_pro dp on s.id_prod=dp.id_prod
    Where s.id_sin=@dcIdSin and dp.nom_zone='franchise_paybox') = 0 Set @aiRetour=3

  If not exists (select * from sysadm.w_sin s where id_sin=@dcIdSin) Set @aiRetour=1
  If exists (select * from sysadm.w_div_sin d where id_sin=@dcIdSin and nom_zone='franchise_paybox' and d.val_car='O') Set @aiRetour=2
  	  
  If @aiRetour=0
  Begin
    Select s.id_sin, s.nom, s.prenom, s.dte_surv
	From sysadm.w_sin s
		inner join sysadm.div_pro dp on s.id_prod=dp.id_prod
	Where s.id_sin=@dcIdSin
		And not exists (select * from sysadm.w_div_sin d where d.id_sin=s.id_sin and d.nom_zone='franchise_paybox' and d.val_car='O')
		and dp.nom_zone='franchise_paybox'
  End 
 
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSERV_VALID_FRANCHISE_PAYBOX_V01
-- Auteur               :       F. PINON
-- Date                 :       06/11/2012 
-- Libelle              :        
-- Commentaires         :       Procédure de lecture pour le site Paybox
--                               
-- References           :       [PC801]
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				
--
-- Retourne             :      0 si NOK, > 0 si OK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSERV_VALID_FRANCHISE_PAYBOX_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSERV_VALID_FRANCHISE_PAYBOX_V01
GO


CREATE PROCEDURE sysadm.PS_WEBSERV_VALID_FRANCHISE_PAYBOX_V01
	@asIdSin               VarChar(10),  -- [PI062]
	@dcMtFranchise		   Decimal (11,2)
AS
  DECLARE @dcIdSin 	Decimal ( 10 ),  -- [PI062]
	@iRet integer,
	@iRetTot integer,
	@iIdCt integer,
	@iRetCt integer,
	@sMess         Varchar(254)

  Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

  Update sysadm.div_sin Set val_car='O', maj_le=getdate(), maj_par='WEB'
  Where id_sin=@dcIdSin and nom_zone='franchise_paybox'

  set @iRetTot = @@ROWCOUNT
  
  Update sysadm.w_div_sin Set val_car='O', maj_le=getdate(), maj_par='WEB'
  Where id_sin=@dcIdSin and nom_zone='franchise_paybox'
  
  set @iRetTot = @iRetTot + @@ROWCOUNT
  
  insert into sysadm.div_sin
  Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
	alt_oblig, 'O', cpt_tri, NULL, NULL, NULL, 'O', GETDATE(), GETDATE(), 'WEB', GETDATE(), 'WEB'
  from sysadm.sinistre s
  inner join sysadm.div_pro d on d.id_prod=s.id_prod
  Where d.nom_zone='franchise_paybox'
  and s.id_sin=@dcIdSin
  and not exists (select * from sysadm.div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)
  
  set @iRet=@@ROWCOUNT
  set @iRetTot = @iRetTot + @iRet 
  
  insert into sysadm.w_div_sin
  Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
	alt_oblig, 'O', cpt_tri, NULL, NULL, NULL, 'O', @iRet, GETDATE(), GETDATE(), 'WEB'
  from sysadm.w_sin s
  inner join sysadm.div_pro d on d.id_prod=s.id_prod
  Where d.nom_zone='franchise_paybox'
  and s.id_sin=@dcIdSin
  and not exists (select * from sysadm.w_div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)
  
  set @iRet=@@ROWCOUNT
  set @iRetTot = @iRetTot + @iRet 

	insert into sysadm.div_sin
	  Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
		alt_oblig, 'O', cpt_tri, NULL, @dcMtFranchise, NULL, NULL, GETDATE(), GETDATE(), 'WEB', GETDATE(), 'WEB'
	  from sysadm.sinistre s
	  inner join sysadm.div_pro d on d.id_prod=s.id_prod
	  Where d.nom_zone='mt_franchise_paybox'
	  and s.id_sin=@dcIdSin
	  and not exists (select * from sysadm.div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)
  
	  set @iRet=@@ROWCOUNT
	  set @iRetTot = @iRetTot + @iRet 
  
	  insert into sysadm.w_div_sin
	  Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
		alt_oblig, 'O', cpt_tri, NULL, @dcMtFranchise, NULL, NULL, @iRet, GETDATE(), GETDATE(), 'WEB'
	  from sysadm.w_sin s
	  inner join sysadm.div_pro d on d.id_prod=s.id_prod
	  Where d.nom_zone='mt_franchise_paybox'
	  and s.id_sin=@dcIdSin
	  and not exists (select * from sysadm.w_div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)
  
	  set @iRet=@@ROWCOUNT
	  set @iRetTot = @iRetTot + @iRet 
  

 
  -- [PC801-NDC_V10]
  If @iRetTot > 0
  Begin
    insert into sysadm.div_sin
	Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
		alt_oblig, 'O', cpt_tri, NULL, NULL, NULL, 'CB', GETDATE(), GETDATE(), 'WEB', GETDATE(), 'WEB'
	from sysadm.sinistre s
	inner join sysadm.div_pro d on d.id_prod=s.id_prod
	Where d.nom_zone='mode_paiement'
		and s.id_sin=@dcIdSin
		and not exists (select * from sysadm.div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)

	set @iRet=@@ROWCOUNT
	set @iRetTot = @iRetTot + @iRet 

	insert into sysadm.w_div_sin
	Select id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, 
		alt_oblig, 'O', cpt_tri, NULL, NULL, NULL, 'CB', @iRet, GETDATE(), GETDATE(), 'WEB'
	from sysadm.w_sin s
	inner join sysadm.div_pro d on d.id_prod=s.id_prod
	Where d.nom_zone='mode_paiement'
		and s.id_sin=@dcIdSin
	and not exists (select * from sysadm.w_div_sin ds where ds.id_sin=s.id_sin and ds.nom_zone=d.nom_zone)
  End
  
  If @iRetTot  > 0 
  Begin
	Set @sMess='Paiement de franchise effectué'
	
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
	Begin
		EXECUTE @iRetCt = SHERPA_PRO.sysadm.PS_U01_CONTACT_FRANCHISE_V01
			@dcIdSin,
			2,
			'X',
			'WEB',
			'O',
			@iIdCt OUTPUT
		
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sMess, 'AUTO', 'X' , 0 , null, 'C', null, 0
				
	End
	Else
	Begin
		EXECUTE @iRetCt = SHERPA_SIM.sysadm.PS_U01_CONTACT_FRANCHISE_V01
			@dcIdSin,
			2,
			'X',
			'WEB',
			'O',
			@iIdCt OUTPUT
		
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sMess, 'AUTO', 'X' , 0 , null, 'C', null, 0
	End
	
	If @iRetCt <> 0 Set @iRet=0
  End

	Set @sMess = 'Franchise payée par Carte Bancaire le ' + convert ( varchar(10), getdate(), 103 ) + ' pour un montant de ' + Convert ( Varchar (10), @dcMtFranchise ) + '€.'
	Set @sMess = @sMess + ' S''il existait un précédent contact lié à la vérification de la franchise, il a été mis à jour lors du paiement.'

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'WEB', 300, @iIdCt OUTPUT							
	END
	ELSE
	BEGIN
		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @dcIdSin, 2, @sMess,	'WEB', 300, @iIdCt OUTPUT							
	END	
  

  Return @iRetTot
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSERV_ELIG_BUYBACK
-- Auteur               :       F. PINON
-- Date                 :       03/07/2013
-- Libelle              :        
-- Commentaires         :       Procédure d'éligibilité au BuyBack
--                               
-- References           :       [PC932]
--
-- Arguments            :       
--
-- Retourne             :      0 si non-éligible, 1 si éligible
--							   @aiRetour = -1 Adhésion inconnue
--											-2 Adhésion résiliée
--											-3 Adhésion suspendue
--											-4 Ce n'est pas une option Premium
--											-5 Date adhésion dans les 60 derniers jours
--											-6 Date achat de plus de 2 ans
--											-7 appareil remplacé
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSERV_ELIG_BUYBACK' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSERV_ELIG_BUYBACK
GO

CREATE PROCEDURE sysadm.PS_WEBSERV_ELIG_BUYBACK
	@asIdProdAdh           VarChar(3),
	@asIdEts	           VarChar(5),
	@asIdAdh				VarChar(19),
	@asIdSdos				Varchar(2),
	@aiRetour			   Integer OUTPUT

AS
  DECLARE @dcIdProdSin 	Decimal ( 7 ),
	@dcIdEts Decimal(7),
	@dcIdSDos decimal(2),
	@iOption tinyint,
	@iStatut tinyint,
	@iSuspe tinyint,
	@dtAdh Date,
	@dtAchat date,
	@nbDoss int
	
 Select @dcIdProdSin = Convert ( Decimal ( 7 ),  @asIdProdAdh * 100 ), 
	@dcIdEts=Convert ( Decimal ( 7 ),  @asIdEts),
	@dcIdSDos=Convert ( Decimal ( 2 ),  @asIdSdos),
	@aiRetour=1

  -- Test adhésion valide
  select @iStatut=dosad_statut, 
	@iSuspe = dosad_t_suspe, 
	@iOption=dosad_c_option,
	@dtAdh=convert(date,convert(varchar(8),dosad_dat_adh),112), 
	@dtAchat=convert(date,convert(varchar(8),dosad_dt_embauc),112)
  from FUS_DOSAD_PRO.dbo.dosad d
  Where  d.dosad_code_prod=convert ( smallint, @asIdProdAdh ) and
	d.dosad_ets=convert ( int, @asIdEts ) and
	d.dosad_no_doss=convert ( int, @asIdAdh ) and
    d.dosad_no_sdoss=convert ( tinyint, @asIdSdos ) 
  
  If @@RowCount=0 set @aiRetour=-1 -- Adhésion inconnue
  If @iStatut not in (0,2,3,8) set @aiRetour=-2 -- Adhésion résiliée
  If @iSuspe=2 Set @aiRetour=-3 -- Adhésion suspendue
  
  If @iOption <> 2 Set @aiRetour=-4 -- Ce n'est pas une option Premium
  
  If DateAdd(day,60,@dtAdh) > getdate() Set @aiRetour=-5 -- Date adhésion dans les 60 derniers jours
  
  If DateAdd(year,2,@dtAchat) < getdate() Set @aiRetour=-6 -- Date achat de plus de 2 ans
  
  If @aiRetour <> 1 Return 0
  
  -- Test dossiers avec remplacement
  Set @nbDoss=0
  
  select @nbDoss=count(*) 
  From sysadm.w_sin s
      inner join sysadm.w_commande c on s.id_sin=c.id_sin
  Where s.id_prod between @dcIdProdSin and (@dcIdProdSin + 99)
	and s.id_ets=@dcIdEts
	and s.id_adh=@asIdAdh
	and s.id_sdos=@dcIdSDos
	and c.cod_etat <> 'ANN'
	and c.id_typ_art not in ('EDI','PRS')
  	  
  If @nbDoss=0
  Begin
    select @nbDoss=count(*) 
    From sysadm.sinistre s
        inner join sysadm.commande c on s.id_sin=c.id_sin
    Where s.id_prod between @dcIdProdSin and (@dcIdProdSin + 99)
	  and s.id_ets=@dcIdEts
	  and s.id_adh=@asIdAdh
	  and s.id_sdos=@dcIdSDos
	  and c.cod_etat <> 'ANN'
	  and c.id_typ_art not in ('EDI','PRS')
  End
  
  If @nbDoss > 0 
  Begin
	Set @aiRetour=-7
	Return 0
  End
  
  Return 1
  
Go
