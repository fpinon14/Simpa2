-------------------------------------------------------------------
--
-- Fichier              :       paragrap.cp
-- Auteur               :       YP
-- Date                 :       28/08/97 10:55:37
--
-- Commentaires         :       Liste des procédures de la table PARAGRAPHE
--
-- Procédures           :       DD_S02_PARAGRAPHE
--                              DD_S03_PARAGRAPHE
--                              DD_S04_PARAGRAPHE
--				IM_S02_PARAGRAPHE
--				DW_S01_COMPO_PARA 	JFF, 11/03/2004, SVE
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :   DD_S04_PARAGRAPHE
-- Auteur               :   V.Capelle
-- Date                 :   24/11/1997 11:21:08
-- Libellé              :   Sélection des paragraphes de plafond. 
-- Commentaires         :   
-- Références           :   dddw_sp_para_plafond
-- Arguments            :   Aucun
-- Retourne             :   ResultSet
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S04_PARAGRAPHE' AND type = 'P' )
            DROP procedure sysadm.DD_S04_PARAGRAPHE
GO

CREATE PROC sysadm.DD_S04_PARAGRAPHE
AS
 SELECT  sysadm.paragraphe.id_para,
         sysadm.paragraphe.lib_para
   FROM  sysadm.paragraphe 
   WHERE paragraphe.id_para like 'NG%'
   OR    paragraphe.id_para like 'NH%'
   OR    paragraphe.id_para like 'NJ%'
   OR    paragraphe.id_para like 'NK%'
   OR    paragraphe.id_para like 'NL%'
   OR    paragraphe.id_para like 'NM%'
   OR    paragraphe.id_para like 'NN%'
   OR    paragraphe.id_para like 'NO%'
   OR    paragraphe.id_para like 'NP%'
   OR    paragraphe.id_para like 'NQ%'
GO

grant execute on sysadm.DD_S04_PARAGRAPHE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       DD_S02_PARAGRAPHE
-- Auteur               :       YP
-- Date                 :       28/08/97 10:55:52
-- Libellé              :       Sélection des paragraphes de pièce.
-- Commentaires         :
-- Références           :       dddw_sp_para_piece
--
-- Arguments            :       Aucun
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_PARAGRAPHE' AND type = 'P' )
            DROP procedure sysadm.DD_S02_PARAGRAPHE
GO

CREATE PROC sysadm.DD_S02_PARAGRAPHE
AS
-- JCA 15/01/2008 DCMP 70993 Ajout de paragraphe de type Bxxx (compteur de Pxxx plein)

 SELECT  para.id_para,
         para.lib_para
   FROM  sysadm.paragraphe para
   WHERE para.id_para like 'P%' or para.id_para like 'L%' or para.id_para like 'B%'

GO


--------------------------------------------------------------------
--
-- Procédure            :       DD_S03_PARAGRAPHE
-- Auteur               :       YP
-- Date                 :       28/08/97 10:55:52
-- Libellé              :       Sélection des paragraphes de refus.
-- Commentaires         :
-- Références           :       dddw_sp_para_refus
--
-- Arguments            :       Aucun
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------
-- #1  18/01/2005  PLJ  Gestion des nouveaux codes de refus en Sxxx
-- #2  14/04/2009  FPI  [DCMP90217] Gestion des nouveaux codes de refus en Sxxx
--	 05/02/2014		FPI [ITSM271361] Ajout de O
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S03_PARAGRAPHE' AND type = 'P' )
            DROP procedure sysadm.DD_S03_PARAGRAPHE
GO

CREATE PROC sysadm.DD_S03_PARAGRAPHE
AS
 SELECT  sysadm.paragraphe.id_para,
         sysadm.paragraphe.lib_para
   FROM  sysadm.paragraphe 
   WHERE paragraphe.id_para like 'O%' OR paragraphe.id_para like 'R%' OR paragraphe.id_para like 'S%' OR paragraphe.id_para like 'T%' OR paragraphe.id_para like 'U%' OR paragraphe.id_para like 'W%'

GO

grant execute on sysadm.DD_S03_PARAGRAPHE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :   IM_S02_PARAGRAPHE
-- Auteur               :   DBI
-- Date                 :   18/11/1998 11:21:08
-- Libellé              :   Retourne le numéro de version d'un paragraphe
-- Commentaires         :   
-- Références           :   
-- Arguments            :   asPara		Varchar (4)
--				    asVersion	Varchar (3) OUTPUT
-- Retourne             :   ResultSet
--                          
--------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	JFF	15/11/2006	[DNTMAIL1-2] Ajout du distinct pour retour UNE version qqsoit le canal
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S02_PARAGRAPHE' AND type = 'P' )
            DROP procedure sysadm.IM_S02_PARAGRAPHE
GO

