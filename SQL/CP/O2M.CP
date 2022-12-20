-------------------------------------------------------------------
--
-- Fichier              :       O2M.CP
-- Auteur               :       PHG
-- Date                 :       04/03/2008
--
-- Commentaires         :       Scripts des PS spécifiques fournisseur O2M
--
-- Procédures           :       PS_X_STATO2M_LANCEURSTAT 	Lanceur de Statistique Interne
-- 				PS_S01_STATO2M_SUIVIJOUR	Suivi Journalier des commandes O2M
--				PS_S01_STATO2M_SUIVIBIHEBDO	Suivi Bi-Hebdomadaire des Anomalies O2M 
--				PS_S01_O2M_EXTRACTANN		Liste journalière des annulations de commandes
--				PS_X_O2M_ECRIREANN		Procédure d'ecriture sur disque	du resultat de PS_S01_O2M_EXTRACTANN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_X_STATO2M_LANCEURSTAT
-- Auteur               :       PHG
-- Date                 :       04/03/2008
-- Libellé              :        
-- Commentaires         :       Lanceur de Statistique Interne
-- Références           :       Job F4T => 
--				    SIMPA2_PRO : EXTRACTION O2M : SUIVI BI-HEBDO
--
-- Arguments            :       @sLibStat       Varchar (50)  Titre de la statistique
--                              @sCallProsStock Varchar (255) Chaine d'appel à la PS
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_STATO2M_LANCEURSTAT' AND type = 'P' )
        DROP procedure sysadm.PS_X_STATO2M_LANCEURSTAT
GO

CREATE PROCEDURE sysadm.PS_X_STATO2M_LANCEURSTAT
	@sLibStat	varchar(50),
	@sCallProcStock varchar(255)/*,
	@sMails		varchar(255) 	= NULL*/
as

DECLARE
	@sBase			varchar(255),
	@sQueryout		varchar(500),
	@sAdrMail		varchar(255),
	@sRetourErrMail 	varchar(255),
	@sMessage		varchar(510),
	@sSubject		varchar(255),
	@sFicOut		varchar(255),
	@sFicSuffix		varchar(10)

SET NOCOUNT ON

Set @sBase = db_name(db_id())
Set @sAdrMail = 'fca@spb.fr, ncoignet@spb.eu'
-- 19/07/2009 - FPI - DCMU 106822 - Suppression de npic@spb.fr
-- 14/05/2009 - FPI - Remplacement de stu@spb.fr par ncoignet@spb.fr
--Set @sAdrMail = 'phg@spb.fr'
Set @sSubject = 'Statistique O2M : ' + @sLibStat
Set @sFicSuffix = cast(DAY(GetDate()) as varchar(2))+'_'+
		  cast(MONTH(GetDAte()) as varchar(2))+'_'+
		  cast(YEAR(GetDate()) as varchar(4))

-- [I027] - France - Chemins Relatifs
--IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO')
--	Set @sFicOut = '\\' + @@SERVERNAME + '\Sinistre\Export_Stat_O2M\STATO2M'+@sFicSuffix+'.TXT'
--ELSE
--	Set @sFicOut = '\\' + @@SERVERNAME + '\d$\Sinistre\Export_Stat_O2M\STATO2M'+@sFicSuffix+'.TXT'
-- Remplacé par :
Set @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Stat_O2M\STATO2M'+@sFicSuffix+'.TXT'

-- Envoi Automatique d'un rapport d'exploitation
SET @sMessage  = 'Ci-joint la statistique O2M : '+ @sLibStat + char(13) + char(10)
SET @sQueryout = 'Exec ' + @@SERVERNAME+'.'+ @sBase + '.sysadm.' + @sCallProcStock
EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sAdrMail, @sMessage, @sSubject, '', '', '', @sQueryout, @sFicOut, 2

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_STATO2M_SUIVIJOUR
-- Auteur               :       PHG
-- Date                 :       04/03/2008
-- Libellé              :        
-- Commentaires         :       Suivi Journalier des commandes O2M
-- Références           :       Plus utilisée
--
-- Arguments            :       Rien
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_STATO2M_SUIVIJOUR' AND type = 'P' )
        DROP procedure sysadm.PS_S01_STATO2M_SUIVIJOUR
GO

CREATE PROCEDURE PS_S01_STATO2M_SUIVIJOUR
as
 
