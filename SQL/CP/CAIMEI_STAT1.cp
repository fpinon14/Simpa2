 
----------------------------------------------------------------------------------------------------------------------------------------
-- Fichier	:	CAIMEI_STAT1.CP
-- Commentaires	: 	Comprends toutes les procedures servant à des stats *simples* sur controle IMEI
--			Si stat compliquée, voir EID
-- Procédure	:	PS_CRA_IMEI_STAT_EXPLOITATION
-------------------------------------------------------------------
-- Modifications :
-- [DCMP070214]	PHG	Prise en compte dans le rapport du 
--			Comptage des refus pour ddu<date d'adhesion
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :   PS_CRA_IMEI_STAT_EXPLOITATION
-- Auteur               :   PHG
-- Date                 :   27/02/2007
-- Libellé              :   Rapport d'exploitation
-- Commentaires         :   
-- Références           :   
--
-- Arguments            :   	@dtTrt		datetime     : Datetime réel d'execution du lot 2
--				@sNomFic	varchar(35)  : Nom du Fichier reçu
--
-- Retourne             :   Code retour Standard T-SQL
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- #1	PHG	29/03/2007	[DCMP070214]	Prise en compte dans le rapport du 
--						Comptage des refus pour ddu<date d'adhesion
-- #2	PHG	29/03/2007			Correction rapport lot 1 si execution en journée
-- #3   PHG     13/06/2007	[DCMP070360]	Adaptation du report à la nvlle gestion des rejets
-- #4	PHG	18/09/2009	[20090918].PHG	Ajout du nombre de dossier attendu
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_STAT_EXPLOITATION' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_STAT_EXPLOITATION
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_STAT_EXPLOITATION
	@dtTrt  datetime,
	@sNomFic varchar(35)

AS

DECLARE @dtMEP	datetime,
	@dteExecutionLot1 datetime,
	@dteExecutionLot2 datetime,
	@sConvert	  varchar(23), -- #2 PHG Variable tempo pour convert
	@iNbRejAutre	  integer,     -- #3 PHG [DCMP070360] Comptage nombre de rejet Autre
	@iNbRejInfo	  integer,      -- #3 PHG [DCMP070360] Comptage nombre de rejet Informatique
	@iNbRejImeiLigneInvalide integer, -- #3 JCA [DCMP070360] Comptage nombre de rejet Informatique
	@iNbRejAutreContratOrange integer, -- #3 JCA [DCMP070360] Comptage nombre de rejet Informatique
	@dtDernierEnvoi datetime -- #4 PHG [20090918].PHG Ajout du nombre de dossier attendu
    
SET NOCOUNT ON

-- Paramètres
-- Date de mise en production
SET @dtMEP = cast ( '14/02/2007' as datetime ) -- NE PAS MODIFIER !!!

-- Date de traitement Lot 1
-- #2 PHG : On assume que le lot 1 s'execute tjrs à ~ 6h30
--SET @dteExecutionLot1 = DATEADD(minute, -16, @dtTrt )
-- remplacé par :
SET @sConvert = convert(varchar(10), @dtTrt, 103) + ' 06:29:00.000'
SET @dteExecutionLot1 = @sConvert
--
SET @dteExecutionLot2 = @dtTrt

-- nom de Fichier
SET @sNomFic = UPPER(@sNomFic)

print '************************************************'
print '*       Rapport d''emission du fichier IMEI     *'
print '* Date de traitement : ' + convert (varchar(12), @dteExecutionLot1, 103) +'              *'
print '************************************************'

-- Nbr Emmission réellement effectuée
select 'Nombre de dossiers émis : ' +  cast (
(
	select count(*)
	from sysadm.trace_cra_imei tci 
	where ( ( id_code_action = 'GENFIC' and convert ( datetime, tci.val_action, 121) > @dteExecutionLot1) OR
	      ( id_code_action = 'REL' and convert ( datetime, tci.val_action, 121) > @dteExecutionLot1 ) )
)
as varchar(7) )

