-------------------------------------------------------------------
--
-- Fichier              :       CPDIVERS.CP
-- Auteur               :       Fabry JF
-- Date                 :       03/02/2004
--
-- Commentaires         :       PS Diverses n'étant pas rattachées à une table en particuliers
--
-- Proc‚dures           :      
-- [sysadm].[PS_S01_RECH_ECART]
-- sysadm.DW_S01_FACT_DANGAARD
-- sysadm.PS_CORRECTION_BASE_NUIT_1
-- sysadm.PS_CORRECTION_BASE_NUIT_2
-- sysadm.PS_CORRECTION_BASE_TEMPS_1
-- sysadm.PS_CORRECTION_BASE_TEMPS_2
-- sysadm.PS_CORRECTION_BASE_TEMPS_3
-- sysadm.PS_CORRECTION_BASE_TEMPS_4
-- sysadm.PS_CPS
-- sysadm.PS_D01_ERR_BAC
-- sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION
-- sysadm.PS_KILL_TOUTE_CNX_BASE_SIMPA2
-- sysadm.PS_LANCEUR_JOBS_SQL
-- sysadm.PS_PRESENCE_WSIN
-- sysadm.PS_REDRESS_RN_NON_ATTACHE_DETAIL
-- sysadm.PS_REDRESSEMENT_VDOC15650
-- sysadm.PS_REDRESSEMENT_VDOC15650_2
-- sysadm.PS_S_ADRESSE_CENTRALE_PSM
-- sysadm.PS_S_ADRESSE_PSM_PM234
-- sysadm.PS_S_CONSULT_RESTREINTE
-- sysadm.PS_S_CONTROLE_DISKIO_CPUTIME
-- sysadm.PS_S_CONTROLE_DISKIO_CPUTIME_MAIL
-- sysadm.PS_S_CONTROLE_VERSION_CLUSTER
-- sysadm.PS_S_CPT_SIN_RESTANT
-- sysadm.PS_S_DETECT_ERREUR_WS
-- sysadm.PS_S_DETECT_SQL_QUOT_BASE_SIM
-- sysadm.PS_S_DETECT_VERSION_BASE_SIM
-- sysadm.PS_S_ID_CIE
-- sysadm.PS_S_LIB_CIE
-- sysadm.PS_S_MARQUE_TEL
-- sysadm.PS_S_MODELE_TEL
-- sysadm.PS_S_NBRE_SIN_SANDRINE
-- sysadm.PS_S_RECUP_ADRESSE_FRN
-- sysadm.PS_S_RETURN_TRANCOUNT
-- sysadm.PS_S_VERIF_REV_SVN
-- sysadm.PS_S01_ADRESSE_O2M_V01
-- sysadm.PS_S01_CORRECTION_IMEI
-- sysadm.PS_S01_MAIL
-- sysadm.PS_S01_VERIF_ANNUL_VIR
-- sysadm.PS_T_REDRESS_FRAIS_ABSENT
-- sysadm.PS_U_PM364_DORMANT_AUTO
-- sysadm.PS_U_REDRESS_DET600_GTI100
-- sysadm.PS_U01_CORRECTION_W_DIV_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
---- Proc‚dure            :       PS_S01_RECH_ECART
-- Auteur               :       Fabry JF
-- Date                 :       03/02/2004
-- Libell‚              :
-- Commentaires         :       Recherche d'écart et alerte par mail.
-- R‚f‚rences           :
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECH_ECART' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECH_ECART
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    DECLARE @iCpt DECIMAL(11, 2)
    DECLARE @sBody VARCHAR(200)
    DECLARE @sObjet VARCHAR(200)
    DECLARE @sRetourErr VARCHAR(255)
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[PS_S01_RECH_ECART]
AS 
    DECLARE @iCpt DECIMAL(11, 2)
    DECLARE @sBody VARCHAR(200)
    DECLARE @sObjet VARCHAR(200)

    DECLARE @sRetourErr VARCHAR(255)
	Declare @tb TABLE (id_sin decimal(10,0),  -- [PI062]
		id_reg int)
		
-------------------------------------------------------------------------------
-- Recherche des enregistrements présents dans reglement et absent de reg_gti -
-------------------------------------------------------------------------------
	Set @sBody=''
	
	Insert into @tb
	SELECT  id_sin, id_reg
    FROM    sysadm.reglement r
    WHERE   NOT EXISTS ( SELECT *
                         FROM   sysadm.reg_gti rg
                         WHERE  rg.id_sin = r.id_sin
                                AND rg.id_reg = r.id_reg )
            AND r.id_sin >= 300000
            AND r.dte_reg > DATEADD(month, -2, GETDATE())
            AND r.cod_mot_reg <> 'RI'


    SET @iCpt = (select COUNT(*) from @tb)
    
    If @iCpt > 0
    Begin
		-- Correction
		SET @sBody = 'Presence de ' + CONVERT (VARCHAR(20), @iCpt)
        + ' enregistrement(s) dans reglement et absent(s) de reg_gti' + CHAR(10)
		SET @sObjet = 'SIMPA2_PRO : ' + CONVERT (VARCHAR(20), @iCpt)
        + ' Enregistrement(s) absent(s) de reg_gti' + CHAR(10) + CHAR(10)
        
		Insert into sysadm.reg_gti
		Select  r.id_sin,
				r.id_reg,
				d.id_gti,
				d.id_gti,
				r.id_i,
				r.mt_tot_reg,
				r.mt_tot_reg,
				r.cree_le,
				r.maj_le,
				r.maj_par
		From    @tb t
				inner join sysadm.reglement r on r.id_sin=t.id_sin and r.id_reg=t.id_reg
				inner join sysadm.detail d on d.id_sin = r.id_sin and  d.id_reg = r.id_reg
	End

-------------------------------------------------------------------------------
-- Recherche des écarts de montants entre Réglement et Reg_Gti		      -
-------------------------------------------------------------------------------
    SET @iCpt = 0

    SELECT  @iCpt = SUM(Groupement.Diff)
    FROM    ( SELECT    SUM(ISNULL(rg.mt_reg, 0)) - r.mt_tot_reg Diff
              FROM      sysadm.reglement r
                        JOIN sysadm.sinistre s ON s.id_sin = r.id_sin
                        LEFT OUTER JOIN sysadm.reg_gti rg ON ( r.id_sin = rg.id_sin
                                                               AND r.id_reg = rg.id_reg
                                                             )
              WHERE     r.dte_reg > DATEADD(month, -2, GETDATE())
                        AND r.cod_mot_reg NOT IN ( 'RI' )
              GROUP BY  s.id_sin,
                        s.id_prod,
                        s.id_ets,
                        r.id_reg,
                        r.cod_mot_reg,
                        r.mt_tot_reg,
                        r.dte_reg
            ) Groupement


    IF @iCpt <> 0 
        BEGIN
         SET @sBody = @sBody + Char(10) + 
			'Ecart de ' + CONVERT (VARCHAR(20), @iCpt)
			+ ' Euros détecté entre reglement et reg_gti malgré l''ajout de reg_gti manquant(s).'
		 SET @sObjet = 'SIMPA2_PRO : Ecart de ' + CONVERT (VARCHAR(20), @iCpt)
   
		 EXEC master.dbo.SPB_PS_MAIL @sRetourErr OUTPUT, 'jff@spb.fr',
                @sBody, @sObjet, '', NULL, NULL, NULL, NULL, NULL, NULL      
        END

/* SQL pour Trouver le ou les sinistres concernés à la main
    SELECT  id_sin,id_reg,Diff
    FROM    ( SELECT    s.id_sin,
						r.id_reg,
						SUM(ISNULL(rg.mt_reg, 0)) - r.mt_tot_reg Diff
              FROM      sysadm.reglement r
                        JOIN sysadm.sinistre s ON s.id_sin = r.id_sin
                        LEFT OUTER JOIN sysadm.reg_gti rg ON ( r.id_sin = rg.id_sin
                                                               AND r.id_reg = rg.id_reg
                                                             )
              WHERE     r.dte_reg > DATEADD(month, -2, GETDATE())
                        AND r.cod_mot_reg NOT IN ( 'RI' )
              GROUP BY  s.id_sin,
                        s.id_prod,
                        s.id_ets,
                        r.id_reg,
                        r.cod_mot_reg,
                        r.mt_tot_reg,
                        r.dte_reg
            ) Groupement
	Where Diff > 0 
*/

	Exec sysadm.PS_S_CONTROLE_VERSION_CLUSTER

GO

grant execute on sysadm.PS_S01_RECH_ECART to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D01_ERR_BAC
-- Auteur               :       Fabry JF
-- Date                 :       03/02/2004
-- Libell‚              :       ERReur Boite à ArChive
-- Commentaires         :       A lancer dans pour supprimer totalement un dossier en cours sur w_sin
--
-- R‚f‚rences           :
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_ERR_BAC' AND type = 'P' )
        DROP procedure sysadm.PS_D01_ERR_BAC
GO

CREATE procedure sysadm.PS_D01_ERR_BAC
	@dcIdSin        Decimal (  10,0 )  -- [PI062]
AS

If ( Select Count (*)
     From sysadm.sinistre
     Where id_sin = @dcIdSin ) > 0
 Begin
	Delete From sysadm.w_reg_gti
	Where id_sin = @dcIdSin

	Delete From sysadm.w_commande
	Where id_sin = @dcIdSin

	Delete From sysadm.w_detail
	Where id_sin = @dcIdSin

	Delete From sysadm.w_refus
	Where id_sin = @dcIdSin

	Delete From sysadm.w_piece
	Where id_sin = @dcIdSin

	Delete From sysadm.w_para_plafond
	Where id_sin = @dcIdSin

	Delete From sysadm.w_gar_sin
	Where id_sin = @dcIdSin

	Delete From sysadm.w_para_info
	Where id_sin = @dcIdSin

	Delete From sysadm.w_inter_blob
	Where id_sin = @dcIdSin

	Delete From sysadm.w_frais
	Where id_sin = @dcIdSin

	Delete From sysadm.w_courrier
	Where id_sin = @dcIdSin

	Delete From sysadm.w_inter
	Where id_sin = @dcIdSin

	Delete From sysadm.w_sin
	Where id_sin = @dcIdSin

	Delete From sysadm.w_queue
	Where id_sin = Convert ( VarChar ( 10 ), @dcIdSin ) -- [PI062]

	Print ' Dossier ' + Convert ( VarChar ( 10 ), @dcIdSin ) + ' supprimé des tables temporaires'  -- [PI062]
 End
Else
 Begin
 	Print ' Impossible de supprimer le Dossier ' + Convert ( VarChar ( 10 ), @dcIdSin ) + ' il n''a jamais été validé'  -- [PI062]
 End

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_MAIL
-- Auteur               :       Abdmeziem Catherine
-- Date                 :       10/03/2004
-- Libell‚              :       Envoi d'un mail
-- Commentaires         :       Utilisation de SPB_PS_MAIL
--
-- R‚f‚rences           :
--
-- Arguments            :	@asTo           VarChar ( 2048 )	( Val )
--				@asTextBody     VarChar ( 8000 )	( Val )
--				@asSubject      VarChar (  255 )	( Val )
--				@asFrom         VarChar (  128 )	( Val )
--				@asCc           VarChar ( 2048 )	( Val )
--				@asFicAttach    VarChar ( 2048 )	( Val )
--				@asQuery        VarChar ( 8000 )	( Val )
--				@asFicQueryOut  VarChar (  255 )	( Val )
--				@aiTypeQuery    Integer			( Val )
--				@asNomBaseQuery VarChar			( Val )
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1 Le 30/11/2004 DGA : Modification de la procédure SPB_PS_MAIL. Paramêtre @asRetourErr
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_MAIL
GO

CREATE procedure sysadm.PS_S01_MAIL
        @asTo           VarChar ( 2048 ),
        @asTextBody     VarChar ( 8000 ),
        @asSubject      VarChar (  255 ),
        @asFrom         VarChar (  128 ),
        @asCc           VarChar ( 2048 ),
        @asFicAttach    VarChar ( 2048 ),
        @asQuery        VarChar ( 8000 ),
        @asFicQueryOut  VarChar (  255 ),
        @aiTypeQuery    Integer,
        @asNomBaseQuery VarChar
AS

DECLARE @sRetourErr     VARCHAR ( 255 )

	Exec master.dbo.SPB_PS_MAIL
        @sRetourErr     OUTPUT,
	@asTo,
	@asTextBody,
	@asSubject,
	@asFrom,
	@asCc,
	@asFicAttach,
	@asQuery,
	@asFicQueryOut,
	@aiTypeQuery,
	@asNomBaseQuery


GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_CORRECTION_W_DIV_SIN
-- Auteur               :       FABRY JF
-- Date                 :       29/07/2004
-- Libell‚              :       Corrige w_div_sin au niveau du cpt_valide concernant
--			 	un bug rare et donc difficile à détecter.
-- Commentaires         :
--
-- R‚f‚rences           :
--
-- Arguments            :
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_CORRECTION_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_U01_CORRECTION_W_DIV_SIN
GO

CREATE procedure sysadm.PS_U01_CORRECTION_W_DIV_SIN
AS

Update 	sysadm.w_div_sin
set   	cpt_valide = 1
From  	sysadm.w_div_sin wd
Where 	wd.cpt_valide = 0
And 	Exists (
		Select *
		From  sysadm.div_sin d
		where d.id_sin = wd.id_sin
		And   d.nom_zone = wd.nom_zone )

GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_FACT_DANGAARD
-- Auteur               :       PLJ
-- Date                 :       19/01/2005
-- Libelle              :       Récupération des informations pour enrichissement
--                              Fichier Excel Dangaard.
--
-- Commentaires         :       Traitement : W_Trt_Sp_Cmd_Dangaard
--
-- References           :       dw_Trt_Sp_Cmd_Fact_Dangaard
--
-- Arguments            :
--
--
-- Retourne             :       Rien
-- JFF      19/11/2013   [DT_60_AUGM_TVA]
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_FACT_DANGAARD' AND type = 'P' )
        DROP procedure sysadm.DW_S01_FACT_DANGAARD
GO

CREATE procedure sysadm.DW_S01_FACT_DANGAARD
@lIdSin    integer,
@lIdSeq    integer,
@dcMtHT    Decimal(11,2),
@dtDateCmd DateTime

AS
DECLARE  @lNbSin      integer,
	 @dcIdSin     Decimal (10), -- [PI062]
         @dcIdProd    Decimal (7), 
         @sMotif      varchar(50),
         @dtEnvCli    datetime,
         @lIdCmdFrn   integer,
         @sCodEtat    char(3),
         @lIdCli      integer,
         @dcMtTtcCmde decimal(11,2),
         @sFamOrange  varchar(3)

Set @dcIdSin = Convert ( Decimal (10), @lIdSin ) -- [PI062]

SET @dcIdProd     = 0
SET @sMotif      = ''
SET @dcMtTtcCmde = 0
SET @sFamOrange  = 'N'

/* Est-ce que le sinistre existe ? */
SELECT @lNbSin = count(*)
  FROM sysadm.sinistre
 WHERE id_sin = @dcIdSin

IF @lNbSin = 0
   BEGIN
      SET @sMotif = 'Sinistre inexistant'
      SET @dcIdSin = 0
      GOTO SORTIE_ERREUR
   END

/* Récupération du produit */

SELECT @dcIdProd = id_prod
  FROM sysadm.sinistre
 WHERE id_sin = @dcIdSin

/* S'agit-il d'un produit de la famille Orange ? */
/* Si oui présence d'une ligne dans det_pro 32   */
SELECT @lNbSin = count(*)
  FROM sysadm.det_pro
 WHERE id_prod        = @dcIdProd   AND
       id_typ_code_dp = '-DP'      AND
       id_code_dp     = 32

IF @lNbSin = 1
   BEGIN
      SET @sFamOrange = 'O'
   END
ELSE
   BEGIN
      SET @sFamOrange = 'N'
   END


IF @@RowCount <> 1

/* S'agit-il d'une commande 1 ou 2 ? */
IF @lIdSeq > 2
   BEGIN
      SET @sMotif = 'Il s''agit d''une commande ' + convert( varchar(2), @lIdSeq )
      GOTO SORTIE_ERREUR
   END

/* La commande existe-t-elle ?*/
SELECT @lNbSin = count(*)
  FROM sysadm.commande
 WHERE id_sin = @dcIdSin   AND
       id_seq = @lIdSeq

IF @lNbSin = 0
   BEGIN
      SET @sMotif = 'Commande inexistante'
      GOTO SORTIE_ERREUR
   END

/* Vérication de la validité de la commande */
SELECT @dtEnvCli    = dte_env_cli,
       @lIdCmdFrn   = id_cmd_frn,
       @sCodEtat    = cod_etat,
       @dcMtTtcCmde = mt_ttc_cmde
  FROM sysadm.commande
 WHERE id_sin = @dcIdSin   AND
       id_seq = @lIdSeq

IF @dtEnvCli is Null
   BEGIN
      SET @sMotif = 'Date envoi client non renseignée sur commande'
      GOTO SORTIE_ERREUR
   END

IF @lIdCmdFrn is Null
   BEGIN
      SET @sMotif = 'Identifiant fournisseur non renseigné sur commande'
      GOTO SORTIE_ERREUR
   END

IF @sCodEtat <> 'RPC' AND @sCodEtat <> 'ECL'
   BEGIN
      SET @sMotif = 'Etat de la commande invalide : ' + @sCodEtat
      GOTO SORTIE_ERREUR
   END

/* Pour les commandes 2, vérification que la commande 1 est en ANN ou RSP */
IF @lIdSeq = 2
   BEGIN
      SELECT @sCodEtat  = cod_etat
        FROM sysadm.commande
       WHERE id_sin = @dcIdSin   AND
             id_seq = 1

     IF @sCodEtat <> 'ANN' AND @sCodEtat <> 'RSP'
        BEGIN
           SET @sMotif = 'Etat de la commande (1) invalide : ' + @sCodEtat
           GOTO SORTIE_ERREUR
        END
   END


/* Vérification qu'il n'y a pas de contact de moins de trois semaines */
/*SET @dtDateCmd = DATEADD ( DAY, 21 , @dtDateCmd )                   */
 IF @@ServerName = master.dbo.SPB_FN_ServerName ('SIM')
    BEGIN
       SELECT @lIdCli = id_cli
         FROM SHERPA_SIM.sysadm.sinistre
        WHERE id_sin = Convert ( Integer, @dcIdSin ) and
              id_appli = 2
    END
 ELSE
    BEGIN
       SELECT @lIdCli = id_cli
         FROM SHERPA_PRO.sysadm.sinistre
        WHERE id_sin = Convert ( Integer, @dcIdSin ) and
              id_appli = 2
    END


IF @@RowCount <> 1
   BEGIN
      SET @sMotif = 'Sinistre non retrouvé dans Sherpa'
      GOTO SORTIE_ERREUR
   END

 IF @@ServerName = master.dbo.SPB_FN_ServerName ('SIM')
    BEGIN
       SELECT @lNbSin = COUNT(*)
         FROM SHERPA_SIM.sysadm.contact
        WHERE id_cli = @lIdCli AND cree_le > @dtDateCmd
    END
 ELSE
    BEGIN
       SELECT @lNbSin = COUNT(*)
         FROM SHERPA_PRO.sysadm.contact
        WHERE id_cli = @lIdCli AND cree_le > @dtDateCmd
    END

IF @lNbSin > 0
   BEGIN
      SET @sMotif = convert( varchar(3), @lNbSin ) + ' contact'
      IF @lNbSin > 1
         BEGIN
            SET @sMotif = @sMotif + 's ont été créés depuis le '
         END
      ELSE
         BEGIN
            SET @sMotif = @sMotif + ' a été créé depuis le '
         END

      SET @sMotif = @sMotif + convert (varchar(10), @dtDateCmd, 103 )
      GOTO SORTIE_ERREUR
   END


SORTIE_OK:
   -- DT_60_AUGM_TVA 1.196
   SELECT 'OK', @dcIdSin, @dcIdProd, @dcMtHT * 1.2, @sMotif, @dcMtTtcCmde, @sFamOrange
   RETURN 0

SORTIE_ERREUR:
   -- DT_60_AUGM_TVA 1.196
   SELECT 'NON', @dcIdSin, @dcIdProd, @dcMtHT * 1.2, @sMotif, @dcMtTtcCmde, @sFamOrange
   RETURN 0

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_VERIF_ANNUL_VIR
-- Auteur               :       JFF&PHG
-- Date                 :       11/06/2006
-- Libell‚              :       Vérifie si une annule de virement peut etre effectuée
-- Commentaires         :       
-- R‚f‚rences           :
--
-- Arguments            :	adcIdsin     N° de sinistre
--				dcVerifIdReg N° de Virement
--
-- Retourne             :       Un jeu de resultset pour vérification
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VERIF_ANNUL_VIR' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VERIF_ANNUL_VIR
GO


CREATE procedure sysadm.PS_S01_VERIF_ANNUL_VIR
	@dcIdSin        Decimal (  10,0 ), -- [PI062]
	@dcVerifIdReg 	Decimal(2)

AS
declare @iDay		integer
declare @dtDateReg	datetime
declare @dtDateLimite	datetime
Declare @dcMaxIdReg 	Decimal(2)
Declare	@dcIdGti	Decimal (7)
declare @iOkToCheck	integer -- 1 Ok pour verifier, -1 on arrete tout

set 	@iOkToCheck = 1

-- Vérification
SELECT	sinistre.id_sin,
	i.nom,
	sinistre.mt_reg 'Mt_reg_total_sinistre',
	w_a_virer.mt_vir 'Reg_a_annuler'
  FROM	sinistre,inter i,w_a_virer
 WHERE  i.id_i= w_a_virer.id_i	AND
	i.id_sin = sinistre.id_sin AND
	w_a_virer.id_sin = sinistre.id_sin AND
	sinistre.id_sin = @dcIdSin 

print '*** Controle des date d''execution et de la cohérence des paramètres *********'
print '*** Date du Jour : '+ cast (GetDate() as varchar(30))

--Test permettant de savoir s'il existe un ID_REG supérieur à l'ID_REG fournit dans la DMDI, Si c'est la cas alors
--Ne pas annuler le virement et demander à la gestion de passer une régul moins (RM)
IF @iOkToCheck = 1
begin
	select @dcMaxIdReg = Max (id_reg)
	From reglement
	where 	id_sin = @dcIdSin
	
	If @dcVerifIdReg = @dcMaxIdReg
	   begin
	    set @iOkToCheck = 1
	   End
	Else
	   begin
	    set @iOkToCheck = -1
	    PRINT '**** !!!!!! Un autre reglement a été passé avant l''execution de cette annulation de reglment !!!!!! *****'
	    PRINT '**** ATTENTION : ne pas Annuler ce virement, demander à la gestion de passer une régul moins (RM)****'
	   End
End

-- Test pour savoir si annul reg ea cheval sur traitement mensuel.
IF @iOkToCheck = 1
begin
	set @iDay = datepart(day, getdate())
	
	select 	@dtDateReg = dte_reg
	from 	reglement
	where 	id_sin = @dcIdSin
	and 	id_reg = @dcVerifIdReg
	
	if @iDay between 26 and 31
	begin
		select @dtDateLimite = cast( ('25/' + 
					cast ( datepart ( mm, getdate() ) as varchar(2))+
					'/'+ 
					cast ( datepart ( yyyy, getdate()) as varchar (4))+
					' 23:59:59' ) 
					as datetime )
	-- On ne continue pas si Date de reglement <= 25/xx 23:59 < DAte du Jour
		if Not ( @dtDateReg <= @dtDateLimite) and (@dtDateLimite < GetDate())
		begin
			set @iOkToCheck = 1
		end
		else
		begin
			set @iOkToCheck = -1
			print '**** ATTENTION : Réglement passé sur une période mensuelle antérieure ****'
			print '**** La date d''aujourd''hui est postérieure à la date du règlement ****'
			print 'dte_reg = '+ convert ( Varchar (30), @dtDateReg , 103 )
			print 'Voir avec la gestion : demander de passer une RM'
		end
	end
End

--Test permettant en fonction de l'ID_GTI (s'il est < 0) de déterminer qu'il s'agit d'une annulation de frais
IF @iOkToCheck = 1
begin

	select 	@dcIdGti = id_gti
	from 	reg_gti
	where 	id_sin = @dcIdSin
	and 	id_reg = @dcVerifIdReg
	
	If not (@dcIdGti < 0 )
	   begin 
	    set @iOkToCheck = 1
	   End		
	Else
	   begin
	    set @iOkToCheck = 0 -- Modif PHG : 0 Indique que c'est Ok mais qu'il faut faire attention : annulation de frais a faire.
	    PRINT '**** ATTENTION : Il s''agit d''une annulation de frais, Veuillez utiliser la procédure d''annulation de frais sur interlocuteur ****'
	    PRINT '****					****'
	    PRINT "Spécifier l'ID_GTI à -1 ( @dcIdGti )"
	    PRINT "Spécifier le COD_ETAT à l'identique de celui du dossier ( @dcEtatSin )"
	    PRINT '****					****'
	   End
end

if @iOkToCheck >= 0
begin
	print '*** dte-reg = ' + cast (@dtDateReg as varchar(25) )+' : Date d''execution et paramètres valides.. Select de Vérification lancé.'
	print ''
	print '************ Gar_sin ***********'
	SELECT  * FROM gar_sin where id_sin = @dcIdSin 
	
	print '************ w_Gar_sin ***********'
	SELECT  * FROM w_gar_sin where id_sin = @dcIdSin 
	
	print '************ detail ***********'
	SELECT  * FROM detail where id_sin = @dcIdSin 
	
	print '************ w_detail ***********'
	SELECT  * FROM w_detail where id_sin = @dcIdSin 
	
	print '************ frais ***********'
	SELECT  * FROM frais where id_sin = @dcIdSin 
	
	print '************ w_frais ***********'
	SELECT  * FROM w_frais where id_sin = @dcIdSin 
	
	print '************ W_a_virer ***********'
	SELECT	* FROM w_a_virer where id_sin = @dcIdSin 
	
	print '************ w_Reg_gti ***********'
	SELECT	* FROM w_reg_gti where id_sin = @dcIdSin 
	
	print '************ Reg_gti ***********'
	SELECT	* FROM reg_gti where id_sin = @dcIdSin 
	
	print '************ RŠglement ***********'
	SELECT	* FROM reglement where id_sin = @dcIdSin 
	
	print '************ Inter ***********'
	SELECT	* FROM inter where id_sin = @dcIdSin 
	
	print '************ w_Inter ***********'
	SELECT	* FROM w_inter where id_sin = @dcIdSin 
	
	print '************ w_cour_blob ***********'
	SELECT	* FROM w_cour_blob where id_sin = @dcIdSin 
	
	print '************ w_cour_blob_arch ***********'
	SELECT	* FROM w_cour_blob_arch where id_sin = @dcIdSin 
	
	print '************ Archive ***********'
	SELECT	* FROM archive where id_sin = @dcIdSin 
	
	print '************ Archive_Blob ***********'
	SELECT	* FROM archive_blob where id_sin = @dcIdSin 
