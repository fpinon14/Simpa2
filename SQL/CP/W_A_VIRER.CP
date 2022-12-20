-------------------------------------------------------------------
--
-- Fichier              :       w_a_virer.cp
-- Auteur               :       Fabry JF
-- Date                 :       05/03/08 17:17:18
--
-- Commentaires         :       Liste des proc‚dures aff‚rentes … la table W_A_VIRER
--
-- Procedures           :       PS_ENVOI_MAIL_GROUPE_FACTURATION
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_ENVOI_MAIL_GROUPE_FACTURATION
-- Auteur               :       Erick John Stark
-- Date                 :       14/04/07 11:27:57
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @asRetour               VarChar (  250 )        OUTPUT
--
-- Retourne             :       Rien
--
-- JFF  25/03/2014  ITSM205975 changement 0 en D + job à 08h00
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAIL_GROUPE_FACTURATION' AND type = 'P' )
        DROP procedure sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION
GO

CREATE  PROC sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION
        @asRetour               VarChar (  250 )        OUTPUT
AS

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @asRetour            = Valeur de retour suite au traitement                                                                  */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Variables pour le traitement.                                    */
/*------------------------------------------------------------------*/
DECLARE         
        @dtTrt                  DATETIME        ,
        @sdtTrt                 VARCHAR(25)     ,
        @sRepExport             VARCHAR(250)    ,
        
        @sDossierRegles         VARCHAR(250)    ,
        @sSelectRegles          VARCHAR(2500)   ,
        
        @sNomServeur            VARCHAR(25)     ,
        
        @sCmd                   VARCHAR(4000)   ,
        
        @sObjetFacturation      VARCHAR(255)    ,
        @sTextFacturation       VARCHAR(8000)   ,
        @sTo                    VARCHAR(2048)   ,
        @sCc                    VARCHAR(2048)   ,
        @sFichiersRattaches     VARCHAR(8000)   ,
        @iRet                   INTEGER         ,
        @sRetourErrMail         VARCHAR(255)

/*------------------------------------------------------------------*/
/* On positionne le nom du répertoire pour l'export.                */
/*------------------------------------------------------------------*/
SET @sRepExport     = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Facturation' 
/*------------------------------------------------------------------*/
/* On va vérifier si le répertoire de traitement existe. Si ce      */
/* n'est pas le cas, on arrête le traitement.                       */
/*------------------------------------------------------------------*/
IF      ( SELECT object_id ( 'tempdb.dbo.#TblFileExistsExport' ) ) > 0
        BEGIN
                EXEC ('Drop table #TblFileExistsExport' )
        END
/*------------------------------------------------------------------*/
/* On va créer une table temporaire pour fonctionner avec la        */
/* procédure stockée étendue xp_fileexist.                          */
/*------------------------------------------------------------------*/
CREATE TABLE #TblFileExistsExport
        (
        FileExists              TINYINT         NULL    ,
        FileIsDirectory         TINYINT         NULL    ,
        ParentDirectoryExists   TINYINT         NULL
        )

INSERT INTO #TblFileExistsExport
EXEC master.dbo.xp_fileexist @sRepExport

IF      ( SELECT FileIsDirectory FROM #TblFileExistsExport ) <> 1
        BEGIN
                SET @asRetour = 'Le répertoire ' + @sRepExport + ' n''existe pas. Le traitement est impossible.' 
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On arme une variable au format JJMMAAAA(Date de Traitement)      */
/* _HHMMSSMS(Heure de lancement du traitement).                     */
/* Cette variable sera concaténée au nom du fichier que l'on va     */
/* produire.                                                        */
/*------------------------------------------------------------------*/
SET @dtTrt              = GETDATE()
SET @sdtTrt             = REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( dd, @dtTrt ) ) ) ) )  )    +
                          LTRIM ( RTRIM ( STR ( DATEPART ( dd, @dtTrt ) ) ) )                                   +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( mm, @dtTrt ) ) ) ) )  )    + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( mm, @dtTrt ) ) ) )                                   +
                          LTRIM ( RTRIM ( STR ( DATEPART ( yyyy, @dtTrt ) ) ) )                                 + '_' +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( hh, @dtTrt ) ) ) ) )  )    +
                          LTRIM ( RTRIM ( STR ( DATEPART ( hh, @dtTrt ) ) ) )                                   +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( mi, @dtTrt ) ) ) ) )  )    + 
                          LTRIM ( RTRIM ( STR ( DATEPART ( mi, @dtTrt ) ) ) )                                   +
                          REPLICATE ( '0', 2- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( ss, @dtTrt ) ) ) ) )  )    +
                          LTRIM ( RTRIM ( STR ( DATEPART ( ss, @dtTrt ) ) ) )                                   +
                          REPLICATE ( '0', 3- LEN ( LTRIM ( RTRIM ( STR ( DATEPART ( ms, @dtTrt ) ) ) ) )  )    +
                          LTRIM ( RTRIM ( STR ( DATEPART ( ms, @dtTrt ) ) ) )
