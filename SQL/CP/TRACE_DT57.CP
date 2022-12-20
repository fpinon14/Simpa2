-------------------------------------------------------------------
--
-- Fichier              :       TRACE_DT57.CP
-- Auteur               :       FABRY JF
-- Date                 :       27/08/2013
--
-- Commentaires         :       
--
-- Procédures           :       PS_I01_TRACE_DT57	 	// Insertion dans table
--				PS_S01_TRACE_DT57		// Extraction 
--				PS_S02_TRACE_DT57_ECR_FIC  // Ecriture du fichier
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_DT57
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans TRACE_DT57
-- Commentaires         :       
--
-- Arguments           : @dcIdSin           decimal ( 7, 0 ),
--		         @iIdSeq	    integer,
--			 @sImei		    varchar ( 20 ),
--			 @sMajPar	    varchar ( 4 )
--
-- Retourne                            :     Rien
--                                
--  JFF	28/03/2014	[DT57][V3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_DT57' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_DT57
GO

CREATE procedure sysadm.PS_I01_TRACE_DT57 
        @dcIdSin    Decimal ( 10, 0 ), -- [PI062]
        @iIdSeq		Integer,
		@sNouvImei  varchar ( 20 ),
		@dtDteEnvoi DateTime
		
AS

Declare @sNouvMarq	VarChar( 35 ) 
Declare @sNouvModl	VarChar( 35 ) 
Declare @sAncImei   varChar ( 20 )
Declare @sDonneurOrdre   varChar ( 35 )

If Exists ( 
		Select * 
		From   sysadm.trace_dt57 t
		Where  t.id_sin = @dcIdSin
		And    t.id_seq = @iIdSeq 
		)
	Begin
		Return
	End 

If Not Exists ( 
		Select * 
		From   sysadm.commande c
		Where  c.id_sin = @dcIdSin
		And    c.id_seq = @iIdSeq 
		And    CharIndex ('IPHONE', c.id_modl_art_ifr ) > 0
		And    sysadm.FN_CLE_VAL ( 'DONNEUR_ORDRE', rtrim ( c.info_spb_frn_cplt ) , ';' ) in ( '9802463', '980246X' ) -- [DT57][V3]
		)
	Begin
		Return
	End 

Select @sNouvMarq = rtrim ( c.id_marq_art ),
	   @sNouvModl = rtrim ( c.id_modl_art ),
	   @sAncImei = rtrim ( c.id_serie_anc ),
	   @sDonneurOrdre = IsNull ( sysadm.FN_CLE_VAL ( 'DONNEUR_ORDRE', rtrim ( c.info_spb_frn_cplt ) , ';' ) , '' )
From   sysadm.commande c
Where  c.id_sin = @dcIdSin
And    c.id_seq = @iIdSeq


Insert into sysadm.trace_dt57
	(  
		id_lot,    
		id_sin,    
		id_seq,    
		nouv_marq, 
		nouv_modl, 
		nouv_imei, 
		anc_imei, 
		dte_envoi, 
		donneur_ordre, -- [DT57][V3]
		alt_genfic,
		cree_le,
		maj_le,    
		maj_par 
	)

Values 
	(
	   0,
	   @dcIdSin,
	   @iIdSeq,
	   @sNouvMarq,
	   @sNouvModl,
	   @sNouvImei,
	   @sAncImei,
	   @dtDteEnvoi,
	   @sDonneurOrdre, -- [DT57][V3]
	   'N' ,
	   GetDate (),
	   GetDate (),
	   'OPCO' 
     )

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_TRACE_DT57
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans TRACE_DT57
-- Commentaires         :       Contrôle sur l'heure d'execution entre 22h00 et 05H59
--
-- Arguments           : @dcIdSin           decimal ( 7, 0 ),
--		         @iIdSeq	    integer,
--			 @sImei		    varchar ( 20 ),
--			 @sMajPar	    varchar ( 4 )
---- Retourne                            :     Rien
--                                
--  JFF	28/03/2014	[DT57][V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_TRACE_DT57' AND type = 'P' )
        DROP procedure sysadm.PS_S01_TRACE_DT57 
GO

CREATE procedure sysadm.PS_S01_TRACE_DT57
AS

Declare @iIdLot integer

-- Begin tran
EXEC sysadm.PS_X_INCREMENTER 'ID_LOTDT57', @iIdLot OUTPUT 
-- Commit Tran

Update sysadm.trace_dt57
Set    alt_genfic = 'O', id_lot = @iIdLot 
Where  alt_genfic = 'N'

Select  id_lot,    
		id_sin,   
		id_seq,    
		nouv_marq, 
		nouv_modl, 
		nouv_imei, 
		anc_imei,
		donneur_ordre,  -- [DT57][V3]
		dte_envoi, 
		GETDATE() 'dte_extrac'
From	sysadm.trace_dt57 tmr
Where  	id_lot = @iIdLot 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_TRACE_DT57_ECR_FIC
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans TRACE_DT57
-- Commentaires         :       
--
-- Arguments           : @dcIdSin           decimal ( 7, 0 ),
--		         @iIdSeq	    integer,
--			 @sImei		    varchar ( 20 ),
--			 @sMajPar	    varchar ( 4 )
--
-- Retourne                            :     Rien
--                                
--		JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_TRACE_DT57_ECR_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S02_TRACE_DT57_ECR_FIC
GO

CREATE PROC sysadm.PS_S02_TRACE_DT57_ECR_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sOsqlOption VarChar(255),
        @iRetOsql	int	
 
SET @sFicOut = '\\F4T\SIMPA2\O2M\fic_RET_IPHONE_SFR_O2M\' + 
--SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT() + 'SIMPA2\O2M\fic_RET_IPHONE_SFR_O2M\' + 
               CONVERT (varchar(4), DatePart (year,getdate())  ) +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(hour,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(minute,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(second,getdate())   ),  2 )   + 
               '-RETOUR_CMDE_IPHONE_O2M_SFR.TXT'


SET @sNomServeur = @@servername
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

Select @sFicOut

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S01_TRACE_DT57 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S01_TRACE_DT57 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

Select @sCommande
                                       
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output
Select @iRetOsql
GO

grant execute on sysadm.PS_S02_TRACE_DT57_ECR_FIC to rolebddsinistres
go