end

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_CORRECTION_IMEI
-- Auteur               :       FABRY JF
-- Date                 :       23/01/2007
-- Libelle              :       Correction d'imei
-- Commentaires         :       Renvoi l'imei corrigé, et complèté si besoin
-- References           :       
--
--				Exec sysadm.PS_S01_CORRECTION_IMEI 
--
-- Arguments            :       @sRacine	VarChar ( 15 ) OutPut   -- premiers chiffres (éventuellement)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CORRECTION_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CORRECTION_IMEI
GO

CREATE procedure sysadm.PS_S01_CORRECTION_IMEI
        @asRacine        VarChar ( 15 )   OUTPUT
AS

Declare @iFin integer
Declare @iCpt integer
Declare @iSom  integer
Declare @iCalc  integer
Declare @Coef integer
Declare @iIdCarte Decimal ( 7 )
Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
Declare @sCle VarChar ( 1 )    -- Cle calculée

Set @iFin = 0
Set @iCpt = 1
Set @iIdCarte = -1
Set @iSom = 0

select @CpltRacine = Convert ( varchar (24) , getdate (),14 ) + Convert ( varchar ( 24) , getdate (),14 ) 

WHILE ( @iCpt <= Len ( @CpltRacine ) )
BEGIN
   If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
     Begin
        Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
        Set @iCpt = 1
     End 
   Else
     Begin
        Set @iCpt = @iCpt + 1
     End 

End

Set @asRacine = Left ( @asRacine + @CpltRacine, 14 )

Set @iCpt = 1

While @iCpt <= 14
 Begin
   If ( @iCpt % 2 = 0 )
     Begin
        Set @iCalc = Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) ) * 2
        If  @iCalc >= 10 
          Begin
            Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
                         Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
          End
   
        Set @iSom = @iSom + @iCalc
     End
   Else
     Begin
        Set @iSom = @iSom + Convert ( integer, SubString ( @asRacine, @iCpt, 1 ) )
     End
   Set @iCpt = @iCpt + 1
 End 

If ( @iSom % 10 = 0 ) 
 Set @sCle = 0
Else
 Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )

Set @asRacine = @asRacine + @sCle

Select @asRacine

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_ADRESSE_O2M_V01
-- Auteur               :       Fabry JF
-- Date                 :       29/04/2010
-- Libelle              :       [VDoc14882][ADRESSE_O2M]
-- Commentaires         :       Renvoi la bonne adresse O2M en fonction du contexte.
-- References           :       !!!! voir pour toute modif n_cst_cmd_commun::uf_GetAdresseO2M !!!!
--
-- Arguments            :       
--
-- Retourne             :       
--
-- JFF	  15/06/2010    [PC419/440/418/439_MICROMANIA] demandé par Lisette et Eric Remy
-- JFF    12/11/2012    [VDOC9057]
-- FPI	  19/04/2013	[VDOC10610]
-- FPI	  14/06/2013	[VDOC11407] Modif adresse O2M
-- JFF	  24/07/2013    [MANTIS8246][PC938]
-- FPI	  11/07/2014	[VDoc14882] Appel de la V01
-- JFF    04/11/2014    [PM280-1]
-- JFF    18/11/2014    [VDOC15981]
-- JFF    06/05/2015    [PM280-1][MANTIS15144]
-- JFF    17/05/2016    [PM280-2]
-- JFF    12/02/2016    [PI062]
-- JFF    04/01/2019    [PM280-2] suite mail Emm. Olivier le 04/01/19, CONTEST_SUR_REMPL devient SPB 5 et non plus SPB5A
-- JFF    27/10/2021    [RS1218-RS1259-ADRO2M]
-- JFF    05/07/2022    [RS3337]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_ADRESSE_O2M_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S01_ADRESSE_O2M_V01
GO

CREATE procedure sysadm.PS_S01_ADRESSE_O2M_V01
   	@dcIdSin	Decimal ( 10 ), -- [PI062]
   	@asCas		VarChar ( 35 ),
	@asNomLigne1	VarChar ( 35 ) OUTPUT,
	@asNomLigne2	VarChar ( 35 ) OUTPUT,
	@asAdrLigne1	VarChar ( 35 ) OUTPUT,	
	@asAdrLigne2	VarChar ( 35 ) OUTPUT,		
	@asCP		VarChar ( 35 ) OUTPUT,
	@asVille	VarChar ( 35 ) OUTPUT				
AS

Declare @iRet	Integer
Declare @sTypApp VarChar ( 35 )
Declare @sLettreCatg VarChar ( 35 )

Set @iRet = -1
Set @asNomLigne1= '' 
Set @asNomLigne2= '' 
Set @asAdrLigne1= ''
Set @asAdrLigne2= ''
Set @asCP= ''
Set @asVille= ''

-- Adresse réélle, standard, complète
If @asCas = 'COMPLETE'
	Begin 

		-- [RS3337]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS3337') > 0 
			Begin
				Set @asNomLigne1 = 'LOXY'
				Set @asAdrLigne1 = '21-23 Rue Saint-Hilaire'
				Set @asAdrLigne2 = 'Saint-Ouen l''Aumône'
				Set @asCP = '95041'
				Set @asVille = 'CERGY-PONTOISE CEDEX 1'
			End 
		Else 
		  Begin
			-- [RS1218-RS1259-ADRO2M]
			Set @asNomLigne1 = 'O2M SPB'
			Set @asAdrLigne1 = '124, rue Salvador Allende'
			Set @asAdrLigne2 = ''
			Set @asCP = '95870'
			Set @asVille = 'BEZONS'
		  End 

		Return
	End 

-- Adresse par défaut

-- [RS3337]
If sysadm.FN_CLE_NUMERIQUE ( 'RS3337') > 0 
	Begin
		Set @asNomLigne1 = 'LOXY'
		Set @asAdrLigne1 = '21-23 Rue Saint-Hilaire'
		Set @asAdrLigne2 = 'Saint-Ouen l''Aumône'
		Set @asCP = '95041'
		Set @asVille = 'CERGY-PONTOISE CEDEX 1'
	End 
Else 
Begin
	-- [RS1218-RS1259-ADRO2M]
	Set @asAdrLigne1 = '124, rue Salvador Allende'
	Set @asCP = '95870'
	Set @asVille = 'BEZONS'
End 

-- [PM280-1]
Set @sTypApp = ''
Select @sTypApp = ds.val_car 
From sysadm.div_sin ds
Where ds.nom_zone = 'type_app'
And	  ds.id_sin = @dcIdSin

If @sTypApp is null Set @sTypApp = ''

If @asCas = 'GENERATION'
	Begin 
		-- SPB 1
		If 	(
			Select  Count(*)
			From 	sysadm.div_sin ds,
				sysadm.commande c
			Where   ds.id_sin = @dcIdSin
			And	ds.nom_zone = 'type_app'
			And	c.id_sin = ds.id_sin
			And 
				(
					( 
						ds.val_car = 'TEL'
						And	c.id_typ_art = 'EDI'
						And	c.cod_etat = 'ECT'
						And	c.id_ref_four = 'A_DIAGNOSTIQUER'  -- [VDOC9057]
					) 			
					Or 
					( c.id_typ_art = 'REA' )
				) 
			) > 0				
			Begin
				Set @asNomLigne1 = 'SPB 1'
			End 

		-- SPB 4	
		If 	@asNomLigne1= '' AND (
			Select  Count(*)
			From	sysadm.commande c
			Where   c.id_sin = @dcIdSin
			And	( c.id_ref_four = 'CONTEST_SUR_REMPL' ) -- [PM280-2]
			And	c.cod_etat = 'ECT'
			) > 0

			Begin
				Set @asNomLigne1 = 'SPB 5'
			End 

		-- SPB 5
		-- [PM280-1][MANTIS15144]	
		If 	@asNomLigne1= '' AND (
			Select  Count(*)
			From 	sysadm.w_commande c
			Where   c.id_sin = @dcIdSin
			And	c.id_typ_art = 'PRS' -- [VDOC9057]
			And	sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'OUI'
			And	c.cod_etat in ( 'CNV', 'ECT' )
			) > 0
	
			Begin
				Set @asNomLigne1 = 'SPB 5'
			End 

		If 	@asNomLigne1= '' AND (
			Select  Count(*)
			From	sysadm.commande c
			Where   c.id_sin = @dcIdSin
			And	c.id_typ_art = 'PRS'  -- [VDOC9057]
			And	c.cod_etat = 'ECT'
			and @sTypApp = 'TEL' 
			) > 0

			Begin
				Set @asNomLigne1 = 'SPB 4'
			End 


		-- SPB 8
		If 	@asNomLigne1= '' AND (
			Select  Count(*)
			From	sysadm.commande c
			Where   c.id_sin = @dcIdSin
			And	c.id_typ_art = 'PRS' -- [VDOC9057]
			And	c.cod_etat = 'ECT'
			and @sTypApp <> 'TEL' 
			) > 0

			Begin
				Set @asNomLigne1 = 'SPB 8'
			End 


			
		-- SPB 2
		If 	@asNomLigne1= '' AND (
			Select  Count(*)
			From 	sysadm.commande c
			Where   c.id_sin = @dcIdSin
			And	c.id_typ_art = 'EDI'
			And	c.cod_etat = 'ECT'
			-- [PC419/440/418/439_MICROMANIA] Ajout 15
			And	c.id_gti in ( 15, 18)
			And	c.id_ref_four = 'A_DIAGNOSTIQUER'-- [VDOC9057]
			) > 0

			Begin
				Set @asNomLigne1 = 'SPB 2'
			End 

		-- SPB 3
		If 	@asNomLigne1= '' Set @asNomLigne1 = 'SPB 3'
		
	End 

-- [PM280-1]
Set @sLettreCatg = ''
Select @sLettreCatg = sysadm.FN_CODE_CAR ( @sTypApp, '-AT' ) 
If @sLettreCatg is null Set @sLettreCatg = ''

