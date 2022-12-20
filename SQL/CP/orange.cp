-------------------------------------------------------------------
--
-- Fichier              :       ORANGE.CP
-- Auteur               :       PLJ
-- Date                 :       03/06/2004
--
-- Commentaires         :       Extraction pour Orange
--
-- Procedures           :       PS_S01_ORANGE    Envoi des IMEI via PS_S02_ORANGE
--				PS_S02_ORANGE    Extraction des IMEI
--                              PS_S03_ORANGE    Envoi des dossiers ORANGE à VALENCIENNES via PS_S04_ORANGE
--                              PS_S04_ORANGE    Extraction des dossiers ORANGE ouverts J-1
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_ORANGE
-- Auteur               :       PLJ
-- Date                 :       03/06/2004
-- Libelle              :        
-- Commentaires         :       Procedure principale appele tous les jours
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-- #2 Le 23/03/2006 FS  : Retrait trigrammes KAV et BRE de la liste de diffusion
-- #3 JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ORANGE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_ORANGE
GO

CREATE procedure sysadm.PS_S01_ORANGE
AS

DECLARE @dJour       DateTime,
        @sdMin       Varchar(20),
        @sdMax       VarChar(20),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255)
        
DECLARE @sRetourErrMail         VarChar(255)
DECLARE @sRoot Varchar(255)

Set @dJour  = GetDate ()
Set @dJour  = DateADD ( Day, -1, @dJour )
Set @sdMin  = Convert ( Varchar (10), @dJour, 103 ) + " 00:00:00"
set @sdMax  = Convert ( Varchar (10), @dJour, 103 ) + " 23:59:59"
Set @sRoot = master.sysadm.SPB_FN_GET_ROOT()+'SINISTRE\EXPORT_SPB_PS_MAIL\orange.OUT'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   Set @sCommande = "SIMPA2_PRO.sysadm.PS_S02_ORANGE '" + @sdMin + "', '" + @sdMax + "'"
Else
   Set @sCommande = "SIMPA2_TRT.sysadm.PS_S02_ORANGE '" + @sdMin + "', '" + @sdMax + "'"

Set @sObjet    = "SPB/ORANGE : IMEI sinistres Orange Securité du " + @sdMin + " au " + @sdMax
set @sMessage  = "Extraction des IMEI Orange Sécurité des sinistres créés entre le " + @sdMin + " et le " + @sdMax + Char(13)+ Char(10) +
                 "Veuillez détacher sur votre disque le fichier pour pouvoir l'ouvrir"

EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, 'SLT@spb.fr, VPA@spb.fr, MSL@spb.fr, MPR@spb.fr, LAS@Spb.fr, SZE@Spb.fr, KGR@Spb.fr, NTA@Spb.fr, ACA@Spb.fr, CAV@Spb.fr, JOC@Spb.fr, CAS@Spb.fr, CBR@Spb.fr, PDE@Spb.fr, IHO@spb.fr, NCA@spb.fr, DUM@spb.fr, CBN@spb.fr, SAL@spb.fr, SRA@spb.fr, bruno.hanin@spb.fr, karima.zouaoui@spb.fr, myriam.occolier@spb.fr', @sMessage, @sObjet, '', '', '', @sCommande, @sRoot, 2, ''


SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+'Simpa2\Orange\IMEI\IMEI-' + 
               CONVERT (char(4), DatePart (year,getdate())  ) + "-" +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + "-" +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )    + ".TXT"


SET @sNomServeur = @@servername

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    "SIMPA2_PRO.sysadm.PS_S02_ORANGE '" + @sdMin + "', '" + @sdMax + "'" +
                    '" /o' + @sFicOut + ' -w5000 -u'
Else
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    "SIMPA2_TRT.sysadm.PS_S02_ORANGE '" + @sdMin + "', '" + @sdMax + "'" +
                    '" /o' + @sFicOut + ' -w5000 -u'

                                       
EXEC master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S01_ORANGE to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S02_ORANGE
-- Auteur               :       PLJ
-- Date                 :       03/06/2004
-- Libelle              :        
-- Commentaires         :       Procedure principale appele tous les jours
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_ORANGE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_ORANGE
GO

CREATE procedure sysadm.PS_S02_ORANGE
@dMin   Datetime,
@dMax   Datetime
AS

SELECT w_sin.nom,
       w_sin.prenom,
       w_sin.id_sin, 
	    w_sin.id_prod,
       convert ( varchar(10), w_sin.cree_le, 103 ) + ' ' + 
       convert ( varchar(08), w_sin.cree_le, 108 )               AS "cree_le",
	    w_sin.maj_par,
	    w_sin.num_imei_port,
	    w_sin.num_port,
       convert ( varchar(10), w_sin.dte_surv, 103 )              AS "survenance"

 FROM  sysadm.w_sin

WHERE w_sin.id_prod      in (9104, 9105, 9106, 9107, 9108, 9109, 9110, 9111, 9112, 9120)
AND   w_sin.cree_le between @dMin and @dMax
      

UNION

SELECT personne.nom,
       personne.prenom,
       sinistre.id_sin, 
       sinistre.id_prod,
       convert ( varchar(10), sinistre.cree_le, 103 ) + ' ' + 
       convert ( varchar(08), sinistre.cree_le, 108 )            AS "cree_le",
	    sinistre.maj_par,
	    sinistre.num_imei_port,
	    sinistre.num_port,
       convert ( varchar(10), sinistre.dte_surv, 103 )           AS "survenance"

  FROM sinistre  INNER JOIN sysadm.personne  ON personne.id_ordre = sinistre.id_ordre
 WHERE sinistre.id_prod      in (9104, 9105, 9106, 9107, 9108, 9109, 9110, 9111, 9112, 9120)   AND
       sinistre.cree_le between @dMin and @dMax

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S03_ORANGE
-- Auteur               :       MADM
-- Date                 :       13/01/2006
-- Libelle              :        
-- Commentaires         :       Procedure principale appele tous les jours
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
--		JCA changement repertoire cible (norme UNC)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_ORANGE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_ORANGE
GO