Declare @sDteToDay varchar(25)
Declare @sDteYesterday varchar(25)

Set @sDteToDay = convert(varchar(25), GetDate(), 103) + ' 16:00:00.000'
Set @sDteYesterday = convert(varchar(25), GetDate() - 1, 103) + ' 16:00:00.000'

select	c.maj_le 'Mise à Jour le :',
	c.maj_par 'Par :',
	cast(c.id_sin as varchar(9)) + '-' + cast(c.id_seq as varchar(2)) 'Numero de Commande :',
	ccEC.lib_code 'Etat :',
	p.lib_long 'Produit:',
	cg.lib_gti 'Garantie :',
	cast (c.id_detail as varchar(2)) + ' : ' + cEV.lib_code 'Détail :',
	c.id_four 'Fournisseur',
	c.id_marq_art 'Action :',
	sysadm.FN_TRIM(c.adr_nom)+ ' ' + sysadm.FN_TRIM(c.adr_prenom) 'Client :',
	c.id_serie_anc 'N° de Serie',
	sysadm.FN_TRIM(c.probleme) 'Problème :',
	cIF.lib_code 'Type d''envoi :',
	cGC.lib_code 'Réponse O2M'

from	sysadm.commande c,
	sysadm.produit p,
	sysadm.sinistre s,
	sysadm.code_garantie cg,
	sysadm.detail d, 
	code_car ccEC,
	code cEV,
	code cIF,
	code cGC
where 	c.id_four = 'O2M' and c.maj_le between @sDteYesterday and @sDteToDay
and	s.id_sin = c.id_sin
and 	cg.id_prod = s.id_prod
and	cg.id_gti = c.id_gti
and 	d.id_sin = s.id_sin 
and	d.id_gti = c.id_gti
and	d.id_detail = c.id_detail
and	s.id_prod = p.id_prod
and	ccEC.id_typ_code = '-EC'
and	ccEC.id_code = c.cod_etat
and	cEV.id_typ_code = '+EV'
and	cEV.id_code = d.id_evt
and	cIF.id_typ_code = '-IF'
and	cIF.id_code = c.info_spb_frn
and	cGC.id_typ_code = '-GC'
and	cGC.id_code = c.status_gc
order by 1
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_STATO2M_SUIVIBIHEBDO
-- Auteur               :       PHG
-- Date                 :       04/03/2008
-- Libellé              :        
-- Commentaires         :       Suivi des anomalies de Process O2M bi-hebdomandaire
-- Références           :       Job F4T => 
--				    SIMPA2_PRO : EXTRACTION O2M : SUIVI BI-HEBDO
--
-- Arguments            :       Rien
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------
-- #1	PHG	le 19/03/2008	[DCMP080250] Amélioration de la statistique
-- #2	PHG	le 19/01/2010	[BUG20100118].[PHG] Amélioration de performance
--				par utilisation de clause with nolock
-- 		FPI	le 09/02/2018	[PI056] On supprime le nom de serveur car PS lancé depuis la prod uniquement
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_STATO2M_SUIVIBIHEBDO' AND type = 'P' )
        DROP procedure sysadm.PS_S01_STATO2M_SUIVIBIHEBDO
GO

CREATE PROCEDURE sysadm.PS_S01_STATO2M_SUIVIBIHEBDO
as
SET NOCOUNT ON

-- Modif Datafly 20101203
set transaction isolation level read uncommitted
--

DECLARE @dtDateDebO2M datetime

Select @dtDateDebO2M = convert(varchar(10), min(cree_le), 103 ) 
from sysadm.commande 
where id_four = 'O2M'

-- #1 [DCMP080250].001 Ajout de la Date d'édition
Select 'STATISTIQUE O2M BI-HEDOMADAIRE DU : ' + convert(varchar(10), GetDAte(), 103)
-- 

-- Demande de diag auprès d'O2M en CNV et pas en ECT
select	'Demande de diag auprès d''O2M en CNV et pas en ECT'
select 	cm.id_sin, cm.id_seq, cm.id_gti, cm.id_detail, cm.cod_etat, cm.id_marq_art, sysadm.FN_CODE_NUM(cm.status_gc, '-GC') 'Rep. O2M.', 
	sysadm.FN_CODE_NUM(s.cod_etat, '-ET') + ( SELECT case when count(*)= 0 THEN '' ELSE ' - Attente de Pieces' END from w_piece where w_piece.id_sin = s.id_sin ),
	sysadm.FN_LIB_PROD(s.id_prod) 'Produit', cm.maj_le 'Commande Maj le :', sysadm.FN_TRIM(p.nom) + ' ' + sysadm.FN_TRIM(p.prenom) as 'Client :'