-- SPB 1
If 	@asNomLigne1= '' AND (
	Select  Count(*)
  	From 	sysadm.w_div_sin ds,
  		sysadm.w_commande c
	Where ds.id_sin = @dcIdSin
	And	c.id_sin = ds.id_sin
	And	ds.nom_zone = 'type_app'
	And	c.cod_etat in ( 'CNV', 'ECT' )
	And ( 
			(
				ds.val_car = 'TEL'
				And	c.id_typ_art = 'EDI'
				And	c.id_ref_four = 'A_DIAGNOSTIQUER' -- [VDOC9057]
			)
			Or 
			( c.id_typ_art = 'REA')
		)
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 1'
	End 

-- SPB 5
If 	@asNomLigne1= '' AND (
	Select  Count(*)
  	From 	sysadm.w_commande c
	Where   c.id_sin = @dcIdSin
	And		c.id_ref_four = 'CONTEST_SUR_REMPL' -- [PM280-2]
	And	    c.cod_etat in ( 'CNV', 'ECT' )
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 5'
	End 


-- [PM280-1][MANTIS15144]	
If 	@asNomLigne1= '' AND (
	Select  Count(*)
	From 	sysadm.w_commande c
	Where   c.id_sin = @dcIdSin
	And	c.id_typ_art = 'PRS' -- [VDOC9057]
	And	sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt), ';' ) = 'OUI'
	And	c.cod_etat in ( 'CNV', 'ECT' )
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 5'
	End 

-- SPB 4	
If 	@asNomLigne1= '' AND (
	Select  Count(*)
  	From 	sysadm.w_commande c
	Where   c.id_sin = @dcIdSin
	And	c.id_typ_art = 'PRS' -- [VDOC9057]
	And	c.cod_etat in ( 'CNV', 'ECT' )
	and @sTypApp = 'TEL' 
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 4'
	End 

-- SPB 8	
If 	@asNomLigne1= '' AND (
	Select  Count(*)
  	From 	sysadm.w_commande c
	Where   c.id_sin = @dcIdSin
	And	c.id_typ_art = 'PRS' -- [VDOC9057]
	And	c.cod_etat in ( 'CNV', 'ECT' )
	and @sTypApp <> 'TEL' 
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 8'
	End 


		
-- SPB 2
If 	@asNomLigne1= '' AND (
	Select  Count(*)
	From 	sysadm.w_commande c
	Where   c.id_sin = @dcIdSin
	And	c.id_typ_art = 'EDI'
	And	c.cod_etat in ( 'CNV', 'ECT' )
-- [PC419/440/418/439_MICROMANIA] Ajout 15
	And	c.id_gti in( 18, 15 )
	And	c.id_ref_four = 'A_DIAGNOSTIQUER' -- [VDOC9057]
	) > 0
	
	Begin
		Set @asNomLigne1 = 'SPB 2'
	End 

-- SPB 3
If 	@asNomLigne1= '' Set @asNomLigne1 = 'SPB 3'


-- [PM280-1]
Set @asNomLigne1 = @asNomLigne1 + @sLettreCatg 
 
-- Affectation de l'adresse
-- SPB 2, 6 et 7, on ne change rien

-- [PM280-1] le LEFT
If sysadm.FN_CLE_NUMERIQUE ( 'RS3337') > 0 
	Begin
		If sysadm.FN_CLE_NUMERIQUE ( 'RS3337') >= 2 
		  Begin
			Set @asNomLigne1 = 'LOXY - ' + @asNomLigne1
		  End 
		Else
		  Begin
			Set @asNomLigne1 = 'LOXY'
		  End

		Set @asAdrLigne1 = '21-23 Rue Saint-Hilaire'
		Set @asAdrLigne2 = 'Saint-Ouen l''Aumône'
		Set @asCP = '95041'
		Set @asVille = 'CERGY-PONTOISE CEDEX 1'
	End 
Else 
	Begin

		If Left ( @asNomLigne1, 5) in ('SPB 1','SPB 4','SPB 5')
		Begin
			-- Bezons
			Set @asAdrLigne1 = '124, rue Salvador Allende'
			Set @asAdrLigne2 = ''
			Set @asCP = '95870'
			Set @asVille = 'BEZONS'
		End
	End

Go

grant execute on sysadm.PS_S01_ADRESSE_O2M_V01 to rolebddsinistres
Go


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_TEMPS_1' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_TEMPS_1
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure sysadm.PS_CORRECTION_BASE_TEMPS_1
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_TEMPS_1
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au temps 1
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-- JFF	18/12/2013	ITSM190500
-- JFF      12/02/2016   [PI062]
-- JFF  25/08/2020 Création enregistrement dans routage si absent
-------------------------------------------------------------------
AS

SET NOCOUNT ON

-- PM234-7 Mantis 22824 JFF 07/12/16
Exec sysadm.PS_I_ERR_TRAVAIL_ABSENT

-- JFF 28/04/2017
Exec sysadm.PS_REDRESS_PIECE_HISTO

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL


------------------------------------------------------
-- Nettoyage de w_queue si  non présence dans w_sin --
------------------------------------------------------
-- Correction W_queue
-- Temps 0s (Hors cache)
-- Chaque heure à 10
Delete  From sysadm.w_queue
From   	sysadm.w_queue wq  with (nolock),
	sysadm.sinistre s  with (nolock)
where   convert ( Decimal ( 10), wq.id_sin ) = s.id_sin  -- [PI062]
And 	Not Exists
	( Select *
	  From   sysadm.w_sin ws with (nolock) 
	  Where  convert ( Decimal ( 10), wq.id_sin ) = ws.id_sin ) -- [PI062]

------------------------------------------------------
-- Nettoyage de Routage 			    --
------------------------------------------------------
-- Correction routage
-- Temps 0s (Hors cache)
-- Chaque heure à 10
Update  sysadm.routage
Set alt_queue = 'N'
from 	sysadm.routage r  with (nolock)
where r.alt_queue = 'O'
and not exists ( select Top 1 1 from sysadm.w_queue wq  with (nolock)
		where wq.id_sin = convert ( varchar ( 10 ), r.id_sin ) )  -- [PI062]

Update  sysadm.routage
Set alt_queue = 'O'
from 	sysadm.routage r  with (nolock)
where r.alt_queue = 'N'
and exists ( select Top 1 1 from sysadm.w_queue wq  with (nolock)
		where wq.id_sin = convert ( varchar ( 10 ), r.id_sin ) )  -- [PI062]

-- JFF  25/08/2020 
Insert into sysadm.routage
Select	s.id_sin,
		'N', 
	    p.id_corb,
		'X',
		Case 
			When Exists ( Select Top 1 1 From sysadm.sinistre s2  with (nolock) where s2.id_sin = s.id_sin ) Then 'CPL'
			Else 'DEC'
		End,
		Case 
			When Exists ( Select Top 1 1 From sysadm.w_queue s2  with (nolock) where s2.id_sin = s.id_sin ) Then 'O'
			Else 'N'
		End,
		s.cree_le, 
		s.cree_le,
		'AUTO', 
		null,
		null,
		null,
		null,
		null
from sysadm.w_sin s  with (nolock),
	 sysadm.produit p   with (nolock)
where not exists ( Select top 1 1 From sysadm.routage r  with (nolock) where r.id_sin = s.id_sin ) 
And   p.id_prod = s.id_prod

Insert into sysadm.routage
Select	s.id_sin,
		'N', 
	    p.id_corb,
		'X',
		Case 
			When Exists ( Select Top 1 1 From sysadm.sinistre s2  with (nolock) where s2.id_sin = s.id_sin ) Then 'CPL'
			Else 'DEC'
		End,
		Case 
			When Exists ( Select Top 1 1 From sysadm.w_queue s2  with (nolock) where s2.id_sin = s.id_sin ) Then 'O'
			Else 'N'
		End,
		s.cree_le, 
		s.cree_le,
		'AUTO', 
		null,
		null,
		null,
		null,
		null
from sysadm.sinistre s  with (nolock),
	 sysadm.produit p  with (nolock)
where not exists ( Select top 1 1 From sysadm.routage r with (nolock) where r.id_sin = s.id_sin ) 
And   p.id_prod = s.id_prod

-- /JFF  25/08/2020 

-----------------------------------------------------------------
-- Correction sur les frais, redressement de clé	       --
-----------------------------------------------------------------
Update sysadm.frais
Set    cod_etat = 600
where  cod_etat = 500

Update sysadm.w_frais
Set    cod_etat = 600
From   sysadm.w_frais wf  with (nolock)
Where  wf.cod_etat = 500
And    Exists (
	Select top 1 1 
	From  sysadm.frais f with (nolock)
	where f.id_sin = wf.id_sin
	And   f.id_i = 	wf.id_i
	And   f.id_frais = wf.id_frais
	And   f.cod_etat = 600 )

--------------------------------------------------------
-- Redressement detail en 500 vers 600 JFF 08/02/2010 --
--------------------------------------------------------
-- 0 s (hors cache)
-- chaque heure à 30
Update sysadm.w_detail
Set    cod_etat = 600
From   sysadm.detail with (nolock)
WHERE   w_detail.maj_le > DateAdd ( day, -2, getdate( ) )
And	w_detail.id_sin		= detail.id_sin
And	w_detail.id_gti		= detail.id_gti		
And	w_detail.id_detail	= detail.id_detail
And	w_detail.cod_etat = 500
And 	detail.mt_plaf > 0 
And	detail.id_reg > 0
And	detail.cod_etat in ( 500, 600 )

Update sysadm.detail
Set    cod_etat = 600
WHERE  detail.valide_le > DateAdd ( day, -2, getdate( ) )
And 	mt_plaf > 0 
And	id_reg > 0
And	cod_etat = 500


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_TEMPS_2' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_TEMPS_2
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure sysadm.PS_CORRECTION_BASE_TEMPS_2
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_TEMPS_2
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au temps 2
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF 23/04/2019 - Redressement des cmde ELD sur le num CC manquant.
-- JFF 19/12/2022   [RS4093_EVOL_ELD]
-------------------------------------------------------------------

AS

SET NOCOUNT ON

-- [RS4093_EVOL_ELD]
If NOT sysadm.FN_CLE_NUMERIQUE ( 'RS4093_EVOL_ELD') > 0 
 Begin
	-- JFF 23/04/2019 - Redressement des cmde ELD sur le num CC manquant.
	Exec sysadm.PS_U_COMMANDE_ELD_NUM_CC_REDRESS
 End

----------------------------------------------------------------------------------
-- Nouveau bug peu fréquent : Par moment l'enregistrement reste sur w_cour_blob --
----------------------------------------------------------------------------------
-- 0 s (hors cache)
delete from sysadm.w_cour_blob 
from sysadm.w_cour_blob wcb  with (nolock)
where not exists ( 
	select * from sysadm.w_queue wq with (nolock)
	where wq.id_sin = wcb.id_sin )

delete from sysadm.w_courrier
from sysadm.w_courrier wc  with (nolock)
where not exists ( 
	select * from w_queue wq with (nolock)
	where wq.id_sin = wc.id_sin )

----------------------------------------------------------------------------------
-- JFF redressement de cas incohérent entre w_cour_blob, w_courrier et w_inter  --
----------------------------------------------------------------------------------
-- 2 s (hors cache)
Delete from w_cour_blob
From 
	(
	Select id_sin ,   id_i 
	from sysadm.w_inter wi with (nolock)
	where ( wi.alt_part = 'O' or wi.id_cour = 'APART1' or wi.id_nat_cour = 'APART1' )
	and 
	( not exists 
	 ( Select *
	   From sysadm.w_courrier wc with (nolock)
	   where wc.id_sin = wi.id_sin
	   and   wc.id_i = wi.id_i
	   and   wc.id_cour = 'APART1'
	 )
	Or not exists  
	 ( Select *
	   From sysadm.w_courrier wc with (nolock),
		sysadm.w_cour_blob wcb with (nolock)
	   where wc.id_sin = wi.id_sin
	   and   wc.id_i = wi.id_i
	   and   wc.id_cour = 'APART1'
	   and   wcb.id_sin = wc.id_sin 
	   and   wcb.id_i = wc.id_i
	   and   wcb.id_cpt = wc.id_cpt
	 )
	)
	) as Tb1
Where w_cour_blob.id_sin = Tb1.id_sin
And   w_cour_blob.id_i = Tb1.id_i

Delete from w_courrier
From 
	(
	Select id_sin ,   id_i 
	from sysadm.w_inter wi with (nolock)
	where ( wi.alt_part = 'O' or wi.id_cour = 'APART1' or wi.id_nat_cour = 'APART1' )
	and 
	( not exists 
	 ( Select top 1 1 
	   From sysadm.w_courrier wc with (nolock)
	   where wc.id_sin = wi.id_sin
	   and   wc.id_i = wi.id_i
	   and   wc.id_cour = 'APART1'
	 )
	Or not exists  
	 ( Select top 1 1 
	   From sysadm.w_courrier wc with (nolock),
		sysadm.w_cour_blob wcb with (nolock)
	   where wc.id_sin = wi.id_sin
	   and   wc.id_i = wi.id_i
	   and   wc.id_cour = 'APART1'
	   and   wcb.id_sin = wc.id_sin 
	   and   wcb.id_i = wc.id_i
	   and   wcb.id_cpt = wc.id_cpt
	 )
	)
	) as Tb1
Where w_courrier.id_sin = Tb1.id_sin
And   w_courrier.id_i = Tb1.id_i

-- Rappatrie dans w_inter si absecne de w_inter, présent dans inter et présence w_sin (JFF, 15/12/2020)
Insert into sysadm.w_inter 
Select 
i.id_sin,
i.id_i,
i.cod_inter,
i.cod_civ,
i.nom,
i.adr_1,
i.adr_2,
i.adr_cp,
i.adr_ville,
i.adr_att,
i.num_teld,
i.num_telb,
i.num_fax,
i.cod_mode_reg,
i.rib_bq,
i.rib_gui,
i.rib_cpt,
i.rib_cle,
0,
i.mt_reg,
i.v_ref1,
i.v_ref2,
i.cod_ag,
i.cod_bq,
i.cpt_cour,
1,
'N',
'N',
'N',
'N',
'N',
null,
null,
'N',
null,
null,
i.cree_le,
i.maj_le,
i.maj_par,
i.ordre_cheque,
null,
i.id_four,
i.alt_suivi_mail,
i.adr_mail,
i.alt_suivi_sms,
i.num_port_sms,
i.dte_naiss, -- [PMO89_RS4822]
i.ville_naiss, -- [PMO89_RS4822]
i.pays_naiss, -- [PMO89_RS4822]
i.cod_etat_ctrle_inter -- [PMO89_RS4822] 

from sysadm.inter i with (nolock),
	 sysadm.w_sin ws with (nolock) 
where ws.id_sin = i.id_sin
And Not exists ( 
	Select top 1 1
	From sysadm.w_inter wi with (nolock)
	Where wi.id_sin = i.id_sin
	and wi.id_i = i.id_i
)


Update sysadm.w_inter_encrypt 
Set alt_part = 'N' , id_cour = null , id_nat_cour = null
from sysadm.w_inter_encrypt wi with (nolock), sysadm.w_sin ws with (nolock)
where ws.id_sin = wi.id_sin
and ( wi.alt_part = 'O' or wi.id_cour = 'APART1' or wi.id_nat_cour = 'APART1' )
and 
( not exists 
 ( Select *
   From sysadm.w_courrier wc with (nolock)
   where wc.id_sin = wi.id_sin
   and   wc.id_i = wi.id_i
   and   wc.id_cour = 'APART1'
 )
Or not exists  
 ( Select *
   From sysadm.w_courrier wc with (nolock),
	sysadm.w_cour_blob wcb with (nolock)
   where wc.id_sin = wi.id_sin
   and   wc.id_i = wi.id_i
   and   wc.id_cour = 'APART1'
   and   wcb.id_sin = wc.id_sin 
   and   wcb.id_i = wc.id_i
   and   wcb.id_cpt = wc.id_cpt
 )
)
--And ws.maj_le >= dateadd ( day, -2, getdate() )

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_TEMPS_3' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_TEMPS_3
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure sysadm.PS_CORRECTION_BASE_TEMPS_3
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_TEMPS_3
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au temps 3
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
AS

SET NOCOUNT ON

DECLARE @dcIdSin        Decimal (10),  -- [PI062]
        @sBody          VarChar ( 2000 ),
        @sObjet         VarChar ( 200 ),
        @sRetourErr     VARCHAR ( 255 ),
		@iRet			Integer,
		@iCtpSecu		Integer

Declare @sDIR Varchar ( 100 )
Declare @TbRepCour Table ( id_seq integer identity, nom_fic varchar ( 100) INDEX IX1 CLUSTERED, marquage int  ) 
Declare @TbRepCour2 Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED ) 
Declare @TbLstFicBase Table ( nom_fic varchar ( 100) INDEX IX1 CLUSTERED ) 
Declare @sRepCourDest VarChar ( 200 )
Declare @iIdSeq Integer
Declare @iIdCode Integer
Declare @sNomFic VarChar ( 100 ) 


-------------------------------------------------------------
-- Bug du règlement non attaché à un RN (JFF le 05/02/2010)--
-------------------------------------------------------------
-- 5 s (hors cache) (18s parfois)
-- chaque heure à 30
-- Index Papillon
Set @iRet = 1
Set @iCtpSecu = 1 
While @iRet > 0 And @iCtpSecu < 50
 Begin
	Select top 1 @dcIdSin = r.id_sin 
	from   reglement r with (nolock),
		reg_gti rg With (NoLock)
	where  rg.id_sin = r.id_sin
	and    rg.id_reg = r.id_reg
	and    rg.id_gti > 0
	and    r.cod_mot_reg = 'RN'
	and    Not Exists ( 
		Select top 1 1  
		from detail d with (nolock)
		where d.id_sin = rg.id_sin
		and   d.id_gti = rg.id_gti
		and   d.id_reg = rg.id_reg
		)
	and r.cree_le >= DATEADD(day, -2, GETDATE()) 

	If @@Rowcount > 0 
	  Begin 

			Exec @iRet = sysadm.PS_REDRESS_RN_NON_ATTACHE_DETAIL @dcIdSin

			If @iRet < 0 
			 Begin
				Set @sBody = '!! Reglement RN non attaché à un détail ' + Convert ( VarChar ( 10 ) , @dcIdSin )  -- [PI062]
				Set @sBody = @sBody + Char( 10 ) + Char (13)
				Set @sBody = @sBody + 'Relancez ensuite sysadm.PS_CORRECTION_BASE_TEMPS_3 pour vérifier qu''y en ait pas d''autres'
				Set @sObjet = 'SIMPA2_PRO : RN non attaché à un détail ' + Convert ( VarChar ( 10 ),  @dcIdSin ) -- [PI062]

				Exec master.dbo.SPB_PS_MAIL
				@sRetourErr     OUTPUT,
				'jff@spb.fr',
				@sBody  ,
				@sObjet,
				'',
				null,
				null,
				null,
				null,
				null,
				null
			 End
	  End
	Else
	 Begin
	  Set @iRet = -1
	 End 

	Set @iCtpSecu = @iCtpSecu + 1 
 End
-- MOUCHARD_REFUS
Select top 1 @dcIdSin = s.id_sin 
from sysadm.sinistre s with (nolock)
where s.cod_etat = 200
and Not exists ( 
	Select Top 1 1
	From sysadm.refus r  with (nolock)
	Where r.id_sin = s.id_sin
	)
and s.cree_le >= '17/05/2016'
and s.cree_le >= DATEADD(Month, -6, GETDATE())

If @@Rowcount > 0 
	Begin 
		Set @sBody = 'Etat refusé sans motif de refus, sinistre ' + Convert ( VarChar ( 10 ) , @dcIdSin ) + Char( 10 ) + Char (13)  -- [PI062]
		Set @sObjet = @sBody

		Exec master.dbo.SPB_PS_MAIL
		@sRetourErr     OUTPUT,
		'jff@spb.fr,fpinon@spb.eu',
		@sBody  ,
		@sObjet,
		'Mouchard Refus SQL',
		null,
		null,
		null,
		null,
		null,
		null
	End

-- /MOUCHARD_REFUS

-- Maintence option dp/W8 automatique pour les *.DOT
Set @sRepCourDest = '\\SPB.LAN\APPLIS\SPB\SIMPA2\COURRIER\'
Set @sDIR = 'DIR "' + @sRepCourDest + '*.DOT" /b'

-- @TbRepCour se charge avec la liste des fichiers du répertoire
Insert into @TbRepCour2 EXEC master.dbo.xp_cmdshell @sDIR 
Delete @TbRepCour2 where nom_fic is null
Delete @TbRepCour2 where left ( ltrim ( nom_fic ), 16 ) = 'ACCESS IS DENIED'
Update @TbRepCour2 Set nom_fic = Upper ( nom_fic )
Insert into @TbRepCour Select nom_fic, 0  From @TbRepCour2

-- @@TbLstFicBase se charge avec la liste des fichiers de la base
Insert into @TbLstFicBase Select rtrim ( c.lib_code ) From sysadm.code c where c.id_typ_code = '-W8'  and id_code > 0 and Right ( rtrim ( c.lib_code), 4 ) = '.DOT'
Update @TbLstFicBase Set nom_fic = Upper ( nom_fic )

While Exists ( Select Top 1 1 From @TbRepCour where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq  = id_seq,
		@sNomFic = nom_fic
	From	@TbRepCour 
	Where	marquage = 0

	If Not Exists ( 
		Select Top 1 1 
		From @TbLstFicBase tl
		Where tl.nom_fic = @sNomFic
	  )
	 Begin
	    Select @iIdCode = IsNull ( max ( id_code ), 0 ) + 1 From sysadm.code where id_typ_code = '-W8'
		Insert into sysadm.code values ( '-W8', @iIdCode , @sNomFic, GetDate(), Getdate(), 'SQL' )
	 End 

	Update @TbRepCour Set marquage = 1 Where id_seq = @iIdSeq
 End

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_TEMPS_4' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_TEMPS_4
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure sysadm.PS_CORRECTION_BASE_TEMPS_4
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_TEMPS_4
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au temps 4
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
AS

SET NOCOUNT ON

Declare @dt1 DateTime

Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'COUPER_ACCES_SIMPA2'

-- Est utilisé pour le message d'erreur en SIM sur la recopie de base.
-- Select @dt1 = max (s.valide_le) From sysadm.sinistre s  with (nolock)
-- Update sysadm.date_pivot Set dte_1 = DateAdd ( minute, 75, @dt1), maj_le = getdate() Where id_cle = 'DERN_VALID'
Update sysadm.date_pivot Set dte_1 = getdate(), maj_le = getdate() Where id_cle = 'DERN_VALID'

---------------------------------------------------------------------------------
-- Ajout de certains types codes créés sur SIMPA2 en automatique 	       -- 
---------------------------------------------------------------------------------
-- Optimisé									
-- 0 s (hors cache)
insert SHERPA_PRO.sysadm.code
        select c.id_typ_code, c.id_code, c.lib_code, 
		Case c.id_typ_code  		
			When '-GA' Then '-GA'+ Convert (Varchar(3), c.id_code) 
			Else Null
		End , 
		Getdate(), GetDate(), 'SQL'
        from SIMPA2_PRO.sysadm.code c with (nolock)
        where c.id_typ_code in ( '+DT', '+EV', '+NS', '+TR', '-GA' )
	And c.cree_le >= DateAdd ( day, -2, getdate( ) )
        and not exists ( 
        	Select top 1 1
        	From SHERPA_PRO.sysadm.code cc with (nolock)
        	Where cc.id_typ_code = c.id_typ_code
        	And cc.id_code = c.id_code )


insert SHERPA_PRO.sysadm.code_appli
        select c.id_typ_code, c.id_code, 2, c.id_typ_code, c.id_code, 20, Getdate(), GetDate(), 'SQL'
        from SIMPA2_PRO.sysadm.code c with (nolock)
        where c.id_typ_code in ( '+DT', '+EV', '+NS', '+TR', '-GA' )
	And c.cree_le >= DateAdd ( day, -2, getdate( ) )
        and not exists ( 
        	Select top 1 1
        	From SHERPA_PRO.sysadm.code_appli cc with (nolock)
        	Where cc.id_typ_code = c.id_typ_code
        	And cc.id_code = c.id_code
        	And cc.id_appli = 2 )


Insert into sysadm.lien_article
Select  a.id_four,
		a.id_ref_four,
		a.id_marq_art,
		a.id_modl_art,
		a.id_marq_art_ifr,
		a.id_modl_art_ifr,
		getdate(),
		getdate(),
		'AUTO'

from	sysadm.article a with (nolock)
Where   a.id_marq_art_ifr is not null
And		a.id_modl_art_ifr is not null
And		Not Exists ( 
			Select  Top 1 1 
			From	sysadm.lien_article la with (nolock)
			Where   la.id_four = a.id_four
			And		la.id_ref_four = a.id_ref_four
			And		la.marq_four = a.id_marq_art
			And		la.modl_four = a.id_modl_art
		)
And		a.id_four not in (  'WBA', 'WBB', 'ANV', 'ORV', 'BTP', 'DDF', 'ALP', 'FTT'  )

-- Pro actif avant que le GT ne prenne le dossier
Update i
Set dern_maj_prix_trt = 'URGE'
From sysadm.w_sin ws, 
	 sysadm.ifr i
Where ws.cod_etat = 0
And i.marque = ws.marq_port
And i.reference = ws.modl_port
and i.dern_maj_prix_dte < DateAdd ( month, i.per_rev_prix_mois * (-1), getdate() )
And i.dern_maj_prix_trt not in ( 'URGE', 'FERM' ) 

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_NUIT_1' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_NUIT_1
GO

CREATE procedure sysadm.PS_CORRECTION_BASE_NUIT_1
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_NUIT_1
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au nuit 1
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- ITSM289429 - FPI - correction cpt_valide=99
-- FPI - 05/05/2015 - ajout correction id_opt
-- JFF      12/02/2016   [PI062]
-- JFF      20/02/2023   [RS4616_RET_TLS]
-------------------------------------------------------------------
AS

SET NOCOUNT ON

-- Temps 2 s

DECLARE  @dcIdSin        Decimal (10), -- [PI062]
	 @dcMaxIdSin     Decimal (10), -- [PI062]
	 @dcIdGti        Decimal (7),
	 @dcCodEtat      Decimal (7),
         @iIdLot         Integer,
 	 @sRet    	varchar(60),
	 @sBody          VarChar ( 2000 ),
	 @sObjet         VarChar ( 200 ),
	 @sRetourErr     VARCHAR ( 255 ),
	 @iCptValide     int

-----------------------------------------------------------------
-- Correction lots édités et non archivés.		       --
-----------------------------------------------------------------
-- Obligé de conserver le curseur
-- 2 s (hors cache)
-- La nuit à n'importe qu'elle heure
DECLARE Curs_Correction CURSOR FOR
Select  Distinct id_lot
from 	sysadm.w_cour_blob_arch with (nolock)
where   dte_edit is not null and alt_fn = 'N'

OPEN Curs_Correction

FETCH NEXT FROM Curs_Correction INTO @iIdLot

WHILE @@FETCH_STATUS = 0
BEGIN
	Set @sRet = space ( 60 )
	Exec sysadm.PS_I02_ARCHIVE_BLOB_VAL @iIdLot, @sRet OUTPUT

        FETCH NEXT FROM Curs_Correction INTO @iIdLot
END

CLOSE Curs_Correction
DEALLOCATE Curs_Correction
SET NOCOUNT OFF

------------------------------------------------------
-- Ajout des corbeilles  			    --
------------------------------------------------------
-- 0 s (hors cache)
-- La nuit à n'importe qu'elle heure

-- Toutes le corbeilles

Declare @tbCorb TABLE (id_oper varchar(4))

insert into @tbCorb values ('EADR'),
		('JFF'),('FS'),('SBA'), -- Equipe ES
		('O2M'), ('SB1'),('MS1'), -- fournisseurs SPBS, SBETV & MSS
		('DRE#'),('RSP#'),('RDR#'),('RBA#'), -- Trigrammes virtuels IWD
		('CBO'), -- Christophe Bourdoiseau
		('RBR#'), ('RBD#'), ('RBT#') ,('RHT'),('CDI') -- PM283-1

-- [VDOC15473]
insert into @tbCorb values ('DSA#')

insert into sysadm.corb_oper
select oper.id_oper, 
	corb.id_corb,
	'N',
	getdate(),
	getdate(),
	'FPI'
from (select distinct p.id_corb from sysadm.produit p with (nolock)) corb,
	@tbCorb oper
where not exists
	 (select * from sysadm.corb_oper c with (nolock)
	  where c.id_oper=oper.id_oper and c.id_corb=corb.id_corb)
And corb.id_corb not in ( 291 ) -- PMO77 Retrait Corbeille Securipanne/Securishopping
	
-- Corbeille 998 a la factu
Insert into sysadm.corb_oper
select
id_oper,
998,
'N',
getdate(),
getdate(),
'JFF'
From
(
select distinct c1.id_oper from sysadm.corb_oper c1 with (nolock)
where c1.id_oper in ('CBP','CBA','VAD','COD','EOS','ML') and
	not exists (
	select * from sysadm.corb_oper c with (nolock)
	where c.id_oper = c1.id_oper
	and c.id_corb = 998
	) ) as CorbAbsente

-----------------------------------------------------
-- bug rare mais gênant relevé par Marion. Guerin  --
-- Certains dossiers (très peu) sont en etat 100   --
-- ainsi que la Gti (en état 100) alors qu'au moins--
-- un détail est réglé 	                           --
-----------------------------------------------------
-- 4 s (hors cache)
-- La nuit à n'importe qu'elle heure

-- JFF le 23/06/2016
Exec sysadm.PS_U_REDRESS_DET600_GTI100


Update sysadm.w_detail
Set    cod_etat = 600
From   sysadm.detail with (nolock)
WHERE   w_detail.maj_le > DateAdd ( hour, -26, getdate( ) )
And	w_detail.id_sin		= detail.id_sin
And	w_detail.id_gti		= detail.id_gti		
And	w_detail.id_detail	= detail.id_detail
And	w_detail.cod_etat = 500
And 	detail.mt_plaf > 0 
And	detail.id_reg > 0
And	detail.cod_etat in ( 500, 600 )

Update sysadm.detail
Set    cod_etat = 600
WHERE  detail.valide_le > DateAdd ( day, -2, getdate( ) )
And 	mt_plaf > 0 
And	id_reg > 0
And	cod_etat = 500

Update sysadm.w_inter 
Set alt_part = 'N' , id_cour = null , id_nat_cour = null
from sysadm.w_inter wi with (nolock)
where ( wi.alt_part = 'O' or wi.id_cour = 'APART1' or wi.id_nat_cour = 'APART1' )
and 
( not exists 
 ( Select top 1 1 
   From sysadm.w_courrier wc with (nolock)
   where wc.id_sin = wi.id_sin
   and   wc.id_i = wi.id_i
   and   wc.id_cour = 'APART1'
 )
Or not exists  
 ( Select top 1 1 
   From sysadm.w_courrier wc with (nolock),
	sysadm.w_cour_blob wcb with (nolock)
   where wc.id_sin = wi.id_sin
   and   wc.id_i = wi.id_i
   and   wc.id_cour = 'APART1'
   and   wcb.id_sin = wc.id_sin 
   and   wcb.id_i = wc.id_i
   and   wcb.id_cpt = wc.id_cpt
 )
)
--And wi.maj_le >= dateadd ( day, -2, getdate( ) )

Select top 1 @dcIdSin = r.id_sin 
from   sysadm.reglement r with (nolock), 
	sysadm.reg_gti rg With (NoLock)
where  rg.id_sin = r.id_sin
and    rg.id_reg = r.id_reg
and    rg.id_gti > 0
and    r.cod_mot_reg = 'RN'
and    Not Exists ( 
	Select top 1 1  
	from sysadm.detail d with (nolock)
	where d.id_sin = rg.id_sin
	and   d.id_gti = rg.id_gti
	and   d.id_reg = rg.id_reg
	)
and r.cree_le >= DATEADD(day, -2, getdate( ) )

If @@Rowcount > 0 
  Begin 
        Set @sBody = '!! Reglement RN non attaché à un détail ' + Convert ( VarChar ( 7 ) , @dcIdSin ) 
        Set @sBody = @sBody + Char( 10 ) + Char (13)
        Set @sBody = @sBody + 'Relancez ensuite sysadm.PS_U01_CORRECTION_REG_GTI pour vérifier qu''y en ait pas d''autres'
        Set @sObjet = 'SIMPA2_PRO : RN non attaché à un détail ' + Convert ( VarChar ( 7 ),  @dcIdSin ) 

        Exec master.dbo.SPB_PS_MAIL
        @sRetourErr     OUTPUT,
        'jff@spb.fr',
        @sBody  ,
        @sObjet,
        '',
        null,
        null,
        null,
        null,
        null,
        null
  End

-- ITSM190500
Insert into sysadm.commande
Select  c.id_sin,
		(Select max ( id_seq ) from sysadm.commande c2 with (nolock) where c2.id_sin = c.id_sin ) + 1 id_seq,
		c.id_gti,
		c.id_detail,
		'PSM' id_four,
		'REL' id_typ_art,
		'RELAI BOUTIQUE PSM' id_marq_art,
		'' id_modl_art,
		0 mt_ttc_cmde,
		c.adr_nom,
		c.adr_prenom,
		c.adr_livr1,
		c.adr_livr2,
		c.adr_livr_cpl,
		c.adr_cp,
		c.adr_ville,
		c.adr_tel1,
		c.adr_tel2,
		c.adr_tel3,
		c.adr_mail,
		c.dte_rdv_cli,
		c.hrdv_cli_min,
		c.hrdv_cli_max,
		c.id_serie_anc,
		'O2M vous envoie un appareil de remplacement définitif pour l assuré qui passera le chercher en boutique une fois que vous aurez répondu à cette prestation comme quoi vous avez reçu l appareil' probleme,
		null id_cmd_frn,
		null id_serie_nouv,
		null id_bon_transp,
		null dte_rcp_frn,
		null dte_env_cli,
		'ECT' cod_etat,
		null comment_frn,
		c.nom_gest,
		0 id_lot_cmd,
		null cmd_gen_le,
		null cmd_gen_par,
		GETDATE() cree_le,
		GETDATE() maj_le,
		'AUTO' maj_par,
		GETDATE() valide_le,
		'AUTO' valide_par,
		null id_zone,
		0 id_bsp,
		null dte_ret_pret,
		c.adr_cod_civ,
		'RELAI_BTQ' id_ref_four,
		0 id_orian_marque,
		0 id_orian_modele,
		null dte_elv_mobile,
		0 status_gc,
		null dte_emis_devis,
		null mt_devis,
		null alt_dev_acp,
		null dte_dev_acp,
		c.adrfc_cod_civ,
		'X' adrfc_nom,
		'X' adrfc_prenom,
		'X' adrfc_livr1,
		'X' adrfc_livr2,
		null adrfc_livr_cpl,
		'0' adrfc_cp,
		'X' adrfc_ville,
		c.dte_ret_logis,
		c.dte_ret_pret_min,
		c.dte_ret_pret_max,
		c.id_ann,
		c.dte_env_bte_frn,
		c.dte_rcp_bte_cli,
		c.dte_dep_bte_cli,
		c.dte_env_st,
		null dte_rcp_mob_cli,
		2136 info_spb_frn,
		'RELAI BOUTIQUE PSM' id_marq_art_ifr,
		'' id_modl_art_ifr,
			'CODE_BTQ_RELAI_PSM=' + IsNull ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', RTRIM ( info_spb_frn_cplt ), ';' ), '') + ';' +
			'TYP_RELAI=' + IsNull ( sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( info_spb_frn_cplt ), ';' ), '') + ';' +
			'CODE_BTQ_PSM_PROXIMITE=' + IsNull ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', RTRIM ( info_spb_frn_cplt ), ';' ), '') +
			IsNull (
				( Select top 1 ';APP_SIN_A_RECUPERER=OUI'
				  From commande c1 with (nolock)
				  Where c1.id_sin = c.id_sin
				  And   c1.id_ref_four = 'A_DIAGNOSTIQUER'
				  And   c1.id_four = 'O2M'
				  And   c1.info_spb_frn = 980
				) 
				, '' )info_spb_frn_cplt,
		'' info_frn_spb_cplt

from sysadm.commande c with (nolock),
	 sysadm.sinistre s with (nolock),
	 sysadm.det_pro dp with (nolock)
where s.id_sin = c.id_sin
and   dp.id_prod = s.id_prod
and   dp.id_code_dp = 239
and c.info_spb_frn = 973
And not exists ( 
	Select top 1 1
	from sysadm.commande c1 with (nolock)
	Where c1.id_sin = c.id_sin
	and   c1.id_four = 'PSM'
	and   c1.info_spb_frn = 2136
)
and c.id_typ_art <> 'PRS'

Set @iCptValide = @@RowCount

Insert into sysadm.w_commande
Select  c.id_sin,
		(Select max ( id_seq ) from w_commande c2 with (nolock) where c2.id_sin = c.id_sin )+1 id_seq,
		c.id_gti,
		c.id_detail,
		'PSM' id_four,
		'REL' id_typ_art,
		'RELAI BOUTIQUE PSM' id_marq_art,
		'' id_modl_art,
		0 mt_ttc_cmde,
		c.adr_nom,
		c.adr_prenom,
		c.adr_livr1,
		c.adr_livr2,
		c.adr_livr_cpl,
		c.adr_cp,
		c.adr_ville,
		c.adr_tel1,
		c.adr_tel2,
		c.adr_tel3,
		c.adr_mail,
		c.dte_rdv_cli,
		c.hrdv_cli_min,
		c.hrdv_cli_max,
		c.id_serie_anc,
		'O2M vous envoie un appareil de remplacement définitif pour l assuré qui passera le chercher en boutique une fois que vous aurez répondu à cette prestation comme quoi vous avez reçu l appareil' probleme,
		null id_cmd_frn,
		null id_serie_nouv,
		null id_bon_transp,
		null dte_rcp_frn,
		null dte_env_cli,
		'ECT' cod_etat,
		null comment_frn,
		@iCptValide cpt_valide,
		c.nom_gest,
		GETDATE() cree_le,
		GETDATE() maj_le,
		'AUTO' maj_par,
		null id_zone,
		0 id_bsp,
		null dte_ret_pret,
		c.adr_cod_civ,
		'RELAI_BTQ' id_ref_four,
		0 id_orian_marque,
		0 id_orian_modele,
		null dte_elv_mobile,
		0 status_gc,
		null dte_emis_devis,
		null mt_devis,
		null alt_dev_acp,
		null dte_dev_acp,
		c.adrfc_cod_civ,
		'X' adrfc_nom,
		'X' adrfc_prenom,
		'X' adrfc_livr1,
		'X' adrfc_livr2,
		null adrfc_livr_cpl,
		'0' adrfc_cp,
		'X' adrfc_ville,
		c.dte_ret_logis,
		c.dte_ret_pret_min,
		c.dte_ret_pret_max,
		c.id_ann,
		c.dte_env_bte_frn,
		c.dte_rcp_bte_cli,
		c.dte_dep_bte_cli,
		c.dte_env_st,
		null dte_rcp_mob_cli,
		2136 info_spb_frn,
		'RELAI BOUTIQUE PSM' id_marq_art_ifr,
		'' id_modl_art_ifr,
			'CODE_BTQ_RELAI_PSM=' + IsNull ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', RTRIM ( info_spb_frn_cplt ), ';' ), '') + ';' +
			'TYP_RELAI=' + IsNull ( sysadm.FN_CLE_VAL ( 'TYP_RELAI', RTRIM ( info_spb_frn_cplt ), ';' ), '') + ';' +
			'CODE_BTQ_PSM_PROXIMITE=' + IsNull ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', RTRIM ( info_spb_frn_cplt ), ';' ), '') +
			IsNull (
				( Select top 1 ';APP_SIN_A_RECUPERER=OUI'
				  From sysadm.w_commande c1 with (nolock)
				  Where c1.id_sin = c.id_sin
				  And   c1.id_ref_four = 'A_DIAGNOSTIQUER'
				  And   c1.id_four = 'O2M'
				  And   c1.info_spb_frn = 980				  
				) 
				, '' )info_spb_frn_cplt,
		'' info_frn_spb_cplt

from sysadm.w_commande c with (nolock),
	 sysadm.w_sin s with (nolock),
	 sysadm.det_pro dp with (nolock)
where s.id_sin = c.id_sin
and   dp.id_prod = s.id_prod
and   dp.id_code_dp = 239
and c.info_spb_frn = 973
And not exists ( 
	Select top 1 1 
	from sysadm.w_commande c1
	Where c1.id_sin = c.id_sin
	and   c1.id_four = 'PSM'
	and   c1.info_spb_frn = 2136
)
and c.id_typ_art <> 'PRS'

-- /ITSM190500
-- ITSM289429
update sysadm.w_sin set cpt_valide=1 where cpt_valide > 50
update sysadm.w_inter set cpt_valide=1 where cpt_valide > 50
update sysadm.w_gar_sin set cpt_valide=1 where cpt_valide > 50
update sysadm.w_div_sin set cpt_valide=1 where cpt_valide > 50
update sysadm.w_detail set cpt_valide=1 where cpt_valide > 50
update sysadm.w_div_det set cpt_valide=1 where cpt_valide > 50
update sysadm.w_commande set cpt_valide=1 where cpt_valide > 50
-- /ITSM289429

-- Correction id_opt - 2min
update sysadm.w_sin
set cod_opt = d.dosad_c_option 
 from 
 sysadm.produit p with (nolock),
 FUS_DOSAD_PRO.dbo.dosad d with (nolock)
 Where
	 p.cod_adh in ('1','6') and
	 p.id_prod=w_sin.id_prod and
     w_sin.cod_opt is null and
     convert ( smallint, d.dosad_code_prod ) = p.cod_prod_dms  and
     w_sin.id_ets                           = d.dosad_ets       and
     w_sin.id_adh                           = convert(varchar(19),d.dosad_no_doss)   and
     convert ( tinyint, w_sin.id_sdos )     = d.dosad_no_sdoss  

-- Redressement 
Declare @iCpt Integer
Set @iCpt = 1 
While @iCpt <= 3
 Begin
	Update sysadm.produit_encrypt
	Set   cod_rev_rnv = Case T.cod_eff_rev
							When 'DTE_RNV' Then T.id_rev_max
							Else T.cod_rev_rnv
						End,
		  cod_rev_sous = Case T.cod_eff_rev
							When 'DTE_SOUS' Then T.id_rev_max
							Else T.cod_rev_sous
						End,
										 
		  cod_rev_surv = Case T.cod_eff_rev
							When 'DTE_SURV' Then T.id_rev_max
							Else T.cod_rev_surv
						End
	From 
		(
		select m.*,p.cod_rev_rnv,p.cod_rev_sous,p.cod_rev_surv, id_corb,
			   Case When (m.cod_eff_rev='DTE_RNV' and p.cod_rev_rnv=-1) Then 'Cas dangereux'
			   When (m.cod_eff_rev='DTE_SOUS' and p.cod_rev_sous=-1) Then 'Cas dangereux'
			   When (m.cod_eff_rev='DTE_SURV' and p.cod_rev_surv=-1) Then 'Cas dangereux'
			   Else 'Cas moins grave' End as cas
		from sysadm.produit_encrypt p with (nolock),
			   ( select id_prod,max(id_rev) id_rev_max, r.cod_eff_rev
			   from revision r with (nolock)
			   group by id_prod, cod_eff_rev ) m
		where (m.id_prod=p.id_prod and p.cod_rev_rnv <> m.id_rev_max and m.cod_eff_rev='DTE_RNV')
			   or (m.id_prod=p.id_prod and p.cod_rev_sous <> m.id_rev_max and m.cod_eff_rev='DTE_SOUS')
			   or (m.id_prod=p.id_prod and p.cod_rev_surv <> m.id_rev_max and m.cod_eff_rev='DTE_SURV')
		) as T,
		sysadm.produit_encrypt p with (nolock)
	Where p.id_prod = T.id_prod

	Set @iCpt = @iCpt + 1

 End	

-- JFF le 19/12/2014, envoi d'un mail sur le compteur sinistre SIMPA2 restant.
Exec sysadm.PS_S_CPT_SIN_RESTANT

-- JFF le 16/03/2016, envoi d'un mail à Sandrine sur les sinistres déclarés.
Exec sysadm.PS_S_NBRE_SIN_SANDRINE

-- JFF pour FS et CBO le 24/02/2016
Exec [sysadm].[Iwd_Queue_Recycler_Etat]

-- Param Soldage à 5 ans (60 mois) si absence de param de soldage, sauf pour PM407 SAGA dp/323
Update p
Set alt_sold = 'O', dur_sold_pc = 24, unt_sold_pc = 'M', maj_le = getdate(), maj_par = 'AUTO' 
From sysadm.produit p
Where p.dur_sold_pc <= 0
And Not Exists ( Select Top 1 1 From sysadm.det_pro dp where dp.id_prod = p.id_prod and id_code_dp = 323 ) 

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL

-- [RS4616_RET_TLS]
Exec sysadm.PS_U_RS4616_MAJ_CMDE_TLS 'TLS', 2

GO

grant execute on sysadm.PS_CORRECTION_BASE_NUIT_1 to rolebddsinistres
Go

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CORRECTION_BASE_NUIT_2' AND type = 'P' )
        DROP procedure sysadm.PS_CORRECTION_BASE_NUIT_2
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure sysadm.PS_CORRECTION_BASE_NUIT_2
--------------------------------------------------------------------
--
-- Procedure            :       PS_CORRECTION_BASE_NUIT_2
-- Auteur               :       Fabry JF
-- Date                 :       08/12/2010
-- Libelle              :       Redressement base au nuit 2
-- Commentaires         :       
-- References           :
--
-- Arguments            :
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
AS

SET NOCOUNT ON

Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'COUPER_ACCES_SIMPA2'

------------------------------------------------------
-- Correction de Reg_Gti			    --
------------------------------------------------------
-- Correction Reg_Gti 1
-- 2 s (hors cache)
-- Chaque heure à 00
-- Curs supprimé, fréquence ramené à 75 minute
Insert into sysadm.reg_gti
Select  r.id_sin,
        r.id_reg,
        d.id_gti,
        d.id_gti,
        r.id_i,
        r.mt_tot_reg,
        r.mt_tot_reg,
        r.cree_le,
        r.maj_le,
        r.maj_par

From    sysadm.reglement r with (nolock),
        sysadm.detail d with (nolock)
where   r.dte_reg >= dateadd ( day, -2, getdate() )
And   	r.cod_mot_reg <> 'RI'
and     d.id_sin = r.id_sin
and     d.id_reg = r.id_reg
and	Not exists
        ( select top 1 1  from sysadm.reg_gti rg with (nolock)
	  where rg.id_sin = r.id_sin
          and   rg.id_reg = r.id_reg )

-- Correction Reg_Gti 2
-- 2 s (hors cache)
-- Chaque heure à 00
Update sysadm.reg_gti
set    id_i = r.id_i
from   sysadm.reglement r with (nolock) ,
       sysadm.reg_gti rg with (nolock)
where  r.id_sin = rg.id_sin
and    r.id_reg = rg.id_reg
and    r.id_i <> rg.id_i
And    r.cree_le >= dateadd ( day, -2, getdate() )


-- Redressement 
update sysadm.commande 
set    cod_etat='RPC', id_lot_cmd = 999995
from   sysadm.sinistre s with (nolock)
where s.id_prod in (5706,5760)
and sysadm.commande.id_sin = s.id_sin
and sysadm.commande.id_four = 'DTY' 
and sysadm.commande.id_typ_art = 'TEL'
and sysadm.commande.cod_etat = 'ECT' 


update sysadm.w_commande 
set cod_etat='RPC'
from sysadm.w_sin s with (nolock)
where s.id_prod in (5706,5760)
and sysadm.w_commande.id_sin = s.id_sin
and sysadm.w_commande.id_four = 'DTY' 
and sysadm.w_commande.id_typ_art = 'TEL'
and sysadm.w_commande.cod_etat ='ECT' 

------------------------------------------------------
-- [PM217-2] FS le 07/02/2014 correction des dossiers restés bloqués
------------------------------------------------------
Update	sysadm.w_queue 
Set		alt_occupe = 'N'
From	sysadm.w_queue wq with (nolock)
Where	wq.alt_occupe = 'O' 
And		wq.trv_maj_le < DATEADD( MINUTE, -30, getdate() )

-- FPI/JFF 16/06/2014, corrige bug sur maj presta.
update sysadm.w_commande 
set id_serie_anc=c.id_serie_anc, 
      id_cmd_frn=c.id_cmd_frn, 
      id_serie_nouv=c.id_serie_nouv, 
      id_bon_transp=c.id_bon_transp, 
      dte_rcp_frn=c.dte_rcp_frn, 
      dte_env_cli=c.dte_env_cli, 
      cod_etat=c.cod_etat, 
      comment_frn=c.comment_frn, 
      maj_le=c.maj_le, 
      dte_ret_pret=c.dte_ret_pret, 
      dte_elv_mobile=c.dte_elv_mobile, 
      status_gc=c.status_gc, 
      dte_emis_devis=c.dte_emis_devis, 
      mt_devis=c.mt_devis, 
      dte_ret_logis=c.dte_ret_logis, 
      dte_ret_pret_min=c.dte_ret_pret_min, 
      dte_ret_pret_max=c.dte_ret_pret_max, 
      dte_env_bte_frn=c.dte_env_bte_frn, 
      dte_rcp_bte_cli=c.dte_rcp_bte_cli, 
      dte_dep_bte_cli=c.dte_dep_bte_cli, 
      dte_env_st=c.dte_env_st, 
      dte_rcp_mob_cli=c.dte_rcp_mob_cli, 
      info_frn_spb_cplt=c.info_frn_spb_cplt
from sysadm.w_commande w with (nolock),
      sysadm.commande c with (nolock)
where w.id_sin=c.id_sin
and w.id_seq=c.id_seq
and w.cod_etat <> 'ANN'
and c.cod_etat <> w.cod_etat

-- Script SBA sur demande de FRED, inclu par JFF le 16/06/2014
Delete sysadm.update_iwd_log 
where 
dte_cmd < DATEADD (week,-3,getdate()) and not exists
( select * from sysadm.w_queue v with (nolock) where v.id_sin = sysadm.update_iwd_log.id_sin )


-- Vdoc16713 - JFF - 20/03/2015
Delete sysadm.autorisation 
from sysadm.autorisation a with (nolock)
where Not exists ( 
		Select Top 1 1
		From SESAME_PRO.sysadm.operateur o with (nolock)
		Where o.id_oper = a.id_oper
		)

Delete sysadm.corb_oper 
from sysadm.corb_oper a with (nolock)
where Not exists ( 
		Select Top 1 1
		From SESAME_PRO.sysadm.operateur o with (nolock)
		Where o.id_oper = a.id_oper
		)

Delete sysadm.consult_restreinte
from sysadm.consult_restreinte c with (nolock)
where Not exists ( 
		Select Top 1 1
		From SESAME_PRO.sysadm.operateur o with (nolock)
		Where o.id_oper = c.id_oper
		)

-- Vdoc16713 - JFF - 20/03/2015

-- Suppression Autorisation si GT n'a plus la Corbeille - JFF - 18/08/2021
Delete a
from sysadm.autorisation a with (nolock)
Where a.id_prod is not null 
And a.id_prod > 0 
And Not exists ( 
	Select Top 1 1
	From sysadm.produit p with (nolock),
			sysadm.corb_oper c with (nolock)
	Where p.id_prod = a.id_prod
	And   c.id_corb = p.id_corb
	And   c.id_oper = a.id_oper 
)

-- Suppression Autorisation si GT a le droit en profil par défaut, pas la peine d'avoir le même droit sur "le produit" - JFF - 18/08/2021
Delete a
from sysadm.autorisation a with (nolock)
Where a.id_prod is not null 
And a.id_prod > 0 
And Exists ( 
		Select Top 1 1 
		From sysadm.autorisation a2	 with (nolock)
		Where a2.id_oper = a.id_oper
		And a2.id_nat_oper = a.id_nat_oper
		And a2.id_prod = -1
	)

-- Suppression Autorisation si GT n'a plus la Corbeille

-- FPI - 27/05/2015 - Correction id_ordre de w_sin
update sysadm.w_sin
set id_ordre=s.id_ordre
from sysadm.w_sin w with (nolock)
inner join sysadm.sinistre s on s.id_sin=w.id_sin
where w.id_ordre is null

-- Redressement des Frais absent de la table frais et présent dans reg_gti
Exec sysadm.PS_T_REDRESS_FRAIS_ABSENT

-- PM234-7 Mantis 22824 JFF 07/12/16
Exec sysadm.PS_I_ERR_TRAVAIL_ABSENT

-- Au moins un grant par jour.
Exec sysadm.PS_X_GRANT

-- Redressement table de param.
update c
set alt_plaf='O'
from sysadm.plafond p with (nolock)
       inner join sysadm.condition c on c.id_prod=p.id_prod and c.id_rev=p.id_rev and c.id_gti=p.id_gti
             and c.id_typ_code=p.id_niv_plaf 
where (p.id_ref_plaf=-1 or p.id_ref_plaf=c.id_code)
       and c.alt_plaf='N'

update c
set alt_del='O'
from sysadm.delai p with (nolock)
       inner join sysadm.condition c on c.id_prod=p.id_prod and c.id_rev=p.id_rev and c.id_gti=p.id_gti
             and c.id_typ_code=p.id_niv_del
where (p.id_ref_del=-1 or p.id_ref_del=c.id_code)
       and c.alt_del='N'

update c
set alt_fran='O'
from sysadm.franchise p with (nolock)
       inner join sysadm.condition c on c.id_prod=p.id_prod and c.id_rev=p.id_rev and c.id_gti=p.id_gti
             and c.id_typ_code=p.id_niv_fra
where (p.id_ref_fra=-1 or p.id_ref_fra=c.id_code)
       and c.alt_fran='N'

-- Redressement des cas ElectroDepot non marqués par KSL
Exec sysadm.PS_U_COUR_CARTE_CADEAU_ELD_KSL_REDRESS

Update sysadm.commande set cod_etat = 'RPC' where id_ref_four = 'A_REPARER_FORCE' and cod_etat = 'ECT' and cree_le > DateAdd ( month, -4, Getdate() )
Update sysadm.w_commande set cod_etat = 'RPC' where id_ref_four = 'A_REPARER_FORCE' and cod_etat = 'ECT' and cree_le > DateAdd ( month, -4, Getdate() )

Update sysadm.commande Set cod_etat = 'RFO' where id_ref_four = 'PEC_A_RECYCLER' and cod_etat = 'ECT' and cree_le > DateAdd ( month, -4, Getdate() )
Update sysadm.w_commande Set cod_etat = 'RFO' where id_ref_four = 'PEC_A_RECYCLER' and cod_etat = 'ECT' and cree_le > DateAdd ( month, -4, Getdate() )

Update sysadm.w_commande Set cod_etat = 'RPC' where id_four = 'OMT' and cree_le > DateAdd ( month, -4, Getdate() ) and id_typ_art = 'CAF' and cod_etat = 'ECT'
Update sysadm.commande Set cod_etat = 'RPC' where id_four = 'OMT' and cree_le > DateAdd ( month, -4, Getdate() ) and id_typ_art = 'CAF' and cod_etat = 'ECT'

Update sysadm.w_queue 
Set nom = sysadm.FN_EPURE_CHAINE_V01 ( nom , 'EXCL_SLASHX2' ),
	txt_mess1 = sysadm.FN_EPURE_CHAINE_V01 ( txt_mess1, 'EXCL_SLASHX2' ),
	txt_mess2 = sysadm.FN_EPURE_CHAINE_V01 ( txt_mess2, 'EXCL_SLASHX2' )

Update sysadm.w_sin 
Set nom = sysadm.FN_EPURE_CHAINE_V01 ( nom , 'EXCL_SLASHX2' ), 
    prenom = sysadm.FN_EPURE_CHAINE_V01 ( prenom , 'EXCL_SLASHX2' ),
	adr_1  = sysadm.FN_EPURE_CHAINE_V01 ( adr_1 , 'EXCL_SLASHX2' ),
	adr_2  = sysadm.FN_EPURE_CHAINE_V01 ( adr_2 , 'EXCL_SLASHX2' ),
	adr_ville = sysadm.FN_EPURE_CHAINE_V01 ( adr_ville , 'EXCL_SLASHX2' ),
	txt_mess = sysadm.FN_EPURE_CHAINE_V01 ( txt_mess , 'EXCL_SLASHX2' )

Update sysadm.w_inter
Set nom = sysadm.FN_EPURE_CHAINE_V01 ( nom , 'EXCL_SLASHX2' ), 
	adr_1  = sysadm.FN_EPURE_CHAINE_V01 ( adr_1 , 'EXCL_SLASHX2' ),
	adr_2  = sysadm.FN_EPURE_CHAINE_V01 ( adr_2 , 'EXCL_SLASHX2' ),
	adr_ville = sysadm.FN_EPURE_CHAINE_V01 ( adr_ville , 'EXCL_SLASHX2' )

Update sysadm.groupe set lib_grp = ltrim (rtrim ( lib_grp ))
Update sysadm.compagnie set lib_cie = ltrim (rtrim ( lib_cie ))
Update sysadm.police set lib_police = ltrim (rtrim ( lib_police))
Update sysadm.code set lib_code = ltrim (rtrim ( lib_code ))
Update sysadm.code_car set lib_code = ltrim (rtrim ( lib_code ))

-- Suite ISM 242201
Exec sysadm.PS_IU_REDRESS_PRS_153_154

-- Cette table doit être vide
Delete sysadm.w_reg_frais_annexe_frn

-- Détecte les objets SQL supprimé de façon malveillante
Exec sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL

-- Nettoyage Corbeille
Exec sysadm.PS_DU_NETTOYAGE_CORBEILLES

-- changement Exe Simulation pour le lendemain
If sysadm.FN_CLE_NUMERIQUE ( 'EXE_TSP8') > 0 
 Begin
	Update SESAME_PRO.sysadm.application Set lib_commande = 'C:\SPB\S_FR_APP_Simpa2_main_121.EXE' where id_appli = 'TSP8'
 End
Else
 Begin
	Update SESAME_PRO.sysadm.application Set lib_commande = 'C:\SPB\P_FR_APP_Simpa2_main_121.EXE' where id_appli = 'TSP8'
 End

GO

grant execute on sysadm.PS_CORRECTION_BASE_NUIT_2 to rolebddsinistres
Go
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ADRESSE_CENTRALE_PSM
-- Auteur               :       Fabry JF
-- Date                 :       29/04/2010
-- Libelle              :       [PM200][PSM]
-- Commentaires         :       Renvoi la bonne adresse PSM en fonction du contexte.
-- References           :       !!!! voir pour toute modif n_cst_cmd_commun::uf_GetAdresseO2M !!!!
--
-- Arguments            :       
--
-- Retourne             :       
--
-- JFF	  15/06/2010    [PC419/440/418/439_MICROMANIA] demandé par Lisette et Eric Remy
-------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726] Remplacement de "And b.id_boutique = Convert ( integer, @sCodeBtqPSM_Centrale )"
--       JFF    26/11/2012  [PC877]
--     JFF  16/10/2013 [PC801_LOT1_V5]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ADRESSE_CENTRALE_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_S_ADRESSE_CENTRALE_PSM
GO

CREATE procedure sysadm.PS_S_ADRESSE_CENTRALE_PSM
   	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@sCodMag	Varchar (20),
   	@asCas		VarChar ( 35 ),
	@asNomLigne1	VarChar ( 35 ) OUTPUT,
	@asNomLigne2	VarChar ( 35 ) OUTPUT,
	@asAdrLigne1	VarChar ( 40 ) OUTPUT,	
	@asAdrLigne2	VarChar ( 40 ) OUTPUT,		
	@asCP		VarChar ( 35 ) OUTPUT,
	@asVille	VarChar ( 35 ) OUTPUT				
AS

Declare @iRet	Integer
Declare @sCodeBtqPSM_Centrale VarChar ( 255 )
Declare @dcIdProd Decimal ( 7 ) 

Set @iRet = -1
Set @asNomLigne1= '' 
Set @asNomLigne2= '' 
Set @asAdrLigne1= ''
Set @asAdrLigne2= ''
Set @asCP= ''
Set @asVille= ''

-- Adresse réélle, standard, complète
If @asCas = 'COMPLETE'
	Begin 
		Set @asNomLigne1 = ''
		Set @asAdrLigne1 = ''
		Set @asAdrLigne2 = ''
		Set @asCP = ''
		Set @asVille = ''
		Return
	End 

If @asCas = 'GENERATION'
	Begin 
		Select  Top 1 @sCodeBtqPSM_Centrale = rTrim ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', c.info_spb_frn_cplt, ';' ) ),
					  @dcIdProd = s.id_prod
		From 	sysadm.commande c, 
				sysadm.sinistre s
		Where   c.id_sin = @dcIdSin
		And	c.id_typ_art = 'PRS'
		And	c.cod_etat in ( 'CNV', 'ECT' )
		And s.id_sin = c.id_sin
	End 

If @asCas = 'MAIL' 
	Begin
		Select  Top 1 @sCodeBtqPSM_Centrale = rTrim ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_CENTRALE', c.info_spb_frn_cplt, ';' ) ),
					  @dcIdProd = s.id_prod
		From 	sysadm.w_commande c, 
				sysadm.sinistre s
		Where   c.id_sin = @dcIdSin
		And	c.id_typ_art = 'PRS'
		And	c.cod_etat in ( 'CNV', 'ECT' )
		And s.id_sin = c.id_sin
	End 

If @asCas = 'SEL_BOUTIQUE'
	Begin
		Set @sCodeBtqPSM_Centrale=@sCodMag
		
		Select @dcIdProd=id_prod 
		From sysadm.w_sin w
		Where w.id_sin = @dcIdSin
	End
	
If @sCodeBtqPSM_Centrale is not null And @sCodeBtqPSM_Centrale <> '' 
 Begin
    Select @asNomLigne1 = b.adr_nom,
    	   @asNomLigne2 = '' ,
           @asAdrLigne1 = b.adr_1,
    	   @asAdrLigne2 = b.adr_2,
           @asCP        = b.adr_cp,
           @asVille     = b.adr_ville
    From   sysadm.boutique b
    Where  b.id_prod = @dcIdProd
	-- [VDoc7726]
	    And isNumeric(b.cod_mag)=1 -- [ITSM171587]
		And Convert ( integer, b.cod_mag ) = Convert ( integer, @sCodeBtqPSM_Centrale )
      And sysadm.FN_CLE_VAL( 'FRN',b.region,  ';') = 'PSM'
		
 End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MARQUE_TEL
-- Auteur               :       Fabry JF
-- Date                 :       12/11/2012
-- Libelle              :       [NRJ12] pour F.Bouchet
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MARQUE_TEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MARQUE_TEL
GO

CREATE procedure sysadm.PS_S_MARQUE_TEL
AS

Select distinct marque 
from sysadm.ifr i
where i.id_trait = 
	(Select max (id_trait) 
	 from  sysadm.ifr i2
	 where i2.marque = i.marque
	 And   i2.reference = i.reference )

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_MODELE_TEL
-- Auteur               :       Fabry JF
-- Date                 :       12/11/2012
-- Libelle              :       [NRJ12] pour F.Bouchet
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MODELE_TEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MODELE_TEL
GO

CREATE procedure sysadm.PS_S_MODELE_TEL
@sMarque 	varchar(50)
AS


select reference
from sysadm.ifr i
where i.id_trait = 
	(Select max (id_trait) 
	 from  sysadm.ifr i2
	 where i2.marque = i.marque
	 And   i2.reference = i.reference )
and i.marque = @sMarque 
And   Abs ( DateDiff ( Month, '01/' + SubString ( Convert ( Varchar ( 10 ), id_trait ),5,2 ) + '/' + SubString ( Convert ( Varchar ( 10 ), id_trait ),1,4 ), getdate() ) ) <= 18

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ADRESSE_PSM_PM234
-- Auteur               :       Fabry JF
-- Date                 :       04/09/2014
-- Libelle              :       [PM234]
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ADRESSE_PSM_PM234' AND type = 'P' )
        DROP procedure sysadm.PS_S_ADRESSE_PSM_PM234
GO

CREATE procedure sysadm.PS_S_ADRESSE_PSM_PM234
   	@dcIdProd		Decimal ( 7 ),
	@sCodMag	Varchar (20),
	@asNomLigne1	VarChar ( 35 ) OUTPUT,
	@asNomLigne2	VarChar ( 35 ) OUTPUT,
	@asAdrLigne1	VarChar ( 35 ) OUTPUT,	
	@asAdrLigne2	VarChar ( 35 ) OUTPUT,		
	@asCP		VarChar ( 35 ) OUTPUT,
	@asVille	VarChar ( 35 ) OUTPUT				
AS

Declare @iRet Integer

Set @iRet = 1

Set @asNomLigne1= '' 
Set @asNomLigne2= '' 
Set @asAdrLigne1= ''
Set @asAdrLigne2= ''
Set @asCP= ''
Set @asVille= ''

Select @asNomLigne1 = b.adr_nom,
	   @asNomLigne2 = '' ,
       @asAdrLigne1 = b.adr_1,
	   @asAdrLigne2 = b.adr_2,
       @asCP        = b.adr_cp,
       @asVille     = b.adr_ville
From   sysadm.boutique b
Where  b.id_prod = @dcIdProd
	And b.cod_mag = @sCodMag
    And sysadm.FN_CLE_VAL( 'FRN',b.region,  ';') = 'PSM'

If @@ROWCOUNT <> 1 Set @iRet = -1

Return @iRet

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_REDRESSEMENT_VDOC15650
-- Auteur               :       Fabry JF
-- Date                 :       19/11/2014
-- Libelle              :       [VDOC15650]
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_REDRESSEMENT_VDOC15650' AND type = 'P' )
        DROP procedure sysadm.PS_REDRESSEMENT_VDOC15650
GO

CREATE procedure sysadm.PS_REDRESSEMENT_VDOC15650

As

	Declare @dtDeb DateTime
	Declare @dcIdSin Decimal (10) -- [PI062]
	Declare @iNbre integer


	DECLARE @sMessage    Varchar(1000),
		    @sObjet      VarChar(255),
		    @sRetourErrMail VarChar(255)
	
	Set @dtDeb = GetDate()
	Set @iNbre = 0

--	While DATEDIFF ( second , @dtDeb, GETDATE() ) <= 10
	While DATEDIFF ( MINUTE , @dtDeb, GETDATE() ) <= 360
	 Begin
		Select @dcIdSin = MIN ( id_sin )
		From  sysadm.sinistre s
		Where s.cree_le > '01/01/2013'
		And   Not exists ( 
				Select	Top 1 1
					From	sysadm.div_sin ds
					Where	ds.id_sin = s.id_sin
					And		nom_zone = 'etat_vu_assure'
			  )	 
		
		-- [VDOC15650]
		If @dcIdSin is not null
		  Begin
			Begin tran
			Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'SQL'
			Commit tran
			Set @iNbre = @iNbre + 1
		  End 
	End

	Set @sObjet    = 'Traitement redressement vDoc15650'
	set @sMessage  = sysadm.FN_AFF_DATE ( @dtDeb, 'AVEC_HEURE') 
	set @sMessage  = @sMessage + CHAR ( 10 ) + sysadm.FN_AFF_DATE ( GETDATE(), 'AVEC_HEURE') + '.'
	set @sMessage  = @sMessage + CHAR ( 10 ) + CONVERT ( varchar ( 10), IsNull ( @iNbre , 0 )) + ' dossier(s) a(ont) été traité(s)'
	set @sMessage  = @sMessage + CHAR ( 10 ) + 'Quand le compteur restant sera à 0, il faudra supprimer le job SQL <<SIMPA2_PRO : maj code état assuré>> et la table trace_etat_ass'

		Select @iNbre = COUNT(*)
		From  sysadm.sinistre s
		Where s.cree_le > '01/01/2013'
		And   Not exists ( 
				Select	Top 1 1
					From	sysadm.div_sin ds
					Where	ds.id_sin = s.id_sin
					And		nom_zone = 'etat_vu_assure'
			  )	 
	set @sMessage  = @sMessage + CHAR ( 10 ) + CHAR ( 10 ) 
	set @sMessage  = @sMessage + 'Reste ' + CONVERT ( varchar ( 10), IsNull ( @iNbre, 0 ) ) + ' dossier(s) a traiter.'


	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_REDRESSEMENT_VDOC15650_2
-- Auteur               :       Fabry JF
-- Date                 :       19/11/2014
-- Libelle              :       [VDOC15650]
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_REDRESSEMENT_VDOC15650_2' AND type = 'P' )
        DROP procedure sysadm.PS_REDRESSEMENT_VDOC15650_2
GO

CREATE procedure sysadm.PS_REDRESSEMENT_VDOC15650_2

As

	Set Transaction Isolation level Read UnCommitted

If Not ( sysadm.FN_CLE_NUMERIQUE ( 'REDR_AUTO_ETAT_VU_AS') > 0 ) Return

	-- Si le traitement doit tourner une seule fois ou chaque nuit
	Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'REDR_AUTO_ETAT_VU_AS'

	Declare @dtLancTrt DateTime
	Declare @dtDeb DateTime
	Declare @dcIdSin Decimal (10)
	Declare @iNbre integer

	DECLARE @tb TABLE 
		( id_sin	decimal (10 ),
		  marquage	integer null 
		)

	DECLARE @sMessage    Varchar(1000),
		    @sObjet      VarChar(255),
		    @sRetourErrMail VarChar(255)
	
	Set @dtLancTrt = GetDate()
	Set @dtDeb = '01/01/2013'
	Set @iNbre = 0

	/*
	-- Cas1
	Insert into @tb
	Select Top 800000
		   s.id_sin, 0
	From  sysadm.sinistre s
	Where s.valide_le between @dtDeb and @dtLancTrt
	And   Not exists ( 
			Select	Top 1 1
				From	sysadm.vDoc15650_2 ds
				Where	ds.id_sin = s.id_sin
			)	 

	-- Cas2 
	Insert into @tb
	Select distinct 
		   c.id_sin, 0
	from sysadm.commande c where id_four = 'BLC' and id_ref_four = 'A_DIAGNOSTIQUER' and status_gc in ( 2, 21 )
	*/

	Insert into @tb
	Select distinct 
		   r.id_sin, 0
	from sysadm.commande c1,
		 sysadm.reglement r,
		 sysadm.reg_gti rg
	Where 
		  ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI' 
			 Or 
			sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI' )
	And c1.status_gc = 21
	And  r.id_sin = c1.id_sin
	And	 r.cod_inter = 'A'
	And	 r.cod_mot_reg = 'RN'
	And	 rg.id_sin = r.id_sin
	And  rg.id_reg = r.id_reg
	And  rg.id_gti > 0 
	And  r.cree_le > '01/01/2013'

--	While DATEDIFF ( second , @dtLancTrt, GETDATE() ) <= 21600
--	While DATEDIFF ( MINUTE , @dtLancTrt, GETDATE() ) <= 360
	While Exists ( Select Top 1 1 From @tb where marquage = 0 )
	 Begin
		Select Top 1 @dcIdSin = id_sin
		From @tb
		Where marquage = 0		
		
		-- [VDOC15650]
		If @dcIdSin is not null
		  Begin
			Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'SQL'

			/*
			If Not Exists ( Select Top 1 1 From sysadm.vDoc15650_2 Where id_sin = @dcIdSin ) 
			  Begin
				Insert into sysadm.vDoc15650_2 values ( @dcIdSin )
			  End 
			*/

			Set @iNbre = @iNbre + 1
		  End 

		Update @tb
		Set marquage = 1
		Where id_sin = @dcIdSin
	End

	/*
	set @sMessage  = sysadm.FN_AFF_DATE ( @dtLancTrt, 'AVEC_HEURE') 
	set @sMessage  = @sMessage + CHAR ( 10 ) + sysadm.FN_AFF_DATE ( GETDATE(), 'AVEC_HEURE') + '.'
	set @sMessage  = @sMessage + CHAR ( 10 ) + CONVERT ( varchar ( 10), IsNull ( @iNbre , 0 )) + ' dossier(s) a(ont) été traité(s)'
	set @sMessage  = @sMessage + CHAR ( 10 ) + 'Quand le compteur restant sera à 0, il faudra désactiver le job SQL <<SIMPA2_PRO : maj code état assuré>> et la table vDoc15650_2 et la clé REDR_AUTO_ETAT_VU_AS'

		Select @iNbre = COUNT(*)
		From  sysadm.sinistre s
		Where s.valide_le between @dtDeb and @dtLancTrt
		And   Not exists ( 
				Select	Top 1 1
					From	sysadm.vDoc15650_2 ds
					Where	ds.id_sin = s.id_sin
				)	 

	set @sMessage  = @sMessage + CHAR ( 10 ) + CHAR ( 10 ) 
	set @sMessage  = @sMessage + 'Reste ' + CONVERT ( varchar ( 10), IsNull ( @iNbre, 0 ) ) + ' dossier(s) a traiter.'
	*/

	Set @sObjet = 'Fin redressement Thibault'
	Set @sMessage = 'Fin redressement Thibault'

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL

	

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CPT_SIN_RESTANT
-- Auteur               :       JFF
-- Date                 :       19/12/2014
-- Libelle              :       Calcul le compteur sinistre restant de SIMPA2
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CPT_SIN_RESTANT' AND type = 'P' )
        DROP procedure sysadm.PS_S_CPT_SIN_RESTANT
GO

CREATE procedure sysadm.PS_S_CPT_SIN_RESTANT
As

Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )

