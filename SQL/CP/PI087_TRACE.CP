-------------------------------------------------------------------
--
-- Fichier              :       PI087_TRACE.CP
-- Auteur               :       FABRY JF
-- Date                 :       22/10/2019
--								[PI087_PM473_2]
-- Commentaires         :       A compiler sur TRACE_DOSSIER_SIM/PRO (excépté  PS_I_PI087_TRACE_DOSSIER )
--
-- sysadm.FN_CLE_VAL
-- sysadm.PS_X_GRANT
-- sysadm.PS_X_SIMPA2_INCREMENTER 
-- sysadm.PS_I_PI087_TRACE_DOSSIER <=> A COMPILER SUR SIMPA2 !!!!!
-- sysadm.PS_I_SIMPA2_PI087_TRACE_DOSSIER 
-- sysadm.PS_I_SIMPA2_PI087_SINISTRE 
-- sysadm.PS_I_SIMPA2_PI087_PERSONNE 
-- sysadm.PS_I_SIMPA2_PI087_GAR_SIN 
-- sysadm.PS_I_SIMPA2_PI087_PIECE_HISTO 
-- sysadm.PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA 
-- sysadm.PS_I_SIMPA2_PI087_DIV_SIN 
-- sysadm.PS_I_SIMPA2_PI087_INTER 
-- sysadm.PS_I_SIMPA2_PI087_W_A_VIRER 
-- sysadm.PS_I_SIMPA2_PI087_REGLEMENT 
-- sysadm.PS_I_SIMPA2_PI087_ARCHIVE 
-- sysadm.PS_I_SIMPA2_PI087_REG_GTI 
-- sysadm.PS_I_SIMPA2_PI087_DETAIL 
-- sysadm.PS_I_SIMPA2_PI087_REFUS 
-- sysadm.PS_I_SIMPA2_PI087_DIV_DET 
-- sysadm.PS_I_SIMPA2_PI087_COMMANDE 
-- sysadm.PS_I_SIMPA2_PI087_CONSULT 
-- sysadm.PS_I_SIMPA2_PI087_PURGE_GLISSANTE 
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_VAL
-- Auteur               :       Fabry JF
-- Date                 :       21/02/2007
-- Libellé              :
-- Commentaires         :       Pour un clé fournie, se trouve dans une chaîne de caractères, 
--				retourne la valeur liée, en précisant le séparateur
-- Références           :       Ex : Select sysadm.FN_CLE_VAL ( 'TOTO', 'XYXU=TOTO;TOTO=TUTU;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
--
-- Arguments            :       @asCle		VarChar ( 255 )  La clé à rechercher
--				@asChaine	VarChar ( 255 )  La clé à parcourir
--				@asSep		VarChar ( 1 )    Le séparateur
--
-- Retourne             :       @asVal	 	VarChar ( 255 )  La valeur en retour
--
-- JFF  19/12/2018   Ajout lTrim ( Rtrim ( sur le retour
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL' AND type = 'FN' )
        DROP function sysadm.FN_CLE_VAL
Go

CREATE  function sysadm.FN_CLE_VAL
   (
	@asCle		VarChar ( 255 ) , 
	@asChaine	VarChar ( 1000 ) ,
	@asSep		VarChar ( 1 )   
    )
RETURNS Varchar(1000)

AS

Begin

  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sVal VarChar ( 1000 )
  Declare @AltDebCleValide Integer
  Declare @AltFinCleValide Integer

  Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
  Set @sVal = ''
  Set @AltDebCleValide = 0
  Set @AltFinCleValide = 0

  While @iDeb > 0 
   Begin
     If @iDeb = 1 
	Begin
	  Set @AltDebCleValide = 1
	End 

     If @iDeb > 1 
 	Begin
	  if Substring ( @asChaine, @iDeb - 1, 1 ) = @asSep
		Begin
			Set @AltDebCleValide = 1
		End 
	End 

     Set @iFin = CharIndex ( '=', @asChaine, @iDeb ) 
     If @iFin > 0 
	Begin 
		Set @AltFinCleValide = 1	
	End 

     -- Ce n'est pas une clé
     If @AltDebCleValide = 0 Or @AltFinCleValide = 0
	Begin
	        Set @iDeb = CharIndex ( @asCle + '=', @asChaine, @iDeb + 1 ) 
	End
     
     -- C'est bien une clé valide
     If @AltDebCleValide = 1 And @AltFinCleValide = 1
	Begin
	     Set @iDeb = @iFin + 1
	     Set @iFin = CharIndex ( @asSep, @asChaine, @iDeb ) - 1
	     if @iFin <= 0 Set @iFin = Len ( @asChaine )
	     
	     if @iFin > 0 
	      Begin
	        Set @sVal = Substring ( @asChaine, @iDeb, @iFin - @iDeb + 1 )
		Set @iDeb = 0
	      End
	End
   End

   If @sVal is null Set @sVal = ''

   Return  ltrim ( rTrim ( @sVal ))

End

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_X_GRANT
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_GRANT' AND type = 'P' )
        DROP procedure sysadm.PS_X_GRANT
GO

CREATE procedure sysadm.PS_X_GRANT
AS

SET NOCOUNT ON


DECLARE @sObjet         VarChar ( 100 )
DECLARE @sType          VarChar (   2 )
DECLARE @sMsg           VarChar ( 150 )

DECLARE @iUid           Integer         ,
        @iTotTable      Integer         ,
        @iTotProcedure  Integer         ,
        @iTotFonction   Integer         ,
        @iTotVue        Integer

SET NOCOUNT ON
/*------------------------------------------------------------------*/
/* Récupération du UserId pour sysadm.                              */
/*------------------------------------------------------------------*/
SELECT  @iUid = uid FROM sysusers WHERE name = 'sysadm'
/*------------------------------------------------------------------*/
/* Déclaration du Curseur sur sysobjects.                           */
/*------------------------------------------------------------------*/
DECLARE cur1 CURSOR FOR
        SELECT  name, 
                type 
        FROM    sysobjects 
        WHERE ( xtype = 'U' OR xtype = 'P' Or xtype = 'FN' Or xtype = 'V' )    AND uid = @iUid
        ORDER BY 
                type DESC

SET @iTotTable          = 0
SET @iTotProcedure      = 0
SET @iTotFonction       = 0
SET @iTotVue            = 0

OPEN cur1

FETCH cur1 INTO @sObjet,@sType

WHILE @@FETCH_STATUS <> -1
        BEGIN
/*------------------------------------------------------------------*/
/* On s'occupe du traitement des tables.                            */
/*------------------------------------------------------------------*/
                IF      @sType = 'U' 
                        BEGIN
                                SET @sMsg = 'grant select, insert, delete, update on sysadm.' + @sObjet + ' to rolebddsinistres'
                                SET @iTotTable = @iTotTable + 1
                        END

/*------------------------------------------------------------------*/
/* #2 On s'occupe du traitement des vues                            */
/*------------------------------------------------------------------*/
                IF      @sType = 'V' 
                        BEGIN
                                SET @sMsg = 'grant select, insert, delete, update on sysadm.' + @sObjet + ' to rolebddsinistres'
                                SET @iTotVue = @iTotVue + 1
                        END

/*------------------------------------------------------------------*/
/* On s'occupe du traitement des procédures stockées.               */
/*------------------------------------------------------------------*/
                IF      @sType = 'P'
                        BEGIN
                                SET @sMsg = 'grant execute on sysadm.' + @sObjet + ' to rolebddsinistres'
                                SET @iTotProcedure = @iTotProcedure + 1
                        END

/*------------------------------------------------------------------*/
/* #1 On s'occupe du traitement des fonctions.                      */
/*------------------------------------------------------------------*/
                IF      @sType = 'FN'
                        BEGIN
                                SET @sMsg = 'grant execute on sysadm.' + @sObjet + ' to rolebddsinistres'
                                SET @iTotFonction = @iTotFonction + 1
                        END

                

                EXECUTE ( @sMsg )

                IF      @@error <> 0
                        BEGIN
                                SET @sMsg = @sMsg + ' * * * Erreur ' + Cast ( @@error AS CHAR(10) ) + ' * * *'
                                PRINT @sMsg
                        END
                ELSE
                        BEGIN
                                PRINT @sMsg
                        END


                FETCH cur1 INTO @sObjet,@sType
        END

CLOSE cur1
DEALLOCATE cur1

PRINT 'Nombre de tables     = ' +  CAST ( @iTotTable AS CHAR(3) )
PRINT 'Nombre de vues       = ' +  CAST ( @iTotVue AS CHAR(3) )
PRINT 'Nombre de procédures = ' +  CAST ( @iTotProcedure AS CHAR(3) )
PRINT 'Nombre de fonctions  = ' +  CAST ( @iTotFonction AS CHAR(3) )

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_X_SIMPA2_INCREMENTER
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_SIMPA2_INCREMENTER' AND type = 'P' )
        DROP procedure sysadm.PS_X_SIMPA2_INCREMENTER
GO

CREATE procedure sysadm.PS_X_SIMPA2_INCREMENTER 
	@sRefCpt	 varchar(10),
	@dcCptval   decimal(10,0) output -- [PI062]
AS

-- JFF      12/02/2016   [PI062]

/* mise a jour de la valeur du compteur dans la table. */
update sysadm.simpa2_parametre
   set cpt_val = cpt_val + 1
 where ref_cpt = @sRefCpt

if @@rowcount = 0	 return -1

/* acquisition de la derniere valeur du compteur */
select  @dcCptval = cpt_val
  from  sysadm.simpa2_parametre
 where  ref_cpt = @sRefCpt

return 1

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_PI087_TRACE_DOSSIER
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       Se compile sur SIMPA2_TRT/PRO !!! pas sur la base TRACE_DOSSIER_SIM/PRO
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PI087_TRACE_DOSSIER_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PI087_TRACE_DOSSIER_V01
GO

CREATE procedure sysadm.PS_I_PI087_TRACE_DOSSIER_V01 
	@dcIdSin  Decimal ( 10 ),
	@sCas	  VarChar ( 20 ),
	@sIdOper  VarChar ( 4 ),
	@dcIdInter Decimal ( 7 ),
	@dcIdDoc   Decimal ( 7 )
AS

Declare @iRet Integer
Declare @sIdGt VarChar ( 4 ) 

-- On ne trace pas sur Recette
If SERVERPROPERTY('ServerName' ) = 'SINSQL19REC\RECSINISTRES19' Return 1

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN

	Exec @iRet = TRACE_DOSSIERS_PRO.sysadm.PS_I_SIMPA2_PI087_TRACE_DOSSIER_V01 @dcIdSin, @sCas, @sIdOper, @dcIdInter, @dcIdDoc
	If @iRet < 0 Return @iRet 
END
ELSE
BEGIN
	Exec @iRet = TRACE_DOSSIERS_SIM.sysadm.PS_I_SIMPA2_PI087_TRACE_DOSSIER_V01 @dcIdSin, @sCas, @sIdOper, @dcIdInter, @dcIdDoc
	If @iRet < 0 Return @iRet 
END

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_TRACE_DOSSIER
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :      
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_TRACE_DOSSIER_V01' AND type = 'P' ) 
	DROP procedure sysadm.PS_I_SIMPA2_PI087_TRACE_DOSSIER_V01
Go

CREATE procedure sysadm.PS_I_SIMPA2_PI087_TRACE_DOSSIER_V01 
	@dcIdSin  Decimal ( 10 ),
	@sCas	  VarChar ( 20 ),
	@sIdOper  VarChar ( 4 ),
	@dcIdInter Decimal ( 7 ),
	@dcIdDoc   Decimal ( 7 )

AS

Declare @iCptTrc Integer
Declare @iRet Integer

If @sCas Not In ( 'VALIDATION', 'CONSULTATION' ) Return -1

-- Récupération d'un ID_TRACE
Exec @iRet = sysadm.PS_X_SIMPA2_INCREMENTER 'ID_TRACE', @iCptTrc OUTPUT
If @iRet < 0 Return @iRet 

If @sCas = 'CONSULTATION'
  Begin
	-- Trace consult
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_CONSULT_V01 @dcIdSin, @iCptTrc, @sIdOper, @dcIdInter, @dcIdDoc
	If @iRet < 0 Return @iRet 
  End 

If @sCas = 'VALIDATION'
  Begin

	-- Insertion par respect de l'intégrité 1er niveau.

	-- Trace personne
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_PERSONNE @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace sinistre
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_SINISTRE @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace gar_sin
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_GAR_SIN @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace piece_histo
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_PIECE_HISTO @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace trt_frais_presta
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace div_sin
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_DIV_SIN @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet 

	-- Trace inter
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_INTER @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace w_a_virer
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_W_A_VIRER @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace reglement
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_REGLEMENT @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Insertion par respect de l'intégrité 2ème niveau.

	-- Trace archive
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_ARCHIVE @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace reg_gti
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_REG_GTI @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace detail
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_DETAIL @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace refus
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_REFUS @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Insertion par respect de l'intégrité 3ème niveau.

	-- Trace div_det
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_DIV_DET @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

	-- Trace commande
	Exec @iRet = sysadm.PS_I_SIMPA2_PI087_COMMANDE @dcIdSin, @iCptTrc, @sIdOper
	If @iRet < 0 Return @iRet

  End 

Return @iRet 

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_SINISTRE
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_SINISTRE
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_SINISTRE 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_sinistre
	   (
			id_trc,
			id_sin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_ordre,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			id_dos_cie,
			dte_dos_cie,
			ref_cie,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			mt_reg,
			lieu,
			txt_mess,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			id_natsin,
			id_territ,
			id_detsin,
			id_type_carte,
			id_carte,
			cpt_reg,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_ouvlig_port,
			dte_ach_port,
			modl_port,
			marq_port,
			num_imei_port,
			num_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_ordre,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			id_dos_cie,
			dte_dos_cie,
			ref_cie,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			mt_reg,
			lieu,
			txt_mess,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			id_natsin,
			id_territ,
			id_detsin,
			id_type_carte,
			id_carte,
			cpt_reg,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_ouvlig_port,
			dte_ach_port,
			modl_port,
			marq_port,
			num_imei_port,
			num_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.sinistre s with (nolock)
	Where   s.id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_sinistre
	   (
			id_trc,
			id_sin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_ordre,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			id_dos_cie,
			dte_dos_cie,
			ref_cie,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			mt_reg,
			lieu,
			txt_mess,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			id_natsin,
			id_territ,
			id_detsin,
			id_type_carte,
			id_carte,
			cpt_reg,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_ouvlig_port,
			dte_ach_port,
			modl_port,
			marq_port,
			num_imei_port,
			num_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_prod,
			id_rev,
			id_ets,
			id_adh,
			id_sdos,
			id_ordre,
			dte_adh,
			dte_sous,
			dte_opt,
			cod_opt,
			dte_resil,
			dte_fin_gti,
			id_dos_cie,
			dte_dos_cie,
			ref_cie,
			cod_decl,
			cod_i_decl,
			dte_decl,
			dte_surv,
			heu_surv,
			mt_reg,
			lieu,
			txt_mess,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			id_natsin,
			id_territ,
			id_detsin,
			id_type_carte,
			id_carte,
			cpt_reg,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_ouvlig_port,
			dte_ach_port,
			modl_port,
			marq_port,
			num_imei_port,
			num_port,
			id_contrat_abonne,
			id_hlr,
			id_orian_marque,
			id_orian_modele,
			id_orian_boutique,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.sinistre s with (nolock)
	Where   s.id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_PERSONNE
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_PERSONNE' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_PERSONNE
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_PERSONNE 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS




IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_personne
	   (
			id_trc,
			id_ordre,
			cod_civ,
			nom,
			prenom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			num_fax,
			num_telb,
			num_teld,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			p.id_ordre,
			p.cod_civ,
			p.nom,
			p.prenom,
			p.adr_1,
			p.adr_2,
			p.adr_cp,
			p.adr_ville,
			p.num_fax,
			p.num_telb,
			p.num_teld,
			p.valide_le,
			p.valide_par,
			p.cree_le,
			p.maj_le,
			p.maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.sinistre s with (nolock), 
			SIMPA2_PRO.sysadm.personne p with (nolock)
	Where   s.id_sin = @dcIdSin
	And     p.id_ordre = s.id_ordre

END
ELSE
BEGIN
	Insert into sysadm.simpa2_personne
	   (
			id_trc,
			id_ordre,
			cod_civ,
			nom,
			prenom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			num_fax,
			num_telb,
			num_teld,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			p.id_ordre,
			p.cod_civ,
			p.nom,
			p.prenom,
			p.adr_1,
			p.adr_2,
			p.adr_cp,
			p.adr_ville,
			p.num_fax,
			p.num_telb,
			p.num_teld,
			p.valide_le,
			p.valide_par,
			p.cree_le,
			p.maj_le,
			p.maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.sinistre s with (nolock),
			SIMPA2_TRT.sysadm.personne p with (nolock)
	Where   s.id_sin = @dcIdSin
	And     p.id_ordre = s.id_ordre
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_GAR_SIN
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_GAR_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_GAR_SIN
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_GAR_SIN 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_gar_sin
	   (
			id_trc,
			id_sin,
			id_gti,
			dte_oppo,
			heu_oppo,
			dte_1er_uf,
			mt_tot_prej,
			mt_prej_reg,
			mt_fran_reg,
			mt_nplaf_reg,
			mt_plaf_reg,
			mt_dedu_reg,
			mt_prov,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			txt_mess,
			alt_plaf,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,			
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			dte_oppo,
			heu_oppo,
			dte_1er_uf,
			mt_tot_prej,
			mt_prej_reg,
			mt_fran_reg,
			mt_nplaf_reg,
			mt_plaf_reg,
			mt_dedu_reg,
			mt_prov,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			txt_mess,
			alt_plaf,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,			
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.gar_sin with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_gar_sin
	   (
			id_trc,
			id_sin,
			id_gti,
			dte_oppo,
			heu_oppo,
			dte_1er_uf,
			mt_tot_prej,
			mt_prej_reg,
			mt_fran_reg,
			mt_nplaf_reg,
			mt_plaf_reg,
			mt_dedu_reg,
			mt_prov,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			txt_mess,
			alt_plaf,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,			
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			dte_oppo,
			heu_oppo,
			dte_1er_uf,
			mt_tot_prej,
			mt_prej_reg,
			mt_fran_reg,
			mt_nplaf_reg,
			mt_plaf_reg,
			mt_dedu_reg,
			mt_prov,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			dte_ouv,
			txt_mess,
			alt_plaf,
			alt_ssui,
			cod_mot_ssui,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,			
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.gar_sin with (nolock)
	Where   id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_PIECE_HISTO
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_PIECE_HISTO' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_PIECE_HISTO
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_PIECE_HISTO 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_piece_histo
	   (
			id_trc,
			id_cle,
			id_sin,
			id_gti,
			id_detail,
			id_pce,
			id_i,
			id_para,
			dte_demande,
			dte_reception,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_cle,
			id_sin,
			id_gti,
			id_detail,
			id_pce,
			id_i,
			id_para,
			dte_demande,
			dte_reception,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.piece_histo with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_piece_histo
	   (
			id_trc,
			id_cle,
			id_sin,
			id_gti,
			id_detail,
			id_pce,
			id_i,
			id_para,
			dte_demande,
			dte_reception,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_cle,
			id_sin,
			id_gti,
			id_detail,
			id_pce,
			id_i,
			id_para,
			dte_demande,
			dte_reception,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.piece_histo with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_TRT_FRAIS_PRESTA 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_trt_frais_presta
	   (
			id_trc,
			id_seq,
			id_sin,
			id_seq_cmd,
			cod_dept,
			id_adh,
			id_prod_adh,
			id_ets,
			id_sdos,
			rib_bq,
			rib_ag,
			rib_cpt,
			rib_cle,
			lib_ag,
			lib_reglement,
			montant,
			monnaie,
			moyen_paiement,
			cod_civ,
			cod_inter,
			nom_assure,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			ordre_chq,
			dte_trt,
			periode_reg,
			top_valide,
			top_info,
			no_cie,
			no_contrat,
			id_prod,
			cod_pec_spb,
			cod_pec_presta,
			cod_pec_assureur,
			cod_presta,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_seq,
			id_sin,
			id_seq_cmd,
			cod_dept,
			id_adh,
			id_prod_adh,
			id_ets,
			id_sdos,
			rib_bq,
			rib_ag,
			rib_cpt,
			rib_cle,
			lib_ag,
			lib_reglement,
			montant,
			monnaie,
			moyen_paiement,
			cod_civ,
			cod_inter,
			nom_assure,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			ordre_chq,
			dte_trt,
			periode_reg,
			top_valide,
			top_info,
			no_cie,
			no_contrat,
			id_prod,
			cod_pec_spb,
			cod_pec_presta,
			cod_pec_assureur,
			cod_presta,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.trt_frais_presta with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_trt_frais_presta
	   (
			id_trc,
			id_seq,
			id_sin,
			id_seq_cmd,
			cod_dept,
			id_adh,
			id_prod_adh,
			id_ets,
			id_sdos,
			rib_bq,
			rib_ag,
			rib_cpt,
			rib_cle,
			lib_ag,
			lib_reglement,
			montant,
			monnaie,
			moyen_paiement,
			cod_civ,
			cod_inter,
			nom_assure,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			ordre_chq,
			dte_trt,
			periode_reg,
			top_valide,
			top_info,
			no_cie,
			no_contrat,
			id_prod,
			cod_pec_spb,
			cod_pec_presta,
			cod_pec_assureur,
			cod_presta,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_seq,
			id_sin,
			id_seq_cmd,
			cod_dept,
			id_adh,
			id_prod_adh,
			id_ets,
			id_sdos,
			rib_bq,
			rib_ag,
			rib_cpt,
			rib_cle,
			lib_ag,
			lib_reglement,
			montant,
			monnaie,
			moyen_paiement,
			cod_civ,
			cod_inter,
			nom_assure,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			ordre_chq,
			dte_trt,
			periode_reg,
			top_valide,
			top_info,
			no_cie,
			no_contrat,
			id_prod,
			cod_pec_spb,
			cod_pec_presta,
			cod_pec_assureur,
			cod_presta,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.trt_frais_presta with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_DIV_SIN
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_DIV_SIN
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_DIV_SIN 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_div_sin
	   (
			id_trc,
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.div_sin with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_div_sin
	   (
			id_trc,
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.div_sin with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_INTER
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_INTER' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_INTER
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_INTER 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_inter
	   (
			id_trc,
			id_sin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.inter with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_inter
	   (
			id_trc,
			id_sin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_i,
			cod_inter,
			cod_civ,
			nom,
			adr_1,
			adr_2,
			adr_cp,
			adr_ville,
			adr_att,
			num_teld,
			num_telb,
			num_fax,
			cod_mode_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			mt_reg,
			v_ref1,
			v_ref2,
			cod_ag,
			cod_bq,
			cpt_cour,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			ordre_cheque,
			id_four,
			alt_suivi_mail,
			adr_mail,
			alt_suivi_sms,
			num_port_sms,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.inter with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_W_A_VIRER
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_W_A_VIRER' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_W_A_VIRER
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_W_A_VIRER 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_w_a_virer
	   (
			id_trc,
			id_sin,
			id_i,
			id_reg,
			cod_inter,
			id_prod,
			id_ets,
			id_adh,
			id_sdos,
			rib_bq_dest,
			rib_gui_dest,
			rib_cpt_dest,
			rib_cle_dest,
			mt_vir,
			cod_mode_reg,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_i,
			id_reg,
			cod_inter,
			id_prod,
			id_ets,
			id_adh,
			id_sdos,
			rib_bq_dest,
			rib_gui_dest,
			rib_cpt_dest,
			rib_cle_dest,
			mt_vir,
			cod_mode_reg,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.w_a_virer with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_w_a_virer
	   (
			id_trc,
			id_sin,
			id_i,
			id_reg,
			cod_inter,
			id_prod,
			id_ets,
			id_adh,
			id_sdos,
			rib_bq_dest,
			rib_gui_dest,
			rib_cpt_dest,
			rib_cle_dest,
			mt_vir,
			cod_mode_reg,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_i,
			id_reg,
			cod_inter,
			id_prod,
			id_ets,
			id_adh,
			id_sdos,
			rib_bq_dest,
			rib_gui_dest,
			rib_cpt_dest,
			rib_cle_dest,
			mt_vir,
			cod_mode_reg,
			cod_pos,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.w_a_virer with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_REGLEMENT
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_REGLEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_REGLEMENT
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_REGLEMENT 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_reglement
	   (
			id_trc,
			id_sin,
			id_reg,
			mt_tot_reg,
			lib_reg,
			dte_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			cod_inter,
			cod_mode_reg,
			cod_mot_reg,
			id_i,
			id_reg_base,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			num_let_cheque,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_reg,
			mt_tot_reg,
			lib_reg,
			dte_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			cod_inter,
			cod_mode_reg,
			cod_mot_reg,
			id_i,
			id_reg_base,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			num_let_cheque,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.reglement with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_reglement
	   (
			id_trc,
			id_sin,
			id_reg,
			mt_tot_reg,
			lib_reg,
			dte_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			cod_inter,
			cod_mode_reg,
			cod_mot_reg,
			id_i,
			id_reg_base,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			num_let_cheque,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_reg,
			mt_tot_reg,
			lib_reg,
			dte_reg,
			rib_bq,
			rib_gui,
			rib_cpt,
			rib_cle,
			cod_inter,
			cod_mode_reg,
			cod_mot_reg,
			id_i,
			id_reg_base,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			num_let_cheque,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.reglement with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_ARCHIVE
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_ARCHIVE' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_ARCHIVE
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_ARCHIVE 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_archive
	   (
			id_trc,
			id_sin,
			id_inter,
			id_doc,
			id_cour,
			id_prod,
			id_ordre,
			id_adh,
			cod_version,
			cod_inter,
			nom,
			dte_edit,
			dte_conf,
			dte_archiv,
			dte_rep,
			alt_part,
			alt_pce,
			alt_ps,
			alt_rep,
			txt_compo1,
			txt_compo2,
			ref_doc_dt,
			ref_doc_cp,
			ref_doc_pc,
			ref_doc_ps,
			nbr_conf,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			id_arch,
			id_cour_orig,
			id_doc_edt,
			id_canal,
			envoi_mail_le,
			dte_atlas_notif,
			dte_atlas_telecharg,
			dte_atlas_rappel,
			dte_edit_courrier_rappel,
			dte_echec_distrib_ksl,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_inter,
			id_doc,
			id_cour,
			id_prod,
			id_ordre,
			id_adh,
			cod_version,
			cod_inter,
			nom,
			dte_edit,
			dte_conf,
			dte_archiv,
			dte_rep,
			alt_part,
			alt_pce,
			alt_ps,
			alt_rep,
			txt_compo1,
			txt_compo2,
			ref_doc_dt,
			ref_doc_cp,
			ref_doc_pc,
			ref_doc_ps,
			nbr_conf,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			id_arch,
			id_cour_orig,
			id_doc_edt,
			id_canal,
			envoi_mail_le,
			dte_atlas_notif,
			dte_atlas_telecharg,
			dte_atlas_rappel,
			dte_edit_courrier_rappel,
			dte_echec_distrib_ksl,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.archive with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_archive
	   (
			id_trc,
			id_sin,
			id_inter,
			id_doc,
			id_cour,
			id_prod,
			id_ordre,
			id_adh,
			cod_version,
			cod_inter,
			nom,
			dte_edit,
			dte_conf,
			dte_archiv,
			dte_rep,
			alt_part,
			alt_pce,
			alt_ps,
			alt_rep,
			txt_compo1,
			txt_compo2,
			ref_doc_dt,
			ref_doc_cp,
			ref_doc_pc,
			ref_doc_ps,
			nbr_conf,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			id_arch,
			id_cour_orig,
			id_doc_edt,
			id_canal,
			envoi_mail_le,
			dte_atlas_notif,
			dte_atlas_telecharg,
			dte_atlas_rappel,
			dte_edit_courrier_rappel,
			dte_echec_distrib_ksl,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_inter,
			id_doc,
			id_cour,
			id_prod,
			id_ordre,
			id_adh,
			cod_version,
			cod_inter,
			nom,
			dte_edit,
			dte_conf,
			dte_archiv,
			dte_rep,
			alt_part,
			alt_pce,
			alt_ps,
			alt_rep,
			txt_compo1,
			txt_compo2,
			ref_doc_dt,
			ref_doc_cp,
			ref_doc_pc,
			ref_doc_ps,
			nbr_conf,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			id_arch,
			id_cour_orig,
			id_doc_edt,
			id_canal,
			envoi_mail_le,
			dte_atlas_notif,
			dte_atlas_telecharg,
			dte_atlas_rappel,
			dte_edit_courrier_rappel,
			dte_echec_distrib_ksl,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.archive with (nolock)
	Where   id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_REG_GTI
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_REG_GTI' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_REG_GTI
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_REG_GTI 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_reg_gti
	   (
			id_trc,
			id_sin,
			id_reg,
			id_gti,
			id_rgpt,
			id_i,
			mt_reg,
			mt_rgpt,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_reg,
			id_gti,
			id_rgpt,
			id_i,
			mt_reg,
			mt_rgpt,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.reg_gti with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_reg_gti
	   (
			id_trc,
			id_sin,
			id_reg,
			id_gti,
			id_rgpt,
			id_i,
			mt_reg,
			mt_rgpt,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_reg,
			id_gti,
			id_rgpt,
			id_i,
			mt_reg,
			mt_rgpt,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.reg_gti with (nolock)
	Where   id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_DETAIL
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_DETAIL' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_DETAIL
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_DETAIL 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_detail
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			id_evt,
			id_reg,
			id_i_reg,
			lib_det,
			dte_det,
			heu_det,
			num_carte,
			mt_prej,
			mt_fran,
			mt_nplaf,
			mt_plaf,
			alt_plaf,
			alt_reg,
			alt_att,
			alt_ssui,
			cod_mot_ssui,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			id_carte,
			id_type_carte,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_cmd,
			dte_livr,
			mt_val_achat,
			mt_val_publique,
			num_facture,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			id_evt,
			id_reg,
			id_i_reg,
			lib_det,
			dte_det,
			heu_det,
			num_carte,
			mt_prej,
			mt_fran,
			mt_nplaf,
			mt_plaf,
			alt_plaf,
			alt_reg,
			alt_att,
			alt_ssui,
			cod_mot_ssui,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			id_carte,
			id_type_carte,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_cmd,
			dte_livr,
			mt_val_achat,
			mt_val_publique,
			num_facture,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.detail with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_detail
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			id_evt,
			id_reg,
			id_i_reg,
			lib_det,
			dte_det,
			heu_det,
			num_carte,
			mt_prej,
			mt_fran,
			mt_nplaf,
			mt_plaf,
			alt_plaf,
			alt_reg,
			alt_att,
			alt_ssui,
			cod_mot_ssui,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			id_carte,
			id_type_carte,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_cmd,
			dte_livr,
			mt_val_achat,
			mt_val_publique,
			num_facture,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			id_evt,
			id_reg,
			id_i_reg,
			lib_det,
			dte_det,
			heu_det,
			num_carte,
			mt_prej,
			mt_fran,
			mt_nplaf,
			mt_plaf,
			alt_plaf,
			alt_reg,
			alt_att,
			alt_ssui,
			cod_mot_ssui,
			cod_dec_mac,
			cod_dec_ope,
			cod_etat,
			id_carte,
			id_type_carte,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			dte_cmd,
			dte_livr,
			mt_val_achat,
			mt_val_publique,
			num_facture,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.detail with (nolock)
	Where   id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_REFUS
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_REFUS
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_REFUS 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_refus
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			id_motif,
			alt_mac,
			alt_ope,
			id_i,
			id_para,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			id_motif,
			alt_mac,
			alt_ope,
			id_i,
			id_para,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.refus with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_refus
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			id_motif,
			alt_mac,
			alt_ope,
			id_i,
			id_para,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			id_motif,
			alt_mac,
			alt_ope,
			id_i,
			id_para,
			valide_le,
			valide_par,
			cree_le,
			maj_le,
			maj_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.refus with (nolock)
	Where   id_sin = @dcIdSin

END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_DIV_DET
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_DIV_DET' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_DIV_DET
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_DIV_DET 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_div_det
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.div_det with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_div_det
	   (
			id_trc,
			id_sin,
			id_gti,
			id_detail,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_gti,
			id_detail,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.div_det with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_COMMANDE
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_COMMANDE
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_COMMANDE 
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into sysadm.simpa2_commande
	   (
			id_trc,
			id_sin,
			id_seq,
			id_gti,
			id_detail,
			id_four,
			id_typ_art,
			id_marq_art,
			id_modl_art,
			mt_ttc_cmde,
			adr_nom,
			adr_prenom,
			adr_livr1,
			adr_livr2,
			adr_livr_cpl,
			adr_cp,
			adr_ville,
			adr_tel1,
			adr_tel2,
			adr_tel3,
			adr_mail,
			dte_rdv_cli,
			hrdv_cli_min,
			hrdv_cli_max,
			id_serie_anc,
			probleme,
			id_cmd_frn,
			id_serie_nouv,
			id_bon_transp,
			dte_rcp_frn,
			dte_env_cli,
			cod_etat,
			comment_frn,
			nom_gest,
			id_lot_cmd,
			cmd_gen_le,
			cmd_gen_par,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			id_zone,
			id_bsp,
			dte_ret_pret,
			adr_cod_civ,
			id_ref_four,
			id_orian_marque,
			id_orian_modele,
			dte_elv_mobile,
			status_gc,
			dte_emis_devis,
			mt_devis,
			alt_dev_acp,
			dte_dev_acp,
			adrfc_cod_civ,
			adrfc_nom,
			adrfc_prenom,
			adrfc_livr1,
			adrfc_livr2,
			adrfc_livr_cpl,
			adrfc_cp,
			adrfc_ville,
			dte_ret_logis,
			dte_ret_pret_min,
			dte_ret_pret_max,
			id_ann,
			dte_env_bte_frn,
			dte_rcp_bte_cli,
			dte_dep_bte_cli,
			dte_env_st,
			dte_rcp_mob_cli,
			info_spb_frn,
			id_marq_art_ifr,
			id_modl_art_ifr,
			info_spb_frn_cplt,
			info_frn_spb_cplt,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_seq,
			id_gti,
			id_detail,
			id_four,
			id_typ_art,
			id_marq_art,
			id_modl_art,
			mt_ttc_cmde,
			adr_nom,
			adr_prenom,
			adr_livr1,
			adr_livr2,
			adr_livr_cpl,
			adr_cp,
			adr_ville,
			adr_tel1,
			adr_tel2,
			adr_tel3,
			adr_mail,
			dte_rdv_cli,
			hrdv_cli_min,
			hrdv_cli_max,
			id_serie_anc,
			probleme,
			id_cmd_frn,
			id_serie_nouv,
			id_bon_transp,
			dte_rcp_frn,
			dte_env_cli,
			cod_etat,
			comment_frn,
			nom_gest,
			id_lot_cmd,
			cmd_gen_le,
			cmd_gen_par,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			id_zone,
			id_bsp,
			dte_ret_pret,
			adr_cod_civ,
			id_ref_four,
			id_orian_marque,
			id_orian_modele,
			dte_elv_mobile,
			status_gc,
			dte_emis_devis,
			mt_devis,
			alt_dev_acp,
			dte_dev_acp,
			adrfc_cod_civ,
			adrfc_nom,
			adrfc_prenom,
			adrfc_livr1,
			adrfc_livr2,
			adrfc_livr_cpl,
			adrfc_cp,
			adrfc_ville,
			dte_ret_logis,
			dte_ret_pret_min,
			dte_ret_pret_max,
			id_ann,
			dte_env_bte_frn,
			dte_rcp_bte_cli,
			dte_dep_bte_cli,
			dte_env_st,
			dte_rcp_mob_cli,
			info_spb_frn,
			id_marq_art_ifr,
			id_modl_art_ifr,
			info_spb_frn_cplt,
			info_frn_spb_cplt,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_PRO.sysadm.commande with (nolock)
	Where   id_sin = @dcIdSin

END
ELSE
BEGIN
	Insert into sysadm.simpa2_commande
	   (
			id_trc,
			id_sin,
			id_seq,
			id_gti,
			id_detail,
			id_four,
			id_typ_art,
			id_marq_art,
			id_modl_art,
			mt_ttc_cmde,
			adr_nom,
			adr_prenom,
			adr_livr1,
			adr_livr2,
			adr_livr_cpl,
			adr_cp,
			adr_ville,
			adr_tel1,
			adr_tel2,
			adr_tel3,
			adr_mail,
			dte_rdv_cli,
			hrdv_cli_min,
			hrdv_cli_max,
			id_serie_anc,
			probleme,
			id_cmd_frn,
			id_serie_nouv,
			id_bon_transp,
			dte_rcp_frn,
			dte_env_cli,
			cod_etat,
			comment_frn,
			nom_gest,
			id_lot_cmd,
			cmd_gen_le,
			cmd_gen_par,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			id_zone,
			id_bsp,
			dte_ret_pret,
			adr_cod_civ,
			id_ref_four,
			id_orian_marque,
			id_orian_modele,
			dte_elv_mobile,
			status_gc,
			dte_emis_devis,
			mt_devis,
			alt_dev_acp,
			dte_dev_acp,
			adrfc_cod_civ,
			adrfc_nom,
			adrfc_prenom,
			adrfc_livr1,
			adrfc_livr2,
			adrfc_livr_cpl,
			adrfc_cp,
			adrfc_ville,
			dte_ret_logis,
			dte_ret_pret_min,
			dte_ret_pret_max,
			id_ann,
			dte_env_bte_frn,
			dte_rcp_bte_cli,
			dte_dep_bte_cli,
			dte_env_st,
			dte_rcp_mob_cli,
			info_spb_frn,
			id_marq_art_ifr,
			id_modl_art_ifr,
			info_spb_frn_cplt,
			info_frn_spb_cplt,
			cree_le_trc,
			maj_le_trc,
			maj_par_trc
		)
	Select 
			@iCptTrc,
			id_sin,
			id_seq,
			id_gti,
			id_detail,
			id_four,
			id_typ_art,
			id_marq_art,
			id_modl_art,
			mt_ttc_cmde,
			adr_nom,
			adr_prenom,
			adr_livr1,
			adr_livr2,
			adr_livr_cpl,
			adr_cp,
			adr_ville,
			adr_tel1,
			adr_tel2,
			adr_tel3,
			adr_mail,
			dte_rdv_cli,
			hrdv_cli_min,
			hrdv_cli_max,
			id_serie_anc,
			probleme,
			id_cmd_frn,
			id_serie_nouv,
			id_bon_transp,
			dte_rcp_frn,
			dte_env_cli,
			cod_etat,
			comment_frn,
			nom_gest,
			id_lot_cmd,
			cmd_gen_le,
			cmd_gen_par,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par,
			id_zone,
			id_bsp,
			dte_ret_pret,
			adr_cod_civ,
			id_ref_four,
			id_orian_marque,
			id_orian_modele,
			dte_elv_mobile,
			status_gc,
			dte_emis_devis,
			mt_devis,
			alt_dev_acp,
			dte_dev_acp,
			adrfc_cod_civ,
			adrfc_nom,
			adrfc_prenom,
			adrfc_livr1,
			adrfc_livr2,
			adrfc_livr_cpl,
			adrfc_cp,
			adrfc_ville,
			dte_ret_logis,
			dte_ret_pret_min,
			dte_ret_pret_max,
			id_ann,
			dte_env_bte_frn,
			dte_rcp_bte_cli,
			dte_dep_bte_cli,
			dte_env_st,
			dte_rcp_mob_cli,
			info_spb_frn,
			id_marq_art_ifr,
			id_modl_art_ifr,
			info_spb_frn_cplt,
			info_frn_spb_cplt,
			getdate(),
			getdate(),
			@sIdOper

	From    SIMPA2_TRT.sysadm.commande with (nolock)
	Where   id_sin = @dcIdSin
END	

IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_CONSULT
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_CONSULT_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_CONSULT_V01
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_CONSULT_V01
	@dcIdSin  Decimal ( 10 ),
	@iCptTrc  Integer,
	@sIdOper  VarChar ( 4 ),
	@dcIdInter Decimal ( 7 ),
	@dcIdDoc   Decimal ( 7 )
AS

Declare @IdTrcLu Integer

Select @IdTrcLu = max ( id_trc )
From   sysadm.simpa2_sinistre with (nolock) 
Where  id_sin = @dcIdSin

If @IdTrcLu is null Set @IdTrcLu = -1
If @IdTrcLu = 0     Set @IdTrcLu = -1

Insert into sysadm.simpa2_consult
	(
		id_trc,
		id_sin,
		id_trc_lu,
		dte_consult,
		cree_le_trc,
		maj_le_trc,
		maj_par_trc,
		id_inter,
		id_doc
	)
Select 
		@iCptTrc,
		@dcIdSin,
		@IdTrcLu,
		getdate(),
		getdate(),
		getdate(),
		@sIdOper,
		@dcIdInter,
		@dcIdDoc


IF @@ERROR <> 0 Return -1
Return 1

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_SIMPA2_PI087_PURGE_GLISSANTE
-- Auteur               :       JFF
-- Date                 :       22/10/2019
-- Libelle              :       
-- Commentaires         :       [PI087_PM473_2]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_SIMPA2_PI087_PURGE_GLISSANTE' AND type = 'P' )
        DROP procedure sysadm.PS_I_SIMPA2_PI087_PURGE_GLISSANTE
GO

CREATE procedure sysadm.PS_I_SIMPA2_PI087_PURGE_GLISSANTE 

AS

-- Pensez à index
Declare @dtPivot DateTime
Declare @iIdTrc Integer

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_prod	decimal ( 7 ),
	  dte_pivot Datetime,
	  marquage	integer null 
	)

Declare @dcIdProd decimal ( 7 )
Declare @dtDtePivot DateTime
Declare @iIdSeq integer

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Insert into @tb
	Select  dp.id_prod,
			Case sysadm.FN_CLE_VAL ( 'UNITE', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) 
				When 'A' Then DATEADD ( year, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )
				When 'M' Then DATEADD ( month, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )         
				When 'J' Then DATEADD ( day, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )         
			End dte_pivot,
			0

	From	SIMPA2_PRO.sysadm.det_pro dp
	Where   dp.id_code_dp = 343
End 
Else 
BEGIN
	Insert into @tb
	Select  dp.id_prod,
			Case sysadm.FN_CLE_VAL ( 'UNITE', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) 
				When 'A' Then DATEADD ( year, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )
				When 'M' Then DATEADD ( month, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )         
				When 'J' Then DATEADD ( day, (-1) * Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI', rtrim ( val_car ) + rtrim ( val_car2 ), ';' )), Getdate () )         
			End dte_pivot,
			0

	From	SIMPA2_TRT.sysadm.det_pro dp
	Where   dp.id_code_dp = 343
End 


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdProd = id_prod,
		@dtDtePivot = dte_pivot
	From	@tb
	Where	marquage = 0

	While Exists ( Select Top 1 1 From sysadm.simpa2_sinistre where id_prod = @dcIdProd and cree_le_trc < @dtDtePivot )
	 Begin

	 	Select 	Top 1 
				@iIdTrc = id_trc
		From	sysadm.simpa2_sinistre
		where   id_prod = @dcIdProd 
		And cree_le_trc < @dtDtePivot 

		Delete sysadm.simpa2_refus where id_trc = @iIdTrc
		Delete sysadm.simpa2_commande where id_trc = @iIdTrc
		Delete sysadm.simpa2_div_det where id_trc = @iIdTrc
		Delete sysadm.simpa2_detail where id_trc = @iIdTrc
		Delete sysadm.simpa2_reg_gti where id_trc = @iIdTrc
		Delete sysadm.simpa2_archive where id_trc = @iIdTrc
		Delete sysadm.simpa2_div_sin where id_trc = @iIdTrc
		Delete sysadm.simpa2_w_a_virer where id_trc = @iIdTrc
		Delete sysadm.simpa2_reglement where id_trc = @iIdTrc
		Delete sysadm.simpa2_gar_sin where id_trc = @iIdTrc
		Delete sysadm.simpa2_inter where id_trc = @iIdTrc
		Delete sysadm.simpa2_piece_histo where id_trc = @iIdTrc
		Delete sysadm.simpa2_consult where id_trc = @iIdTrc
		Delete sysadm.simpa2_trt_frais_presta where id_trc = @iIdTrc
		Delete sysadm.simpa2_sinistre where id_trc = @iIdTrc
		Delete sysadm.simpa2_personne where id_trc = @iIdTrc
	 End 

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End
 
GO



------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- Doit rester à la fin. si compiler sur TRACE_DOSSIER_, cela supprime la PS (qui doit être sur SIMPA2_)
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PI087_TRACE_DOSSIER_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PI087_TRACE_DOSSIER_V01
GO
