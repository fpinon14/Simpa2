-------------------------------------------------------------------
--
-- Fichier              :       IMEI_ORANGECARAIBE.CP
-- Auteur               :       FPI
-- Date                 :       02/10/2013
--
-- Commentaires         :       Table des IMEI Orange Caraibe
--
-- Procédures           :       PS_S01_CTL_IMEI_ORANGECARAIBE
-------------------------------------------------------------------
/* ------------------
   Création de table 
   ------------------
if exists (select 1
            from  sysobjects
           where  id = object_id('sysadm.imei_orangecaraibe')
            and   type = 'U')
   drop table sysadm.imei_orangecaraibe
go

create table sysadm.imei_orangecaraibe (
   id_seq               integer              identity,
   num_port             varchar(25)          not null,
   num_imei             varchar(60)          not null,
   dte_dern_jour_trans  datetime             not null,
   cree_le              datetime             not null,
   maj_le               datetime             null,
   nom_fic              varchar(255)         null,
   constraint PK_IMEI_ORANGECARAIBE primary key  (id_seq)
)
go

grant select, insert, delete, update on sysadm.imei_orangecaraibe to rolebddsinistres
Go

*/
--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CTL_IMEI_ORANGECARAIBE
-- Auteur               :       FPI
-- Date                 :       14/05/2013
-- Libellé              :        
-- Commentaires         :       Sélect sur la table Imei_orangecaraibe
-- Références           :       
--
-- Arguments            :       @sNumPort varchar(25)
--								@sNumImei Varchar(60)
--								@dtDteSurv DateTime  -- V01
--
-- Retourne             :       1 si le binome existe en table, 0 sinon
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CTL_IMEI_ORANGECARAIBE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CTL_IMEI_ORANGECARAIBE
GO

CREATE procedure sysadm.PS_S01_CTL_IMEI_ORANGECARAIBE
        @sNumPort varchar(25),
		@sNumImei Varchar(60),
		@dtDteSurv DateTime
AS
	Declare @iRet integer
	Declare @dtDtePivot datetime
	
	Set @iRet=0
	Set @dtDtePivot = DateAdd(day, -30, @dtDteSurv)
	
	Select @iRet=IsNull(Count(*),0)
	From sysadm.imei_orangecaraibe
	Where num_port=@sNumPort
		And num_imei=Left(@sNumImei,14)
		And dte_dern_jour_trans >= @dtDtePivot
		
	If @iRet > 1 Set @iRet=1
	
	Return @iRet
Go