CREATE procedure sysadm.PS_S03_ORANGE
AS

DECLARE @dJour       DateTime,
        @sdMin       Varchar(20),
        @sdMax       VarChar(20),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255)
        
DECLARE @sRetourErrMail         VarChar(255)

Set @dJour  = GetDate ()
Set @dJour  = DateADD ( Day, -1, @dJour )
Set @sdMin  = Convert ( Varchar (10), @dJour, 103 ) + ' 00:00:00'
set @sdMax  = Convert ( Varchar (10), @dJour, 103 ) + ' 23:59:59'

/* SHUNT car départ par CFT
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   Set @sCommande = "SIMPA2_PRO.sysadm.PS_S04_ORANGE '" + @sdMin + "', '" + @sdMax + "'"
Else
   Set @sCommande = "SIMPA2_TRT.sysadm.PS_S04_ORANGE '" + @sdMin + "', '" + @sdMax + "'"

Set @sObjet    = "SPB/ORANGE : Dossiers ORANGE ouverts entre le  " + @sdMin + " au " + @sdMax
set @sMessage  = "Extraction des Dossiers ORANGE créés entre le " + @sdMin + " et le " + @sdMax + Char(13)+ Char(10) +
                 "Veuillez détacher sur votre disque le fichier pour pouvoir l'ouvrir"

EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, 'adhesion.orangesecurite@francetelecom.com', @sMessage, @sObjet, '', 'JFF@Spb.fr', '', @sCommande, 'D:\SINISTRE\EXPORT_SPB_PS_MAIL\orange.OUT', 2, ''
*/

SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+'Simpa2\Orange\DOSSIERS_OUVERTS\DOSSIERS_OUVERTS-' + 
               CONVERT (char(4), DatePart (year,getdate())  ) + "-" +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,getdate()) ),  2 )    + "-" +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,getdate())   ),  2 )    + ".TXT"


SET @sNomServeur = @@servername

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    "SIMPA2_PRO.sysadm.PS_S04_ORANGE '" + @sdMin + "', '" + @sdMax + "'" +
                    '" /o' + @sFicOut + ' -w5000'
Else
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    "SIMPA2_TRT.sysadm.PS_S04_ORANGE '" + @sdMin + "', '" + @sdMax + "'" +
                    '" /o' + @sFicOut + ' -w5000'

                                       
EXEC master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S03_ORANGE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S04_ORANGE
-- Auteur               :       MADM
-- Date                 :       13/01/2006
-- Libelle              :        
-- Commentaires         :       Procedure principale appele tous les jours
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- #1	JFF	06/02/2008 [DCMP080728]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_ORANGE' AND type = 'P' )
        DROP procedure sysadm.PS_S04_ORANGE
GO

CREATE procedure sysadm.PS_S04_ORANGE
@dMin   Datetime,
@dMax   Datetime
AS

SELECT w_sin.nom,
       w_sin.prenom,
       w_sin.id_sin, 
       w_sin.id_prod,
       Left ( produit.lib_long, 35 ), -- #1
       convert ( varchar(10), w_sin.cree_le, 103 ) + ' ' + 
       convert ( varchar(08), w_sin.cree_le, 108 )               AS "cree_le",
       w_sin.maj_par,
       Case 
       	 When w_sin.id_adh like '6%' Or w_sin.id_adh like '06%' Then Right ( Replicate ( '0', 10 ) + w_sin.id_adh, 10 )        	 
       	 Else Right ( Replicate ( '0', 10 ) + w_sin.num_port, 10 )
       End,
       convert ( varchar(10), w_sin.dte_surv, 103 )              AS "survenance",
       w_sin.dte_adh,
       w_sin.dte_resil

 FROM  sysadm.w_sin , sysadm.produit

WHERE w_sin.id_prod      in (9110, 9111, 9112, 9120)
AND   produit.id_prod = w_sin.id_prod
AND   w_sin.cree_le between @dMin and @dMax
      
UNION

SELECT personne.nom,
       personne.prenom,
       sinistre.id_sin, 
       sinistre.id_prod,
       Left ( produit.lib_long, 35), -- #1
       convert ( varchar(10), sinistre.cree_le, 103 ) + ' ' + 
       convert ( varchar(08), sinistre.cree_le, 108 )            AS "cree_le",
       sinistre.maj_par,
       Case 
       	 When sinistre.id_adh like '6%' Or sinistre.id_adh like '06%' Then Right ( Replicate ( '0', 10 ) + sinistre.id_adh, 10 )
       	 Else Right ( Replicate ( '0', 10 ) + sinistre.num_port, 10 )
       End,
       convert ( varchar(10), sinistre.dte_surv, 103 )           AS "survenance",
       sinistre.dte_adh,
       sinistre.dte_resil

  FROM  produit , sinistre  INNER JOIN sysadm.personne  ON personne.id_ordre = sinistre.id_ordre
  WHERE sinistre.id_prod      in (9110, 9111, 9112, 9120)  
  AND   produit.id_prod = sinistre.id_prod
  AND   sinistre.cree_le between @dMin and @dMax

Go