from 	sysadm.w_commande cm, sysadm.sinistre s, sysadm.personne p
where	cm.id_four = 'O2M' and cm.cod_etat = 'CNV'
and	s.id_sin = cm.id_sin
and 	p.id_ordre = s.id_ordre

-- Travail O2M non traité pr la gsetion depuis 48h
select	'Travail O2M non traité par la gestion depuis au moins 3 jours'
select 	id_sin, id_prod, nom, dos_maj_le, sysadm.FN_LIB_PROD(w_queue.id_prod) 'Produit'
from 	sysadm.w_queue 
where 	dos_maj_par = 'O2M' 
and	(GetDate() > DATEADD(day, 3, dos_maj_le))

-- Distibution, par date, du nb de Demande de diag auprès d''O2M sans réponse.
select	'Distibution, par date, du nb de Demande de diag auprès d''O2M sans réponse.'
select 	convert(varchar(10), maj_le, 120), count(*)
from 	sysadm.commande cm
where	cm.id_four = 'O2M' and cod_etat = 'ECT'
group by convert(varchar(10), maj_le, 120)
order by convert(varchar(10), maj_le, 120) ASC
--compute sum(count(*)) -- #1 [DCMP080250].002 Totalisation de demande de Diag en Attente.

-- Diag d'O2M avec Numérisation (Donc Piece Jointe Recue ) et pas de batch GED
--select	'Diag d''O2M avec Numérisation (Donc Piece Jointe Recue ) et pas de batch GED'
select 'O2M - PJ à "OUI" mais pas d''image dans GED'
select 	cm.id_sin, cm.id_seq, cm.id_gti, cm.id_detail, cm.cod_etat, cm.id_marq_art, sysadm.FN_CODE_NUM(cm.status_gc, '-GC') 'Rep. O2M.', cm.maj_le, 
	( sysadm.FN_CODE_NUM(s.cod_etat, '-ET') + ( SELECt case when count(*)= 0 THEN '' ELSE ' - Attente de Pieces' END from w_piece where w_piece.id_sin = s.id_sin ) ) 'Code Etat', 
	sysadm.FN_TRIM(p.nom) + ' ' + sysadm.FN_TRIM(p.prenom) as 'Client :'
-- from 	commande cm, sinistre s, personne p
from 	sysadm.commande cm WITH ( NOLOCK ), sysadm.sinistre s, sysadm.personne p -- #2 [BUG20100118].[PHG] Pas de vérrouillage sur la table commande
where	cm.id_four = 'O2M' 
and	cm.id_sin = s.id_sin
and	p.id_ordre = s.id_ordre
and 	cm.status_gc > 0 -- Diag Conforme
and 	cm.id_orian_modele = 1 -- Piece Jointe Recue.
and	s.cod_etat not in (200, 600, 900) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
and 	Not Exists (	Select 	ct.id_cli
			From 	SHERPA_PRO.sysadm.contact ct, 
				SHERPA_PRO.sysadm.archive ar,
				SHERPA_PRO.sysadm.sinistre ss
			Where	ss.id_sin = cm.id_sin
			and	ss.id_appli = 2
			and	ct.id_cli = ss.id_cli
			and	ct.id_sin = ss.id_sin
			and	ct.id_typ_fam = 2 
			and	ct.cree_le >= @dtDateDebO2M -- #1 [DCMP080250] Optimisation Performance
			and	ar.id_cli = ct.id_cli
			and	ar.id_contact = ct.id_contact
			and	ar.lib_fic like 'OM%'
			)
and	cm.id_seq = ( 	select 	max(cm2.id_seq) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
			from 	sysadm.commande cm2 
			where 	cm2.id_sin = cm.id_sin 
			and	cm2.id_gti = cm.id_gti
			and	cm2.id_detail = cm.id_detail)
order by cm.maj_le