select 'Nombre de dossiers émis : Demande de Controle: ' +  cast (
(
	select count(*)
	from sysadm.trace_cra_imei tci
	where ( ( id_code_action = 'GENFIC' and convert ( datetime, tci.val_action, 121) > @dteExecutionLot1 ) )
)
as varchar(7) )

select 'Nombre de dossiers émis : Relance : ' +  cast (
(
	select count(*)
	from sysadm.trace_cra_imei tci
	where ( ( id_code_action = 'REL' and convert ( datetime, tci.val_action, 121) > @dteExecutionLot1 ) )
)
as varchar(7) )

-- Nbr Forcage réellement effectué
select 'Nombre de Forcage Automatique effectués : ' + cast (
(
select count(*)
from sysadm.trace_cra_imei 
where id_code_action = 'FOR_OK' and convert ( datetime, val_action, 121) between @dteExecutionLot1 and @dteExecutionLot2
) 
as varchar(7) )

-- Rejet d'emission
select 'Nbr Rejet d''emission :	'+ cast (
(
select count(* )
from sysadm.cra_imei_rejet
where type_trait = 'E' and date_rejet > @dteExecutionLot1
) 
as varchar(7) )

-- Rapport d'integration du fichier 
print '************************************************'
print '*       Rapport d''integration du fichier       *'
print '*            ' +@sNomFic + '              *'
print '************************************************'

-- #4 PHG [20090918].PHG Ajout du nombre de dossier attendu
select @dtDernierEnvoi=max(tci.dat_log)
from sysadm.trace_cra_imei tci 
where ( ( id_code_action = 'GENFIC' and convert ( datetime, tci.val_action, 121) < @dteExecutionLot2) OR
      ( id_code_action = 'REL' and convert ( datetime, tci.val_action, 121) < @dteExecutionLot2 ) )

select 'Nombre de dossiers attendu ( Estimation ) : ' +  cast (
(
	select count(*)
	from sysadm.trace_cra_imei tci 
	where ( ( id_code_action = 'GENFIC' and convert ( datetime, tci.val_action, 121) between @dtDernierEnvoi and @dteExecutionLot2) OR
	      ( id_code_action = 'REL' and convert ( datetime, tci.val_action, 121) between @dtDernierEnvoi and @dteExecutionLot2 ) )
)
as varchar(7) )
--

-- Nombre de dossier traité :
select 'Nombre de dossier lu dans le fichier :	'+ cast (
(
	Select count(*) from sysadm.cra_imei_trt_import
	where	upper(nom_fic) = @sNomFic
) as varchar(7) )

-- Comptage des cas de traitement importés
select 'Nombre de dossier traité et injecté dans la base de données :	'+ cast (
(
select 	count(*) 
from 	sysadm.cra_imei_trt_import
where  	upper(nom_fic) = @sNomFic
and	code_pos = '*'
) as varchar(7) )

-- Comptage des cas de traitement ignorés
select 'Nombre de dossier ignorés ( Dossier déja Réglés ou Sans Suite ou Refusé ):	' + cast (
(
select 	count(*)
from 	sysadm.cra_imei_trt_import
where  	upper(nom_fic) = @sNomFic
and	code_pos = 'I'
) as varchar(7) )

-- Comptage des cas de traitement importés, mais avec des erreur focntionnelle (etat R).
select 'Nombre de dossiers avec des erreurs fonctionnelles :	' + cast (
(
select 	count(*)
from 	sysadm.cra_imei_trt_import
where  	upper(nom_fic) = @sNomFic
and	code_pos = 'R'
) as varchar(7) )

print 'NOTE :Rappels des erreurs fonctionnelles :'
print '''- Création de contact impossible'
print '''- Dossier déja traité'
print '''- Date de survenanve vide'
print '''- Dossier déja à Controle IMEI OK'

