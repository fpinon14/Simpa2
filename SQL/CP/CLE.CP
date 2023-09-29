-------------------------------------------------------------------
--
-- Fichier              :       CLE.CP
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2011
--
-- Commentaires         :       
--
-- Procedures           :       PS_S01_CLE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_CLE
-- Auteur               :       Fabry JF
-- Date                 :       08/09/2011
-- Libelle              :		Lecture d'une clé
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CLE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CLE
GO

CREATE procedure sysadm.PS_S01_CLE
	@asCle      	varchar (20),
	@aiValeur		integer OUTPUT
AS

Set @asCle = UPPER ( @asCle )

Select @aiValeur = c.valeur
From   sysadm.cle c With(NOLOCK)
Where  c.id_cle = @asCle
And	   GETDATE() between dte_deb and dte_fin

If @@ROWCOUNT <> 1 Set @aiValeur = -1
If @aiValeur is null Set @aiValeur = -1

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_NUMERIQUE
-- Auteur               :       Fabry JF
-- Date                 :       11/10/2011
-- Libellé              :
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_NUMERIQUE' AND type = 'FN' )
        DROP function sysadm.FN_CLE_NUMERIQUE
Go

CREATE  function sysadm.FN_CLE_NUMERIQUE
       ( @asCle        VarChar ( 20 ))
RETURNS integer

AS

Begin
  	
	Declare @iValeur Integer 

	Set @asCle = UPPER ( @asCle )

	Select @iValeur = c.valeur
	From   sysadm.cle c With(NOLOCK)
	Where  c.id_cle = @asCle
	And	   GETDATE() between dte_deb and dte_fin

	If @@ROWCOUNT <> 1 Set @iValeur = -1
	If @iValeur is null Set @iValeur = -1

	Return @iValeur

End
Go

--------------------------------------------------------------------------------------------
-- PS_L_CLE	      JFF 07/10/2011 : Lecture global des clé SQL.
--------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_L_CLE' AND type = 'P' )
        DROP Procedure sysadm.PS_L_CLE
Go


CREATE PROCEDURE sysadm.PS_L_CLE
	@sParam1 VarChar ( 10 ) = null,
	@sParam2 VarChar ( 50 ) = null,
	@sParam3 VarChar ( 50 ) = null,
	@sParam4 VarChar ( 50 ) = null
	WITH RECOMPILE
As

-- La base PRO est : SIMPA2_PRO
-- La base SIM est : SIMPA2_TRT
-- Le code appli de PRO est : SIM8
-- Le code appli de SIM est : TSP8

DECLARE @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255)


If rTrim ( @sParam1 ) = '?'
 Begin
 	Select 'sysadm.PS_L_CLE' 'Aide'
 	Union all
 	Select '=> Visu par défaut de toutes les clés en base de production et en base de simulation'
 	Union all
 	Select ''
 	Union all
	Select 'sysadm.PS_L_CLE ''R'''
 	Union all
 	Select '=> Visu des clés non activées en production'
 	Union all
 	Select ''
 	Union all 	
	Select 'sysadm.PS_L_CLE ''P'''
 	Union all
 	Select '=> Visu des clés activées en base de production'
 	Union all
 	Select ''
 	Union all 	
 	Select 'sysadm.PS_L_CLE ''SVN'''
 	Union all
 	Select '=> Visu du nbre d''utilisateurs ayant utilisés la dernière révision placée, donc sur poste hôte'
 	Union all
 	Select ''
 	Union all 	
 	Select 'sysadm.PS_L_CLE ''SVN_ACTIF'''
 	Union all
 	Select '=> Visu du nbre d''utilisateurs actuellement connectés'
 	Union all
 	Select ''
 	Union all