If Convert(  Integer, Datepart ( day, CONVERT (varchar ( 10), getdate(), 103 ) )) <> 1
  Begin
	Return
  End

/*
Select count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le)
From sinistre s
Where s.cree_le between DATEADD ( month, -4, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le )
Order by 2, 3
*/

Declare @dcResultat Decimal ( 13, 10 )
Declare @dcAnnRestante Integer
Declare @dcMoisRestant Integer
Declare @dcJourRestant Integer

Select  @dcResultat =
		( 
			( 9999999 - MAX ( id_sin ) ) /
			(
			Select ( count(*) / 4 ) 
			From sinistre s
			Where s.cree_le between DATEADD ( month, -4, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
							And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) + ' 23:59' )
			 )
		)
		/
		12
from sinistre 

Set @dcAnnRestante = @dcResultat  

Set @dcResultat = @dcResultat - @dcAnnRestante 
Set @dcResultat = @dcResultat * 12

Set @dcMoisRestant = @dcResultat 

Set @dcResultat = @dcResultat - @dcMoisRestant 
Set @dcResultat = @dcResultat * 30

Set @dcJourRestant = @dcResultat 

/*
Set @sObjet = 'PI062 : Compteur de sinistre SIMPA2 : '
Set @sObjet = @sObjet +  
				'Reste ' + CONVERT ( VarChar (10) , @dcAnnRestante ) + ' ans, ' + 
						   CONVERT ( VarChar (10) , @dcMoisRestant ) + ' mois, ' + 
						   CONVERT ( VarChar (10) , @dcJourRestant ) + ' jours'

Set @sMessage = 'Bonjour, '
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'La définition des zones pouvant stocker les numéros de sinistre SIMPA2 étant dans toutes les tables SIMPA2, PS SQL, programmes PB,etc... sur 7 positions, '
Set @sMessage = @sMessage + '(parce que le soft a été pensé ainsi par ses concepteurs en 1998), en l''état actuel des choses, la valeur maximale de sinistre est de 9 999 999.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Sans modification, et suivant une formule mathématique sur le taux de déclarations de sinistres des quatre derniers mois, à l''heure d''aujourd''hui, il reste ' 
Set @sMessage = @sMessage + CONVERT ( VarChar (10) , @dcAnnRestante ) + ' ans, ' + 
						   CONVERT ( VarChar (10) , @dcMoisRestant ) + ' mois, et ' + 
						   CONVERT ( VarChar (10) , @dcJourRestant ) + ' jours '
Set @sMessage = @sMessage + 'avant un arrêt net de l''application SIMPA2 si un Projet Informatique (PI) n''est pas engagé d''ici là.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Cette échance est dynamique (puisque calculée) et pourrait éventuellement s''éloigner si les déclarations baissent sur les quatre dernier mois glissants.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Je sais exactement tout ce qu''il faut modifier et comment le modifier, il me faut juste du temps pour le faire.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Vous recevrez ce mail chaque 1er du mois afin que ce danger, qui est encore lointain, reste tout de même une alerte.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Si vous souhaitez voir des données supplèmentaires dans ce mail, contactez-moi.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Cordialement,'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Fabry Jean-François'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'


EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
--		'jff@spb.fr',
		'ras@spb.fr,ffoutel@spb.fr,jff@spb.fr,jkuster@spb.fr',
		@sMessage, 
		@sObjet, 
		'Compteur SIMPA2', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
*/