-- Vérification de la création des contact/travaux
-- Test d'existence sur w_queue / SHERPA_PRO..contact
-- pour les traitements : 1,3,4,6,10,12,13 et ( 35 ) => #1 [DCMP070214] traitement 35 : nouveau refus DDu<date adh
-- ATTENTION : Plus cette partie est executée juste après execution lot 2, plus la requete est fiable
print ''
print '**** Vérification des travaux :'
select 'Nombre de travaux prévus :	' + cast (
(
select count(id_seq)
from 	sysadm.cra_imei_trt_import
where  	upper(nom_fic) = @sNomFic
and	code_pos = '*'
/* and traitement in ( '1','3','4','6','10','12','13' ) */
/*#1 [DCMP070214] PHG : Remplacé par : */
and traitement in ( '1','3','4','6','10','12','13','35')
) as varchar(7) )

select 'Nombre de travaux crées ( et non encore gérés ) :	' + cast (
(
select count(wq.id_sin )
from	sysadm.w_queue wq,
	(	select id_sin from sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		/*and traitement in ( '1','3','4','6','10','12','13' )*/
		/*#1 [DCMP070214] PHG : Remplacé par : */
		and traitement in ( '1','3','4','6','10','12','13','35' )
	) as sin_trv
where	wq.id_sin = sin_trv.id_sin
) as varchar(7) )

select 'Nombre de travaux crées et validé :	' + cast (
(
select count(s.id_sin )
from	sysadm.sinistre s,
	(	select id_sin from sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		/* and traitement in ( '1','3','4','6','10','12','13' ) */
		/*#1 [DCMP070214] PHG : Remplacé par : */
		and traitement in ( '1','3','4','6','10','12','13','35' )
	) as sin_trv
where	s.id_sin = sin_trv.id_sin
and 	s.valide_le > @dteExecutionLot2
) as varchar(7) )

-- Nombre de travaux affecté à CRAO
select 'Nombre de travaux affecté à CRAO : 	' + cast (
(
select count(*) 
from sysadm.w_queue 
where dos_maj_par = 'CRAO' or trv_maj_par = 'CRAO' 
) as varchar(7) )

-- Vérification Cohérence Suivi IMEI / code Traitement pour traitement entrainant creation de contact
-- Nombre de deuxieme ou plus controle ctrl
print ' **** Comptage des actions effectuées :'
select 'Nombre de Nouvelle demande de Controle :	' + cast (
(
select count(ds.id_sin)
from sysadm.div_sin ds,
(	select  id_sin
	from 	sysadm.cra_imei_trt_import
	where  	upper(nom_fic) = @sNomFic
	and	code_pos = '*'
/*	and traitement in ( '2','5','9' ) ) as rfHD */
/*#1 [DCMP070214] PHG : Remplacé par : */
	and traitement in ( '2','5','9','21' ) ) as rfHD
where	ds.id_sin = rfHD.id_sin
and 	ds.nom_zone = 'cra_ctrl_imei'
and	ds.val_car = 'O'
) as varchar(7) )

-- nombre de Controle OK :
select 'Nombre de Controle OK :	' + cast (
(
select count(ds.id_sin)
from sysadm.div_sin ds,
(	select  id_sin
	from 	sysadm.cra_imei_trt_import
	where  	upper(nom_fic) = @sNomFic
	and	code_pos = '*'
	and traitement in ( '1','4','10' ) ) as rfHD
where	ds.id_sin = rfHD.id_sin
and 	ds.nom_zone = 'cra_suivi_imei'
and	ds.val_nbre = 2
) as varchar(7) )

-- nombre de Refus Hors delai prévu :
select 'Nombre de Refus Hors delai  :	' + cast (
(
	select count(ds.id_sin)
	from sysadm.div_sin ds,
	(	select  id_sin
		from 	sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		and traitement in ( '3','6' ) ) as rfHD
	where	ds.id_sin = rfHD.id_sin
	and 	ds.nom_zone = 'cra_suivi_imei'
	and	ds.val_nbre = 5
) as varchar(7) )

