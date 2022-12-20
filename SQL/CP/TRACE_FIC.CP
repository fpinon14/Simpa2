------------------------------------------------------------------
--
-- Fichier              :       STATS.CP
-- Auteur               :       FPI
-- Date                 :       12/10/2016
--
-- Commentaires         :       Gestion des traces fichier mises en table
--
-- Procédures           :       PS_I01_TRACE_FIC
------------------------------------------------------------------

/*
create table sysadm.trace_fic (
   id_trace             int                  identity,
   nom_appli            varchar(30)          not null,
   nom_fichier          varchar(255)         not null,
   ligne_trace          varchar(500)         not null,
   cree_le              datetime             not null,
   maj_par              varchar(4)           not null,
   constraint PK_TRACE_FIC primary key  (id_trace)
)
go

create   index trace_fic_dk1 on sysadm.trace_fic (
nom_fichier
)
go

create   index trace_fic_dk2 on sysadm.trace_fic (
cree_le
)
go

grant select, insert, update, delete on sysadm.trace_fic to rolebddsinistres
Go*/

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_FIC
-- Auteur               :       FPI
-- Date                 :       12/10/2016
-- Libellé              :        
-- Commentaires         :       Insert sur la table TRACE_FIC
-- Références           :       
--
-- Arguments            :      
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_FIC' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_FIC
GO

CREATE PROCEDURE sysadm.PS_I01_TRACE_FIC
	@nom_appli varchar(30),
	@nom_fichier varchar(255),
	@ligne_trace varchar(max),
	@cree_par varchar(4)
AS
	insert into sysadm.trace_fic
	(nom_appli, nom_fichier, ligne_trace, cree_le, maj_par)
	values (@nom_appli, @nom_fichier, @ligne_trace, getdate(),@cree_par)
Go

grant execute on sysadm.PS_I01_TRACE_FIC to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_TRACE_FIC_DAY
-- Auteur               :       FPI
-- Date                 :       21/10/2016
-- Libellé              :        
-- Commentaires         :       Renvoie le contenu d'un fichier à une date donnée
-- Références           :       
--
-- Arguments            :       @dtDate			Date du fichier de trace
--								@sRepAppli		Répertoire de trace (TRACE_C par défaut)
--								@sAppli			Répertoire applicatif du fichier de trace (SIMPA2 par défaut)
--
-- Retourne             :       Rien
--
-- Exemple : exec sysadm.PS_GET_TRACE_FIC_DAY '20/10/2016'
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_TRACE_FIC_DAY' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_GET_TRACE_FIC_DAY
GO

CREATE PROCEDURE sysadm.PS_GET_TRACE_FIC_DAY
	@dtDate datetime,
	@sRepAppli varchar(50)='TRACE_C',
	@sAppli varchar(50)='SIMPA2'
AS
	Declare @dtDeb datetime,
		@dtFin datetime

	Set @dtDeb=convert(datetime,convert(varchar(10),@dtDate,103),103)
	Set @dtFin=DATEADD(day,1,@dtDeb)
	Set @sAppli=upper(@sAppli)

	select ligne_trace
	from sysadm.trace_fic t
	where t.cree_le between @dtDeb and @dtFin
		and nom_fichier like '%\' + @sAppli + '\%\' + @sRepAppli + '\%'
	order by cree_le
Go

grant execute on sysadm.PS_GET_TRACE_FIC_DAY to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_TRACE_FIC_DAY_FICHIER
-- Auteur               :       FPI
-- Date                 :       21/10/2016
-- Libellé              :        
-- Commentaires         :       Réécrit le contenu d'un fichier à une date donnée
-- Références           :       
--
-- Arguments            :       @dtDate			Date du fichier de trace
--								@sRepAppli		Répertoire de trace (TRACE_C par défaut)
--								@sAppli			Répertoire applicatif du fichier de trace (SIMPA2 par défaut)
--								@sNomFichier	Nom du fichier en sortie (facultatif)
--
-- Retourne             :       Rien
--
-- Exemple : exec sysadm.PS_GET_TRACE_FIC_DAY_FICHIER '20/10/2016','TRACE_C','SIMPA2', '\\spb.lan\applis\spb\SIMPA2\XLS\test.txt'
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_TRACE_FIC_DAY_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_GET_TRACE_FIC_DAY_FICHIER
GO

CREATE procedure sysadm.PS_GET_TRACE_FIC_DAY_FICHIER
	@dtDate datetime,
	@sRepAppli varchar(50)='TRACE_C',
	@sAppli varchar(50)='SIMPA2',
	@sNomFichier varchar(255)=null
AS

Declare @dtDeb datetime,
		@dtFin datetime,
		@sNomServeur VarChar(255),
		@sPath  VarChar(255),
		@sCommande   VarChar(250),
		@sSql varchar(1000),
		@sOsqlOption VarChar(255),
		@iRetOsql	int

Set @dtDeb=convert(datetime,convert(varchar(10),@dtDate,103),103)
Set @dtFin=DATEADD(day,1,@dtDeb)
Set @sAppli=upper(@sAppli)

if @sNomFichier is null or Len(RTrim(@sNomFichier)) = 0
Begin
	Select top 1 @sNomFichier=t.nom_fichier
	from sysadm.trace_fic t
	where t.cree_le between @dtDeb and @dtFin
		and nom_fichier like '%\' + @sAppli + '\%\' + @sRepAppli + '\%'
End

-- chemin d'enregistrement du Result Set
Set @sPath 	= Replace(@sNomFichier,'K:\','\\spb.lan\applis\spb\')

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Set @sSql='Declare @dt datetime;'
Set @sSql=@sSql + 'Set @dt=convert(datetime,''' + convert(varchar(10), @dtDate,103)  + ''',103);'
Set @sSql=@sSql + 'Set NOCOUNT ON;'
Set @sSql=@sSql + 'exec  ' + DB_NAME(db_id()) + '.sysadm.PS_GET_TRACE_FIC_DAY @dt,''' + @sRepAppli + ''',''' + @sAppli + ''''

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' +
		 + @sSql + 
		'" /o' + @sPath + ' -w5000 -h-1' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

If @iRetOsql=0 print 'Fichier ' + @sPath + ' créé.'
Else print 'Erreur de création du fichier ' + @sPath + '.'

Go

grant execute on sysadm.PS_GET_TRACE_FIC_DAY_FICHIER to rolebddsinistres
Go