Set @sObjet = 'PI062 : Compteur de sinistre SIMPA2 : '
Set @sObjet = @sObjet +  
				'Reste ' + CONVERT ( VarChar (10) , @dcAnnRestante ) + ' ans, ' + 
						   CONVERT ( VarChar (10) , @dcMoisRestant ) + ' mois, ' + 
						   CONVERT ( VarChar (10) , @dcJourRestant ) + ' jours'

Set @sMessage = 'Bonjour, '
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Il reste ' 
Set @sMessage = @sMessage + CONVERT ( VarChar (10) , @dcAnnRestante ) + ' ans, ' + 
						   CONVERT ( VarChar (10) , @dcMoisRestant ) + ' mois, et ' + 
						   CONVERT ( VarChar (10) , @dcJourRestant ) + ' jours '
Set @sMessage = @sMessage + 'avant l''échéance du sinistre numéro 9 999 999 sur SIMPA2'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Cordialement,'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Fabry Jean-François'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'


EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'jff@spb.fr',
--		'jff@spb.fr,fs@spb.fr,ilg@spb.fr,flefaucheur@spb.fr,svrigneau@spb.fr,qdionis@spb.fr,sbarthelemy@spb.fr',
		@sMessage, 
		@sObjet, 
		'Compteur SIMPA2', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL

Go

grant execute on sysadm.PS_S_CPT_SIN_RESTANT to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_VERIF_REV_SVN
-- Auteur               :       JFF
-- Date                 :       05/02/2015
-- Libelle              :       PS_S_VERIF_REV_SVN
-- Commentaires         :       
-- References           :       Contrôle que lé révision SVN de SIMPA2 ne soit pas une révision obsolète.
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VERIF_REV_SVN' AND type = 'P' )
        DROP procedure sysadm.PS_S_VERIF_REV_SVN
GO

CREATE procedure sysadm.PS_S_VERIF_REV_SVN
	@aiRevSvn	Integer,
	@asCodOper	VarChar ( 4 ),
	@asChaine   VarChar ( 255 )
As

Declare @iMaxRevSvn Integer
Declare @iMinRecSvn Integer

If @aiRevSvn is null Return 0 -- Ok
If @aiRevSvn <=0 Return 0 -- Ok

Select	@iMaxRevSvn = MAX ( revsvn ) 
From	sysadm.trace_revsvn

If @iMaxRevSvn is null Set @iMaxRevSvn = 0

-- Existe, donc ok, on ressort
If Exists ( 
		Select Top 1 1
		From   sysadm.trace_revsvn
		Where  revsvn = @aiRevSvn
	)
	Begin
		Return 0 -- Ok
	End 

-- N'existe pas, par rev plus grande que la max présente, donc on insère	
If 	@aiRevSvn > @iMaxRevSvn
  Begin
	Insert into sysadm.trace_revsvn values ( @aiRevSvn, GETDATE(), GETDATE(), @asCodOper )
  End 
Else
  -- Rev svn inférieur au max ET n'existe pas dans la table => Rejet
  Begin
	Return -1 -- Ko Rev Obsolète
  End 

-- Maintenance à 3 rev max.
If ( Select COUNT (*) From sysadm.trace_revsvn ) >= 6 
  Begin
	Select @iMinRecSvn = MIN ( revsvn ) From sysadm.trace_revsvn
	Delete sysadm.trace_revsvn Where revsvn <= @iMinRecSvn 
  End 
	 
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CONSULT_RESTREINTE
-- Auteur               :       JFF
-- Date                 :       05/02/2015
-- Libelle              :       [CONSULT_RESTREINTE]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONSULT_RESTREINTE' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONSULT_RESTREINTE
GO


CREATE procedure sysadm.PS_S_CONSULT_RESTREINTE
	@sCodOper	VarChar ( 4 ),
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@sChaine	VarChar ( 255 )
As

Declare @dcIdCie	Decimal ( 7 )

If @dcIdSin	is null 
 Begin
	If Exists ( 
		Select	Top 1 1
		From	sysadm.consult_restreinte
		Where   id_oper = @sCodOper
	)	
	 Begin
		Return -1
	 End 
	Else
	 Begin
		Return 1	 
	 End 
 End 



If Not Exists ( 
	Select	Top 1 1
	From	sysadm.consult_restreinte
	Where   id_oper = @sCodOper
	)
	Begin
		Return 1
	End 

If Not Exists ( 
	Select  Top 1 1
	From	sysadm.sinistre s,
			sysadm.garantie g,
			sysadm.police p,
			sysadm.consult_restreinte cr
			
	Where	s.id_sin = @dcIdSin
	And		g.id_prod = s.id_prod
	And		( g.id_rev = s.id_rev or s.id_rev = -1 )
	And		p.id_police = g.id_police
	And		p.id_cie = cr.id_cie
	And		cr.id_oper = @sCodOper
	)
	Begin
		Return -1
	End 

Return 1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_RECUP_ADRESSE_FRN
-- Auteur               :       JFF
-- Date                 :       20/02/2015
-- Libelle              :       [PM283]
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECUP_ADRESSE_FRN' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECUP_ADRESSE_FRN
GO


CREATE procedure sysadm.PS_S_RECUP_ADRESSE_FRN
	@adcIdSin	  Decimal ( 10 ), -- [PI062]
	@asNomLigne1	VarChar ( 35 ) OUTPUT,
	@asNomLigne2	VarChar ( 35 ) OUTPUT,
	@asAdrLigne1	VarChar ( 35 ) OUTPUT,	
	@asAdrLigne2	VarChar ( 35 ) OUTPUT,		
	@asCP		VarChar ( 35 ) OUTPUT,
	@asVille	VarChar ( 35 ) OUTPUT,
	@asRetour	VarChar ( 50 ) OUTPUT

AS

Declare @iPrestaO2M Integer
Declare @iPrestaPSM Integer

Set @iPrestaO2M = 0
Set @iPrestaPSM = 0

Set @asRetour = 'OK'

If Exists ( 
		Select	Top 1 1 
		From	sysadm.commande c
		Where	c.id_sin = @adcIdSin
		And		c.id_four = 'O2M'
		And		c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER' )
		And		c.cod_etat = 'ECT'
	)
	Begin
		Set @iPrestaO2M = 1
	End


If Exists ( 
		Select	Top 1 1 
		From	sysadm.commande c
		Where	c.id_sin = @adcIdSin
		And		c.id_four = 'PSM'
		And		c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' )
		And		c.cod_etat = 'ECT'
	)
	Begin
		Set @iPrestaPSM = 1
	End

If @iPrestaO2M > 0 And @iPrestaPSM > 0 
	Begin
		Set @asRetour = 'Presta O2M&PSM présentes, impossible de déterminer l''adresse'
		Return
	End 

If @iPrestaO2M <= 0 And @iPrestaPSM <= 0 
	Begin
		Set @asRetour = 'Aucune presta O2M ou PSM présente, impossible de déterminer l''adresse'
		Return
	End 


If @iPrestaO2M > 0 
    Begin
		Exec sysadm.PS_S01_ADRESSE_O2M_V01
   			@adcIdSin,
   			'GENERATION',
			@asNomLigne1 OUTPUT,
			@asNomLigne2 OUTPUT,
			@asAdrLigne1 OUTPUT,	
			@asAdrLigne2 OUTPUT,		
			@asCP		 OUTPUT,
			@asVille	 OUTPUT				
    End 

If @iPrestaPSM > 0 
    Begin
		Exec sysadm.PS_S_ADRESSE_CENTRALE_PSM
   			@adcIdSin,
			null,
   			'GENERATION',
			@asNomLigne1 OUTPUT,
			@asNomLigne2 OUTPUT,
			@asAdrLigne1 OUTPUT,	
			@asAdrLigne2 OUTPUT,		
			@asCP		 OUTPUT,
			@asVille	 OUTPUT				
	End
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_CONTROLE_VERSION_CLUSTER
-- Auteur               :       Fabry JF
-- Date                 :       02/10/2015
-- Libelle              :		Contrôle le version de simpa2 sur les cluster
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONTROLE_VERSION_CLUSTER' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONTROLE_VERSION_CLUSTER
GO

CREATE procedure sysadm.PS_S_CONTROLE_VERSION_CLUSTER

As 

DECLARE @tb TABLE 
	( id_seq integer identity,
	  dtDteDernCnx VarChar ( 10 ),
	  id_appli	Varchar ( 10 ),
	  iRevSvn 	integer,
	  iNbreCnx   integer
	)

Insert @tb Exec sysadm.PS_L_CLE 'SVN'

Declare	@DteDernCnx Varchar ( 10 ),
		@Appli		Varchar ( 10 ),
		@RevSvn 	integer,
		@NbreCnx	integer,
		@iCpt		integer,
		@iCount		integer,
		@sChaine    VarChar ( 1500 )

Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @NbreFoisSupAn Integer -- Nbre de fois supérieur à 'n'

Set @NbreFoisSupAn = 0

Select @iCount = Count (* )
From 
	(
	Select dtDteDernCnx,
		   id_appli,
		   iRevSvn
	From   @tb
	Where Convert ( VarChar ( 10), GETDATE (), 112 ) = dtDteDernCnx
	And   id_appli = 'SIM8'
	) as t

If @iCount <= 1 Return

Select	@iCount = count (*) 
From	@tb 
where	dtDteDernCnx = Convert ( VarChar ( 10), GETDATE (), 112 ) 

Set @iCpt = 1
Set @sChaine = ''

While @iCpt <= @iCount
 Begin
	Set @DteDernCnx = null
 
	Select 	
		@DteDernCnx = dtDteDernCnx ,
		@Appli		= id_appli	,
		@RevSvn 	= iRevSvn 	,
		@NbreCnx	= iNbreCnx	
	From	@tb
	Where	id_seq = @iCpt
	And		id_appli = 'SIM8'

	If @DteDernCnx is null
	  Begin 
		Set @iCpt = @iCpt + 1
		Continue
	  End 
	Select @sChaine = @sChaine + @DteDernCnx + '         | ' + @Appli + '                  | ' + Convert ( VarChar ( 10 ), @RevSvn ) + '                           | ' + Convert ( VarChar ( 10 ), @NbreCnx ) + Char ( 10 )

	If @NbreCnx > 10 
	  Begin
		Set @NbreFoisSupAn = @NbreFoisSupAn + 1
	  End 

	Set @iCpt = @iCpt + 1

 End

Set @sObjet = 'Problème version SIMPA2 sur les Cluster/TS'

Set @sMessage = 'Bonjour,' + Char ( 10 ) + Char ( 10 )
Set @sMessage = @sMessage + 'Un ou plusieurs TS/SERVER n''ont été servis par la recopie des livrables (EXE) PowerBuilder cette nuit.' + Char ( 10 ) + Char ( 10 )
Set @sMessage = @sMessage + 'Date Dern Cnx | SIMPA2	| Révision EXE SIMPA2 | Nbre User dessus' + Char ( 10 )
Set @sMessage = @sMessage + @sChaine + Char ( 10 ) + Char ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Cordialement,'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Fabry Jean-François'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'


EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'jff@spb.fr',
		@sMessage, 
		@sObjet, 
		'jff@spb.fr', 
		'', 
		NULL, 
		NULL, 
		NULL, 
		NULL, 
		NULL

If @NbreFoisSupAn >= 2 
  Begin

	Set @sObjet = 'Problème version SIMPA2 sur les Cluster/TS'

	Set @sMessage = @sChaine

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr,GG_DSI-DO-INFRA-SERVEUR@spb.eu,fs@spb.fr,cbo@spb.eu',
			@sMessage, 
			@sObjet, 
			'jff@spb.fr', 
			'', 
			NULL, 
			NULL, 
			NULL, 
			NULL, 
			NULL
	  End 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_CONTROLE_DISKIO_CPUTIME
-- Auteur               :       Fabry JF
-- Date                 :       02/10/2015
-- Libelle              :		Contrôle les Disk I/O et CPUTIME
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONTROLE_DISKIO_CPUTIME' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONTROLE_DISKIO_CPUTIME
GO

CREATE procedure sysadm.PS_S_CONTROLE_DISKIO_CPUTIME
@Cas VarChar ( 20 )
As 

/*
Declare @Cas VarChar ( 20 )
Set @Cas = 'Disk_IO'
--Set @Cas = 'CPU_Time'
*/
	DECLARE @tb TABLE 
		( id_seq integer identity,
		  spid1	 integer,
		  status  VarChar ( 100 ),
		  login   VarChar ( 100 ),
		  hostname VarChar ( 100 ),
		  blkby   VarChar ( 100 ),
		  dbname  VarChar ( 100 ),
		  command VarChar ( 100 ),
		  cputime integer,
		  diskio integer,
		  lastbatch VarChar ( 100 ),
		  programname VarChar ( 200 ),
		  spid2	 integer,
		  requestid integer
		)

	Declare	@iDiskIoMax Integer,
			@iCPUTimeMax Integer,
			@iCountDiskIO Integer,
			@iCountCPUTIME Integer,
			@sLibCle VarChar (100 )

	Select @sLibCle = Replace ( c.lib_cle, 'PERM : ', '' )
	From   sysadm.cle c
	Where  c.id_cle = 'CTRLE_DISKIO_CPUTIME'

	Set @iDiskIoMax = Convert ( Integer, sysadm.FN_CLE_VAL ( 'DISK_IO', @sLibCle, ';' ) )
	Set @iCPUTimeMax = Convert ( Integer, sysadm.FN_CLE_VAL ( 'CPUTIME', @sLibCle, ';' ) )

	Insert @tb Exec sp_who2

	If @Cas = 'Disk_IO' 
	 Begin
		Select @iCountDiskIO = COUNT(*) 
		From   @tb
		Where  diskio > @iDiskIoMax
		And    login   not in ( 'sql_genesys' )
		And    Not ( login = 'sa' And lower (status) = 'background' )
		And    lower (status) in ( 'running', 'runnable', 'background' )
		/*
		And    login   not in ( 'sql_genesys', 'sa', 'sqluser_linked_server_SIM' )
		And    lower (status)  in ( 'running', 'runnable', 'background' )
		*/
		
		If @iCountDiskIO <= 0 Return 0

		Select *
		From   @tb
		Where  diskio > @iDiskIoMax
		Order  by diskio Desc
		
		Return 1
		
	 End

	If @Cas = 'CPU_Time'
	 Begin
		Select @iCountCPUTIME = COUNT(*) 
		From   @tb
		Where  cputime > @iCPUTimeMax
		And    login   not in ( 'sql_genesys' )
		And    Not ( login = 'sa' And lower (status) = 'background' )
		And    lower (status) in ( 'running', 'runnable', 'background' )
		
		If @iCountCPUTIME <=0 Return 0
		
		Select *
		From   @tb
		Where  cputime > @iCPUTimeMax
		Order  by cputime Desc
		
		Return 1
	 End


Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_CONTROLE_DISKIO_CPUTIME_MAIL
-- Auteur               :       Fabry JF
-- Date                 :       02/10/2015
-- Libelle              :		Contrôle les Disk I/O et CPUTIME
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CONTROLE_DISKIO_CPUTIME_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S_CONTROLE_DISKIO_CPUTIME_MAIL
GO

CREATE procedure sysadm.PS_S_CONTROLE_DISKIO_CPUTIME_MAIL
As

DECLARE @sCommande   VarChar(250),
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
		@iCpt	Integer,
		@sParam VarChar(30),
		@iRet Integer,
        @dtTrt   DATETIME,
        @sdtTrt  VARCHAR(25),
        @shrTrt  VARCHAR(25)

Declare @sHeure VarChar( 15)
Declare @iHeure Integer

If sysadm.FN_CLE_NUMERIQUE ( 'CTRLE_DISKIO_CPUTIME') <= 0 Return

Set @sHeure = Convert ( VarChar ( 10), GETDATE (), 108 )
Set @sHeure = Substring ( @sHeure , 1, charIndex ( ':', @sHeure ) - 1 )
Set @iHeure = Convert ( Integer, @sHeure )		

-- Donc strict supé à 22h ou entre 0 et 7 => arrêt
If @iHeure > 21 Or @iHeure between 0 and 6 Return

-- chemin d'enregistrement du Result Set
Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Extraction_DiskIo_CPUTime\'
Set @sFileName	= 'Extraction_DiskIo_CPUTime_' 
Set @sFileExt	= 'xls'

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'
Set @iCpt = 1

While @iCpt <= 2
 Begin 

	If @iCpt = 1 Set @sParam = 'Disk_IO'
	If @iCpt = 2 Set @sParam = 'CPU_Time'

	SET @dtTrt              = GETDATE()
	SET @sdtTrt             = REPLACE(CONVERT(CHAR(10), @dtTrt, 103), '/', '') 
							  + '_' 
							  + Replace(CONVERT(varchar(20),@dtTrt,114),':','')
	Set @shrTrt             = convert(varchar(8), getdate(),14)

	SET @sFicOut = @sPath + @sFileName + @sdtTrt + CONVERT ( VarChar ( 1 ), @iCpt ) + '.' + @sFileExt


	Exec @iRet = sysadm.PS_S_CONTROLE_DISKIO_CPUTIME @sParam 
	
	If @iRet <= 0
	 Begin
	  Set @iCpt = @iCpt + 1		
	  Continue
	 End

	SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			DB_NAME(db_id()) + '.sysadm.PS_S_CONTROLE_DISKIO_CPUTIME ' + '''' + @sParam + '''' + 
			'" /o' + @sFicOut + ' -W -w5000 ' + @sOsqlOption

	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


	If @iCpt = 1 
	  Begin
		Set @sObjet = 'Alerte Disk I/O élevé, risque de ralentissement à ' + @shrTrt
		set @sMessage  = 'Ci-joint le relevé des Disk I/O au moment du déclenchement de l''alerte à ' + @shrTrt
	  End

	If @iCpt = 2 
	  Begin
		Set @sObjet = 'Alerte CPU Time élevé, risque de ralentissement à ' + @shrTrt
		set @sMessage  = 'Ci-joint le relevé des CPU Time au moment du déclenchement de l''alerte à ' + @shrTrt
	  End

	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter DEI.'
	END

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr,fpinon@spb.eu',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
			
	Set @iCpt = @iCpt + 1		
		
 End

