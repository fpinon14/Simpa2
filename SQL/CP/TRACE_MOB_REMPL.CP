-------------------------------------------------------------------
--
-- Fichier              :       TRACE_MOB_REMPL.CP
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
--
-- Commentaires         :       
--
-- Procédures           :       PS_I01_TRACE_MOB_REMPL	 	// Insertion dans table
--				PS_S01_TRACE_MOB_REMPL		// Extraction fichier pour EA
--				PS_S02_TRACE_MOB_REMPL_ECR_FIC  // Ecriture du fichier
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_MOB_REMPL
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans trace_mob_rempl
-- Commentaires         :       
--
-- Arguments           : @dcIdSin           decimal ( 7, 0 ),
--		         @iIdSeq	    integer,
--			 @sImei		    varchar ( 20 ),
--			 @sMajPar	    varchar ( 4 )
--
-- Retourne                            :     Rien
--                                
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_MOB_REMPL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_MOB_REMPL
GO

CREATE procedure sysadm.PS_I01_TRACE_MOB_REMPL 
        @dcIdSin           decimal ( 10, 0 ), -- [PI062]
        @iIdSeq		   integer,
        @sImei		   varchar ( 20 ),
        @sMajPar	   varchar ( 4 )
AS

Declare @dcIdProd	Decimal ( 7 )
Declare @dcIdProdDms	Decimal ( 3 )
Declare @dcIdEts	Decimal ( 7 )
Declare @sIdAdh		VarChar ( 19 )
Declare @dcIdDos	Decimal ( 2 )
Declare @sIdMarqArt	VarChar ( 35 )
Declare @sIdModlArt	VarChar ( 35 )

	
Select 	@dcIdProd = s.id_prod 
From 	sysadm.sinistre s
Where 	s.id_sin = @dcIdSin 

select 	@dcIdProdDms = p.cod_prod_dms
From 	sysadm.sinistre s,
	sysadm.produit p
Where 	s.id_sin = @dcIdSin
And 	p.id_prod = s.id_prod 

Select 	@dcIdEts = s.id_ets
From 	sysadm.sinistre s
Where 	s.id_sin = @dcIdSin 

Select 	@sIdAdh = s.id_adh
From 	sysadm.sinistre s
Where 	s.id_sin = @dcIdSin 

Select 	@dcIdDos = s.id_sdos
From 	sysadm.sinistre s
Where 	s.id_sin = @dcIdSin 

Select 	@sIdMarqArt = 	Case 
				When Len ( c.id_marq_art_ifr ) <> 0 And sysadm.FN_TRIM ( c.id_marq_art_ifr ) <> '' Then c.id_marq_art_ifr
				Else c.id_marq_art
			End 
From 	sysadm.commande c
Where 	c.id_sin = @dcIdSin 
And     c.id_seq = @iIdSeq

Select 	@sIdModlArt = Case 
				When Len ( c.id_modl_art_ifr ) <> 0 And sysadm.FN_TRIM ( c.id_modl_art_ifr ) <> '' Then c.id_modl_art_ifr
				Else c.id_modl_art
		      End 
From 	sysadm.commande c
Where 	c.id_sin = @dcIdSin 
And     c.id_seq = @iIdSeq

Insert into sysadm.trace_mob_rempl
	(  
	   id_sin,
	   id_seq,
	   id_prod_sin,
	   id_prod_dms,
	   id_ets,
	   id_adh,
	   id_sdos,
	   nouv_marq,
	   nouv_modl,
	   nouv_imei,
	   alt_genfic,
	   cree_le,
	   maj_le,
	   maj_par
	)

Values 
	(
	   @dcIdSin,
	   @iIdSeq,
	   @dcIdProd,
	   @dcIdProdDms,
	   @dcIdEts,
	   @sIdAdh,
	   @dcIdDos,
	   @sIdMarqArt,
	   @sIdModlArt,
	   @sImei,
	   'N' ,
	   GetDate (),
	   GetDate (),
	   @sMajPar 
        )
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_TRACE_MOB_REMPL
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans trace_mob_rempl
-- Commentaires         :       Contrôle sur l'heure d'execution entre 22h00 et 05H59
--
-- Arguments           : @dcIdSin           decimal ( 7, 0 ),
--		         @iIdSeq	    integer,
--			 @sImei		    varchar ( 20 ),
--			 @sMajPar	    varchar ( 4 )
--
-- Retourne                            :     Rien
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_TRACE_MOB_REMPL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_TRACE_MOB_REMPL
GO