CREATE PROC sysadm.IM_S02_PARAGRAPHE
	@asPara 	Varchar (4),
	@asVersion	Varchar (3) OUTPUT
AS
 SELECT  DISTINCT @asVersion = sysadm.paragraphe.cpt_ver
   FROM  sysadm.paragraphe 
   WHERE paragraphe.id_para = @asPara
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_COMPO_PARA
-- Auteur               :       Fabry JF
-- Date                 :       11/03/2004
-- Libell‚              :       Rappatriement des paragraphes pour la SVE
-- Commentaires         :       Si composition non existante on ramène un paragraphe
--				d'erreur
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMPO_PARA' And type = "P" )
DROP PROCEDURE sysadm.DW_S01_COMPO_PARA
GO

CREATE PROCEDURE sysadm.DW_S01_COMPO_PARA
 @sIdCour VarChar( 6 )
AS

Declare @iRet integer

SELECT @iRet = Count(*) FROM sysadm.composition WHERE id_cour = @sIdCour 

If @iRet > 0
 Begin

	SELECT  p.id_para,
	        p.lib_para,
	        p.cpt_ver,
	        p.maj_le,
	        p.maj_par,
	        c.id_ordre
	FROM 	sysadm.composition c
		INNER JOIN sysadm.paragraphe p ON c.id_para = p.id_para 
	WHERE 	c.id_cour = @sIdCour

 End

Else

   Begin  

	SELECT  p.id_para,
	        p.lib_para,
	        p.cpt_ver,
	        p.maj_le,
	        p.maj_par,
	        1
	FROM    sysadm.paragraphe p
        WHERE   p.id_para = 'NERR'
    
   End   
Go


--------------------------------------------------------------------
--
-- Procédure            :   PS_S_PARA_REELS_REP_COURRIER
-- Auteur               :   Fabry JF
-- Date                 :   26/12/2022
-- Libellé              :   Sélection des paragraphes et fichier rééls du rep COURRIER
-- Commentaires         :   
-- Références           :   
-- Arguments            :   
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PARA_REELS_REP_COURRIER' AND type = 'P' )
            DROP procedure sysadm.PS_S_PARA_REELS_REP_COURRIER
GO

CREATE PROC sysadm.PS_S_PARA_REELS_REP_COURRIER
AS


Select	rtrim ( p.id_para ) + '.' + rtrim ( p.cpt_ver) 'NOM_FIC',
		rtrim ( p.cpt_ver ) 'EXT',
		''
From sysadm.paragraphe p with (nolock) 
Union all
Select	rtrim ( c.lib_code ) , 
		RIGHT ( rtrim ( c.lib_code) , 3 ), 
		''
From sysadm.code c with (nolock) 
where c.id_typ_code = '-W8'
and id_code > 0
Order by 2 desc

Go

--------------------------------------------------------------------
--
-- Procédure            :   PS_S_PARA_REELS_REP_COUR_JUSTE_LES_MANQUANTS
-- Auteur               :   Fabry JF
-- Date                 :   16/01/2023
-- Libellé              :   Sélection des paragraphes et fichier rééls du rep COURRIER
-- Commentaires         :   
-- Références           :   
-- Arguments            :   
-- Retourne             :   PS_S_PARA_REELS_REP_COUR_JUSTE_LES_MANQUANTS
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PARA_REELS_REP_COUR_JUSTE_LES_MANQUANTS' AND type = 'P' )
            DROP procedure sysadm.PS_S_PARA_REELS_REP_COUR_JUSTE_LES_MANQUANTS
GO

CREATE PROC sysadm.PS_S_PARA_REELS_REP_COUR_JUSTE_LES_MANQUANTS
	@asRepCourDest VarChar ( 200 )
AS

	Declare @sDIR Varchar ( 100 )
	Declare @TbRepCour Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED ) 
	Declare @TbLstFicBase Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED, ext varchar (3), autre varchar ( 10) ) 
	Set @sDIR = 'DIR "' + @asRepCourDest + '*.*" /b'

	-- @TbRepCour se charge avec la liste des fichiers du répertoire
	Insert into @TbRepCour EXEC master.dbo.xp_cmdshell @sDIR 
	Delete @TbRepCour where nom_fic is null
	Update @TbRepCour Set nom_fic = Upper ( nom_fic )

	-- @@TbLstFicBase se charge avec la liste des fichiers de la base
	Insert into @TbLstFicBase EXEC sysadm.PS_S_PARA_REELS_REP_COURRIER
	Update @TbLstFicBase Set nom_fic = Upper ( nom_fic )

	-- Retour des fichier manquant uniquement
	Select  Tl.nom_fic,
			Tl.ext,
			''
	From @TbLstFicBase Tl
	Where Not exists ( 
			Select Top 1 1 
			From @TbRepCour Tr
			Where Tr.nom_fic = Tl.nom_fic
		)

Go