Go

grant execute on sysadm.PS_S_CONTROLE_DISKIO_CPUTIME_MAIL to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_CPS
-- Auteur               :       Fabry JF
-- Date                 :       02/10/2015
-- Libelle              :		Copie d'un dossier de la production vers la sim.
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer
--					  
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CPS' AND type = 'P' )
        DROP procedure sysadm.PS_CPS
GO

CREATE procedure sysadm.PS_CPS
	@dcIdsin Decimal ( 10 ),  -- [PI062]
	@aiCas   Integer -- 1 : Rappatriement + Travail, 
					 -- 2 : Création d'un travail uniquement
As

-- Sécurité
If Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) <> 'SIMPA2_TRT' Return

Declare @bCreerTravail varchar(1)
DECLARE @sMajPar varchar(4)
DECLARE @sErr varchar(60)
DECLARE @iIdCt int
DECLARE @dDteFinGti datetime
DECLARE @sIdCanal char(1)
DECLARE @dDteRecu datetime

If @aiCas = 2 
 Begin
	Set @sMajPar = 'AUTO'

	Select  @dDteRecu=getdate(),
		@dDteFinGti=s.dte_fin_gti
	From sysadm.sinistre s
	Where s.id_sin = @dcIdsin


	exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@dcIdsin
				,2
				,''
				,@sMajPar
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
 End 
 
 
If @aiCas = 1
 Begin  
	Set @bCreerTravail = 'O'
	Set @sMajPar = 'AUTO'	

	-- Tables tempo
	delete from sysadm.w_a_virer where id_sin=@dcIdsin
	delete from sysadm.w_para_plafond where id_sin=@dcIdsin

	delete from sysadm.routage where id_sin=@dcIdsin
	delete from sysadm.w_commande where id_sin=@dcIdsin
	delete from sysadm.w_piece where id_sin=@dcIdsin
	delete from sysadm.w_div_det where id_sin=@dcIdsin
	delete from sysadm.w_detail where id_sin=@dcIdsin
	delete from sysadm.w_div_sin where id_sin=@dcIdsin
	delete from sysadm.w_cour_blob_arch where id_sin=@dcIdsin
	delete from sysadm.w_cour_blob where id_sin=@dcIdsin
	delete from sysadm.w_courrier where id_sin=@dcIdsin
	delete from sysadm.w_frais where id_sin=@dcIdsin
	delete from sysadm.w_refus where id_sin=@dcIdsin
	delete from sysadm.w_inter where id_sin=@dcIdsin
	delete from sysadm.w_reg_frais_annexe_frn where id_sin=@dcIdsin  -- [PM80_FA12_FRANEX]
	delete from sysadm.w_reg_gti where id_sin=@dcIdsin
	delete from sysadm.w_gar_sin where id_sin=@dcIdsin
	delete from sysadm.w_sin where id_sin=@dcIdsin
	delete from sysadm.w_queue where id_sin=@dcIdsin

	delete from sysadm.commande where id_sin=@dcIdsin
	delete from sysadm.div_det where id_sin=@dcIdsin
	delete from sysadm.detail where id_sin=@dcIdsin
	delete from sysadm.div_sin where id_sin=@dcIdsin
	delete from sysadm.frais where id_sin=@dcIdsin
	delete from sysadm.refus where id_sin=@dcIdsin
	delete from sysadm.reg_frais_annexe_frn where id_sin=@dcIdsin  -- [PM80_FA12_FRANEX]
	delete from sysadm.reg_gti where id_sin=@dcIdsin
	delete from sysadm.reglement where id_sin=@dcIdsin
	delete from sysadm.inter where id_sin=@dcIdsin
	delete from sysadm.gar_sin where id_sin=@dcIdsin
	delete from sysadm.cra_imei_trt_import where id_sin=@dcIdsin
	delete from sysadm.trace_cra_imei where id_sin=@dcIdsin
	delete from sysadm.sinistre where id_sin=@dcIdsin

	insert into sysadm.w_sin
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_sin
	where id_sin=@dcIdsin

	insert into sysadm.w_inter 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_inter
	where id_sin=@dcIdsin

	insert into sysadm.w_courrier
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_courrier
	where id_sin=@dcIdsin

	insert into sysadm.w_cour_blob
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_cour_blob
	where id_sin=@dcIdsin

	insert into sysadm.w_cour_blob_arch 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_cour_blob_arch
	where id_sin=@dcIdsin

	insert into sysadm.w_div_sin 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_div_sin
	where id_sin=@dcIdsin

	insert into sysadm.w_gar_sin 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_gar_sin
	where id_sin=@dcIdsin

	insert into sysadm.w_reg_gti 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_reg_gti
	where id_sin=@dcIdsin

	insert into sysadm.w_reg_frais_annexe_frn 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_reg_frais_annexe_frn -- [PM80_FA12_FRANEX]
	where id_sin=@dcIdsin
	
	insert into sysadm.w_detail 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_detail
	where id_sin=@dcIdsin

	insert into sysadm.w_div_det 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_div_det
	where id_sin=@dcIdsin

	insert into sysadm.w_piece 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_piece
	where id_sin=@dcIdsin

	insert into sysadm.w_frais 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_frais
	where id_sin=@dcIdsin

	insert into sysadm.w_refus 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_refus
	where id_sin=@dcIdsin

	insert into sysadm.w_commande 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_commande
	where id_sin=@dcIdsin

	insert into sysadm.w_a_virer 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_a_virer
	where id_sin=@dcIdsin

	insert into sysadm.w_queue
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.w_queue
	where id_sin=@dcIdsin

	insert into sysadm.personne
	select p.* from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.sinistre s,
		[SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.personne p
	where id_sin=@dcIdsin and p.id_ordre=s.id_ordre 
	and not exists (select * from personne p2 where p2.id_ordre=p.id_ordre)

	insert into sysadm.sinistre 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.sinistre
	where id_sin=@dcIdsin

	insert into sysadm.inter 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.inter
	where id_sin=@dcIdsin

	insert into sysadm.div_sin 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.div_sin
	where id_sin=@dcIdsin

	insert into sysadm.gar_sin 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.gar_sin
	where id_sin=@dcIdsin

	insert into sysadm.detail 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.detail
	where id_sin=@dcIdsin

	insert into sysadm.div_det 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.div_det
	where id_sin=@dcIdsin

	insert into sysadm.frais 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.frais
	where id_sin=@dcIdsin

	insert into sysadm.refus 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.refus 
	where id_sin=@dcIdsin

	insert into sysadm.reglement 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.reglement
	where id_sin=@dcIdsin

	insert into sysadm.reg_gti
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.reg_gti
	where id_sin=@dcIdsin

	insert into sysadm.reg_frais_annexe_frn 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.reg_frais_annexe_frn -- [PM80_FA12_FRANEX]
	where id_sin=@dcIdsin

	insert into sysadm.commande 
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.commande
	where id_sin=@dcIdsin

	insert into sysadm.routage
	select * from [SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.routage
	where id_sin=@dcIdsin

	If @dcIdsin >= (select cpt_val from sysadm.parametre where ref_cpt='ID_SIN')
	Begin
		Exec SHERPA_SIM.sysadm.PS_VERIF_CPT_SIN
	End

	-- Création du travail et son contact
	if @bCreerTravail='O' 
	Begin
		if not exists (select * from sysadm.w_queue where id_sin=@dcIdsin)
		Begin
			select @dDteRecu=getdate(),
				@dDteFinGti=s.dte_fin_gti
			from sysadm.sinistre s
			Where s.id_sin = @dcIdsin
			
			exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@dcIdsin
				,2
				,''
				,@sMajPar
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
		End 
		Else
		Begin
			If exists (select * from sysadm.w_queue where id_sin=@dcIdsin and cod_etat=1 )
				print 'Travail existant en saisie'
			Else print 'Travail existant en validation' 
		End 
	End

	update sysadm.w_queue set alt_occupe='N' where id_sin=@dcIdsin
 End 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_NBRE_SIN_SANDRINE
-- Auteur               :       JFF
-- Date                 :       16/03/2016
-- Libelle              :       Envoi à Sandrine le nbre de sinistres des mois précédents
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF	30/07/2018	Lecture sur w_sin.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_NBRE_SIN_SANDRINE' AND type = 'P' )
        DROP procedure sysadm.PS_S_NBRE_SIN_SANDRINE
GO


CREATE procedure sysadm.PS_S_NBRE_SIN_SANDRINE
As

Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @iIdSeq Integer
Declare @iIdSeqMin Integer
Declare @iNbre Integer
Declare @sAnnee VarChar ( 20 )
Declare @sMLettre VarChar ( 20 )
Declare @iCpt Integer
Declare @idAppli VarChar ( 20 )

Set @sMessage = 'Bonjour, '
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Ci-joints les sinistres des mois précédents pour les applis de sinistres SIMPA2, SINDI, PEGASE, SAVANE.'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )


DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_appli		VarChar ( 20 ),
	  nbre		Integer,
	  annee		integer,
	  mois		integer,
	  mlettre   varchar ( 20 ),
	  marquage	integer null 
	)

DECLARE @tb2 TABLE 
	( id_seq	integer identity,
	  id_appli		VarChar ( 20 ),
	  nbre		Integer,
	  annee		integer,
	  mois		integer,
	  mlettre   varchar ( 20 ),
	  marquage	integer null 
	)


If Convert(  Integer, Datepart ( day, CONVERT (varchar ( 10), getdate(), 103 ) )) <> 1
  Begin
	Return
  End


Insert into @tb
Select 'SIMPA2',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From sysadm.sinistre s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )

Insert into @tb
Select 'SIMPA2',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From sysadm.w_sin s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
And   Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s1
		Where s1.id_sin = s.id_sin
	)	
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )


Insert into @tb
Select 'SINDI',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From SINDI_PRO.sysadm.sinistre s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )

Insert into @tb
Select 'SINDI',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From SINDI_PRO.sysadm.w_sinistre s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
And   Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s1
		Where s1.id_sin = s.id_sin
	)	
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )



Insert into @tb
Select 'PEGASE',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From PEGASE_PRO.sysadm.sinistre s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )

Insert into @tb
Select 'PEGASE',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From PEGASE_PRO.sysadm.w_sin s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
And   Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s1
		Where s1.id_sin = s.id_sin
	)	
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )


Insert into @tb
Select 'SAVANE',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From SAVANE_PRO.sysadm.sinistre s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )

Insert into @tb
Select 'SAVANE',
	   count(*),
	   YEAR ( s.cree_le ),
	   MONTH ( s.cree_le),
	   DateName ( month,s.cree_le ),
	   0 
From SAVANE_PRO.sysadm.w_sin s
Where s.cree_le between DATEADD ( month, -15, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
				And     DATEADD ( day, -1, '01'+ Right ( CONVERT (varchar ( 10), getdate(), 103 ), 8 ) )
And   Not exists ( 
		Select top 1 1 
		From sysadm.sinistre s1
		Where s1.id_sin = s.id_sin
	)
group by MONTH ( s.cree_le),
	     YEAR ( s.cree_le ),
		 DateName ( month,s.cree_le )


Insert into @tb2
Select id_appli,
	   sum ( nbre ),
	   annee,
	   mois,
	   mlettre,
	   marquage 
from @tb
Group by 
	   id_appli,
	   annee,
	   mois,
	   mlettre,
	   marquage 

Delete @tb

Insert into @tb 
Select id_appli,
	   nbre,
	   annee,
	   mois,
	   mlettre,
	   marquage  
from @tb2
Order by 1, 3, 4


Set @iCpt = 1 
While @iCpt <= 4
 Begin
	If @iCpt = 1  Set @idAppli = 'SIMPA2'
	If @iCpt = 2  Set @idAppli = 'SINDI'
	If @iCpt = 3  Set @idAppli = 'PEGASE'
	If @iCpt = 4  Set @idAppli = 'SAVANE'

	Select @iIdSeqMin = Min ( id_seq ) From @tb where marquage = 0 and id_appli = @idAppli
	Set @sMessage = @sMessage + @idAppli + ' : ' + Char ( 10 ) + Char ( 10 )
	Set @sMessage = @sMessage + 'Année' + Char ( 9 ) + 'Mois' + Char ( 9 ) + Char ( 9 ) + 'Nombre'+ Char ( 10 )
	While Exists ( Select * From @tb where marquage = 0 and id_appli = @idAppli )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@iNbre = nbre,
			@sAnnee = annee,
			@sMLettre = mlettre
		From	@tb
		Where	marquage = 0
		and id_appli = @idAppli
		and id_seq = @iIdSeqMin

		Set @sMessage = @sMessage + @sAnnee + Char ( 9 ) + @sMLettre + Char ( 9 ) 
		If Len ( @sMLettre ) <= 7 And @sMLettre <> 'octobre' Set @sMessage = @sMessage + Char ( 9 ) 
		Set @sMessage = @sMessage + Convert ( varchar ( 10), @iNbre)   + Char ( 10 )  

		Update @tb
		Set marquage = 1
		Where id_seq = @iIdSeq

		Set @iIdSeqMin = @iIdSeqMin + 1

	 End

	Set @iCpt = @iCpt + 1
	Set @sMessage = @sMessage + Char (10) + Char (10)  

 End 
 

Set @sObjet = 'Nombre de sinistres déclarés sur les mois précédents '
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Cordialement,'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'Fabry Jean-François'
Set @sMessage = @sMessage + CHAR ( 10 )
Set @sMessage = @sMessage + 'DSI/Etudes SIMPA2'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'jff@spb.fr,ADUFRESNOY@spb.eu,cbourdoiseau@spb.eu,jkuster@spb.eu',
--		'ras@spb.fr,jff@spb.fr',
		@sMessage, 
		@sObjet, 
		'Nbre déclaration sinistre', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL

Go

grant execute on sysadm.PS_S_NBRE_SIN_SANDRINE to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_REDRESS_DET600_GTI100
-- Auteur               :       JFF
-- Date                 :       23/06/2016
-- Libelle              :       Redressement des dossier ayant amu 600 et un gti 100
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REDRESS_DET600_GTI100' AND type = 'P' )
        DROP procedure sysadm.PS_U_REDRESS_DET600_GTI100
GO

CREATE procedure sysadm.PS_U_REDRESS_DET600_GTI100
As

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_gti	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @dcIdGti decimal (10 )
Declare @iIdSeq integer

Insert into @tb
select distinct g.id_sin, g.id_gti, 0
from   gar_sin g,
	   detail d1,
	   detail d2
Where  g.cod_etat = 100
And    d1.id_sin = g.id_sin
And    d1.id_gti = g.id_gti
And    d1.cod_etat = 100
And    d2.id_sin = g.id_sin
And    d2.id_gti = g.id_gti
And    d2.cod_etat = 600

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@dcIdGti = id_gti
	From	@tb
	Where	marquage = 0

	Update sysadm.w_gar_sin 
	Set cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @dcIdSin , @dcIdGti, 'W') 
	Where id_sin = 	@dcIdSin
	And   id_gti =  @dcIdGti

	Update sysadm.w_gar_sin
	set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac
	Where  id_sin = @dcIdSin
	And     id_gti = @dcIdGti

	Update sysadm.w_sin
	Set	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @dcIdSin, 'W' )
	Where  id_sin = @dcIdSin

	Update sysadm.w_sin
	Set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac 
	Where  id_sin = @dcIdSin	

	Update sysadm.gar_sin 
	Set cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @dcIdSin , @dcIdGti, 'P') 
	Where id_sin = 	@dcIdSin
	And   id_gti =  @dcIdGti

	Update sysadm.gar_sin
	set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac
	Where  id_sin = @dcIdSin
	And     id_gti = @dcIdGti

	Update sysadm.sinistre
	Set	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @dcIdSin, 'P' )
	Where  id_sin = @dcIdSin

	Update sysadm.sinistre
	Set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac 
	Where  id_sin = @dcIdSin	

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_PRESENCE_WSIN
-- Auteur               :       JFF
-- Date                 :       ?
-- Libelle              :       
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_PRESENCE_WSIN' AND type = 'P' )
        DROP procedure sysadm.PS_PRESENCE_WSIN
GO

CREATE procedure sysadm.PS_PRESENCE_WSIN
  @dcIdSin	Decimal (10), -- [PI062]
  @sRet VarChar ( 20 ) OUTPUT
AS

Set @sRet = 'ABSENT'
If Exists ( Select * From sysadm.w_sin Where id_sin = @dcIdSin )
 Begin
	Set @sRet = 'PRESENT'
 End
	
If @sRet = 'ABSENT'
	Begin
		Delete from sysadm.w_queue where id_sin = @dcIdSin
	End
	
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_PM364_DORMANT_AUTO
-- Auteur               :       Fabry JF
-- Date                 :       01/08/2016
-- Libelle              :       [PM364-1]
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      07/09/2020   [VDOC29610] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM364_DORMANT_AUTO' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM364_DORMANT_AUTO
GO

CREATE procedure sysadm.PS_U_PM364_DORMANT_AUTO

As
	Set Transaction Isolation level Read UnCommitted
	
	-- Si modif des critères, voir FN_LIB_ETAT_DOS_ASSURE_V03

	Declare @dtDeb DateTime
	Declare @dcIdSin Decimal (10)

	DECLARE @tb TABLE 
		( id_sin	decimal (10 ),
		  marquage	integer null 
		)

	DECLARE @sMessage    Varchar(1000),
		    @sObjet      VarChar(255),
		    @sRetourErrMail VarChar(255)
	
	Set @dtDeb = GetDate()

	-- Cas 0 : Si état sans suite et Si presta ECT et dte_rcp_frn is null alors Dormant
	Insert into @tb
	Select s.id_sin, 0
	From  sysadm.sinistre s
	Where s.cree_le > '01/01/2013'
	And   s.cod_etat = 900
	And Exists (
				Select Top 1 1
				from sysadm.commande c1
				Where c1.id_sin = s.id_sin
				and c1.id_ref_four in ( 'A_REPARER', 'A_REPARER_SAV', 'A_DESOXYDER', 'A_DESOXYDER_SAV', 'CONTEST_SUR_REMPL', 'A_DIAGNOSTIQUER' )
				and c1.cod_etat = 'ECT' 
				and c1.dte_rcp_frn is null
				And c1.status_gc = 0 
 			   )
	And	Not Exists ( 
				Select Top 1 1
				From   sysadm.div_sin ds
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'etat_vu_assure'
				And    ds.val_nbre = 1550
		)

	-- Cas 1 : Si presta ECT et dte_rcp_frn is null And cree_le > 2 mois => dormant						
	Insert into @tb
	Select s.id_sin, 0
	From  sysadm.sinistre s
	Where s.cree_le > '01/01/2013'
	And   Exists (
					Select Top 1 1
					from sysadm.commande c1
					Where c1.id_sin = s.id_sin
					and c1.id_ref_four in ( 'A_REPARER', 'A_REPARER_SAV', 'A_DESOXYDER', 'A_DESOXYDER_SAV', 'CONTEST_SUR_REMPL', 'A_DIAGNOSTIQUER' )
					and c1.cod_etat = 'ECT' 
					and c1.dte_rcp_frn is null
					And c1.status_gc = 0 
					And c1.cree_le < DateAdd ( Month, -2, getdate () ) 
				 )
	And	Not Exists ( 
				Select Top 1 1
				From   sysadm.div_sin ds
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'etat_vu_assure'
				And    ds.val_nbre = 1550
		)
	And   Not exists ( 
			Select	Top 1 1
				From	@tb ds
				Where	ds.id_sin = s.id_sin
			)	 

	-- Cas 2 : Si Valide_le > 2 mois And cod_etat tech = 100 => dormant
	Insert into @tb
	Select s.id_sin, 0
	From  sysadm.sinistre s
	Where s.cree_le > '01/01/2013'
	And   s.valide_le < DateAdd ( Month, -2, getdate () )
	And s.cod_etat = 100
	And	Not Exists ( 
				Select Top 1 1
				From   sysadm.div_sin ds
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'etat_vu_assure'
				And    ds.val_nbre = 1550
		)
	And   Not exists ( 
			Select	Top 1 1
				From	@tb ds
				Where	ds.id_sin = s.id_sin
			)	 

	-- Cas 3 : 'Refusé et clos pour l''assuré pour présence irréparable ou (incomplet chez CORDON) et absence de dde de pce'	 
	Insert into @tb
	Select s.id_sin, 0
	from sysadm.commande c1,
		 sysadm.sinistre s,
		 sysadm.div_sin ds
	Where c1.id_sin = s.id_sin
	and c1.id_typ_art in ( 'PRS' )		
	and c1.cod_etat <> 'ANN' 
	And s.cree_le > DateAdd ( Year, -1, getdate () )
	And c1.cree_le < DateAdd ( Month, -1, getdate () ) -- [VDOC29610]
	And ( c1.status_gc in ( 21, 23, 30, 34 )
			Or 
			( c1.status_gc = 169 and c1.id_four = 'COR' )
		)
  	And Not Exists ( 
		Select Top 1 1 
		From	sysadm.w_piece wp
		Where   wp.id_sin = s.id_sin
	)			
	And ds.id_sin = s.id_sin
	And ds.nom_zone = 'etat_vu_assure' 		
	And ds.val_nbre in ( 100, 1540, 1550 )
	And   Not exists ( 
			Select	Top 1 1
				From	@tb ds
				Where	ds.id_sin = s.id_sin
			)


	-- Cas 4 : 'Refusé et clos pour l''assuré pour diag non conforme '
	Insert into @tb
	Select s.id_sin, 0
	from sysadm.commande c1,
		 sysadm.sinistre s,
		 sysadm.div_sin ds
	Where c1.id_sin = s.id_sin
--					and c1.id_typ_art in ( 'EDI' )		
--					and c1.id_ref_four in ( 'A_DIAGNOSTIQUER' ) Tout ce qui est non conforme génère de fait un état refusé pour l'assuré 
	and c1.cod_etat <> 'ANN' 
	And s.cree_le >  DateAdd ( Year, -1, getdate () )
	And c1.cree_le < DateAdd ( Month, -1, getdate () ) -- [VDOC29610]
	And c1.status_gc in ( 152, 170 )
  	And Not Exists ( 
		Select Top 1 1 
		From	sysadm.w_piece wp
		Where   wp.id_sin = s.id_sin
	)	
	And ds.id_sin = s.id_sin
	And ds.nom_zone = 'etat_vu_assure' 		
	And ds.val_nbre in ( 100, 1540, 1550 )
	And   Not exists ( 
			Select	Top 1 1
				From	@tb ds
				Where	ds.id_sin = s.id_sin
			)

	While Exists ( Select Top 1 1 From @tb where marquage = 0 )
	 Begin
		Select Top 1 @dcIdSin = id_sin
		From @tb
		Where marquage = 0		
		
		-- [VDOC15650]
		If @dcIdSin is not null
		  Begin
			Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'SQL'

 			-- [PI087_PM473_2]
 			Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'SQLS' -- [VDOC29610] 

		  End 

		Update @tb
		Set marquage = 1
		Where id_sin = @dcIdSin
	End

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_T_REDRESS_FRAIS_ABSENT
-- Auteur               :       Fabry JF
-- Date                 :       19/10/2016
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_T_REDRESS_FRAIS_ABSENT' AND type = 'P' )
        DROP procedure sysadm.PS_T_REDRESS_FRAIS_ABSENT
GO

CREATE procedure sysadm.PS_T_REDRESS_FRAIS_ABSENT
AS
DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_reg	decimal ( 3),
	  mt_reg    decimal ( 11,2 ),
	  marquage	integer null 
	)

Declare @iIdSeq  Integer 
Declare @dcIdSin decimal (10 )
Declare @dcIdReg decimal (3 )
Declare @dcMtReg decimal ( 11,2 )
Declare @dcIdI   decimal ( 7 )
Declare @dcIdFrais   decimal ( 7 )
Declare @dcIdTypFrais   decimal ( 7 )
Declare @dtValideLe DateTime
Declare @sValidePar VarChar ( 4 )
Declare @dtCreeLe DateTime
Declare @dtMajLe DateTime
Declare @sMajPar VarChar ( 4 );

with maTable (id_sin, id_reg, mt_reg)
as (
	select r.id_sin, r.id_reg, sum(mt_reg) as mt_reg
	from reglement rt
		 inner join reg_gti r on r.id_sin=rt.id_sin and r.id_reg=rt.id_reg
	where r.id_gti < 0
		and rt.cod_mot_reg='RN'
	group by r.id_reg, r.id_sin
)
Insert into @tb
select	m.id_sin, 
		m.id_reg, 
		m.mt_reg,
		0 
from maTable m
	 left outer join frais f on m.id_sin=f.id_sin and f.id_reg=m.id_reg
group by m.id_sin, m.id_reg, m.mt_reg
having sum(f.mt_frais) <>  m.mt_reg or sum(f.mt_frais) is null
order by id_sin, id_reg


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@dcIdReg = id_reg,
		@dcMtReg = mt_reg
	From	@tb
	Where	marquage = 0

	Select @dcIdI = r.id_i,
		   @dtValideLe = r.valide_le,
		   @sValidePar = r.valide_par,
		   @dtCreeLe = r.cree_le,
		   @dtMajLe = r.maj_le,
		   @sMajPar = r.maj_par
	from sysadm.reglement r
	Where r.id_sin = @dcIdSin
	And   r.id_reg = @dcIdReg

	Select @dcIdFrais = max ( id_frais ) 
	From   sysadm.frais fr
	Where  fr.id_sin = @dcIdSin

	Select Top 1 @dcIdTypFrais = Case 
									When rg.id_rgpt <= 0 Then 1
									Else rg.id_rgpt 
								 End 
	From   sysadm.reg_gti rg
	Where  rg.id_sin = @dcIdSin
	And	   rg.id_reg = @dcIdReg

	if @dcIdFrais is null Set @dcIdFrais = -1
	Set  @dcIdFrais = @dcIdFrais + 1

	If Exists ( Select top 1 1 From sysadm.w_sin where id_sin = @dcIdSin ) 
	  Begin
		Insert into sysadm.w_frais values ( 
			@dcIdSin, 
			@dcIdI,
			@dcIdFrais,
			@dcIdTypFrais,
			sysadm.FN_CODE_NUM ( @dcIdTypFrais, '+NF' ),
			'N',
			@dcMtReg,
			600,
			@dtCreeLe, 
			@dtMajLe,
			@sMajPar
		)
	  End 

	Insert into sysadm.frais values ( 
			@dcIdSin, 
			@dcIdI,
			@dcIdFrais,
			@dcIdTypFrais,
			sysadm.FN_CODE_NUM ( @dcIdTypFrais, '+NF' ),
			@dcMtReg,
			@dcIdReg,
			600,
			@dtValideLe,
			@sValidePar,
			@dtCreeLe, 
			@dtMajLe,
			@sMajPar
		)

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End
 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_LANCEUR_JOBS_SQL