CREATE procedure sysadm.PS_S01_TRACE_MOB_REMPL
AS
-- [I027] Ajout d'espace pour correspondre au masque d'import des adhésions+ remplacement des FN_TRIM par LTRIM
Select  ' ' +
    Right ( Replicate ('0', 10 ) + LTRIM ( Convert ( Varchar (50), tmr.id_sin )) , 10 ) + -- [PI062]
	Right ( Replicate ('0', 1 ) + LTRIM ( Convert ( Varchar (50), tmr.id_seq )) , 1 ) + 
	Right ( Replicate ('0', 6 ) + LTRIM ( Convert ( Varchar (50), tmr.id_prod_sin )), 6 ) +
	Right ( Replicate ('0', 4 ) + LTRIM ( Convert ( Varchar (50), tmr.id_prod_dms )), 4 ) +
	Right ( Replicate ('0', 5 ) + LTRIM ( Convert ( Varchar (50), tmr.id_ets )), 5 ) +
	Right ( Replicate ('0', 19 ) + LTRIM ( tmr.id_adh ), 19 ) +
	Right ( Replicate ('0', 1 ) + LTRIM ( Convert ( Varchar (50), tmr.id_sdos )), 1 ) +
	Left ( LTRIM ( tmr.nouv_marq ) + Replicate (' ', 35 ), 35 ) + 
	Left ( LTRIM ( tmr.nouv_modl ) + Replicate (' ', 35 ), 35 ) + 
	Right ( Replicate ('0', 15 ) + LTRIM ( tmr.nouv_imei ), 15 ) +
        RIGHT ( '0000' + CONVERT (varchar(4),DatePart(year,getdate())   ),  4 )   + 
        RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + 
        RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )+ ' '    
From	sysadm.trace_mob_rempl tmr,
	SHERPA_PRO.sysadm.sinistre s,
	SHERPA_PRO.sysadm.adhesion a,
	SHERPA_PRO.sysadm.det_pro dp
Where  	tmr.alt_genfic = 'N'
And 	( Convert ( integer, Substring ( Convert ( Varchar (23), getdate(), 8 ), 1, 2 ) ) between 19 and 23
          Or 
	  Convert ( integer, Substring ( Convert ( Varchar (23), getdate(), 8 ), 1, 2 ) ) between 0 and 5
	 )
And 	s.id_sin = tmr.id_sin
And	s.id_appli = 2
And 	s.id_cli = a.id_cli
And 	LTRIM ( s.id_adh ) = LTRIM ( Convert ( varchar ( 19 ), a.id_adh ) )
And 	s.id_ets = a.id_ets
And 	s.id_sdos = a.id_sdos
and     dp.id_prod = s.id_prod_sin
and     dp.id_typ_code = '-PADH'
and     dp.id_code = a.id_prod_adh


Update sysadm.trace_mob_rempl
Set    alt_genfic = 'O'
Where  alt_genfic = 'N'
And 	( Convert ( integer, Substring ( Convert ( Varchar (23), getdate(), 8 ), 1, 2 ) ) between 19 and 23
          Or 
	  Convert ( integer, Substring ( Convert ( Varchar (23), getdate(), 8 ), 1, 2 ) ) between 0 and 5
	 )

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_TRACE_MOB_REMPL_ECR_FIC
-- Auteur               :       FABRY JF
-- Date                 :       27/12/2005
-- Libellé              :       Insertion dans trace_mob_rempl
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


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_TRACE_MOB_REMPL_ECR_FIC' AND type = 'P' )
        DROP procedure sysadm.PS_S02_TRACE_MOB_REMPL_ECR_FIC
GO

CREATE PROC sysadm.PS_S02_TRACE_MOB_REMPL_ECR_FIC
AS

DECLARE @sCommande   VarChar(250),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255)
 

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   Set @sCommande = 'SIMPA2_PRO.sysadm.PS_S01_TRACE_MOB_REMPL'
Else
   Set @sCommande = 'SIMPA2_TRT.sysadm.PS_S01_TRACE_MOB_REMPL'


SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Maj_Telephonie_Vers_EA\' + 
               CONVERT (varchar(4), DatePart (year,getdate())  ) +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(hour,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(minute,getdate())   ),  2 )   + 
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(second,getdate())   ),  2 )   + 
               '-IMEI-MARQ-MODL.TXT'


SET @sNomServeur = @@servername

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"SIMPA2_PRO.sysadm.PS_S01_TRACE_MOB_REMPL" /o' + @sFicOut + ' -w5000'
Else
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"SIMPA2_TRT.sysadm.PS_S01_TRACE_MOB_REMPL" /o' + @sFicOut + ' -w5000'
                                       
EXEC master.dbo.xp_cmdshell @sCommande, no_output



GO

grant execute on sysadm.PS_S02_TRACE_MOB_REMPL_ECR_FIC to rolebddsinistres
Go