-- nombre de Refus Pas de trafic  :
select 'nombre de Refus Pas de trafic :	' + cast (
(
	select count(ds.id_sin)
	from sysadm.div_sin ds,
	(	select  id_sin
		from 	sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		and traitement = 12 ) as rfHD
	where	ds.id_sin = rfHD.id_sin
	and 	ds.nom_zone = 'cra_suivi_imei'
	and	ds.val_nbre = 3
) as varchar(7) )

-- nombre de Refus Autre Operateur  :
select 'Nombre de Refus Autre opérateur :	' + cast (
(
	select count(ds.id_sin)
	from sysadm.div_sin ds,
	(	select  id_sin
		from 	sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		and traitement = 13 ) as rfHD
	where	ds.id_sin = rfHD.id_sin
	and 	ds.nom_zone = 'cra_suivi_imei'
	and	ds.val_nbre = 4
) as varchar(7) )

-- #1 [DCMP070214] PHG On compte les Refus DDU<date adhesion
-- Nombre de Refus DDU :
select 'Nombre de Refus DDU<Date adhesion  :	' + cast (
(
	select count(ds.id_sin)
	from sysadm.div_sin ds,
	(	select  id_sin
		from 	sysadm.cra_imei_trt_import
		where  	upper(nom_fic) = @sNomFic
		and	code_pos = '*'
		and traitement = 35 ) as rfHD
	where	ds.id_sin = rfHD.id_sin
	and 	ds.nom_zone = 'cra_suivi_imei'
	and	ds.val_nbre = 10
) as varchar(7) )
--

-- nombre de Rejet Autre Contrat Orange  :
select @iNbRejAutreContratOrange = count(ds.id_sin)
from sysadm.div_sin ds,
(	select  id_sin
	from 	sysadm.cra_imei_trt_import
	where  	upper(nom_fic) = @sNomFic
	and	code_pos = '*'
	and traitement = 7 ) as rfHD
where	ds.id_sin = rfHD.id_sin
and 	ds.nom_zone = 'cra_suivi_imei'
and	ds.val_nbre = 6

select  'Nombre de Rejet Autre Contrat Orange :	' + cast ( @iNbRejAutreContratOrange as varchar(7) )

-- nombre de Rejet IMEI/N Ligne Invalide  :
select @iNbRejImeiLigneInvalide = count(ds.id_sin)
from sysadm.div_sin ds ,
(	select  id_sin
	from 	sysadm.cra_imei_trt_import
	where  	upper(nom_fic) = @sNomFic
	and	code_pos = '*'
	and traitement = 8 ) as rfHD
where	ds.id_sin = rfHD.id_sin
and 	ds.nom_zone = 'cra_suivi_imei'
and	ds.val_nbre = 8

select  'Nombre de Rejet IMEI/N Ligne Invalide :	' + cast ( @iNbRejImeiLigneInvalide as varchar(7) )

-- nombre de REJET Autre:
select @iNbRejAutre = count(ds.id_sin)
from sysadm.div_sin ds,
(	select  id_sin
	from 	sysadm.cra_imei_trt_import
	where  	upper(nom_fic) = @sNomFic
	and	code_pos = '*'
	and traitement = 11 ) as rfHD
where	ds.id_sin = rfHD.id_sin
and 	ds.nom_zone = 'cra_suivi_imei'
and	ds.val_nbre = 7

-- Total des REJET Fonctionel :
select @iNbRejInfo = count(cir.id_seq)
from sysadm.cra_imei_rejet cir
where  	upper(nom_fic) = @sNomFic
and cir.type_trait = 'I'
and cir.type_rejet = 'F'
and date_rejet >= @dteExecutionLot2


select 'Nombre de REJET Autre :	'  + cast ( @iNbRejAutre as varchar(7) )

select 'Nombre de REJET pour erreur de format de donnée : '  + cast ( (@iNbRejInfo - ( @iNbRejAutre + @iNbRejImeiLigneInvalide + @iNbRejAutreContratOrange ) )  as varchar(7) )

GO