/*------------------------------------------------------------------*/
/* On arme le nom du fichier qui va être généré.                    */
/*------------------------------------------------------------------*/
SET @sDossierRegles     = @sRepExport + '\' + 'DOSSIER_REGLES_'  + @sdtTrt + '.XLS'
SET @sNomServeur        = @@SERVERNAME
/*------------------------------------------------------------------*/
/* On arme la chaine qui va représenter le SELECT à lancer.         */
/*------------------------------------------------------------------*/
-- ITSM205975, changement de 0 en D, car on génère après GENVIR à présent à 08h00, et non plus la veille à 23h00

SET @sSelectRegles = 'SELECT  CONVERT ( CHAR(10), w.cree_le, 103 ) AS ''Créé Le'', w.id_sin AS ''Réf.Sin'', w.id_prod AS ''Produit'', p.lib_court AS ''Libellé'', w.id_ets AS ''Ets'', '
SET @sSelectRegles = @sSelectRegles + 'w.id_adh AS ''Adhésion'', wi.nom AS ''Nom'', w.mt_vir AS ''Mt.Vir'', d.num_facture as ''Num.Fact'', CONVERT ( CHAR(10), d.dte_livr, 103 ) as ''Date Factu.'', '
SET @sSelectRegles = @sSelectRegles + '(select top 1 valide_par from SIMPA2_PRO.sysadm.reglement r WHERE w.cod_mode_reg = ''FM'' and r.id_sin=w.id_sin order by cree_le desc) as ''Dernier_valideur_factu'' '
SET @sSelectRegles = @sSelectRegles + 'FROM SIMPA2_PRO.sysadm.w_a_virer AS w '
SET @sSelectRegles = @sSelectRegles + 'LEFT OUTER JOIN SIMPA2_PRO.sysadm.inter AS wi ON w.id_sin = wi.id_sin AND w.id_i = wi.id_i AND w.cod_inter = wi.cod_inter '
SET @sSelectRegles = @sSelectRegles + 'LEFT OUTER JOIN SIMPA2_PRO.sysadm.produit AS p on w.id_prod = p.id_prod '
SET @sSelectRegles = @sSelectRegles + 'LEFT OUTER JOIN SIMPA2_PRO.sysadm.detail AS d ON w.id_sin = d.id_sin AND w.id_reg = d.id_reg AND w.id_i = d.id_i_reg '
SET @sSelectRegles = @sSelectRegles + 'WHERE w.cod_mode_reg = ''FM'' AND w.cod_pos = ''D'' '
SET @sSelectRegles = @sSelectRegles + 'ORDER BY w.cree_le, w.id_prod, w.id_sin '
print @sSelectRegles
/*------------------------------------------------------------------*/
/* On va maintenant générer le fichier.                             */
/*------------------------------------------------------------------*/
/* REGLES.                                                          */
/*------------------------------------------------------------------*/
SET @sCmd = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + @sSelectRegles + '" /o' + @sDossierRegles + ' -w5000 -u -s"       " -t60'
EXEC master.dbo.xp_cmdshell @sCmd, no_output
/*------------------------------------------------------------------*/
/* On va vérifier si le fichier de sortie existe. Si ce n'est pas   */
/* le cas, on arrête le traitement.                                 */
/*------------------------------------------------------------------*/
DELETE FROM #TblFileExistsExport

INSERT INTO #TblFileExistsExport
EXEC master.dbo.xp_fileexist @sDossierRegles