-- Diag d'O2M avec Numérisation alors que Pas de Piece Jointe Recue ..
--select 'Diag d''O2M avec Numérisation alors que Pas de Piece Jointe Recue ...'
select 'O2M - PJ à "NON" mais images dans GED'
select 	cm.id_sin, cm.id_seq, cm.id_gti, cm.id_detail, cm.cod_etat, cm.id_marq_art, sysadm.FN_CODE_NUM(cm.status_gc, '-GC') 'Rep. O2M.', cm.maj_le, 
	( sysadm.FN_CODE_NUM(s.cod_etat, '-ET') + ( SELECt case when count(*)= 0 THEN '' ELSE ' - Attente de Pieces' END from w_piece where w_piece.id_sin = s.id_sin ) ) 'Code Etat', 
	sysadm.FN_TRIM(p.nom) + ' ' + sysadm.FN_TRIM(p.prenom) as 'Client :'
--from 	commande cm, sinistre s, personne p
from 	sysadm.commande cm WITH ( NOLOCK ), sysadm.sinistre s, sysadm.personne p -- #2 [BUG20100118].[PHG] Pas de vérrouillage sur la table commande
where	cm.id_four = 'O2M' 
and 	s.id_sin = cm.id_sin
and 	p.id_ordre = s.id_ordre
and 	cm.status_gc > 0 -- Diag Conforme
and 	cm.id_orian_modele = 2 -- Piece Jointe non Recue.
and	s.cod_etat not in (200, 600, 900) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
and 	Exists (	Select 	ct.id_cli
			From 	SHERPA_PRO.sysadm.contact ct, 
				SHERPA_PRO.sysadm.archive ar,
				SHERPA_PRO.sysadm.sinistre ss
			Where	ss.id_sin = cm.id_sin
			and	ss.id_appli = 2
			and	ct.id_cli = ss.id_cli
			and	ct.id_sin = ss.id_sin
			and	ct.id_typ_fam = 2 
			and	ct.cree_le >= @dtDateDebO2M -- #1 [DCMP080250] Optimisation Performance
			and	ar.id_cli = ct.id_cli
			and	ar.id_contact = ct.id_contact
			and	ar.lib_fic like 'OM%'
			)
and	cm.id_seq = ( 	select 	max(cm2.id_seq) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
			from 	sysadm.commande cm2 
			where 	cm2.id_sin = cm.id_sin 
			and	cm2.id_gti = cm.id_gti
			and	cm2.id_detail = cm.id_detail)
order by cm.maj_le


-- Diag d'O2M, Pas de Piece Jointe Recue Mais pas de contact travail crée.
-- select 'Diag d''O2M, Pas de Piece Jointe Recue Mais pas de contact travail crée.'
select 'O2M - PJ à "NON" mais pas de contact travail créé.'
select 	cm.id_sin, cm.id_seq, cm.id_gti, cm.id_detail, cm.cod_etat, cm.id_marq_art, sysadm.FN_CODE_NUM(cm.status_gc, '-GC') 'Rep. O2M.', cm.maj_le, 
	( sysadm.FN_CODE_NUM(s.cod_etat, '-ET') + ( SELECt case when count(*)= 0 THEN '' ELSE ' - Attente de Pieces' END from w_piece where w_piece.id_sin = s.id_sin ) ) 'Code Etat'
--from 	commande cm, sinistre s
from 	sysadm.commande cm WITH ( NOLOCK ), sysadm.sinistre s -- #2 [BUG20100118].[PHG] Pas de vérrouillage sur la table commande
where	cm.id_four = 'O2M' 
and 	s.id_sin = cm.id_sin
and 	cm.status_gc > 0 -- Diag Conforme
and 	cm.id_orian_modele = 2 -- Piece Jointe Non Recue.
and	s.cod_etat not in (200, 600, 900) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
and 	Not Exists (	Select 	ct.id_cli
			From 	SHERPA_PRO.sysadm.contact ct,
				SHERPA_PRO.sysadm.sinistre ss
			Where	ss.id_sin = cm.id_sin
			and	ss.id_appli = 2
			and	ct.id_cli = ss.id_cli
			and	ct.id_sin = ss.id_sin
			and	ct.id_typ_fam = 2
			and	ct.cree_le >= @dtDateDebO2M -- #1 [DCMP080250] Optimisation Performance
			and	ct.txt_mess like '%![O2M!]%' ESCAPE '!'
		)
and	cm.id_seq = ( 	select 	max(cm2.id_seq) -- #1 [DCMP080250].003 Limitation au commande O2M non gérée
			from 	sysadm.commande cm2 
			where 	cm2.id_sin = cm.id_sin 
			and	cm2.id_gti = cm.id_gti
			and	cm2.id_detail = cm.id_detail)
