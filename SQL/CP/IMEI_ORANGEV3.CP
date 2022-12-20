-------------------------------------------------------------------
--
-- Fichier              :       IMEI_ORANGEV3.CP
-- Auteur               :       FPI
-- Date                 :       14/05/2013
--
-- Commentaires         :       Table des IMEI Orange
--
-- Procédures           :       PS_S01_CTL_IMEI_ORANGEV3
--								PS_I01_IMEI_ORANGEV3
-------------------------------------------------------------------
/* ------------------
   Création de table 
   ------------------
   
CREATE TABLE sysadm.imei_orangev3(
	id_seq int IDENTITY(1,1) NOT NULL,
	num_port varchar(25) not null,
	num_imei varchar(60) not null,
    dte_dern_jour_trans  datetime not null,
	cree_le datetime not null
 CONSTRAINT pk_imei_orange_v3 PRIMARY KEY CLUSTERED 
(
	id_seq ASC
) 
) 

GO
grant select, insert, delete, update on sysadm.imei_orangev3 to rolebddsinistres
Go
*/
--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CTL_IMEI_ORANGEV3
-- Auteur               :       FPI
-- Date                 :       14/05/2013
-- Libellé              :        
-- Commentaires         :       Sélect sur la table Imei_orange_v3
-- Références           :       
--
-- Arguments            :       @sNumPort varchar(25)
--								@sNumImei Varchar(60)
--								@dtDteSurv DateTime  -- V01
--								@dtDteTrans DateTime OUTPUT - V02
--
-- Retourne             :       1 si le binome existe en table, 0 sinon
--
-------------------------------------------------------------------
-- FPI - 5/08/2014 - [DT01-2] - V2 - Récup de la date de der util
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CTL_IMEI_ORANGEV3_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CTL_IMEI_ORANGEV3_V02
GO

CREATE procedure sysadm.PS_S01_CTL_IMEI_ORANGEV3_V02
        @sNumPort varchar(25),
		@sNumImei Varchar(60),
		@dtDteSurv DateTime,
		@dtDteTrans DateTime OUTPUT
AS
	Declare @iRet integer
	Declare @dtDtePivot datetime
	
	Set @iRet=0
	Set @dtDtePivot = DateAdd(day, -30, @dtDteSurv)
	
	Select @iRet=IsNull(Count(*),0)
	From sysadm.imei_orangev3
	Where num_port=@sNumPort
		And num_imei=Left(@sNumImei,14)
		And dte_dern_jour_trans >= @dtDtePivot
		
	If @iRet > 1 Set @iRet=1
	
	Select @dtDteTrans=max(dte_dern_jour_trans)
	From sysadm.imei_orangev3
	Where num_port=@sNumPort
		And num_imei=Left(@sNumImei,14)

	Return @iRet
Go
grant execute on sysadm.PS_S01_CTL_IMEI_ORANGEV3_V02 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_IMEI_ORANGEV3
-- Auteur               :       FPI
-- Date                 :       14/05/2013
-- Libellé              :        
-- Commentaires         :       insert sur la table Imei_orange_v3
-- Références           :       
--
-- Arguments            :       @sNumPort varchar(25)
--								@sNumImei Varchar(60)
--								@dteDernJourTrans  datetime -- V01
--
-- Retourne             :       rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_IMEI_ORANGEV3_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_IMEI_ORANGEV3_V01
GO

CREATE procedure sysadm.PS_I01_IMEI_ORANGEV3_V01
        @sNumPort varchar(25),
		@sNumImei Varchar(60),
		@dteDernJourTrans  datetime
AS

  Insert into sysadm.imei_orangev3 (num_port, num_imei, dte_dern_jour_trans, cree_le)
  values (@sNumPort, @sNumImei,@dteDernJourTrans,getdate())
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_IMEI_ORANGEV3
-- Auteur               :       FPI
-- Date                 :       14/05/2013
-- Libellé              :        
-- Commentaires         :       insert sur la table Imei_orange_v3
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_IMEI_ORANGEV3' AND type = 'P' )
        DROP procedure sysadm.PS_D01_IMEI_ORANGEV3
GO

CREATE procedure sysadm.PS_D01_IMEI_ORANGEV3
AS

  delete from sysadm.imei_orangev3
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_IMEI_ORANGEV3_DATA
-- Auteur               :       FPI
-- Date                 :       29/09/2016
-- Libellé              :        
-- Commentaires         :       renvoie un extrait de la table Imei_orange_v3
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_IMEI_ORANGEV3_DATA' AND type = 'P' )
        DROP procedure sysadm.PS_GET_IMEI_ORANGEV3_DATA
GO

CREATE procedure sysadm.PS_GET_IMEI_ORANGEV3_DATA
AS

  set nocount on

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  select top 1000 num_port, 
	sysadm.FN_CORR_IMEI(num_imei,getdate()) as num_imei, 
	convert(varchar(10),dte_dern_jour_trans,103) as dte_dern_jour_trans 
  from sysadm.imei_orangev3 
	where dte_dern_jour_trans > dateadd(day,-30,getdate())  
  union 
  select top 1000 num_port, 
	sysadm.FN_CORR_IMEI(num_imei,getdate()) as num_imei, 
	convert(varchar(10),dte_dern_jour_trans,103) as dte_dern_jour_trans 
  from sysadm.imei_orangev3 
  where dte_dern_jour_trans < dateadd(day,-30,getdate())  
  order by dte_dern_jour_trans desc
		
Go

grant execute on sysadm.PS_GET_IMEI_ORANGEV3_DATA to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_IMEI_ORANGEV3_FIC
-- Auteur               :       FPI
-- Date                 :       29/09/2016
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_IMEI_ORANGEV3_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_GET_IMEI_ORANGEV3_FIC
GO

CREATE procedure sysadm.PS_GET_IMEI_ORANGEV3_FIC
AS


DECLARE @sCommande   VarChar(250),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	




-- chemin d'enregistrement du Result Set
Set @sPath 	= '\\spb.lan\applis\spb\RecCmd\ORANGE\Imei_OrangeV3\'
Set @sFileName	= 'Imei_OrangeV3_' + substring(@@SERVERNAME,charindex('\',@@SERVERNAME) + 1,3) -- [PI056]
Set @sFileExt	= 'txt'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
	'exec ' + db_name() + '.sysadm.PS_GET_IMEI_ORANGEV3_DATA ' + 
	'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_GET_IMEI_ORANGEV3_FIC to rolebddsinistres
Go