/* 	Select 'sysadm.PS_L_CLE ''PS'''
 	Union all
 	Select '=> Visu des PS et fonctions obsolètes sur [SINSQL19REC\RECSINISTRES19].SIMPA2_TRT par rapport la base de production'
*/
  	Select ''
	Union all
	Select 'sysadm.PS_L_CLE ''ACT'', ''trigramme'', ''MA_CLE'', ''code activation optionnel'''
 	Union all
 	Select '=> Active la clé à 1 par défaut, ou sur le code d''activation donné en 4ème paramètre'
 	Union all
 	Select ''
	Union all
	Select 'sysadm.PS_L_CLE ''DES'', ''trigramme'', ''MA_CLE'', ''code activation optionnel'''
 	Union all
 	Select '=> Désactive la clé à 0 par défaut, ou sur le code désactivation donné en 4ème paramètre'
 	Union all
 	Select ''
	Union all
	Select 'sysadm.PS_L_CLE ''SUP'', ''MA_CLE'''
 	Union all
 	Select '=> Supprime physiquement la clé en base'
 	Union all
 	Select ''
	Union all
	Select 'sysadm.PS_L_CLE ''L'', ''MA_CLE'''
 	Union all
 	Select '=> Lit et affiche la clé spécifiée'
 	Union all
 	Select ''
	Union all
 	Select 'sysadm.PS_L_CLE ''TRCSVN'''
 	Union all
 	Select '=> Lit et affiche la table trace_revsvn. Elle contient les dernières versions SVN placées'
 	Union all
 	Select ''
	Union all
 	Select 'sysadm.PS_L_CLE ''EXE'', ''L'' '
 	Union all
 	Select '=> Lit et affiche la table application de SESAME_PRO pour les 4 applis ''SPT8'', ''SIM8'', ''TSP8'', ''SIRP'''
 	Union all
 	Select ''
	Union all
 	Select 'sysadm.PS_L_CLE ''EXE'', ''trigramme'', ''E'', ''M'''
 	Union all
 	Select '=> Modifie la table application de SESAME_PRO pour les 4 applis ''SPT8'', ''SIM8'', ''TSP8'', ''SIRP'' au niveau l''éxécutable qui passe en M_....'
 	Union all
 	Select ''
	Union all
 	Select 'sysadm.PS_L_CLE ''EXE'', ''trigramme'', ''E'', ''P'''
 	Union all
 	Select '=> Modifie la table application de SESAME_PRO pour les 4 applis ''SPT8'', ''SIM8'', ''TSP8'', ''SIRP'' au niveau l''éxécutable qui passe en P_....'
 	Union all
 	Select ''
	
 End 