order by cm.maj_le

Go

grant execute on sysadm.PS_S01_STATO2M_SUIVIBIHEBDO to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_O2M_EXTRACTANN
-- Auteur               :       PHG
-- Date                 :       04/03/2008
-- Libellé              :        
-- Commentaires         :       Liste journalière des annulations de commandes
-- Références           :       
--
-- Arguments            :       Rien
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------
-- FPI 19/07/2012 - [ITSM125154] Annulations du Vendredi non-prise en compte
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_O2M_EXTRACTANN' AND type = 'P' )
        DROP procedure sysadm.PS_S01_O2M_EXTRACTANN
GO
CREATE PROCEDURE sysadm.PS_S01_O2M_EXTRACTANN
	@adDateJour	datetime
as

set NOCOUNT ON

-- [I027] Correction sysadm + date ISO => la taille passe à 8 ald 10. exemple : 20071101 au lieu de 01/11/2007
Declare	@sDateJour	varchar(8),
	@sDateHier	varchar(8)
-- [I027] Correction sysadm + date ISO
--select	@sDateJour = convert(varchar(10), @adDateJour, 103 )
--select	@sDateHier = convert(varchar(10), @adDateJour - 1, 103 )
select	@sDateJour = convert(varchar(8), @adDateJour, 112 )

If datepart(weekday,@adDateJour) = 1 
Begin 
	-- on est Lundi, on prend le week-end en plus
	select	@sDateHier = convert(varchar(8), @adDateJour - 3, 112 )
End
Else select	@sDateHier = convert(varchar(8), @adDateJour - 1, 112 )

select 	cast(commande.id_sin as varchar(10))+ '-' + cast(id_seq as varchar(7)) as 'NUM_CMD_SPB', -- [PI062]
	sysadm.FN_CODE_CAR(div_sin.val_car,'-AR') as 'TYP_ART',
	Case When id_typ_art in ('EDI','PRS') Then id_ref_four Else 'A_COMMANDER' End as 'ACTION',
	id_prod as 'CODE_PRODUIT', 
	sysadm.FN_LIB_PROD(id_prod) as 'LIB_PRODUIT'	
from sysadm.commande
inner join sysadm.sinistre on commande.id_sin=sinistre.id_sin
left outer join sysadm.div_sin  on commande.id_sin=div_sin.id_sin and div_sin.nom_zone='type_app'
where 	id_four = 'O2M' 
and 	( id_lot_cmd > 0 and id_lot_cmd < 999900 )
and 	commande.cod_etat = 'ANN'
and	id_ann > 0
--and	cmd_gen_le between @sDateHier and @sDateJour
and	commande.maj_le between @sDateHier and @sDateJour -- [ITSM93517]

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_X_O2M_ECRIREANN
-- Auteur               :       PHG
-- Date                 :       04/03/2008
-- Libellé              :        
-- Commentaires         :       Procédure d'ecriture sur disque
--				du result set de la PS_S01_O2M_EXTRACTANN
-- Références           :       
--
-- Arguments            :       Rien
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_O2M_ECRIREANN' AND type = 'P' )
        DROP procedure sysadm.PS_X_O2M_ECRIREANN
GO

CREATE PROCEDURE PS_X_O2M_ECRIREANN
as

Declare @dDateJour	datetime,
	@sCommande	VarChar(250),
        @sFicOut	VarChar(255)

set NOCOUNT ON

SET @dDateJour = GetDate()
-- [I027] - France - Chemins Relatifs
SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+ '\Simpa2\O2M\fic_annul\ANNO2M-' + 
               CONVERT (char(4), DatePart (year,@dDateJour)  ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,@dDateJour) ),  2 ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,@dDateJour ) ),  2 ) + '.TXT'


SET @sCommande = 'sqlcmd /S' + @@servername + ' /E /Q"' + 
            'SIMPA2_PRO.sysadm.PS_S01_O2M_EXTRACTANN ''' + convert(varchar(10), @dDateJour, 112) +
            '''" /o ' + @sFicOut + ' -s"	" -w5000 -u' -- [I027] Correction sysadm + date ISO
EXEC master.dbo.xp_cmdshell @sCommande, no_output

GO

grant execute on sysadm.PS_X_O2M_ECRIREANN to rolebddsinistres
Go