-- Auteur               :       Fabry JF
-- Date                 :       03/01/2017
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_LANCEUR_JOBS_SQL' AND type = 'P' )
        DROP procedure sysadm.PS_LANCEUR_JOBS_SQL
GO

CREATE procedure sysadm.PS_LANCEUR_JOBS_SQL  
AS  
  
Declare @iCnxDuTrt Integer   
Declare @iCetteCnx Integer   
Declare @iTypeTrt Integer   
Declare @iCnxATuer Integer   
Declare @iIdSpId integer  
Declare @iIdSeq integer  
Declare @iHeure integer  
  
Declare @sSql varchar ( 50 )  
Declare @dtDebTrt DateTime  
Declare @sDuree VarChar ( 50 )  
  
Declare @sRetourErrMail VarChar ( 100 )  
Declare @sMaChaine VarChar ( 100 )  
  
  
-- Vérouille le lanceur  
If Not ( sysadm.FN_CLE_NUMERIQUE ( 'LANCEUR_JOBS_SQL') > 0 ) Return  
  
-- Lancement valable pour une seule fois, on doit réamer le lanceur à chaque fois (par sécurité)  
Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'LANCEUR_JOBS_SQL'  
  
  
Set @iTypeTrt = 2
/* @iTypeTrt   
1  : Traitement pour PI085  
2  : Redressement Blob plus vieux de 6 mois  
3  : Test ADODB droit réseau
4  : Test ADODB sur C:\ local Serveur de prod
5  : Test Move de local vers rep dest
*/  
  
-----------------  
-- Traitements --  
-----------------  
  
-- Traitement 1  
If @iTypeTrt = 1  
  Begin  
  
 /*  
 Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'KILL CNX SIMPA2'  
 Exec sysadm.PS_KILL_TOUTE_CNX_BASE_SIMPA2  
 Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'KILL CNX SIMPA2'  
 */  
  
 If GetDate () >= Convert ( VarChar, GetDate (), 103 ) + ' ' + '08:00'  
   Begin  
  Set @sMaChaine = 'Trop tard, non lancé, ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 )  
  EXEC master.dbo.SPB_PS_MAIL   
    @sRetourErrMail OUTPUT,   
    'jff@spb.fr, jff7209@yahoo.com',  
    'Début PS_LANCEUR_JOBS_SQL',   
    @sMaChaine,   
    'PS_LANCEUR_JOBS_SQL', -- From  
    '',   
    NULL,   
    NULL,   
    NULL,   
    NULL,   
    NULL  
  Return  
   End   
  
 -- Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'COUPER_ACCES_SIMPA2'  
  
 Set @dtDebTrt = GetDate()  
  
 Set @sMaChaine = 'Début ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 )  
 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr',  
   'Début PS_LANCEUR_JOBS_SQL',   
   @sMaChaine,   
   'PS_LANCEUR_JOBS_SQL', -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  
  
  -- Ici mettre la maj des Tables.  
  
  
-- Ici TRT  
  -- [PI085]  
  alter table sysadm.w_volcanes_ass alter column cod_prod_dms decimal ( 5 )  
  alter table sysadm.produit_supp alter column cod_prod_dms decimal ( 5 )  
  alter table sysadm.produit alter column cod_prod_dms decimal ( 5 )  
  
  alter table sysadm.cum_ftu_brk alter column id_prod_volc decimal ( 5 )  
  alter table sysadm.w_cum_ftu_brk alter column id_prod_volc decimal ( 5 )  
  
  alter table sysadm.resil_adh alter column id_prod_dms decimal ( 5 )  
  alter table sysadm.trace_mob_rempl alter column id_prod_dms decimal ( 5 )  
  
  Update sysadm.produit  
  Set cod_prod_dms = Left ( Right ( REPLICATE ( '0', 5 ) + Convert ( varchar ( 5), id_prod) , 5 ), 3)  
  where cod_prod_dms is null   
  
  
  -- / Ici mettre la maj des Tables.  
  
   
 Update sysadm.cle Set valeur = 0, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'COUPER_ACCES_SIMPA2'  
  
 Set @sDuree =   
     Convert ( VarChar ( 10), DateDiff ( minute, @dtDebTrt , getdate())/60) + ' heures ' +  
     Convert ( VarChar (10 ),  
      convert ( Integer,  
       (  
       Convert( Decimal ( 10, 3 ) , DateDiff ( minute, @dtDebTrt , getdate())) / 60 -  
       DateDiff ( minute, @dtDebTrt , getdate()) / 60   
       ) * 60  
       )) + ' minutes'  
  
 Set @sMaChaine = 'Fin ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 ) + ', durée ' + @sDuree   
   
 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr, jff7209@gmail.com',  
   'Fin PS_LANCEUR_JOBS_SQL',   
   @sMaChaine,   
   'PS_LANCEUR_JOBS_SQL',   
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  
  
  
  
  End  
  
-- Traitement 2  
If @iTypeTrt = 2  
  Begin  
  
 Set @dtDebTrt = GetDate()  
  
 Set Transaction Isolation level Read UnCommitted  
  
 -- Déb trt  
    
  -- La nuit prochaine  
  Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'LANCEUR_JOBS_SQL'  
  
  If ( Select day ( getdate() ) ) <> 15 -- le 15 il y a déjà un trt mensuel   
    Begin  
  
   DECLARE @iRet                   INTEGER  
   DECLARE @dtDebTrt2         DATETIME  
   DECLARE @adtFinTrt              DATETIME  
   DECLARE @aiNbrLig               INTEGER  
   DECLARE @asRetour               VARCHAR (  500 )  
  
   SET     @dtDebTrt2      = DATEADD ( mm, -225, getDate() )  
   SET     @adtFinTrt      = DATEADD ( mm, -6, getDate() )  
   SET     @aiNbrLig       = 50000  
  
   EXEC @iRet = sysadm.PS_X_TRT_SIMPA2_ARCHIVE_BLOB @dtDebTrt2, @adtFinTrt, @aiNbrLig, @asRetour OUTPUT  
    End   
  
 -- fin trt  
  
  
  End   
    
-- Traitement 3  
If @iTypeTrt = 3  
  Begin  
  
 Set @dtDebTrt = GetDate()  

 Set @sMaChaine = 'Début ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 )  
 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr, jff7209@gmail.com',  
   @sMaChaine,   
   'Début',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  
 
 
 -- Déb trt  
Declare @File        VARCHAR(2000)

DECLARE @OLE            INT 

EXECUTE sp_OACreate 'ADODB.Stream',  @OLE OUTPUT

DECLARE @Text XML
SET @Text = 'Toto'
DECLARE @Converted NVARCHAR(MAX)
SET @Converted = CONVERT(nvarchar(MAX), @Text)

EXECUTE sp_OASetProperty             @OLE,    'Type',             2                           --1 = binary, 2 = text
EXECUTE sp_OASetProperty             @OLE,    'Mode',             3                           --0 = not set, 1 read, 2 write, 3 read/write
EXECUTE sp_OASetProperty             @OLE,    'Charset',          'UTF-8'                     --'ISO-8859-1'
EXECUTE sp_OASetProperty             @OLE,    'LineSeparator',    'adLF'                      -- adCR (13) 	Retour chariot uniquement, adCRLF (-1) Par défaut, un retour chariot et un saut de ligne, adLF (10) Saut de ligne uniquement
EXECUTE sp_OAMethod                  @OLE,    'Open'  
EXECUTE sp_OAMethod                  @OLE,    'WriteText',        NULL,       @Converted      --text method

Declare @iRetMATPN Integer
Declare @iRetMATPD Integer

Set @File = '\\SPB.LAN\PRODUCTION\EDITIQUE\KSL-PRD\INPUT\PANNE_CASSE_VOL\SINISTRES\864_CA_ELD-7881723_1-20230309111033400_TEST_ELD_JFF_Test_Prod_MATPN.txt'
EXECUTE @iRetMATPN=sp_OAMethod                  @OLE,    'SaveToFile',       NULL,       @File, 2   --1 = notexist 2 = overwrite
Select '@iRetMATPN', @iRetMATPN

Set @File = '\\SPB.LAN\PRODUCTION\FLUX_APPLIS\APPLIS_WEB\WEB_FILES\PCV\KSLPRO\MATP\864_CA_ELD-7881723_1-20230309111033400_TEST_ELD_JFF_Test_Prod_MATPD.txt'
EXECUTE @iRetMATPD=sp_OAMethod                  @OLE,    'SaveToFile',       NULL,       @File, 2   --1 = notexist 2 = overwrite
Select '@@iRetMATPD', @iRetMATPD

EXECUTE sp_OAMethod                  @OLE,    'Close'
EXECUTE sp_OADestroy                 @OLE
 
 -- fin trt  
  
 Set @sDuree =   
     Convert ( VarChar ( 10), DateDiff ( minute, @dtDebTrt , getdate())/60) + ' heures ' +  
     Convert ( VarChar (10 ),  
      convert ( Integer,  
       (  
       Convert( Decimal ( 10, 3 ) , DateDiff ( minute, @dtDebTrt , getdate())) / 60 -  
       DateDiff ( minute, @dtDebTrt , getdate()) / 60   
       ) * 60  
       )) + ' minutes'  
  
 Set @sMaChaine = 'Fin ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 ) + ', durée ' + @sDuree + CHAR ( 10 ) + CHAR ( 10 ) 
 Set @sMaChaine = @sMaChaine + '// Handle : ' + Convert  ( Varchar ( 50 ),  @OLE ) + CHAR ( 10 ) + CHAR ( 10 ) 
 Set @sMaChaine = @sMaChaine + '// @iRetMATPN : ' + Convert  ( Varchar ( 50 ),  @iRetMATPN ) + CHAR ( 10 ) + CHAR ( 10 ) 
 Set @sMaChaine = @sMaChaine + '// @iRetMATPD : ' + Convert  ( Varchar ( 50 ),  @iRetMATPD ) + CHAR ( 10 ) + CHAR ( 10 ) 
 
-- Select @sMaChaine 

 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr,jff7209@gmail.com',  
   @sMaChaine,
   'Fin',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  

Select '@sRetourErrMail', @sRetourErrMail
  
  End   

-- Traitement 4  
If @iTypeTrt = 4  
  Begin  

Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'LANCEUR_JOBS_SQL'  
  
 Set @dtDebTrt = GetDate()  

 Set @sMaChaine = 'Début ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 )  
 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr, jff7209@gmail.com',  
   @sMaChaine,   
   'Début',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  
 
 
 -- Déb trt  
Declare @Blob varbinary (max)

Select @Blob = txt_blob
From sysadm.archive_blob
Where id_sin = 7932233
And   id_inter = 0
And   id_doc = 2

Declare @File2        VARCHAR(2000)
Declare @iRetMATPD2 Integer

Set @File2 = 'C:\JFF_MATP_SQL_BLOB\MonDocTestSIMPA2.doc'

DECLARE @OLE2            INT 
EXECUTE sp_OACreate 'ADODB.Stream',  @OLE2 OUTPUT

EXECUTE sp_OASetProperty             @OLE2,    'Type',             1                           --1 = binary, 2 = text
EXECUTE sp_OASetProperty             @OLE2,    'Mode',             3                           --0 = not set, 1 read, 2 write, 3 read/write
EXECUTE sp_OAMethod                  @OLE2,    'Open'  
EXECUTE sp_OAMethod                  @OLE2,    'Write',        NULL,       @Blob  --text method

--Commit data and close text stream
EXECUTE @iRetMATPD2 = sp_OAMethod                  @OLE2,    'SaveToFile',       NULL,       @File2, 2   --1 = notexist 2 = overwrite
EXECUTE sp_OAMethod                  @OLE2,    'Close'
EXECUTE sp_OADestroy                 @OLE2

EXECUTE sp_OADestroy @OLE2 
 
 -- fin trt  
  
 Set @sDuree =   
     Convert ( VarChar ( 10), DateDiff ( minute, @dtDebTrt , getdate())/60) + ' heures ' +  
     Convert ( VarChar (10 ),  
      convert ( Integer,  
       (  
       Convert( Decimal ( 10, 3 ) , DateDiff ( minute, @dtDebTrt , getdate())) / 60 -  
       DateDiff ( minute, @dtDebTrt , getdate()) / 60   
       ) * 60  
       )) + ' minutes'  
  
 Set @sMaChaine = 'Fin ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 ) + ', durée ' + @sDuree + CHAR ( 10 ) + CHAR ( 10 ) 
 Set @sMaChaine = @sMaChaine + '// Handle : ' + Convert  ( Varchar ( 50 ),  @OLE2 ) + CHAR ( 10 ) + CHAR ( 10 ) 
 Set @sMaChaine = @sMaChaine + '// @iRetMATPD (Save): ' + Convert  ( Varchar ( 50 ),  @iRetMATPD2 ) + CHAR ( 10 ) + CHAR ( 10 ) 

Select @sMaChaine 
 
-- Select @sMaChaine 

 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr,jff7209@gmail.com',  
   @sMaChaine,
   'Fin',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  

Select '@sRetourErrMail', @sRetourErrMail
  
  End   


-- Traitement 5
If @iTypeTrt = 5  
  Begin  

Update sysadm.cle Set valeur = 1, maj_le = getdate(), maj_par = 'JFF' Where id_cle = 'LANCEUR_JOBS_SQL'  
  
 Set @dtDebTrt = GetDate()  

 Set @sMaChaine = 'Début ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 )  
 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr, jff7209@gmail.com',  
   @sMaChaine,   
   'Début',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  
 
 
 -- Déb trt  

Declare @FilePDFSource        VARCHAR(2000)
Declare @FilePDFDest        VARCHAR(2000)

Set @FilePDFSource = 'C:\JFF_MATP_SQL_BLOB\MonDocTestSIMPA2.PDF'

-- Prod
Set @FilePDFDest = '\\SPB.LAN\PRODUCTION\FLUX_APPLIS\APPLIS_WEB\WEB_FILES\PCV\KSLPRO\MATP\MonDocTestSIMPA2.PDF'

-- Rc7
--Set @FilePDFDest = '\\SPB.LAN\PRODUCTION\FLUX_APPLIS\APPLIS_WEB\WEB_FILES\PCV\KSLREC\MATP\MonDocTestSIMPA2.PDF'

Declare @sCmdDos VarChar ( 200 )
Set @sCmdDos = 'Move ' +  @FilePDFSource + ' ' + @FilePDFDest
EXEC @iRet = master.dbo.xp_cmdshell @sCmdDos 

 
 -- fin trt  
  
 Set @sDuree =   
     Convert ( VarChar ( 10), DateDiff ( minute, @dtDebTrt , getdate())/60) + ' heures ' +  
     Convert ( VarChar (10 ),  
      convert ( Integer,  
       (  
       Convert( Decimal ( 10, 3 ) , DateDiff ( minute, @dtDebTrt , getdate())) / 60 -  
       DateDiff ( minute, @dtDebTrt , getdate()) / 60   
       ) * 60  
       )) + ' minutes'  
  
 Set @sMaChaine = 'Fin ' + Left ( Convert ( Varchar (50), GetDate(), 103 ) + ' ' + Convert ( Varchar (50), GetDate(), 114 ), 19 ) + ', durée ' + @sDuree + CHAR ( 10 ) + CHAR ( 10 ) 
  Set @sMaChaine = @sMaChaine + '// @iRet (Move): ' + Convert  ( Varchar ( 50 ),  @iRet ) + CHAR ( 10 ) + CHAR ( 10 ) 

Select @sMaChaine 
 
-- Select @sMaChaine 

 EXEC master.dbo.SPB_PS_MAIL   
   @sRetourErrMail OUTPUT,   
   'jff@spb.fr,jff7209@gmail.com',  
   @sMaChaine,
   'Fin',   
   null, -- From  
   '',   
   NULL,   
   NULL,   
   NULL,   
   NULL,   
   NULL  

Select '@sRetourErrMail', @sRetourErrMail
  
  End   

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_KILL_TOUTE_CNX_BASE_SIMPA2
-- Auteur               :       Fabry JF
-- Date                 :       03/01/2017
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_KILL_TOUTE_CNX_BASE_SIMPA2' AND type = 'P' )
        DROP procedure sysadm.PS_KILL_TOUTE_CNX_BASE_SIMPA2
GO

CREATE procedure sysadm.PS_KILL_TOUTE_CNX_BASE_SIMPA2
AS

-- Vérouille le lanceur
If Not ( sysadm.FN_CLE_NUMERIQUE ( 'KILL CNX SIMPA2') > 0 ) Return

Declare @iIdSpId integer
Declare @iIdSeq integer
Declare @sSql varchar ( 50 )

If Exists ( Select top 1 1 From sys.objects where name = 'temp_sp_who2' ) Drop Table temp_sp_who2

DECLARE @tb TABLE 
	( id_seq	integer identity,
		id_spid	integer,
		marquage	integer null 
	)

CREATE TABLE temp_sp_who2
	(
		SPID INT,
		Status VARCHAR(1000) NULL,
		Login SYSNAME NULL,
		HostName SYSNAME NULL,
		BlkBy SYSNAME NULL,
		DBName SYSNAME NULL,
		Command VARCHAR(1000) NULL,
		CPUTime INT NULL,
		DiskIO INT NULL,
		LastBatch VARCHAR(1000) NULL,
		ProgramName VARCHAR(1000) NULL,
		SPID2 INT
		, rEQUESTID INT NULL --comment out for SQL 2000 databases

	)

INSERT  INTO temp_sp_who2 EXEC sp_who2
Delete @tb

Insert into @tb
Select distinct 
		SPID,
		0
from temp_sp_who2
Where Left ( Upper ( DBName) , 5 ) = 'SIMPA'
And   SPID not in ( @@SPID )

While Exists ( Select * From @tb where marquage = 0 )
	Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@iIdSpId = id_spid
	From	@tb
	Where	marquage = 0

	
	Set @sSql = 'Kill ' + Convert ( varchar ( 10 ), @iIdSpId )
	Select @sSql 
	Execute ( @sSql )

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
	End
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_REDRESS_RN_NON_ATTACHE_DETAIL
-- Auteur               :       Fabry JF
-- Date                 :       24/03/2017
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_REDRESS_RN_NON_ATTACHE_DETAIL' AND type = 'P' )
        DROP procedure sysadm.PS_REDRESS_RN_NON_ATTACHE_DETAIL
GO

CREATE procedure sysadm.PS_REDRESS_RN_NON_ATTACHE_DETAIL
	@dcIdSin	Decimal ( 10 )
AS

Declare @dcIdreg Decimal ( 3 )

If ( Select count(*) 
	 From sysadm.reglement r
	 Where r.id_sin = @dcIdSin
	 And   r.cree_le > Convert ( Varchar, Getdate (), 103 ) + ' 0:00'
    ) <> 1
	Return -1

Select	@dcIdreg = r.id_reg
From	sysadm.reglement r
where   r.id_sin = @dcIdSin
And     r.cree_le > Convert ( Varchar, Getdate (), 103 ) + ' 0:00'

If @dcIdreg <= 0 Or @dcIdreg is null Return -1

If ( Select count(*) 
	 From sysadm.detail r
	 Where r.id_sin = @dcIdSin
	 And   r.id_reg is null
    ) <> 1
	Return -1

Update sysadm.detail
Set alt_ssui = 'N',
	alt_att = 'N',
	cod_dec_mac = 500,
	cod_dec_ope = 500,
	cod_etat = 600,
	id_reg = @dcIdreg