If rTrim ( @sParam1 ) is null
 Begin
	select 	IsNull ( ( Select CONVERT ( VarChar ( 10), cp.cree_le, 103 ) 
			   from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
			   where cp.id_cle = cs.id_cle), 'Absente' ) 'Création P',
		IsNull ( ( Select CONVERT ( VarChar ( 10), cp.maj_le, 103 ) 
			   from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
			   where cp.id_cle = cs.id_cle), 'Absente' ) 'Dern maj P',	      
		cs.id_cle,
		Cast ( cs.valeur as VarChar (4) ) 'Rec7',		   
		IsNull ( 
		( Select Cast ( cp.valeur as VarChar (4) )
		  from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
		  where cp.id_cle = cs.id_cle), 'Abs' ) 'Prod',
		cs.cree_par 'Qui',
		cs.lib_cle,
		cs.cree_le
	from [SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.cle cs
	Order by cs.cree_le desc
 End

If rTrim ( @sParam1 ) = 'R'
 Begin
	select 	IsNull (  CONVERT ( VarChar ( 10), cs.cree_le, 103 ), 'Absente' ) 'Création R',
		IsNull (  CONVERT ( VarChar ( 10), cs.maj_le, 103 ), 'Absente' ) 'Dern maj R',	       
		cs.id_cle,
		Cast ( cs.valeur as VarChar (4) ) 'Rec7',		   
		cs.cree_par 'Qui',
		cs.lib_cle,
		cs.cree_le
	from [SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.cle cs
	Where ( cs.valeur = 0 )
	Or ( cs.valeur > 0
	     And (
		     Not Exists ( 
				  Select * 
				  From [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
				  Where cp.id_cle = cs.id_cle
				  And cp.valeur > 0
				)
		   OR
		     Exists ( 
				  Select * 
				  From [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
				  Where cp.id_cle = cs.id_cle
				  And cs.valeur > cp.valeur
				)
		  )
		   
	   )
	
	Order by cs.cree_le desc
 End

If rTrim ( @sParam1 ) = 'P'
 Begin
	select 	IsNull (  CONVERT ( VarChar ( 10), cp.cree_le, 103 ), 'Absente' ) 'Création P',
		IsNull (  CONVERT ( VarChar ( 10), cp.maj_le, 103 ), 'Absente' ) 'Dern maj P',	       
		cp.id_cle,
		Cast ( cp.valeur as VarChar (4) ) 'Prod',
		cp.cree_par 'Qui',		   
		cp.lib_cle,
		cp.cree_le
	from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
	Where valeur > 0
	Order by cp.maj_le desc
 End


If Upper ( rTrim ( @sParam1 ) ) = 'SVN'
 Begin 
	Select 	Convert ( VarChar ( 10), date_der_cnx, 112 ) 'Dte Dern. Cnx',
		id_appli,
		rev_svn_cnx 'Rev SVN' ,
		Convert ( VarChar ( 4), count (*) ) 'Nbre cnx'

	From 	[SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.connexion
	Where   rev_svn_cnx is not null
	And     rev_svn_cnx > 0 
	And	id_appli in ( 'SIM8', 'TSP8' )
	And	date_der_cnx > DATEADD ( day, -5, getdate() )
	Group by rev_svn_cnx, 
		 id_appli,
		 Convert ( VarChar ( 10), date_der_cnx, 112 )
	Order by 'Dte Dern. Cnx' desc , rev_svn_cnx desc
 End

If Upper ( rTrim ( @sParam1 ) ) = 'SVN_ACTIF'
 Begin 
	Select 	Convert ( VarChar ( 10), date_der_cnx, 112 ) 'Dte Dern. Cnx',
			id_appli,
			rev_svn_cnx 'Rev SVN' ,
			Convert ( VarChar ( 4), count (*) ) 'Nbre cnx'

	From 	[SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.connexion
	Where   rev_svn_cnx is not null
	And     rev_svn_cnx > 0 
	And	id_appli in ( 'SIM8', 'TSP8' )
	And	date_der_cnx > DATEADD ( day, -5, getdate() )
	And	date_der_cnx > date_der_sor 
	Group by rev_svn_cnx, 
		 id_appli,
		 Convert ( VarChar ( 10), date_der_cnx, 112 )
	Order by 'Dte Dern. Cnx' desc , rev_svn_cnx desc
 End

/*
If Upper ( rTrim ( @sParam1 ) ) = 'PS'
 Begin 
	select os.crdate as date_sim, op.crdate as date_pro, op.name 'PS/Vue/Fonction à recompiler sur [SINSQL19REC\RECSINISTRES19].SIMPA2_TRT'
	from [SINSQL19REC\RECSINISTRES19].SIMPA2_TRT.dbo.sysobjects os,
	     [SQL14BI\SINISTRESBI].SIMPA2_PRO.dbo.sysobjects op
	Where op.crdate > os.crdate
	and   op.name = os.name
	and   os.xtype in  ('P','FN','V')
	Union 
	Select null as date_sim, op.crdate as date_pro, op.name + ' (n''existe pas sur Recette1)' 'PS/Vue/Fonction à recompiler sur [SINSQL19REC\RECSINISTRES19].SIMPA2_TRT'
	from  [SQL14BI\SINISTRESBI].SIMPA2_PRO.dbo.sysobjects op
	Where op.xtype in  ('P','FN')
	And   Not exists ( 
		Select *
		From [SINSQL19REC\RECSINISTRES19].SIMPA2_TRT.dbo.sysobjects os
		Where os.name = op.name
		and   os.xtype in  ('P','FN','V')
			 )
 End
*/

If Upper ( rTrim ( @sParam1 ) ) = 'ACT'
 Begin 
	If LEN ( @sParam2 ) = 0 Or @sParam2 is null
	 Begin
		Select 'Deuxième paramètre non valide'
		Return
	 End 

	If LEN ( @sParam3 ) = 0 Or @sParam3 is null
	 Begin
		Select 'Troisième paramètre non valide'
		Return
	 End 

	If Not ( LEN ( @sParam4 ) = 0 Or @sParam4 is null ) 
	 Begin
		If ISNUMERIC ( @sParam4 ) = 0 
		  Begin
			Select 'Quatrième paramètre non valide (doit être un numérique)'
		 	Return
		  End

		If Convert( Integer, @sParam4 ) <= 0 
		  Begin
			Select 'Quatrième paramètre non valide (doit être un numérique strictement positif)'
		 	Return
		  End
	 End
	Else
	 Begin
		Set @sParam4 = '1'
	 End  

	 Update sysadm.cle Set valeur = CONVERT ( integer,@sParam4 ) , maj_le = getdate(), maj_par = Upper ( Rtrim ( @sParam2 ) ) Where id_cle = @sParam3

	 IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	  Begin
	
		Set @sObjet = 'Activation en production de la clé "' + @sParam3 + '" le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)
		Set @sMessage = 'Bonjour' + CHAR ( 13 ) + CHAR ( 13 )
		Set @sMessage = @sMessage + 'Le trigramme ' + Upper ( Rtrim ( @sParam2 ) ) + ' vient d''activer en production la clé "' + Upper ( @sParam3 ) + '", ce jour le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)+ '.'


 + CHAR ( 13 ) + CHAR ( 13 )
		Set @sMessage = @sMessage + 'La révision de la clé "' + Upper ( @sParam3 ) + '" est à présent à ' + @sParam4 + ' en production.'
		
		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				'jff@spb.eu, fpinon@spb.eu',
--				'jff@spb.eu',
				@sMessage, 
				@sObjet, 
				'', 
				'', 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL	  
	  End 
 End 

If Upper ( rTrim ( @sParam1 ) ) = 'DES'
 Begin 
	If LEN ( @sParam2 ) = 0 Or @sParam2 is null
	 Begin
		Select 'Deuxième paramètre non valide'
		Return
	 End 

	If LEN ( @sParam3 ) = 0 Or @sParam3 is null
	 Begin
		Select 'Troisième paramètre non valide'
		Return
	 End 

	If Not ( LEN ( @sParam4 ) = 0 Or @sParam4 is null ) 
	 Begin
		If ISNUMERIC ( @sParam4 ) = 0 
		  Begin
			Select 'Quatrième paramètre non valide (doit être un numérique)'
		 	Return
		  End

		If Convert( Integer, @sParam4 ) < 0 
		  Begin
			Select 'Quatrième paramètre non valide (doit être un numérique strictement positif)'
		 	Return
		  End
	 End
	Else
	 Begin
		Set @sParam4 = '0'
	 End  

	 Update sysadm.cle Set valeur = CONVERT ( integer,@sParam4 ) , maj_le = getdate(), maj_par = Upper ( Rtrim ( @sParam2 ) ) Where id_cle = @sParam3
	 
	 IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	  Begin
	
		Set @sObjet = 'Désactivation en production de la clé "' + @sParam3 + '" le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)
		Set @sMessage = 'Bonjour' + CHAR ( 13 ) + CHAR ( 13 )
		Set @sMessage = @sMessage + 'Le trigramme ' + Upper ( Rtrim ( @sParam2 ) ) + ' vient de désactiver en production la clé "' + Upper ( @sParam3 ) + '", ce jour le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)+ 


'.' + CHAR ( 13 ) + CHAR ( 13 )
		Set @sMessage = @sMessage + 'La révision de la clé "' + Upper ( @sParam3 ) + '" est à présent à ' + @sParam4 + ' en production.'
		
		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				'jff@spb.eu, fpinon@spb.eu',
--				'jff@spb.eu',
				@sMessage, 
				@sObjet, 
				'', 
				'', 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL	  
	  End 
 
 End 


If Upper ( rTrim ( @sParam1 ) ) = 'SUP'
 Begin 
	If LEN ( @sParam2 ) = 0 Or @sParam2 is null
	 Begin
		Select 'Deuxième paramètre non valide'
		Return
	 End 

	Delete from sysadm.cle Where id_cle = Upper ( @sParam2 )
	
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	  Begin
	
		Set @sObjet = 'Suppression en production de la clé "' + @sParam2 + '" le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)
		Set @sMessage = 'Bonjour' + CHAR ( 13 ) + CHAR ( 13 )
		Set @sMessage = @sMessage + 'La clé "' + Upper ( @sParam2 ) + '" vient d''être supprimer (physiquement) en production, ce jour le ' + convert ( varchar(10), GETDATE(), 103 ) + ' à ' + CONVERT (varchar(8), GETDATE(), 108)+ '.' + CHAR ( 13 ) + CHAR ( 13 )




		
		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				'jff@spb.eu, fpinon@spb.eu',
--				'jff@spb.eu',
				@sMessage, 
				@sObjet, 
				'', 
				'', 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL	  
	  End 


 End 

If Upper ( rTrim ( @sParam1 ) ) = 'L'
 Begin 
	If LEN ( @sParam2 ) = 0 Or @sParam2 is null
	 Begin
		Select 'Deuxième paramètre non valide'
		Return
	 End 

	select 	IsNull ( ( Select CONVERT ( VarChar ( 10), cp.cree_le, 103 ) 
			   from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
			   where cp.id_cle = cs.id_cle), 'Absente' ) 'Création P',
		IsNull ( ( Select CONVERT ( VarChar ( 10), cp.maj_le, 103 ) 
			   from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
			   where cp.id_cle = cs.id_cle), 'Absente' ) 'Dern maj P',	      
		cs.id_cle,
		Cast ( cs.valeur as VarChar (4) ) 'Rec7',		   
		IsNull ( 
		( Select Cast ( cp.valeur as VarChar (4) )
		  from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.cle cp
		  where cp.id_cle = cs.id_cle), 'Abs' ) 'Prod',
		cs.cree_par 'Qui',
		cs.lib_cle,
		cs.cree_le
	from [SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.cle cs
	Where cs.id_cle = @sParam2
	Order by cs.cree_le desc


 End 

If Upper ( rTrim ( @sParam1 ) ) = 'TRCSVN'
 Begin 
	Select 	*
	From 	[SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.trace_revsvn
	Order   by revsvn
 End


If Upper ( rTrim ( @sParam1 ) ) = 'EXE'
 Begin 
	If LEN ( @sParam2 ) = 0 Or @sParam2 is null
	 Begin
		Select 'Deuxième paramètre non valide'
		Return
	 End 

	If @sParam2 = 'L' 
	 Begin
		select * from [SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.application where id_appli in ( 'SPT8', 'SIM8', 'TSP8', 'SIRP' )		
		Return
	 End 

	If LEN ( @sParam3 ) = 0 Or @sParam3 is null Or @sParam3 not in ( 'E' )
	 Begin
		Select 'Troisième paramètre non valide, doit être renseigné E'
		Return
	 End 
 
	If @sParam3 = 'E' And ( LEN ( @sParam4 ) = 0 Or @sParam4 is null Or @sParam4 not in ( 'M', 'P' ) )
	 Begin
		Select 'Quatrième paramètre non valide, doit être renseigné par M ou P si param3 = E'
		Return
	 End 	 

	If @sParam3 = 'E' And SERVERPROPERTY('ServerName' ) <> 'SQL14BI\SINISTRESBI' 
	 Begin 
		Select 'La commande d''écriture ne peut être lancée que de l''instance de production'
		Return
	 End

	If @sParam3 = 'E' And @sParam4 = 'M' 
	 Begin
		Exec sysadm.PS_L_CLE 'DES', @sParam2, 'VERIF_REVSVN'
		Select 'Action d''écriture M effectuée en production'	 
		Update SESAME_PRO.sysadm.application set lib_commande = 'C:\SPB\M_FR_APP_Simpa2_main_121.EXE' where id_appli in ( 'SPT8', 'SIM8', 'TSP8', 'SIRP' )
	 End 

	If @sParam3 = 'E' And @sParam4 = 'P' 
	 Begin
		Exec sysadm.PS_L_CLE 'ACT', @sParam2, 'VERIF_REVSVN'
		Select 'Action d''écriture P effectuée en production'	 
		Update SESAME_PRO.sysadm.application set lib_commande = 'C:\SPB\P_FR_APP_Simpa2_main_121.EXE' where id_appli in ( 'SPT8', 'SIM8', 'TSP8', 'SIRP' )
	 End 

 End

Go

grant execute on sysadm.PS_L_CLE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_L_CLE_LISTE
-- Auteur               :       FPI
-- Date                 :       25/10/2016
-- Libelle              :		Lecture des clés
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       liste des clés
--					  
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_L_CLE_LISTE' AND type = 'P' )
        DROP procedure sysadm.PS_L_CLE_LISTE
GO

CREATE PROCEDURE sysadm.PS_L_CLE_LISTE
As
select 	Case When s.type='PRO' Then convert(varchar(10),cs.cree_le,103) Else 'Absent' End as 'Création P',
		Case When s.type='PRO' Then convert(varchar(10),cs.cree_le,103) Else 'Absent' End as 'Dern maj P',	      
		Case When s.type='SIM' Then convert(varchar(10),cs.cree_le,103) Else 'Absent' End as 'Création R',
		Case When s.type='SIM' Then convert(varchar(10),cs.cree_le,103) Else 'Absent' End as 'Dern maj R',	      
		cs.id_cle,
		Case When s.type='SIM' Then convert(varchar(10),cs.valeur) Else 'Absent' End 'Rec7',		   
		Case When s.type='PRO' Then convert(varchar(10),cs.valeur) Else 'Absent' End 'Prod',
		cs.cree_par 'Qui',
		cs.lib_cle,
		cs.cree_le
	from sysadm.cle cs,
		[master].[dbo].[SPB_servername] s
	where s.server_name=@@SERVERNAME
	Order by cs.cree_le desc
Go


grant execute on sysadm.PS_L_CLE_LISTE to rolebddsinistres
Go