IF      ( SELECT FileExists FROM #TblFileExistsExport ) <> 1
        BEGIN
                EXEC ('Drop table #TblFileExistsExport' )
                SET @asRetour = 'Impossible de générer le fichier ' + @sDossierRegles + '.'
                RETURN -1
        END
/*------------------------------------------------------------------*/
/* On va maintenant procéder à l'envoi du mail qui contiendra le    */
/* fichier qui vient d'être généré.                                 */
/*------------------------------------------------------------------*/
SET @sFichiersRattaches = LTRIM ( RTRIM ( @sDossierRegles ) )

SET @sObjetFacturation  = 'Liste des dossiers pour contrôle par la cellule facturation'
SET @sTextFacturation   = 'Ci-joint le fichier' + CHAR(10) + CHAR(10)
SET @sTextFacturation   = @sTextFacturation + 'Heure de lancement du traitement ' + RIGHT ( @sdtTrt, 9 ) + CHAR(10) + CHAR(10)
SET @sTo                = 'groupefacturation@spb.fr'
SET @sCc                = ''
/*------------------------------------------------------------------*/
/* Envoi du mail.                                                   */
/*------------------------------------------------------------------*/
EXEC @iRet = master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sTo, @sTextFacturation, @sObjetFacturation, 'FACTURATION SIMPA2@SPB.FR', @sCc, @sFichiersRattaches
IF      @iRet <> 1
        BEGIN
                SET @asRetour = 'L''envoi du mail est impossible.'
                RETURN -1
        END
RETURN 1

GO

grant execute on sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_SUPP_REGL_W_A_VIRER
-- Auteur               :       FABRY JF
-- Date                 :       07/10/13
-- Libelle              :        
-- Commentaires         :       [DT044-1_V5]
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SUPP_REGL_W_A_VIRER' AND type = 'P' )
        DROP procedure sysadm.PS_SUPP_REGL_W_A_VIRER
GO


CREATE  PROC sysadm.PS_SUPP_REGL_W_A_VIRER
	@dcIdSin	Decimal ( 10 ) -- [PI062]
AS

If 	( Select COUNT(*)
	From   sysadm.w_a_virer wav,
		   sysadm.detail d,
		   sysadm.div_det dd
	Where  wav.id_sin = @dcIdSin
	And    wav.cod_inter = 'F'
	And    wav.cod_mode_reg = 'FM'
	And    d.id_sin = wav.id_sin
	And    d.id_reg = wav.id_reg
	And    dd.id_sin = d.id_sin
	And    dd.id_gti = d.id_gti
	And    dd.id_detail = d.id_detail
	And    dd.nom_zone = 'pas_de_rglt_fourn'
	And    dd.val_car = 'O' ) = 1
	
 Begin
	Delete sysadm.w_a_virer
	From   sysadm.w_a_virer wav,
		   sysadm.detail d,
		   sysadm.div_det dd
	Where  wav.id_sin = @dcIdSin
	And    cod_inter = 'F'
	And    cod_mode_reg = 'FM'
	And    d.id_sin = wav.id_sin
	And    d.id_reg = wav.id_reg
	And    dd.id_sin = d.id_sin
	And    dd.id_gti = d.id_gti
	And    dd.id_detail = d.id_detail
	And    dd.nom_zone = 'pas_de_rglt_fourn'
	And    dd.val_car = 'O' 
 End 	
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA
-- Auteur               :       FPI
-- Date                 :       19/02/2015
-- Libelle              :        Réécriture de PS_ENVOI_MAIL_GROUPE_FACTURATION
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 02/03/2016 - [VDOC20151] ajout du mode chèque pour obtenir les RM LBE
-- FPI - 14/04/2016 - [VDOC20575] ajout du code fournisseur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA' AND type = 'P' )
        DROP procedure sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA
GO

CREATE procedure sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED -- FPI - 28/09/2016
	SET NOCOUNT ON

	Declare @dtDeb datetime,
		@dtFin datetime
		
	Set @dtFin=CONVERT(datetime,convert(varchar(10),getdate(),103),103)
	set @dtDeb=DATEADD(day,-1,@dtFin)
	
    SELECT  CONVERT ( CHAR(10), w.cree_le, 103 ) AS 'Créé Le', 
		w.id_sin AS 'Réf.Sin',
		(select top 1 id_seq 
		 from sysadm.commande c 
		 where c.id_sin=w.id_sin 
			and c.id_gti=d.id_gti 
			and c.id_detail=d.id_detail
			order by id_seq) as 'N° commande',
		w.id_reg as 'N° reglt',
		w.id_prod AS 'Produit', 
		p.lib_court AS 'Libellé', 
		sysadm.FN_LIB_CIE(w.id_sin) as 'Compagnie',
		sysadm.FN_LIB_POLICE(w.id_sin) as 'Police',
		w.id_ets AS 'Ets', 
		w.id_adh AS 'Adhésion', 
		wi.nom AS 'Nom', 
		w.mt_vir AS 'Mt.Vir', 
		Case When r.cod_mot_reg in ('RM','RP') Then '' Else d.num_facture End as 'Num.Fact', 
		Case When r.cod_mot_reg in ('RM','RP') Then '' Else CONVERT ( CHAR(10), d.dte_livr, 103 ) End as 'Date Factu.', 
		r.lib_reg as 'Libellé règlement',
		r.cod_mot_reg as 'Motif règlement',
		(select top 1 valide_par 
		 from sysadm.reglement r 
		 WHERE w.cod_mode_reg = 'FM' 
			and r.id_sin=w.id_sin 
		 order by cree_le desc) as 'Dernier_valideur_factu',
		 'Réél' as 'Type de règlement',
		 sysadm.FN_CODE_CAR(wi.id_four,'-FR') as 'Fournisseur'
	FROM sysadm.w_a_virer w 
		INNER JOIN sysadm.inter wi ON w.id_sin = wi.id_sin AND w.id_i = wi.id_i
		INNER JOIN sysadm.produit AS p on w.id_prod = p.id_prod 
		INNER JOIN sysadm.reglement r on r.id_sin= w.id_sin AND r.id_reg= w.id_reg 
		INNER JOIN sysadm.detail AS d ON w.id_sin = d.id_sin AND (d.id_reg = r.id_reg or d.id_reg=r.id_reg_base)
	WHERE w.cod_mode_reg = 'FM' AND w.cod_pos = 'D' 
	-- [VDoc16720] ajout des règlements LBE
	UNION
	Select CONVERT ( CHAR(10), r.cree_le,103 ) AS 'Créé Le', 
		r.id_sin AS 'Réf.Sin', 
		(select top 1 id_seq 
		 from sysadm.commande c 
		 where c.id_sin=r.id_sin 
			and c.id_gti=d.id_gti 
			and c.id_detail=d.id_detail
			order by id_seq) as 'N° commande',
		r.id_reg as 'N° reglt',
		s.id_prod AS 'Produit', 
		p.lib_court AS 'Libellé', 
		sysadm.FN_LIB_CIE(r.id_sin) as 'Compagnie',
		sysadm.FN_LIB_POLICE(r.id_sin) as 'Police',
		s.id_ets AS 'Ets', 
		s.id_adh AS 'Adhésion', 
		i.nom AS 'Nom', 
		r.mt_tot_reg 'Mt.Vir', 
		Case When r.cod_mot_reg in ('RM','RP') Then '' Else d.num_facture End as 'Num.Fact', 
		Case When r.cod_mot_reg in ('RM','RP') Then '' Else CONVERT ( CHAR(10), d.dte_livr, 103 ) End as 'Date Factu.', 
		r.lib_reg as 'Libellé règlement',
		r.cod_mot_reg as 'Motif règlement',
		r.valide_par as 'Dernier_valideur_factu',
		'Banque EDEL' as 'Type de règlement',
		 sysadm.FN_CODE_CAR(i.id_four,'-FR') as 'Fournisseur'
	from   sysadm.reglement r
		INNER JOIN sysadm.inter i on i.id_sin = r.id_sin and i.id_i = r.id_i
		inner join sysadm.detail d on d.id_sin=r.id_sin  and
			(d.id_reg=r.id_reg or d.id_reg=r.id_reg_base)
		inner join sysadm.sinistre s on s.id_sin=r.id_sin
		INNER JOIN sysadm.produit p on p.id_prod = s.id_prod 
	Where  r.cree_le between @dtDeb and @dtFin
		And    r.cod_mode_reg in ('FM','C') -- [VDOC20151]
		and    i.id_four = 'LBE'
	ORDER BY 'Créé Le','Produit', 'Réf.Sin'
Go

grant execute on sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_ENVOI_MAIL_GROUPE_FACTURATION_V01
-- Auteur               :       FPI
-- Date                 :       19/02/2015
-- Libelle              :        Réécriture de PS_ENVOI_MAIL_GROUPE_FACTURATION
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAIL_GROUPE_FACTURATION_V01' AND type = 'P' )
        DROP procedure sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_V01
GO

CREATE  PROC sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_V01
AS

/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications Paramêtre                                                                                                       */
/* @asRetour            = Valeur de retour suite au traitement                                                                  */
/*------------------------------------------------------------------------------------------------------------------------------*/

DECLARE         
        @dtTrt                  DATETIME        ,
        @sdtTrt                 VARCHAR(25),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255),	
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
		@sOsqlOption VarChar(255),
		@iRetOsql	int,
		@iRet		int	    
        
SET @dtTrt              = GETDATE()
SET @sdtTrt             = REPLACE(CONVERT(CHAR(10), @dtTrt, 103), '/', '') 
						  + '_' 
						  + Replace(CONVERT(varchar(20),@dtTrt,114),':','')

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Facturation\'
Set @sFileName	= 'DOSSIER_REGLES_' + @sdtTrt
Set @sFileExt	= 'xls'

SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		 DB_NAME(db_id()) + '.sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_DATA ' + 
		'" /o' + @sFicOut + ' -w5000' + @sOsqlOption

EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Set @sObjet   = 'Liste des dossiers pour contrôle par la cellule facturation'
Set @sMessage   = 'Ci-joint le fichier' + CHAR(10) + CHAR(10)
SET @sMessage   = @sMessage + 'Heure de lancement du traitement ' + RIGHT ( @sdtTrt, 9 ) + CHAR(10) + CHAR(10)

/*------------------------------------------------------------------*/
/* Envoi du mail.                                                   */
/*------------------------------------------------------------------*/
EXEC @iRet=master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'facturation@spb.eu', 
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
		

  RETURN 1

GO

grant execute on sysadm.PS_ENVOI_MAIL_GROUPE_FACTURATION_V01 to rolebddsinistres
Go