Where id_sin = @dcIdSin
And   id_reg is null

Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_DETECT_ERREUR_WS
-- Auteur               :       Fabry JF
-- Date                 :       01/02/2018
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      11/03/2019   [DT339]
-- JFF      06/04/2020   [PM506-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DETECT_ERREUR_WS' AND type = 'P' )
        DROP procedure sysadm.PS_S_DETECT_ERREUR_WS
GO


CREATE procedure sysadm.PS_S_DETECT_ERREUR_WS
AS

Declare @iNbreTour  Integer
Declare @iIdSeq		Integer
Declare @sNomWs		VarChar ( 100 )
Declare @sURLWs		VarChar ( 100 )
Declare @iDelai 	integer
Declare @iNbreErr 	Integer
Declare @iDelaiMinParam 	Integer
Declare @iNbreErreMaxDelai1Param 	Integer
Declare @iNbreErreMaxDelai2Param 	Integer
Declare @sMailBody VarChar ( 8000 ) 
Declare @sNomWsDetecte VarChar ( 100 )
Declare @sObjet VarChar ( 255 ) 
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @iMailAEnvoyer Integer
Declare @sExpediteur Varchar ( 128 )

-- Délai en minutes
Set @iDelaiMinParam = 30

Set @iNbreErreMaxDelai1Param = 10
Set @iNbreErreMaxDelai2Param = 15

Set @sMailBody = ''


DECLARE @tb TABLE 
	( id_seq	integer identity,
	  nom_ws    Varchar ( 100 ),
	  url_ws	Varchar ( 100 ),
	  delai		integer,
	  nbre_err	integer,
	  marquage	integer null 
	)

DECLARE @tb2 TABLE 
	( id_seq	integer identity,
	  nom_ws    Varchar ( 100 ),
	  url_ws	Varchar ( 100 ),
	  delai		integer,
	  nbre_err	integer,
	  marquage	integer null 
	)


Set @iNbreTour = 1

While @iNbreTour <= 2
  Begin
	Insert into @tb
	Select  Case 
				When left ( upper ( nom_ws), 3 ) = 'PSM' 
					Then left ( upper ( nom_ws), 3 )
				When left ( upper ( nom_ws), 6 ) = 'CORDON'
					Then left ( upper ( nom_ws), 6 )
				When left ( upper ( nom_ws), 10 ) = 'CHRONOPOST'
					Then left ( upper ( nom_ws), 10 )
				When left ( upper ( nom_ws), 4 ) = 'SEPA'
					Then left ( upper ( nom_ws), 4 )
				When left ( upper ( nom_ws), 10 ) = 'MAIL SAGA2'
					Then left ( upper ( nom_ws), 10 )
				When left ( upper ( nom_ws), 30 ) = 'PM506 - LUTTE ANTI BLANCHIMENT' -- [PM506]
					Then left ( upper ( nom_ws), 30 ) -- [PM506]
			End,
			Left ( url_ws, 87),
			@iDelaiMinParam * @iNbreTour,
			count(*),
			0
	from sysadm.trace_web_service with ( nolock) 
	where ( left ( upper ( nom_ws), 3 ) = 'PSM'
			Or 
			left ( upper ( nom_ws), 6 ) = 'CORDON'
			OR 
			left ( upper ( nom_ws), 10 ) = 'CHRONOPOST'
			OR 
			left ( upper ( nom_ws), 4 ) = 'SEPA'
			OR 
			left ( upper ( nom_ws), 10 ) = 'MAIL SAGA2'
			OR 
			left ( upper ( nom_ws), 30 ) = 'PM506 - LUTTE ANTI BLANCHIMENT' -- [PM506]
		  )
	and   charindex ( 'reponse', nom_ws ) <= 0
	And   cree_le between DateAdd ( minute, -1 * @iDelaiMinParam  * @iNbreTour, Getdate() ) and Convert ( datetime, Getdate()) 
	Group by Case 
				When left ( upper ( nom_ws), 3 ) = 'PSM' 
					Then left ( upper ( nom_ws), 3 )
				When left ( upper ( nom_ws), 6 ) = 'CORDON'
					Then left ( upper ( nom_ws), 6 )
				When left ( upper ( nom_ws), 10 ) = 'CHRONOPOST'
					Then left ( upper ( nom_ws), 10 )
				When left ( upper ( nom_ws), 4 ) = 'SEPA'
					Then left ( upper ( nom_ws), 4 )
				When left ( upper ( nom_ws), 10 ) = 'MAIL SAGA2'
					Then left ( upper ( nom_ws), 10 )
				When left ( upper ( nom_ws), 30 ) = 'PM506 - LUTTE ANTI BLANCHIMENT' -- [PM506]
					Then left ( upper ( nom_ws), 30 ) -- [PM506]
			End,
			Left ( url_ws, 87)

	Set @iNbreTour = @iNbreTour + 1

  End 

Insert into @tb2 
Select nom_ws,
	   url_ws,
	   delai,
	   nbre_err,
	   marquage 
from @tb order by nom_ws, delai

-- Analyse des chiffres

Set @iIdSeq = 1
Set @sNomWsDetecte = ''

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Set @iMailAEnvoyer = 0
	Set @sObjet = ''
	Set @sMailBody = ''


	Select 	Top 1 
		@sNomWs = rtrim ( nom_ws ),
		@sURLWs = rtrim ( url_ws ),
		@iDelai = delai,
		@iNbreErr = nbre_err
	From	@tb2
	Where	marquage = 0
	And     id_seq = @iIdSeq 

	Set @sMailBody = @sMailBody + 'Bonjour,' + char (10)
	Set @sMailBody = @sMailBody + char (10)

	If @iDelai = @iDelaiMinParam And @iNbreErr >= @iNbreErreMaxDelai1Param And @sNomWs <> @sNomWsDetecte
	  Begin
		Set @iMailAEnvoyer = 1
		Set @sNomWsDetecte = @sNomWs

		Set @sObjet = 'WebService ' + @sNomWs + ' en erreur ( ' + Convert ( varchar, @iNbreErr ) + ' erreurs en ' + Convert ( varchar, @iDelai ) + ' minutes )'

		Set @sMailBody = @sMailBody + Convert ( varchar, @iNbreErr ) + ' erreurs ont été relevées sur SIMPA2 entre le '  
		Set @sMailBody = @sMailBody + replace ( Left ( Convert ( varchar, DateAdd ( minute, -1 * @iDelaiMinParam, getdate()), 103 ) + ' ' + Convert ( varchar, DateAdd ( minute, -1 * @iDelaiMinParam, getdate()), 114 ), 16 ), ':', 'h' )
		Set @sMailBody = @sMailBody + ' et le ' 
		Set @sMailBody = @sMailBody + replace ( Left ( Convert ( varchar, getdate(), 103 ) + ' ' + Convert ( varchar, getdate(), 114 ), 16 ), ':', 'h' )
		Set @sMailBody = @sMailBody + ' (délai ' + Convert ( varchar, @iDelaiMinParam ) + ' minutes)'
	  End 

	If @iDelai = @iDelaiMinParam * 2 And @iNbreErr >= @iNbreErreMaxDelai2Param And @sNomWs <> @sNomWsDetecte
	  Begin
		Set @iMailAEnvoyer = 1
		Set @sNomWsDetecte = @sNomWs

		Set @sObjet = 'WebService ' + @sNomWs + ' en erreur ( ' + Convert ( varchar, @iNbreErr ) + ' erreurs en ' + Convert ( varchar, @iDelai ) + ' minutes )'

		Set @sMailBody = @sMailBody + Convert ( varchar, @iNbreErr ) + ' erreurs ont été relevées sur SIMPA2 entre le '  
		Set @sMailBody = @sMailBody + replace ( Left ( Convert ( varchar, DateAdd ( minute, -1 * @iDelaiMinParam * 2, getdate()), 103 ) + ' ' + Convert ( varchar, DateAdd ( minute, -1 * @iDelaiMinParam * 2, getdate()), 114 ), 16 ), ':', 'h' )
		Set @sMailBody = @sMailBody + ' et le ' 
		Set @sMailBody = @sMailBody + replace ( Left ( Convert ( varchar, getdate(), 103 ) + ' ' + Convert ( varchar, getdate(), 114 ), 16 ), ':', 'h' )
		Set @sMailBody = @sMailBody + ' (délai ' + Convert ( varchar, @iDelaiMinParam * 2 ) + ' minutes)'
	  End 

	Set @sMailBody = @sMailBody + ' sur l''appel du WebService ' + @sNomWs + ' (' + @sURLWs + ').'
	Set @sMailBody = @sMailBody + char (10)

	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + '-----------------------------------------------------------------' + char (10)
	Set @sMailBody = @sMailBody + 'Interprétation du ou des mails reçus :' + char (10)
	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + '- Pour RPO :' + char (10)
	Set @sMailBody = @sMailBody + '  Si l''erreur ne concerne qu''un seul prestataire, c''est que le problème vient vraisemblablement de chez lui.' + char (10)
	Set @sMailBody = @sMailBody + '  Attendre de voir si l''alerte se répète sur des fréquences de 30 minutes et si oui, le contacter alors pour lui évoquer le problème.' + char (10)
	Set @sMailBody = @sMailBody + '  Si la prochaine alerte se répète sur un fréquence de 60 minutes, c''est alors que le problème se réduit suite à une intervention du prestataire.' + char (10)
	Set @sMailBody = @sMailBody + '  Le problème sera résolu lorsque vous ne recevrez plus aucun mail.' + char (10)
	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + '- Pour TELCO/Johann :' + char (10)
	Set @sMailBody = @sMailBody + '  Si l''erreur concerne plusieurs prestataire (plusieurs mails reçus concernant des prestataires différents) à la même fréquence (30 minutes), c''est que le problème vient vraisemblablement de chez nous (spb), nous n''arrivons pas appeler les WebService extérieurs ou bien l''appel est très lent et tombe en Time Out.' + char (10)
	Set @sMailBody = @sMailBody + '  Attendre de voir si l''alerte se répète sur des fréquences de 30 minutes sur tous ces prestataires afin de confirmer le problème, et si cela se confirme, agir alors.' + char (10)
	Set @sMailBody = @sMailBody + CHAR ( 10 )

	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Cordialement,'
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Fabry Jean-François'
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'DSI/Etudes SIMPA2'

	Set @sExpediteur = 'ERREUR WEBSERVICE'

	-- On casse la chaine objet et la chaine expediteur
	Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
	Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

	Set @sExpediteur = Left ( @sExpediteur + space ( 128 ), 128)
	Exec sysadm.PS_CASSER_REGLE_CHAINE @sExpediteur Output, '_', ' ' 
	Set @sExpediteur = @sExpediteur  + '<jff@spb.fr>'

	If 	@iMailAEnvoyer > 0 
		Begin
			EXEC master.dbo.SPB_PS_MAIL 
					@sRetourErrMail OUTPUT, 
					'GG_DSI-DO-UTIL@spb.eu,GG_DSI-DO-PI@spb.eu,jff@spb.fr,fsale@spb.eu,GG_DSI-DO-TELCO@spb.eu,vclapson@spb.eu,cbourdoiseau@spb.eu,rpo@spb.eu,YOUACHAOU@spb.eu,JALLIX@spb.eu,HLIEGEARD@spb.eu',
--					'jff@spb.fr',
					@sMailBody, 
					@sObjet, 
					@sExpediteur, 
					'', 
					@sFicOut, 
					NULL, 
					NULL, 
					NULL, 
					NULL
		End 

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
	Set @iIdSeq = @iIdSeq + 1
 End

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_DETECT_VERSION_BASE_SIM
-- Auteur               :       Fabry JF
-- Date                 :       08/11/2018
-- Libelle              :       
-- Commentaires         :       [MSG_SIM_VERSION_BASE]
--
-- Arguments            :       
--
-- Retourne             :       
--
-- JFF  30/09/2020  [PI097]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DETECT_VERSION_BASE_SIM' AND type = 'P' )
        DROP procedure sysadm.PS_S_DETECT_VERSION_BASE_SIM
GO

CREATE procedure sysadm.PS_S_DETECT_VERSION_BASE_SIM
	@adtDteVersBaseSim DateTime OUTPUT,
	@aiAlerte Integer OUTPUT
AS

Declare @dtDeb DateTime
Declare @dtFin DateTime

Set @adtDteVersBaseSim = null
Set @aiAlerte = 0

If Not (
			( ( Select SERVERPROPERTY('ServerName' ) ) = 'SQL14DEV\SIMSINISTRES' And  ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) = 'SIMPA2_TRT')
			Or 
			( ( Select SERVERPROPERTY('ServerName' ) ) = 'SINSQL19REC\SIMSINISTRES19' And  ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) = 'SIMPA2_TRT')  -- [PI097]
   ) Return 


-- Select @adtDteVersBaseSim = max ( valide_le ) from sysadm.sinistre where valide_le between Convert ( varchar, DateAdd ( day, -1, GetDate() ), 103 ) And Convert ( varchar, getdate(), 103 ) 
Select @adtDteVersBaseSim = dte_1 from sysadm.date_pivot where id_cle = 'DERN_VALID'

Select @dtDeb = Convert ( varchar, DateAdd ( day, -1, GetDate() ), 103 ) + ' 20:00'
Select @dtFin = Convert ( varchar, GetDate(), 103 ) + ' 00:10'

If Not ( @adtDteVersBaseSim between @dtDeb and @dtFin ) set @aiAlerte = 1

-- If ( Select Left( Convert ( varchar, @adtDteVersBaseSim, 114 ) , 2 ) ) < 20 set @aiAlerte = 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_DETECT_SQL_QUOT_BASE_SIM
-- Auteur               :       Fabry JF
-- Date                 :       04/02/2020
-- Libelle              :       
-- Commentaires         :       [MSG_SIM_VERSION_BASE]
--
-- Arguments            :       
--
-- Retourne             :       
-- 
-- JFF  30/09/2020  [PI097]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DETECT_SQL_QUOT_BASE_SIM' AND type = 'P' )
        DROP procedure sysadm.PS_S_DETECT_SQL_QUOT_BASE_SIM
GO

CREATE procedure sysadm.PS_S_DETECT_SQL_QUOT_BASE_SIM
	@adtDteSqlQuotBaseSim DateTime OUTPUT,
	@aiAlerte Integer OUTPUT
AS

Declare @dtDeb DateTime
Declare @dtFin DateTime

Set @adtDteSqlQuotBaseSim = null
Set @aiAlerte = 0

If Not (
			( ( Select SERVERPROPERTY('ServerName' ) ) = 'SQL14DEV\SIMSINISTRES' And  ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) = 'SIMPA2_TRT')
			Or 
			( ( Select SERVERPROPERTY('ServerName' ) ) = 'SINSQL19REC\SIMSINISTRES19' And  ( Select ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ))) = 'SIMPA2_TRT')  -- [PI097]
   ) Return 

Select @adtDteSqlQuotBaseSim  = dte_1 from sysadm.date_pivot where id_cle = 'SQL_QUOT_SIM'

If @adtDteSqlQuotBaseSim is null 
 Begin
	set @aiAlerte = 1
	Return
 End 

If Convert ( varchar (10), @adtDteSqlQuotBaseSim, 103 ) <> Convert ( varchar (10), GetDate(), 103 )
 Begin
	set @aiAlerte = 2
	Return
 End 
 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_LIB_CIE
-- Auteur               :       Fabry JF
-- Date                 :       19/12/2018
-- Libelle              :       
-- Commentaires         :       [PM471-1]
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LIB_CIE' AND type = 'P' )
        DROP procedure sysadm.PS_S_LIB_CIE
GO

CREATE procedure sysadm.PS_S_LIB_CIE
	@dcIdSin  Decimal ( 10 ),
	@dcIdRev  Decimal ( 7 ),
	@dcIdGti  Decimal ( 7 ),
	@sLibCie  varChar ( 35 ) OUTPUT
AS

Select	Top 1 @sLibCie = c.lib_cie
From	sysadm.w_sin s,
		sysadm.garantie g,
		sysadm.w_gar_sin gs,
		sysadm.police p,
		sysadm.compagnie c

Where   s.id_sin = @dcIdSin
And		gs.id_sin = s.id_sin
And     g.id_prod = s.id_prod
And		g.id_rev = s.id_rev
And		g.id_gti  = gs.id_gti
And		p.id_police = g.id_police
And		c.id_cie = p.id_cie

If @sLibCie is null Set @sLibCie = ''

Set @sLibCie = lTrim ( rtrim ( @sLibCie ))

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_ID_CIE
-- Auteur               :       Fabry JF
-- Date                 :       31/10/2019
-- Libelle              :       
-- Commentaires         :       [VDOC28559]
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ID_CIE' AND type = 'P' )
        DROP procedure sysadm.PS_S_ID_CIE
GO

CREATE procedure sysadm.PS_S_ID_CIE
	@dcIdSin  Decimal ( 10 ),
	@dcIdRev  Decimal ( 7 ),
	@dcIdGti  Decimal ( 7 ),
	@dcIdCie  Decimal ( 7 )  OUTPUT
AS

If @dcIdGti is null 
  Begin 
	Select	Top 1 @dcIdCie = p.id_cie
	From	sysadm.w_sin s,
			sysadm.garantie g,
			sysadm.police p

	Where   s.id_sin = @dcIdSin
	And     g.id_prod = s.id_prod
	And		g.id_rev = @dcIdRev
	And		p.id_police = g.id_police

  End 
Else
  Begin 
	Select	Top 1 @dcIdCie = p.id_cie
	From	sysadm.w_sin s,
			sysadm.garantie g,
			sysadm.police p

	Where   s.id_sin = @dcIdSin
	And     g.id_prod = s.id_prod
	And		g.id_rev = @dcIdRev
	And		g.id_gti  = @dcIdGti
	And		p.id_police = g.id_police
  End 

If @dcIdCie is null Set @dcIdCie = 0

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_CREATION_AUTO_PARAM_CONDITION
-- Auteur               :       Fabry JF
-- Date                 :       07/11/2019
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CREATION_AUTO_PARAM_CONDITION' AND type = 'P' )
        DROP procedure sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION
GO

CREATE procedure sysadm.PS_I_CREATION_AUTO_PARAM_CONDITION
	@adcIdProd Decimal ( 7 ),
	@adcIdRev Decimal ( 7 ),
	@adcIdGti Decimal ( 7 ),
	@asIdTypCode VarChar ( 3 ),
	@adcIdCode Decimal ( 7 ),
	@asAltReg  VarChar  (1)
AS

  If Not Exists ( 
		  Select Top 1 1 
		  From sysadm.code_condition cc
		  Where cc.id_prod = @adcIdProd
		  And   cc.id_gti  = @adcIdGti
		  And   cc.id_typ_code = @asIdTypCode
		  And   cc.id_code = @adcIdCode
		)
	 Begin
		Insert into sysadm.code_condition values ( @adcIdProd, @asIdTypCode, @adcIdCode, @adcIdGti, null, getdate(), getdate(), 'AUTO' )
	 End 

  If Not Exists ( 
		  Select Top 1 1 
		  From sysadm.condition cc
		  Where cc.id_prod = @adcIdProd
		  And   cc.id_rev = @adcIdRev
		  And   cc.id_gti  = @adcIdGti
		  And   cc.id_code = @adcIdCode
		  And   cc.id_typ_code = @asIdTypCode
		)
	 Begin
		Insert into sysadm.condition values ( @adcIdProd, @adcIdRev, @adcIdGti, @adcIdCode, @asIdTypCode, @asAltReg, 'N', 'N', 'N', getdate(), getdate(), 'AUTO' )
	 End 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_RETURN_TRANCOUNT
-- Auteur               :       Fabry JF
-- Date                 :       24/01/2020
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- [PI056][TRANCOUNT][JFF][24/01/2020]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RETURN_TRANCOUNT' AND type = 'P' )
        DROP procedure sysadm.PS_S_RETURN_TRANCOUNT
GO

CREATE procedure sysadm.PS_S_RETURN_TRANCOUNT
AS
	Return @@TranCount
GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_IU_REDRESS_PRS_153_154
-- Auteur               :       Fabry JF
-- Date                 :       21/02/2020
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- [PI056][TRANCOUNT][JFF][24/01/2020]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_IU_REDRESS_PRS_153_154' AND type = 'P' )
        DROP procedure sysadm.PS_IU_REDRESS_PRS_153_154
GO

CREATE procedure sysadm.PS_IU_REDRESS_PRS_153_154
AS
	
DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_seq_cmde    integer
	)

Declare @dtDtePivot DateTime
Set @dtDtePivot = DateAdd ( month, -1, Getdate() )

Insert into @tb
Select 
c.id_sin,
c.id_seq
from sysadm.sinistre s with ( nolock ),
	 sysadm.commande c with ( nolock )
where s.cod_etat = 900
And s.cod_mot_ssui = 90
And c.id_sin = s.id_sin
And ( c.id_typ_art = 'PRS' or c.id_ref_four = 'A_DIAGNOSTIQUER' )
And c.cod_etat Not in ( 'ANN', 'RFO', 'RPC' )
And c.id_seq = ( Select Max ( c2.id_seq ) from sysadm.commande c2 where c2.id_sin = c.id_sin ) 
And c.cree_le > @dtDtePivot 
And c.status_gc in ( 153, 154 )
And Not Exists ( select top 1 1 from sysadm.w_sin ws where ws.id_sin = s.id_sin ) 

Insert into sysadm.commande 
Select 
c.id_sin,
c.id_seq + 1,
c.id_gti,
c.id_detail,
c.id_four,
'EDI',
'REFUSE A REEXPEDIER',
'',
c.mt_ttc_cmde,
c.adr_nom,
c.adr_prenom,
c.adr_livr1,
c.adr_livr2,
c.adr_livr_cpl,
c.adr_cp,
c.adr_ville,
c.adr_tel1,
c.adr_tel2,
c.adr_tel3,
c.adr_mail,
c.dte_rdv_cli,
c.hrdv_cli_min,
c.hrdv_cli_max,
c.id_serie_anc,
null,
null,
null,
null,
null,
null,
'ECT',
null,
'AUTOMATIQUE',
0,
null,
null,
getdate(),
getdate(),
'AUTO',
getdate(),
'AUTO',
c.id_zone,
c.id_bsp,
c.dte_ret_pret,
c.adr_cod_civ,
'REFUSE_A_REEXP',
c.id_orian_marque,
0,
c.dte_elv_mobile,
0,
c.dte_emis_devis,
c.mt_devis,
NULL,
NULL,
c.adrfc_cod_civ,
'X',
c.adrfc_prenom,
c.adrfc_livr1,
c.adrfc_livr2,
c.adrfc_livr_cpl,
c.adrfc_cp,
c.adrfc_ville,
c.dte_ret_logis,
c.dte_ret_pret_min,
c.dte_ret_pret_max,
c.id_ann,
c.dte_env_bte_frn,
c.dte_rcp_bte_cli,
c.dte_dep_bte_cli,
c.dte_env_st,
c.dte_rcp_mob_cli,
Case c.id_four 
	When 'PSM' Then 430
	Else 990
End,
'REFUSE A REEXPEDIER',
c.id_modl_art_ifr,
null,
null
from sysadm.sinistre s with ( nolock ),
	 sysadm.commande c with ( nolock )
where s.cod_etat = 900
And s.cod_mot_ssui = 90
And c.id_sin = s.id_sin
And ( c.id_typ_art = 'PRS' or c.id_ref_four = 'A_DIAGNOSTIQUER' )
And c.cod_etat Not in ( 'ANN', 'RFO', 'RPC' )
And c.id_seq = ( Select Max ( c2.id_seq ) from sysadm.commande c2 where c2.id_sin = c.id_sin ) 
And c.cree_le > @dtDtePivot 
And c.status_gc in ( 153, 154 )
And Not Exists ( select top 1 1 from sysadm.w_sin ws where ws.id_sin = s.id_sin ) 


Update c
Set cod_etat = 'RPC',
	valide_le = GETDATE()
From sysadm.commande c with (nolock),
	 @tb t
Where c.id_sin = t.id_sin
And   c.id_seq = t.id_seq_cmde


GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_SI_DETECTEUR_SUPP_OBJ_SQL
-- Auteur               :       Fabry JF
-- Date                 :       23/01/2023
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_DETECTEUR_SUPP_OBJ_SQL' AND type = 'P' )
        DROP procedure sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL
GO

CREATE procedure sysadm.PS_SI_DETECTEUR_SUPP_OBJ_SQL
AS

IF NOT ( @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' ) Return

Declare @Tb Table (
	id_seq	int identity,
	nom	    Varchar ( 255 ),
	type    Varchar ( 5 ),
	marquage int
)

Declare @iIdSeq integer
Declare @sNom VarChar ( 255 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sMailBody VarChar ( 8000 ) 
Declare @sChaineObjAbs Varchar ( 3000 ) 
Declare @sObjet VarChar ( 255 ) 
Declare @sExpediteur Varchar ( 128 )
Declare @iRowCount Integer
Declare @sType varchar ( 5 ) 
Declare @iCpt integer

-- Contrôle d'insertion d'objet
Insert into @Tb
Select distinct 
		sob.name, 
		sob.type,
		0
From sys.objects sob
Where Not Exists ( 
	Select Top 1 1
	From sysadm.objet_sql osq
	Where osq.nom = sob.name
)

Set @iRowCount = @@RowCount 
If @iRowCount <= 0 Return

Set @sChaineObjAbs = ''
Set @iCpt = 1

While Exists ( Select Top 1 1 From @Tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@sNom = nom,
		@sType = type
	From	@Tb
	Where	marquage = 0

	Set @sChaineObjAbs = @sChaineObjAbs  + Convert ( Varchar ( 5 ), @iCpt ) + '/ ' + @sNom + ', de type ' + @sType + Char ( 10 ) 

	Update @Tb Set marquage = 1 Where id_seq = @iIdSeq
	Set @iCpt = @iCpt + 1 
 End

Set @sMailBody = 'Bonjour, ' + Char (10) + Char ( 10 )
Set @sMailBody = @sMailBody + convert ( varchar(10), @iRowCount ) + ' objet' + IIF ( @iRowCount > 1,'s','') + ' SQL ' + IIF ( @iRowCount > 1,'ont','a') + ' été créé' + IIF ( @iRowCount > 1,'s','')
Set @sMailBody = @sMailBody + ' sur la base ' + db_name() + ' de façon malveillante (relevé le ' + convert ( varchar ( 10 ) , Getdate(), 103 ) + ' à ' + convert ( varchar ( 10 ) , Getdate(), 108 ) + ').' + Char (10) + Char ( 10 ) 
Set @sMailBody = @sMailBody + @sChaineObjAbs + Char (10) 

Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'Cordialement,'
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'Fabry Jean-François'
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'DSI/Etudes SIMPA2'

Set @sObjet = '[ALERTE] ' + convert ( varchar(10), @iRowCount ) + ' objet' + IIF ( @iRowCount > 1,'s','') + ' SQL créé' + IIF ( @iRowCount > 1,'s','') + ' sur la base ' + db_name() 

-- On casse la chaine objet et la chaine expediteur
Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

Set @sExpediteur = 'SQLSERVER'

Set @sExpediteur = Left ( @sExpediteur + space ( 128 ), 128)
Exec sysadm.PS_CASSER_REGLE_CHAINE @sExpediteur Output, '_', ' ' 
Set @sExpediteur = @sExpediteur  + '<jff@spb.fr>'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'jff@spb.fr',
		--'jff@spb.fr',
		@sMailBody, 
		@sObjet, 
		@sExpediteur, 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL

Delete @Tb

-- Maj tab Ref
Insert into sysadm.objet_sql
Select	name, 
		type, 
		getdate(), 
		getdate(), 
		'SQL' 
from sys.objects sob
Where Not Exists ( 
	Select Top 1 1
	From sysadm.objet_sql osq
	Where osq.nom = sob.name
)



-- Contrôle de suppression d'objet
Insert into @Tb
Select distinct 
		osq.nom, 
		osq.type,
		0
From sysadm.objet_sql osq
Where Not Exists ( 
	Select Top 1 1
	From sys.objects sob
	Where osq.nom = sob.name
)

Set @iRowCount = @@RowCount 
If @iRowCount <= 0 Return

Set @sChaineObjAbs = ''
Set @iCpt = 1

While Exists ( Select Top 1 1 From @Tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@sNom = nom,
		@sType = type
	From	@Tb
	Where	marquage = 0

	Set @sChaineObjAbs = @sChaineObjAbs  + Convert ( Varchar ( 5 ), @iCpt ) + '/ ' + @sNom + ', de type ' + @sType + Char ( 10 ) 

	Update @Tb Set marquage = 1 Where id_seq = @iIdSeq
	Set @iCpt = @iCpt + 1 
 End

Set @sMailBody = 'Bonjour, ' + Char (10) + Char ( 10 )
Set @sMailBody = @sMailBody + convert ( varchar(10), @iRowCount ) + ' objet' + IIF ( @iRowCount > 1,'s','') + ' SQL ' + IIF ( @iRowCount > 1,'ont','a') + ' été supprimé' + IIF ( @iRowCount > 1,'s','')
Set @sMailBody = @sMailBody + ' de la base ' + db_name() + ' de façon malveillante (relevé le ' + convert ( varchar ( 10 ) , Getdate(), 103 ) + ' à ' + convert ( varchar ( 10 ) , Getdate(), 108 ) + ').' + Char (10) + Char ( 10 ) 
Set @sMailBody = @sMailBody + @sChaineObjAbs + Char (10) 

Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'Cordialement,'
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'Fabry Jean-François'
Set @sMailBody = @sMailBody + CHAR ( 10 )
Set @sMailBody = @sMailBody + 'DSI/Etudes SIMPA2'

Set @sObjet = '[ALERTE] ' + convert ( varchar(10), @iRowCount ) + ' objet' + IIF ( @iRowCount > 1,'s','') + ' SQL supprimé' + IIF ( @iRowCount > 1,'s','') + ' de la base ' + db_name() 

-- On casse la chaine objet et la chaine expediteur
Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

Set @sExpediteur = 'SQLSERVER'

Set @sExpediteur = Left ( @sExpediteur + space ( 128 ), 128)
Exec sysadm.PS_CASSER_REGLE_CHAINE @sExpediteur Output, '_', ' ' 
Set @sExpediteur = @sExpediteur  + '<jff@spb.fr>'

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'jff@spb.fr',
		--'jff@spb.fr',
		@sMailBody, 
		@sObjet, 
		@sExpediteur, 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL


Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_DU_NETTOYAGE_CORBEILLES
-- Auteur               :       Fabry JF
-- Date                 :       27/01/2023
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DU_NETTOYAGE_CORBEILLES' AND type = 'P' )
        DROP procedure sysadm.PS_DU_NETTOYAGE_CORBEILLES
GO

CREATE procedure sysadm.PS_DU_NETTOYAGE_CORBEILLES
AS

Update p
Set id_corb = 998
from sysadm.produit p
where p.cree_le < DateAdd ( month, -3, Getdate() )
And not exists ( 
       Select Top 1 1 
       From sysadm.code co 
       Where co.id_typ_code = '-CO'
	   and co.id_code = p.id_corb
	   )

Delete fa
from sysadm.famille fa
where fa.id_typ_code = '-CO'
And fa.cree_le < DateAdd ( month, -3, Getdate() )
And not exists ( 
       Select Top 1 1 
       From sysadm.produit p 
       Where p.id_corb = fa.id_code ) 

Delete fa
from sysadm.famille fa,
	 sysadm.code co
where co.id_typ_code = '-CO'
And fa.id_typ_code = co.id_typ_code
And fa.id_code = co.id_code
And co.id_code not in ( 997, 998, 999 )
And co.cree_le < DateAdd ( month, -3, Getdate() )
And not exists ( 
       Select Top 1 1 
       From sysadm.produit p 
       Where p.id_corb = co.id_code ) 

Delete co
from sysadm.code co
where co.id_typ_code = '-CO'
And co.cree_le < DateAdd ( month, -3, Getdate() )
And co.id_code not in ( 997, 998, 999 )
And not exists ( 
       Select Top 1 1 
       From sysadm.produit p 
       Where p.id_corb = co.id_code ) 

Delete coop
From sysadm.corb_oper coop
Where coop.cree_le < DateAdd ( month, -3, Getdate() )
And   Not Exists ( 
       Select Top 1 1 
       From sysadm.code co 
       Where co.id_typ_code = '-CO'
	   and co.id_code = coop.id_corb	
)

Update p
Set id_corb = 998
from sysadm.produit p
where p.cree_le < DateAdd ( month, -3, Getdate() )
And not exists ( 
       Select Top 1 1 
       From sysadm.code co 
       Where co.id_typ_code = '-CO'
	   and co.id_code = p.id_corb
	   )
Go
