-------------------------------------------------------------------
--
-- Fichier              :       REGLEMENT.CP
-- Auteur               :       PLJ
-- Date                 :       30/07/1998
--
-- Commentaires         :       Gestion des rŠglements dans SIMPA2
--
-- sysadm.DW_S01_REGLEMENT
-- sysadm.IM_CUR_REGLEMENT_VAL
-- sysadm.PS_I_CPLT_PAYBOX_SCM_PM462_1
-- sysadm.PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2
-- sysadm.PS_I_REMB_FRANCHISE_PAYBOX
-- sysadm.PS_I_RM_AVOIR_VDOC12917_V02
-- sysadm.PS_I_RM_SIMPLE_PM375_V01
-- sysadm.PS_I_RN_FRAIS_FACTU_PM375_V01
-- sysadm.PS_I_RP_AVOIR_PM375_V01
-- sysadm.PS_I_RP_SIMPLE_PM375_V01
-- sysadm.PS_S_REGL_PRESTA_VDOC12845
-- sysadm.PS_S01_3S_LISTEBABX
-- sysadm.PS_S02_3S_LISTEBABX
-- sysadm.PS_U_REGUL_CAUTION_ASSUREUR
-- sysadm.PS_S_PM80_CTRLE_VENTIL_REG_BASE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REGLEMENT
-- Auteur               :       PLJ
-- Date                 :       30/07/1998
-- Libell‚              :        
-- Commentaires         :       S‚lect sur la table DETAIL
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REGLEMENT_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REGLEMENT_V01
GO

CREATE procedure sysadm.DW_S01_REGLEMENT_V01
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT reglement.id_sin,
        reglement.id_reg,
        reglement.mt_tot_reg,
        reglement.lib_reg,
        reglement.dte_reg,
		reglement.rib_bq,
        reglement.rib_gui,
        reglement.rib_cpt,
        reglement.rib_cle,
        reglement.cod_inter,
        reglement.cod_mode_reg,
        reglement.cod_mot_reg,
        reglement.id_i,
        reglement.cree_le,
        reglement.maj_le,
        reglement.maj_par,
        reglement.valide_le,
        reglement.valide_par,
        reglement.num_let_cheque,
		reglement.id_reg_base
        
  FROM  sysadm.reglement
 WHERE  reglement.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_CUR_REGLEMENT_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table REGLEMENT
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- #1  JFF  22/05/2008  [3SUISSE].COD_MODE_REG 
--     JFF  25/03/2013  [PC801_LOT1_V2]
--     JFF  12/12/2013  [PC947&977]
--     JFF  12/02/2016  [PI062]
--     JFF  17/04/2018  [DT288-4]
--	   JFF  01/06/2018  [PC151425-1]
--     JFF  07/08/2019  [PM462-1]
--     JFF  21/08/2019  [DT361-1]
--     JFF  04/10/2019  [PM462-1][V3]
--	   JFF  29/11/2021  [RS1363_SURV_FACTU]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_CUR_REGLEMENT_VAL' AND type = 'P' )
        DROP procedure sysadm.IM_CUR_REGLEMENT_VAL
GO
CREATE procedure sysadm.IM_CUR_REGLEMENT_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

/*
Le but de cette proc‚dure est de cr‚‚er une ligne dans la table REGLEMENT 
et une ligne dans la table W_A_VIRER pour chaque interlocuteur concern‚ 
par un mouvement financier.
On r‚cup‚re ensuite le Nø de rŠglement pour le positionner dans les tables
W_REG_GTI, DETAIL et FRAIS. (Zne ID_REG). Pour finir il faut armer le compteur
principal sur SINISTRE. (Zne CPT_REG)
J'utilise des valeurs de retour (iRet) diff‚rentes afin de savoir ou se situe
l'erreur, et cela sans avoir … r‚armer sProc.
-1 -> Erreur d'insertion sur REGLEMENT
-2 -> Erreur d'insertion sur W_A_VIRER
-3 -> Erreur de mise … jour sur W_REG_GTI
-4 -> Erreur de mise … jour sur FRAIS
-5 -> Erreur de mise … jour sur DETAIL   (Nø RŠglement)
-6 -> Erreur de mise … jour sur W_FRAIS  (Code Etat)
-7 -> Erreur de mise … jour sur W_DETAIL (Code Etat)
-8 -> Erreur de mise … jour sur SINISTRE
*/

Declare @dcCptReg       Decimal (  2,0 )
Declare @dcCptRegSin    Decimal (  2,0 )
Declare @dcCptRegTour   Decimal (  2,0 )
Declare @iRet           Integer
Declare @dcMtAReg       Decimal ( 11,2 )
Declare @sRibBq         Varchar (  5   )
Declare @sRibAg         Varchar (  5   )
Declare @sRibCpt        Varchar ( 11   )
Declare @sRibCle        Varchar (  2   )
Declare @sCodInter      Varchar (  1   )
Declare @sCodModeReg    Varchar (  2   )
Declare @dcIdI          Decimal (  7,0 )
Declare @sNumLetCheque  Varchar ( 10   )
Declare @sAdrMail Varchar ( 120 )
Declare @sCasRetour Varchar ( 50 )


Declare cur1    CURSOR FOR
 SELECT w_inter.mt_a_reg,
        w_inter.rib_bq,
        w_inter.rib_gui,
        w_inter.rib_cpt,
        w_inter.rib_cle,
        w_inter.cod_inter,
        w_inter.cod_mode_reg,
        w_inter.id_i,
        w_inter.num_let_cheque,
		w_inter.adr_mail -- [DT288-4]
 FROM   sysadm.w_inter
 WHERE  w_inter.id_sin = @dcIdSin       AND
        w_inter.mt_a_reg > 0

        /* ... R‚cup‚ration du Nø de rŠglement ... */
 SELECT @dcCptRegSin  = sinistre.cpt_reg
 FROM                   sysadm.sinistre
 WHERE                  sinistre.id_sin = @dcIdSin  

 SELECT @dcCptReg = @dcCptRegSin

 OPEN   cur1

 FETCH  cur1    INTO
        @dcMtAReg,
        @sRibBq,
        @sRibAg,
        @sRibCpt,
        @sRibCle,
        @sCodInter,
        @sCodModeReg,
        @dcIdI,
        @sNumLetCheque,
		@sAdrMail -- [DT288-4]  

 Select @iRet = 0

WHILE @@Fetch_status <> -1
BEGIN
        
        /* ... Incr‚mentation du Nø de rŠglement ... */
        Select @dcCptReg = @dcCptReg + 1
        Select @dcCptRegTour = @dcCptReg 

        /* ... Insertion dans la table REGLEMENT ... */
        INSERT INTO     sysadm.reglement
                (       reglement.id_sin,
                        reglement.id_reg,
                        reglement.mt_tot_reg,
                        reglement.lib_reg,
                        reglement.dte_reg,
                        reglement.rib_bq,
                        reglement.rib_gui,
                        reglement.rib_cpt,
                        reglement.rib_cle,
                        reglement.cod_inter,
                        reglement.cod_mode_reg,
                        reglement.cod_mot_reg,
                        reglement.id_i,
                        reglement.cree_le,
                        reglement.maj_le,
                        reglement.maj_par,
                        reglement.valide_le,
                        reglement.valide_par,
        		reglement.num_let_cheque    )
        VALUES  (       @dcIdSin,
                        @dcCptReg,
                        @dcMtAReg,
                        'Reglement Normal',
                        Convert ( DateTime, Convert ( Varchar ( 10 ), @dtValideLe, 103 ) ),
                        @sRibBq,
						@sRibAg,
                        @sRibCpt,
                        @sRibCle,
                        @sCodInter,
                        @sCodModeReg,
                        'RN',
                        @dcIdI,
                        @dtValideLe,
                        @dtValideLe,
                        @sCodOper,
                        @dtValideLe,
                        @sCodOper,
                        @sNumLetCheque  )

        IF      @@RowCount <> 1 
                Begin
                        Select @iRet = -1
                        Break
                End
                        

-- #1 [3SUISSE].COD_MODE_REG 
	If @sCodModeReg Not In ( 'BA', 'XA', 'XX' )
	Begin
		/* ... Insertion dans la table W_A_VIRER ... */
		INSERT INTO     sysadm.w_a_virer
			(       w_a_virer.id_sin,
				w_a_virer.id_i,
				w_a_virer.id_reg,
				w_a_virer.cod_inter,
				w_a_virer.id_prod,
				w_a_virer.id_ets,
				w_a_virer.id_adh,
				w_a_virer.id_sdos,
				w_a_virer.rib_bq_dest,
				w_a_virer.rib_gui_dest,
				w_a_virer.rib_cpt_dest,
				w_a_virer.rib_cle_dest,
				w_a_virer.mt_vir,
				w_a_virer.cod_mode_reg,
				w_a_virer.cod_pos,
				w_a_virer.cree_le,
				w_a_virer.maj_le,
				w_a_virer.maj_par       )
		SELECT          @dcIdSin,
				@dcIdI,
				@dcCptReg,
				@sCodInter,
				w_sin.id_prod,
				w_sin.id_ets,
				w_sin.id_adh,
				w_sin.id_sdos,
				@sRibBq,
				@sRibAg,
				@sRibCpt,
				@sRibCle,
				@dcMtAReg,
				@sCodModeReg,
				'0',
				@dtValideLe,
				@dtValideLe,
				@sCodOper
		FROM            sysadm.w_sin
		WHERE           w_sin.id_sin    = @dcIdSin

		IF      @@RowCount <> 1 
			Begin
				Select @iRet = -2
				Break
			End

		-- [DT288-4]
		IF @sCodModeReg = 'C' And @sCodInter = 'A'  
			Begin
				Exec sysadm.PS_S_MAILPUSH_DT288_4_INFO_REGL @dcIdSin, @dcCptReg, @sCodModeReg, @dcMtAReg, @sCasRetour OUTPUT
			End 

		-- [DT361-1]
		-- Gestion SAMSUNG ? => Trt part
		If Exists (	Select * 
					from sysadm.det_pro dp,
							sysadm.w_sin s
					Where s.id_sin = @dcIdSin 
					And   dp.id_prod = s.id_prod
					And   dp.id_code_dp = 294
			)
			And 
			@sCodModeReg in ( 'C', 'VA' ) And @sCodInter = 'A'  		
			Begin
				Exec sysadm.PS_S_MAILPUSH_DT361_INFO_REGL @dcIdSin, @dcCptReg, @sCodModeReg, @dcMtAReg, @sCasRetour OUTPUT
			End 
		-- /[DT361-1]
		


	End 
-- :#1 [3SUISSE].COD_MODE_REG

        /* ... On positionne le Nø de rŠglement dans W_REG_GTI ... */
        UPDATE          sysadm.w_reg_gti
        SET             sysadm.w_reg_gti.id_reg        = @dcCptReg
        WHERE           w_reg_gti.id_sin        = @dcIdSin      AND
                        w_reg_gti.id_i          = @dcIdI        AND
                        w_reg_gti.id_reg        = 0

        IF      @@Error <> 0
                Begin
                        Select @iRet = -3
                        Break
                End


        /* ... On positionne le Nø de rŠglement dans FRAIS ... */
        UPDATE          sysadm.frais
        SET             sysadm.frais.cod_etat  = 600,
                        sysadm.frais.id_reg    = @dcCptReg
        WHERE           frais.id_sin    = @dcIdSin      AND
                        frais.id_i      = @dcIdI        AND
                        frais.id_reg    = 0             AND
                        frais.cod_etat  = 500

        IF      @@Error <> 0
                Begin
                        Select @iRet = -4
                        Break
                End
                

        /* ... On positionne le Nø de rŠglement dans DETAIL ... */
        UPDATE          sysadm.detail
        SET             sysadm.detail.cod_etat = 600,
                        sysadm.detail.id_reg   = @dcCptReg
        WHERE           detail.id_sin   = @dcIdSin      AND
                        detail.id_i_reg = @dcIdI        AND
                        detail.id_reg   = 0             AND
         detail.cod_etat = 500
                        
        IF      @@Error <> 0
                Begin
                        Select @iRet = -5
                        Break
                End

        /* ... On met … jour la zone COD_ETAT dans W_FRAIS ... */
        UPDATE          sysadm.w_frais
        SET             sysadm.w_frais.cod_etat  = 600
        WHERE           w_frais.id_sin    = @dcIdSin      AND
                  w_frais.id_i      = @dcIdI        AND
                        w_frais.cod_etat  = 500
                        
        IF      @@Error <> 0
                Begin
                        Select @iRet = -6
                        Break
                End


        /* ... On met … jour la zone COD_ETAT dans W_DETAIL ... */
        UPDATE          sysadm.w_detail
        SET             sysadm.w_detail.cod_etat = 600
        WHERE           w_detail.id_sin   = @dcIdSin      AND
                        w_detail.id_i_reg = @dcIdI        AND
                        w_detail.cod_etat = 500
                        
        IF      @@Error <> 0
                Begin
                        Select @iRet = -7
                        Break
                End

		-- [PM80_FA12_FRANEX]
		/* ... On positionne le Nø de rŠglement dans W_REG_FRAIS_ANNEXE_FRN ... */
		UPDATE          sysadm.w_reg_frais_annexe_frn
		SET             sysadm.w_reg_frais_annexe_frn.id_reg = @dcCptReg
		WHERE           w_reg_frais_annexe_frn.id_sin        = @dcIdSin      AND
						w_reg_frais_annexe_frn.id_i          = @dcIdI        AND
						w_reg_frais_annexe_frn.id_reg        = 0

		IF      @@Error <> 0
				Begin
						Select @iRet = -8
						Break
				End

		-- [PC801_LOT1_V2]                        
		Exec @iRet = sysadm.PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2 @dcIdSin, @dcIdI, @sCodInter, @dcCptRegTour, @dtValideLe, @dcCptReg OUTPUT 
		If @iRet < 0 Break

		-- [PM462-1]
/*
		If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1') > 0 
		 Begin
			 Exec @iRet = sysadm.PS_I_CPLT_PAYBOX_SCM_PM462_1 @dcIdSin, @dcIdI, @sCodInter, @dcCptRegTour, @dtValideLe, @dcMtAReg, @dcCptReg OUTPUT 
			 If @iRet < 0 Break
		 End 
*/
		-- [PM462-1]

		-- [PC947&977]]                        
	   -- Détection du cas.
	   If Exists (	Select * 
					from sysadm.det_pro dp,
						 sysadm.w_sin s
					Where s.id_sin = @dcIdSin 
					And   dp.id_prod = s.id_prod
					And   dp.id_code_dp = 252
					And   @dcMtAReg > 0
					And   @sCodInter = 'A'
					And   @sCodModeReg = 'XA'
					
		  )
		  Begin
			Exec sysadm.PS_S_MAILPUSH_ADVISE_RN_XA @dcIdSin, @dcMtAReg, @dcCptRegTour 
		  End 
		-- [PC947&977]]                        

		-- [RS1363_SURV_FACTU]
		If @sCodModeReg = 'FM' And @sCodInter = 'F'
			Begin
				Exec sysadm.PS_DI_RS1363_SURV_FACTU_DOS_LIES @dcIdSin, @dcIdI, @sCodModeReg, @sCodInter, @dcMtAReg  
			End 


        /* ... On passe … l'enregistrement suivant ... */
         FETCH  cur1    INTO
                @dcMtAReg,
                @sRibBq,
                @sRibAg,
                @sRibCpt,
                @sRibCle,
                @sCodInter,
                @sCodModeReg,
                @dcIdI,
                @sNumLetCheque,
				@sAdrMail -- [DT288-4]    

END

CLOSE           cur1
DEALLOCATE      cur1

        /* ... On positionne le Nø de rŠglement dans SINISTRE ... */

IF      @iRet = 0 And @dcCptReg <> @dcCptRegSin
        Begin
                UPDATE          sysadm.sinistre
                SET             sysadm.sinistre.cpt_reg        = @dcCptReg
                WHERE           sinistre.id_sin         = @dcIdSin
                        
                IF      @@RowCount <> 1 Select @iRet = -8

        End


                                                    
                                                
        /* ... On met … jour la zone COD_ETAT dans W_DETAIL ... MADM 06/07/2006 DCMP 060472 */
                UPDATE          sysadm.w_detail
                SET             sysadm.w_detail.cod_etat = 600
                WHERE           w_detail.id_sin   = @dcIdSin      AND
                                w_detail.id_i_reg = 0             AND
                                w_detail.mt_plaf  = 0             AND
                                w_detail.cod_etat = 500
                                
                                
             
                              
        /* ... On met … jour la zone COD_ETAT dans DETAIL ... MADM 06/07/2006 DCMP 060472 */
                UPDATE          sysadm.detail
                SET             sysadm.detail.cod_etat = 600
                WHERE           detail.id_sin   = @dcIdSin      AND
                                detail.id_i_reg = 0             AND
                                detail.mt_plaf  = 0             AND
                                detail.cod_etat = 500
                                                

                                        
                                                
 Return @iRet       

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_3S_LISTEBABX
-- Auteur               :       PHG
-- Date                 :       23/05/2008
-- Libelle              :        
-- Commentaires         :       Selection de la liste de reglement 
--				par bon d'achat pour 3S
-- References           :       PS_S02_3S_LISTEBABX
--
-- Arguments            :       
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_3S_LISTEBABX' AND type = 'P' )
        DROP procedure sysadm.PS_S01_3S_LISTEBABX
GO

CREATE PROCEDURE sysadm.PS_S01_3S_LISTEBABX
	@aiIdProd integer,
	@adtDateTrt datetime
AS
BEGIN

	SET NOCOUNT ON

	Declare @iCount integer
	Declare @iNumSeq integer
	Declare @TFichier3S TABLE ( ligne char(300) )
	Declare @sSB char(1) 	-- Sens du Bourrage
	Set @sSB = 'G'		-- Bourrage à gauche => Cadrage à droite
	
	-- En Tete de Fichier
	EXEC sysadm.PS_X_INCREMENTER 'ID_SEQ_3S', @iNumSeq OUTPUT
	
	Insert INTO @TFichier3S
	select 	'H00'								+ 
		sysadm.FN_CHAMPSFIXE('3 SUISSES', 20, @sSB, ' ' )		+
		sysadm.FN_CHAMPSFIXE(@iNumSeq	,  5, @sSB, '0' )
	
	-- Corps du Select
	Insert INTO @TFichier3S
	select 	'S00'								+ 
		sysadm.FN_CHAMPSFIXE('3 SUISSES', 20, @sSB, ' ' )		+
		sysadm.FN_CHAMPSFIXE(s.id_adh	,  7, @sSB, '0' )		+
		CASE -- Substitution des Civilité spb en Civilité 3S
			WHEN p.cod_civ IN ( 3 )	THEN 	'MLE' 
			WHEN p.cod_civ IN ( 2 )	THEN 	'MME' 
			WHEN p.cod_civ IN ( 5 )	THEN 	'STE'
			ELSE 				'M  '
		END 								+
		sysadm.FN_CHAMPSFIXE(p.nom	, 32, 'D', ' ') 		+ 
 		sysadm.FN_CHAMPSFIXE(p.prenom	, 32, 'D', ' ') 		+ 
 		sysadm.FN_CHAMPSFIXE(i.adr_1	, 32, 'D', ' ') 		+ 
		sysadm.FN_CHAMPSFIXE(i.adr_2	, 32, 'D', ' ') 		+ 
		sysadm.FN_CHAMPSFIXE(i.adr_cp	,  5, 'D', '0') 		+ 
		sysadm.FN_CHAMPSFIXE(i.adr_ville, 26, 'D', ' ') 		+ 
		sysadm.FN_CHAMPSFIXE(cast (r.mt_tot_reg*100 as integer), 7, @sSB, '0')
	from	sysadm.sinistre s
		INNER JOIN sysadm.personne p ON  ( s.id_ordre = p.id_ordre )
		INNER JOIN sysadm.reglement r ON ( s.id_sin = r.id_sin )
		INNER JOIN sysadm.inter i ON	 ( s.id_sin = i.id_sin AND
						   r.id_i = i.id_i )
	where	s.id_prod = @aiIdProd
	and	r.dte_reg BETWEEN 
		( CONVERT(datetime, @adtDateTrt, 103) - 
			( CASE
			  WHEN DATEPART(dw, @adtDateTrt) = 1 THEN 3
			  ELSE 1
			  END
			)
		) AND CONVERT(datetime, @adtDateTrt, 103)
	and	r.cod_mode_reg = 'BX' -- Vraie clause
	--and	r.cod_mode_reg in ('VA', 'BA', 'BX') -- Clause de test

	-- Fin de Fichier
	select @iCount = @@ROWCOUNT + 2
	
	Insert INTO @TFichier3S
	select 	'Z00'+ 
		sysadm.FN_CHAMPSFIXE('3 SUISSES', 20, @sSB, ' ' )		+
		sysadm.FN_CHAMPSFIXE(@iCount	,  7, @sSB, '0' )		

	-- Selection des lignes ainsi constituée
	Select ligne from @TFichier3S
END
GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S02_3S_LISTEBABX
-- Auteur               :       PHG
-- Date                 :       23/05/2008
-- Libelle              :        
-- Commentaires         :       Génération Journalière de la liste de reglement 
--				par bon d'achat pour 3S
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Un fichier dans le répertoire cité ci-dessous.
--
-- format de fichier 	:	\\F4T\SIMPA2\3SUISSE\FIC_REGL
-------------------------------------------------------------------
-- JFF      19/03/2025   [LGY_40]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_3S_LISTEBABX' AND type = 'P' )
        DROP procedure sysadm.PS_S02_3S_LISTEBABX
GO

CREATE procedure sysadm.PS_S02_3S_LISTEBABX
	@adtDateTrt datetime
AS

DECLARE @sCommande	VarChar(250),
        @sFicOut	VarChar(255),
        @sNomServeur	VarChar(255),
        @sTracePath	VarChar(255),
        @sFileName	VarChar(255),
        @sFileExt	VarChar(3),
	@sOsqlOption	VarChar(255),
	@iIdProd	integer,
	@dtDatFichier	DateTime
        
DECLARE @sRetourErrMail         VarChar(255)
DECLARE @sRoot VarChar(255)

Set @sCommande = NULL
Set @dtDatFichier = getdate()
Set @sNomServeur = @@servername
-- Set @sTracePath = master.sysadm.SPB_FN_GET_ROOT()+'\SIMPA2\3SUISSE\FIC_REGL\' -- [I027] - France - Chemins Relatifs
-- [LGY_40]
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @sRoot = sysadm.FN_GET_CHEMIN ( 'ROOT_PROD_EXTRACTION' ) Else Set @sRoot = sysadm.FN_GET_CHEMIN ( 'ROOT_SIM_EXTRACTION' )
Set @sTracePath =@sRoot +'\SIMPA2\3SUISSE\FIC_REGL\' -- [I027] - France - Chemins Relatifs

Set @sFileName	= 'SPB-3SF-IND-J-' + 
			CONVERT (char(4), DatePart (year,getdate())  ) +
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,	@dtDatFichier)),  2 ) +
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,	@dtDatFichier)),  2 ) +
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(hour,	@dtDatFichier)),  2 ) +
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(minute,	@dtDatFichier)),  2 ) +
			RIGHT ( '00' + CONVERT (varchar(2),DatePart(second,	@dtDatFichier)),  2 )
Set @sFileExt	= 'TXT'

SET @sFicOut = @sTracePath + @sFileName + '.' + @sFileExt

Set @iIdProd  = 29600 -- Produit 3 Suisse
-- Au cas ou l'on ne veut pas de header et le tab en separateur de fichier
-- /h-1 	=> Pas de Header
-- /s"	" 	=> Separateur Tabulation
-- /w 		=> Largeur de sortie si fichier fixe
Set @sOsqlOption = ' ' + '/h-1 ' + '/s"" ' + '/w300 '
-- sinon
-- Set @sOsqlOption = ''

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') and RIGHT(db_name(db_id()), 3)= 'PRO' -- SIMPA2_PRO
BEGIN
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    'SIMPA2_PRO.sysadm.PS_S01_3S_LISTEBABX ' + convert(varchar, @iIdProd) +', '''+ convert(varchar, @adtDateTrt, 112) + ''''  + 
                    '" /o' + @sFicOut + ' ' + @sOsqlOption -- [I027] Correction sysadm + date ISO
END 
IF @@servername = master.dbo.SPB_FN_ServerName ('SIM') -- SIMPA2_TRT
BEGIN
   SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
                    'SIMPA2_TRT.sysadm.PS_S01_3S_LISTEBABX ' + convert(varchar, @iIdProd) +', '''+ convert(varchar, @adtDateTrt, 112) + ''''  + 
                    '" /o' + @sFicOut + ' ' + @sOsqlOption -- [I027] Correction sysadm + date ISO
END

IF @sCommande IS NOT NULL EXEC master.dbo.xp_cmdshell @sCommande, no_output
Go

grant execute on sysadm.PS_S02_3S_LISTEBABX to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U_REGUL_CAUTION_ASSUREUR
-- Auteur               :       JFF
-- Date                 :       23/05/2013
-- Libell‚              :       [PC938_ORANGE_V3]
-- Commentaires         :       S‚lect sur la table DETAIL
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--								@sTypRegul      VarChar ( 2 )
--
-- Retourne             :       Rien
--
-- JFF      28/03/2014   [DT081_EVOL_PRET_BRIS]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_REGUL_CAUTION_ASSUREUR' AND type = 'P' )
        DROP procedure sysadm.PS_U_REGUL_CAUTION_ASSUREUR
GO


CREATE procedure sysadm.PS_U_REGUL_CAUTION_ASSUREUR
        @adcIdSin        Decimal (  10,0 ), -- [PI062]
		@asTypRegul		VarChar ( 2 ),
		@adcMtDebit		Decimal ( 11, 2 )
AS

Declare @dcCptReg  Decimal ( 2, 0 )
Declare @dcIdGti Decimal ( 7 )

Select @dcCptReg = s.cpt_reg
From sysadm.sinistre s
Where s.id_sin = @adcIdSin 

If @dcCptReg is null Set @dcCptReg = 0

-- [DT081_EVOL_PRET_BRIS]
Select Top 1 @dcIdGti = g.id_gti
From sysadm.gar_sin g
Where g.id_sin = @adcIdSin 
And   g.id_gti Not in ( 8 )

If @dcIdGti is null 
 Begin
	Select Top 1 @dcIdGti = g.id_gti
	From sysadm.gar_sin g
	Where g.id_sin = @adcIdSin 
 End 


Set @dcCptReg = @dcCptReg + 1
										
INSERT INTO  sysadm.reglement
	(   reglement.id_sin,
		reglement.id_reg,
		reglement.mt_tot_reg,
		reglement.lib_reg,
		reglement.dte_reg,
		reglement.rib_bq,
		reglement.rib_gui,
		reglement.rib_cpt,
		reglement.rib_cle,
		reglement.cod_inter,
		reglement.cod_mode_reg,
		reglement.cod_mot_reg,
		reglement.id_i,
		reglement.id_reg_base,
		reglement.cree_le,
		reglement.maj_le,
		reglement.maj_par,
		reglement.valide_le,
		reglement.valide_par,
		reglement.num_let_cheque    )
VALUES  (       
		@adcIdSin,
		@dcCptReg,
		Case @asTypRegul 
			When 'RM' Then @adcMtDebit * (-1)
			When 'RP' Then @adcMtDebit
			Else 0
		End,
		Case -- [DT081_EVOL_PRET_BRIS]
			When @asTypRegul = 'RM' And @dcIdGti = 10 Then 'Débit caution>rendu à l''assureur'
			When @asTypRegul = 'RP' And @dcIdGti = 10 Then 'Crédit caution>réclam à l''assureur'
			When @asTypRegul = 'RM' And @dcIdGti <> 10 Then 'Débit caution>rendu à SPB Service' -- [DT081_EVOL_PRET_BRIS]
			When @asTypRegul = 'RP' And @dcIdGti <> 10 Then 'Crédit caution>réclam à SPB Service' -- [DT081_EVOL_PRET_BRIS]
			Else '?'
		End,
		Convert ( DateTime, Convert ( Varchar ( 10 ), GETDATE(), 103 ) ),
		null,
		null,
		null,
		null,
		'A',
		'C',
		@asTypRegul,
		0,
		@dcCptReg,
		GETDATE(),
		GETDATE(),
		'EW',
		GETDATE(),
		'EW',
		null  )	 
		

	-- On mets un enregistrement dans W_reg_gti, pour le traitement suivante.
	INSERT INTO     sysadm.reg_gti
		(       reg_gti.id_sin,
				reg_gti.id_reg,
				reg_gti.id_gti,
				reg_gti.id_rgpt,								
				reg_gti.id_i,
				reg_gti.mt_reg,
				reg_gti.mt_rgpt,
				reg_gti.cree_le,
				reg_gti.maj_le,
				reg_gti.maj_par
		)
	Values
		( 
		@adcIdSin,
		@dcCptReg,
		@dcIdGti,
		@dcIdGti,
		0,
		Case @asTypRegul 
			When 'RM' Then @adcMtDebit * (-1)
			When 'RP' Then @adcMtDebit
			Else 0
		End,
		Case @asTypRegul 
			When 'RM' Then @adcMtDebit * (-1)
			When 'RP' Then @adcMtDebit
			Else 0
		End,		
		GETDATE(),
		GETDATE(),
		'EW'
		)

Update sinistre 
Set cpt_reg = @dcCptReg 
Where id_sin = @adcIdSin

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_REGL_PRESTA_VDOC12845
-- Auteur               :       JFF
-- Date                 :       06/02/2014
-- Libell‚              :       [VDOC12845]
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
-- JFF      18/08/2014   [PM254_V1]
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- FPI - 09/06/2015 - [REGL_LBE] RM interdit pour LBE
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_REGL_PRESTA_VDOC12845' AND type = 'P' )
        DROP procedure sysadm.PS_S_REGL_PRESTA_VDOC12845
GO


CREATE procedure sysadm.PS_S_REGL_PRESTA_VDOC12845
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@asResult		Varchar ( 255 ) OUTPUT -- Retour chaine Bin  00000etc...
As

Declare @sBSRegNumInterAssSurGtiSansRM VarChar ( 1 )
Declare @sBSRegFourRepaRepaSansRM VarChar ( 1 )
Declare @sBSRegFourRepaIRRepaSansRM VarChar ( 1 )
Declare @sBSRegFourRepaSAVSansRM VarChar ( 1 )
Declare @sBSRegFourRemplSansRM VarChar ( 1 )
Declare @sBSRegFourDiagConfSansRM VarChar ( 1 )
Declare @sBSRegFourDiagNConfSansRM VarChar ( 1 )
Declare @sBSRemplacementNonAnn VarChar ( 1 )
Declare @sBSRepaRepaNonAnn VarChar ( 1 )
Declare @sBSRepaIRRepaNonAnn VarChar ( 1 )
Declare @sBSRepaSAVNonAnn VarChar ( 1 )
Declare @sBSDiagConfNonAnn VarChar ( 1 )
Declare @sBSDiagNConfNonAnn VarChar ( 1 )
Declare @sBSSwapCTRNonAnn VarChar ( 1 ) -- [PM254_V1]


Set @asResult = ''
Set @sBSRegNumInterAssSurGtiSansRM = '0'	-- Bin 1  -- Règlement num inter A sur une Gti sans Somme de RM Total hors UF (8).
Set @sBSRegFourRepaRepaSansRM = '0'			-- Bin 2  -- Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
Set @sBSRegFourRepaIRRepaSansRM = '0'		-- Bin 3  -- Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
Set	@sBSRegFourRepaSAVSansRM = '0'			-- Bin 4  -- Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
Set @sBSRegFourRemplSansRM  = '0'			-- Bin 5  -- Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
Set @sBSRegFourDiagConfSansRM  = '0'		-- Bin 6  -- Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
Set @sBSRegFourDiagNConfSansRM  = '0'		-- Bin 7  -- Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
Set @sBSRemplacementNonAnn = '0'			-- Bin 8  -- Remplacement (Non annulé)
Set @sBSRepaRepaNonAnn = '0'				-- Bin 9  -- Réparation (réparé) (Non annulé)
Set @sBSRepaIRRepaNonAnn = '0'				-- Bin 10 -- Réparation (irréparable) (Non annulé)
Set @sBSRepaSAVNonAnn = '0'					-- Bin 11 -- Réparation SAV (Non annulé)
Set @sBSDiagConfNonAnn = '0'				-- Bin 12 -- Diag (conforme) (Non annulé)
Set @sBSDiagNConfNonAnn = '0'				-- Bin 13 -- Diag (non conforme) (Non annulé)
Set @sBSSwapCTRNonAnn = '0'					-- Bin 14 -- Swap par CTR (Non annulé) -- [PM254_V1]


-- Bin 1  -- Règlement num inter A sur une Gti sans Somme de RM Total hors UF (8).
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.reg_gti rg,
			sysadm.detail d
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'A'
	And		r.cod_mot_reg = 'RN'
	And		rg.id_sin = r.id_sin
	And		rg.id_reg = r.id_reg
	And		rg.id_gti > 0 
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And     d.id_reg = r.id_reg
	And		d.id_gti not in ( 8 )
	) 
	Begin	
		Set @sBSRegNumInterAssSurGtiSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegNumInterAssSurGtiSansRM

-- Bin 2  -- Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_typ_art = 'PRS'
	And		c.status_gc = 2
	) 
	Begin	
		Set @sBSRegFourRepaRepaSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourRepaRepaSansRM

-- Bin 3  -- Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_typ_art = 'PRS'
	And		c.status_gc = 2
	) 
	Begin	
		Set @sBSRegFourRepaIRRepaSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourRepaIRRepaSansRM

-- Bin 4  -- Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_typ_art = 'PRS'
	And		CHARINDEX ( '_SAV=OUI', rtrim( c.info_spb_frn_cplt) ) > 0
	) 
	Begin	
		Set @sBSRegFourRepaSAVSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourRepaSAVSansRM

-- Bin 5  -- Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_typ_art not in ( 'EDI', 'PRS', 'DEV', 'AEF', 'SMS', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA' )
	) 
	Begin	
		Set @sBSRegFourRemplSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourRemplSansRM

-- Bin 6  -- Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.status_gc = 151
	) 
	Begin	
		Set @sBSRegFourDiagConfSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourDiagConfSansRM

-- Bin 7  -- Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
IF Exists ( 
	Select  r.*
	From	sysadm.reglement r,
			sysadm.detail d,
			sysadm.commande c
	Where   r.id_sin = @adcIdSin
	And		r.cod_inter = 'F'
	And		r.cod_mot_reg = 'RN'
	And		r.cod_mode_reg = 'FM'	
	And		r.mt_tot_reg <> 
			IsNull ( 	
				( 
				Select SUM ( mt_tot_reg ) * (-1)
				From   reglement r1
				Where  r1.id_sin = r.id_sin
				And	   r1.id_reg_base = r.id_reg
				And	   r1.cod_mot_reg = 'RM'
				) , 0 )
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		c.id_sin = d.id_sin
	And		c.id_gti = d.id_gti
	And		c.id_detail = d.id_detail
	And		c.id_ref_four = 'A_DIAGNOSTIQUER'
	And		c.status_gc = 152
	) 
	Begin	
		Set @sBSRegFourDiagNConfSansRM = '1'
	End 

Set @asResult = @asResult + @sBSRegFourDiagNConfSansRM

-- Bin 8  -- Remplacement (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_typ_art not in ( 'EDI', 'PRS', 'DEV', 'AEF', 'SMS', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA' ) 
	And		c.cod_etat not in ( 'ANN' ) 
	)
	Begin	
		Set @sBSRemplacementNonAnn = '1'
	End 

Set @asResult = @asResult + @sBSRemplacementNonAnn

-- Bin 9  -- Réparation (réparé) (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_typ_art = 'PRS' 
	And		c.cod_etat not in ( 'ANN' ) 
	And		c.status_gc = 2
	)
	Begin	
		Set @sBSRepaRepaNonAnn  = '1'
	End 

Set @asResult = @asResult + @sBSRepaRepaNonAnn 

-- Bin 10 -- Réparation (irréparable) (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_typ_art = 'PRS' 
	And		c.cod_etat not in ( 'ANN' ) 
	And		c.status_gc = 21
	)
	Begin	
		Set @sBSRepaIRRepaNonAnn  = '1'
	End 

Set @asResult = @asResult + @sBSRepaIRRepaNonAnn 

-- Bin 11 -- Réparation SAV (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_typ_art = 'PRS' 
	And		c.cod_etat not in ( 'ANN' ) 
	And		CHARINDEX ( '_SAV=OUI', rtrim( c.info_spb_frn_cplt) ) > 0
	)
	Begin	
		Set @sBSRepaSAVNonAnn = '1'
	End 

Set @asResult = @asResult + @sBSRepaSAVNonAnn

-- Bin 12 -- Diag (conforme) (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_ref_four = 'A_DIAGNOSTIQUER' 
	And		c.cod_etat not in ( 'ANN' ) 
	And		c.status_gc = 151
	)
	Begin	
		Set @sBSDiagConfNonAnn = '1'
	End 

Set @asResult = @asResult + @sBSDiagConfNonAnn 


-- Bin 13 -- Diag (non conforme) (Non annulé)
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		c.id_ref_four = 'A_DIAGNOSTIQUER' 
	And		c.cod_etat not in ( 'ANN' ) 
	And		c.status_gc = 152
	)
	Begin	
		Set @sBSDiagNConfNonAnn  = '1'
	End 

Set @asResult = @asResult + @sBSDiagNConfNonAnn 


-- Bin 14 -- Swap par CTR (Non annulé) -- [PM254_V1]
IF Exists ( 
	Select  *
	From	sysadm.commande c
	Where   c.id_sin = @adcIdSin
	And		CHARINDEX ( '[SWAP]', rtrim( c.comment_frn ) ) > 0
	And		c.cod_etat not in ( 'ANN' ) 
	And		c.id_typ_art = 'PRS'
	)
	Begin	
		Set @sBSSwapCTRNonAnn = '1'
	End 

Set @asResult = @asResult + @sBSSwapCTRNonAnn 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RM_AVOIR_VDOC12917
-- Auteur               :       JFF
-- Date                 :       28/01/2013
-- Libell‚              :       [VDOC12917]
-- Commentaires         :       [MASSE_RM_AV]
-- R‚f‚rences           :       [PM375-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      04/10/2019   [PM462-1][V3]
-- JFF      09/09/2022   [PM80_FA12_FRANEX] V01 en V02
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RM_AVOIR_VDOC12917_V02' AND type = 'P' )
        DROP procedure sysadm.PS_I_RM_AVOIR_VDOC12917_V02
GO

CREATE procedure sysadm.PS_I_RM_AVOIR_VDOC12917_V02
	@adcIdSin		Decimal ( 10 ) , -- [PI062]
	@aiIdSeq		Integer,
	@asIdFour		VarChar ( 3 ),
	@adcMtAvoir		Decimal (11, 2 ),
	@asLibRM		VarChar ( 35 ),
	@asCodOper		VarChar ( 4 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @dcIdInterRM Decimal (7)
Declare @dcIdRegBase Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMRPPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )
Declare	@sMtPaiementPayBox Varchar ( 50 )
Declare	@sIdRegFranchiseOrig Varchar ( 50 )
Declare @iCtrleRPFranchise Integer
Declare @sVentilFraisOrig VarChar ( 100 )
Declare @sVentilFraisEncoursAff VarChar ( 100 )
Declare @sVentilFraisEncoursCtrle VarChar ( 100 )
Declare @dcMtFraisAnexExistant Decimal ( 11,2 )
Declare @dcMtFraisAPasser Decimal ( 11,2 )
Declare @iTypeDuFrais Integer
Declare @dcMtDifFraisAnx Decimal ( 11,2 ) 
Declare @iRetCtrleSomFrais Integer

If Exists ( 
		Select Top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10 ) , @adcIdSin )
		And   alt_occupe = 'O' )
 Begin
	Set @asResult = 'ERREUR : Un travail occupé est présent sur le dossier, quelqu''un travaille dessus.'
	Return -1
 End


-- [REGL_LBE]
If @asIdFour='LBE'
 Begin
	Set @asResult = 'ERREUR : Avoir interdit pour LBE'
	Return -1
 End 

If @adcMtAvoir = 0 
 Begin
	Set @asResult = 'ERREUR : Avoir de 0€ interdit'
	Return -1
 End 

Set @adcMtAvoir = abs ( @adcMtAvoir )
Set @adcMtAvoir = @adcMtAvoir * (-1)

Select @dcIdReg = r.id_reg
From   sysadm.reglement r,
	   sysadm.inter i
Where  r.id_sin = @adcIdSin
And	   r.mt_tot_reg = @adcMtAvoir
And    r.cod_mot_reg = 'RM'
And    i.id_sin = r.id_sin
And    i.id_i = r.id_i
And    i.id_four = @asIdFour

If Not ( sysadm.FN_CLE_NUMERIQUE ( 'COUPE_CTL_MULTI_RM_M') > 0 )
 Begin
	If @dcIdReg > 0 
	  Begin
		Set @asResult = 'ERREUR (Doublon): RM déjà passé pour ce fournisseur, pour le même montant, sur le règlement numéro ' + CONVERT ( varchar ( 10 ), @dcIdReg ) + ', passez en manuel si vous voulez continuer.'
		Return -1
	  End 
 End

Set @dcIdReg = 0

Select  @dcIdRegBase = r.id_reg,
		@sCodInter = r.cod_inter,
		@dcIdInterRM = r.id_i,
		@sCodModeReg = r.cod_mode_reg,
		@dcIdGtiBase = d.id_gti,
		@dcMtTotReg = r.mt_tot_reg,
		@sIdFourCtrle = i.id_four,
		@sMtPaiementPayBox = sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';' ),  -- [PM462-1][V3]
		@sIdRegFranchiseOrig = sysadm.FN_CLE_VAL ( 'ID_REG_FRANCHISE', c.info_spb_frn_cplt, ';' )  -- [PM462-1][V3]
	
From	sysadm.commande c,
		sysadm.detail d,
		sysadm.reglement r,
		sysadm.inter i
		
Where   c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		d.id_sin = c.id_sin
And		d.id_gti = c.id_gti
And		d.id_detail = c.id_detail
And     r.id_sin = d.id_sin
And		r.id_reg = d.id_reg
And     r.cod_mode_reg = 'FM'
And		i.id_sin = r.id_sin
And		i.id_i = r.id_i

If @asIdFour <> @sIdFourCtrle
  Begin
	Set @asResult = 'ERREUR : Le fournisseur lié au règlement de ce tiret ' + CONVERT ( varchar ( 10 ), @aiIdSeq ) + ' n''est pas ' + @asIdFour + ' mais ' + @sIdFourCtrle
	Return -1
  End 

Select @dcSomRMRPPrecedent = SUM ( r.mt_tot_reg )
From sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg_base = @dcIdRegBase
And   r.lib_reg not in ( 'RM/FRANCHISE (FR5)', 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) -- [ITSM249772] [ICI]
And   r.cod_mot_reg in ( 'RM', 'RP' ) -- [ITSM429073]

If @dcSomRMRPPrecedent is null set @dcSomRMRPPrecedent = 0

If ( @dcSomRMRPPrecedent + @dcMtTotReg ) - Abs ( @adcMtAvoir ) < 0 
	Begin
		Set @asResult = 'ERREUR : La somme des RM/RP précédents liés à ce règlement d''origine + le règlement d''origine lui-même, est strictement inférieur au présent avoir: ' + CONVERT ( VarChar ( 20), @dcSomRMRPPrecedent ) + ' + ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + ' < ' + CONVERT ( VarChar ( 20), @adcMtAvoir ) + '.'
		Return -1
	End 

-- [PM80_FA12_FRANEX]
	-- Type de frais du RM jamais passé sur RN+RPs
	Set @sVentilFraisOrig = SPACE ( 100)
	Set @sVentilFraisEncoursAff = SPACE ( 100)
	Set @sVentilFraisEncoursCtrle = SPACE ( 100)

	exec sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF 
			@adcIdSin,
			@dcIdRegBase,
			@adcMtIndemPrinc_1,
			@adcMtFraisAnex_2,
			@adcMtFraisAnex_3,
			@adcMtFraisAnex_4,
			@adcMtFraisAnex_5,
			@adcMtFraisAnex_6,
			@adcMtFraisAnex_7,
			@adcMtFraisAnex_8,
			@adcMtFraisAnex_9,
			@adcMtFraisAnex_10,
			@adcMtFraisAnex_11,
			@sVentilFraisOrig OutPut,
			@sVentilFraisEncoursAff OutPut,
			@sVentilFraisEncoursCtrle OutPut

	If @sVentilFraisEncoursCtrle <> @sVentilFraisOrig
		Begin
			Set @asResult = 'ERREUR : Un ou plusieurs types de frais du RM (' + @sVentilFraisEncoursAff + ') n''ont jamais été réglé sur le RN d''origine ou RP lié au RN d''origine (' + @sVentilFraisOrig + ').' 
			Return -1
		End 

	-- Les sommes de ventilation de chaque type de frais sur les RM sont supérieurs à la somme des RN+RP du même frais
	Exec @iRetCtrleSomFrais = sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO
			@adcIdSin,
			@dcIdRegBase,
			@adcMtIndemPrinc_1,
			@adcMtFraisAnex_2,
			@adcMtFraisAnex_3,
			@adcMtFraisAnex_4,
			@adcMtFraisAnex_5,
			@adcMtFraisAnex_6,
			@adcMtFraisAnex_7,
			@adcMtFraisAnex_8,
			@adcMtFraisAnex_9,
			@adcMtFraisAnex_10,
			@adcMtFraisAnex_11,
			@dcMtFraisAnexExistant OutPut,
			@dcMtFraisAPasser OutPut, 
			@iTypeDuFrais OutPut,
			@dcMtDifFraisAnx OutPut

	If @iRetCtrleSomFrais < 0 
		Begin
			Set @asResult = 'ERREUR : La somme des RN/RM/RP du frais ' + Convert ( varchar ( 20), @iTypeDuFrais) + ' (' + sysadm.FN_CODE_NUM ( @iTypeDuFrais, '-W7' ) + ') est de ' + CONVERT ( varchar ( 20), @dcMtFraisAnexExistant) + '€, vous ne pouvez donc soustraire un RM de -' + CONVERT ( varchar ( 20), abs ( @dcMtFraisAPasser) ) + '€, cela donnerait un nombre négatif au final (' + CONVERT ( varchar ( 20), @dcMtDifFraisAnx ) + '€).'
			Return -1
		End 

If @dcIdRegBase is null
 Begin
	Set @asResult = 'ERREUR : Cette prestation ne réfère aucun règlement fournisseur'
	Return -1
 End 

Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select @dcIdReg = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdReg,
@adcMtAvoir,
@asLibRM,
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
@sCodInter,
@sCodModeReg, 
'RM',
@dcIdInterRM,
@dcIdRegBase,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdReg,
@dcIdGtiBase,
@dcIdGtiBase,
@dcIdInterRM,
@adcMtAvoir,
@adcMtAvoir,
Getdate(),
Getdate(),
@asCodOper
)

-- [PM80_FA12_FRANEX]
Exec sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01 
	@adcIdSin,
	@dcIdReg,
	@dcIdInterRM,
	@dcIdGtiBase,
	-1,
	@adcMtIndemPrinc_1,
	@adcMtFraisAnex_2,
	@adcMtFraisAnex_3,
	@adcMtFraisAnex_4,
	@adcMtFraisAnex_5,
	@adcMtFraisAnex_6,
	@adcMtFraisAnex_7,
	@adcMtFraisAnex_8,
	@adcMtFraisAnex_9,
	@adcMtFraisAnex_10,
	@adcMtFraisAnex_11,
	@asCodOper


Insert into w_a_virer 
Select r.id_sin,
	   r.id_i,
	   r.id_reg,
	   r.cod_inter,
	   s.id_prod,
	   s.id_ets,
	   s.id_adh,
	   s.id_sdos,
	   null,
	   null,
	   null,
	   null,
	   r.mt_tot_reg,
	   r.cod_mode_reg,
	   0,
	   Getdate(),
	   GETDATE(),
	   @asCodOper
from reglement r,
	 sinistre s
where r.id_sin = @adcIdSin
And	  r.id_reg = @dcIdReg
And	  s.id_sin = r.id_sin

Update sysadm.w_sin
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin

Update sysadm.sinistre
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin

Update sysadm.inter
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRM

Update sysadm.w_inter
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRM

Update sysadm.w_gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
    mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Update sysadm.gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
    mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

-- [PM462-1][V3]
/*
If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1' ) >= 0 
 Begin
		-- Cas du RP/FM (Tag FR) donc pas dans APF quotidien, mais RP/FM au mensuel tagué FR
	Set @sMtPaiementPayBox = ltrim ( rTrim ( @sMtPaiementPayBox  ))
	Set @sIdRegFranchiseOrig = ltrim ( rTrim ( @sIdRegFranchiseOrig ))

	If IsNumeric ( @sMtPaiementPayBox ) = 1 
		Begin
			Exec sysadm.PS_I_RPFM_TAGFR_REGUL_FRANCHISE_CB
				@adcIdSin,
				@dcIdReg,
				@sMtPaiementPayBox,
				@sIdRegFranchiseOrig,
				@sCodInter,
				@sCodModeReg,
				@dcIdInterRM,
				@asCodOper,
				@dcIdGtiBase,
				@iCtrleRPFranchise OUTPUT		
		End 
	  
 End 
 */

If @iCtrle = 1 
 Begin 
	
	-- [VDOC21687]
	If abs ( @adcMtAvoir ) < abs ( @dcMtTotReg )
	 Begin
		Set @asResult = '(RM inférieur) >> SUCCES : RM de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 End
	Else
	 Begin
		Set @asResult = 'SUCCES : RM de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 End

	Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) 
	Set @asResult = @asResult + ' en référence de l''id_reg_base ' + CONVERT ( VarChar ( 10 ), @dcIdRegBase ) + ' d''un montant de ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + '€'
	Set @asResult = @asResult + ' lié à la prestation tiret -' + CONVERT ( VarChar ( 10 ), @aiIdSeq ) + '.'
	Set @asResult = @asResult + 'Libellé du RM : ' + @asLibRM + '.'

	-- [PM462-1][V3]
/*
	If sysadm.FN_CLE_NUMERIQUE ( 'PM462-1' ) >= 0 
	 Begin
		If @iCtrleRPFranchise > 0 
		  Begin 
			Set @asResult = @asResult + 'Cette action génère un rendu de franchise à l''assureur de ' + @sMtPaiementPayBox + '€.'		
		  End 
	 End 
*/

	Set @sMess = Right ( rtrim( @asResult ), LEN ( rtrim( @asResult )) - 9 )

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT			
	END


	Return 1
 End
Else
 Begin
	Set @asResult = 'ERREUR : Problème Insertion du RM en base, contacter Jean-François' + @asLibRM + '.'
	Return -1
 End 

Go

grant execute on sysadm.PS_I_RM_AVOIR_VDOC12917_V01 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RP_AVOIR_PM375
-- Auteur               :       JFF
-- Date                 :       30/11/2016
-- Libell‚              :       [VDOC12917]
-- Commentaires         :       [MASSE_RP_AV]
-- R‚f‚rences           :       [PM375-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX] rien en V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RP_AVOIR_PM375_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_RP_AVOIR_PM375_V01
GO

CREATE procedure sysadm.PS_I_RP_AVOIR_PM375_V01
	@adcIdSin		Decimal ( 10 ) , -- [PI062]
	@aiIdSeq		Integer,
	@asIdFour		VarChar ( 3 ),
	@adcMtAvoir		Decimal (11, 2 ),
	@asLibRP		VarChar ( 35 ),
	@asCodOper		VarChar ( 4 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @dcIdInterRP Decimal (7)
Declare @dcIdRegBase Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMRPPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )

If Exists ( 
		Select Top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10 ) , @adcIdSin )
		And   alt_occupe = 'O' )
 Begin
	Set @asResult = 'ERREUR : Un travail occupé est présent sur le dossier, quelqu''un travaille dessus.'
	Return -1
 End


-- [REGL_LBE]
If @asIdFour='LBE'
 Begin
	Set @asResult = 'ERREUR : Avoir interdit pour LBE'
	Return -1
 End 

If @adcMtAvoir = 0 
 Begin
	Set @asResult = 'ERREUR : Avoir de 0€ interdit'
	Return -1
 End 

Set @adcMtAvoir = abs ( @adcMtAvoir )

Select @dcIdReg = r.id_reg
From   sysadm.reglement r,
	   sysadm.inter i
Where  r.id_sin = @adcIdSin
And	   r.mt_tot_reg = @adcMtAvoir
And    r.cod_mot_reg = 'RP'
And    i.id_sin = r.id_sin
And    i.id_i = r.id_i
And    i.id_four = @asIdFour

If @dcIdReg > 0 
  Begin
	Set @asResult = 'ERREUR (Doublon): RP déjà passé pour ce fournisseur, pour le même montant, sur le règlement numéro ' + CONVERT ( varchar ( 10 ), @dcIdReg ) + ', passez en manuel si vous voulez continuer.'
	Return -1
  End 
Set @dcIdReg = 0


Select  @dcIdRegBase = r.id_reg,
		@sCodInter = r.cod_inter,
		@dcIdInterRP = r.id_i,
		@sCodModeReg = r.cod_mode_reg,
		@dcIdGtiBase = d.id_gti,
		@dcMtTotReg = r.mt_tot_reg,
		@sIdFourCtrle = i.id_four
		
From	sysadm.commande c,
		sysadm.detail d,
		sysadm.reglement r,
		sysadm.inter i
		
Where   c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		d.id_sin = c.id_sin
And		d.id_gti = c.id_gti
And		d.id_detail = c.id_detail
And     r.id_sin = d.id_sin
And		r.id_reg = d.id_reg
And     r.cod_mode_reg = 'FM'
And		i.id_sin = r.id_sin
And		i.id_i = r.id_i

If @asIdFour <> @sIdFourCtrle
  Begin
	Set @asResult = 'ERREUR : Le fournisseur lié au règlement de ce tiret ' + CONVERT ( varchar ( 10 ), @aiIdSeq ) + ' n''est pas ' + @asIdFour + ' mais ' + @sIdFourCtrle
	Return -1
  End 


If @dcIdRegBase is null
 Begin
	Set @asResult = 'ERREUR : Cette prestation ne réfère aucun règlement fournisseur'
	Return -1
 End 

Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select @dcIdReg = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdReg,
@adcMtAvoir,
@asLibRP,
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
@sCodInter,
@sCodModeReg, 
'RP',
@dcIdInterRP,
@dcIdRegBase,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdReg,
@dcIdGtiBase,
@dcIdGtiBase,
@dcIdInterRP,
@adcMtAvoir,
@adcMtAvoir,
Getdate(),
Getdate(),
@asCodOper
)

-- [PM80_FA12_FRANEX]
Exec sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01 
	@adcIdSin,
	@dcIdReg,
	@dcIdInterRP,
	@dcIdGtiBase,
	-1,
	@adcMtIndemPrinc_1,
	@adcMtFraisAnex_2,
	@adcMtFraisAnex_3,
	@adcMtFraisAnex_4,
	@adcMtFraisAnex_5,
	@adcMtFraisAnex_6,
	@adcMtFraisAnex_7,
	@adcMtFraisAnex_8,
	@adcMtFraisAnex_9,
	@adcMtFraisAnex_10,
	@adcMtFraisAnex_11,
	@asCodOper


Insert into w_a_virer 
Select r.id_sin,
	   r.id_i,
	   r.id_reg,
	   r.cod_inter,
	   s.id_prod,
	   s.id_ets,
	   s.id_adh,
	   s.id_sdos,
	   null,
	   null,
	   null,
	   null,
	   r.mt_tot_reg,
	   r.cod_mode_reg,
	   0,
	   Getdate(),
	   GETDATE(),
	   @asCodOper
from reglement r,
	 sinistre s
where r.id_sin = @adcIdSin
And	  r.id_reg = @dcIdReg
And	  s.id_sin = r.id_sin

Update sysadm.w_sin
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin

Update sysadm.sinistre
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin

Update sysadm.inter
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRP

Update sysadm.w_inter
Set mt_reg = mt_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRP

Update sysadm.w_gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
    mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Update sysadm.gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
    mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

If @iCtrle = 1 
 Begin 
	
	-- [VDOC21687]
	Set @asResult = 'SUCCES : RP de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 
	Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) 
	Set @asResult = @asResult + ' en référence de l''id_reg_base ' + CONVERT ( VarChar ( 10 ), @dcIdRegBase ) + ' d''un montant de ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + '€'
	Set @asResult = @asResult + ' lié à la prestation tiret -' + CONVERT ( VarChar ( 10 ), @aiIdSeq ) + '.'
	Set @asResult = @asResult + 'Libellé du RP : ' + @asLibRP + '.'

	Set @sMess = Right ( rtrim( @asResult ), LEN ( rtrim( @asResult )) - 9 )

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT			
	END


	Return 1
 End
Else
 Begin
	Set @asResult = 'ERREUR : Problème Insertion du RP en base, contacter Jean-François' + @asLibRP + '.'
	Return -1
 End 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RM_SIMPLE_PM375
-- Auteur               :       JFF
-- Date                 :       30/11/2016
-- Libell‚              :       [VDOC12917]
-- Commentaires         :       [MASSE_RM_SPL]
-- R‚f‚rences           :       [PM375-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      29/05/2017   [PC151259-2]
-- JFF      04/10/2019   [PM462-1][V3]
-- JFF      09/09/2022   [PM80_FA12_FRANEX] rien en V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RM_SIMPLE_PM375_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_RM_SIMPLE_PM375_V01
GO

CREATE procedure sysadm.PS_I_RM_SIMPLE_PM375_V01
	@adcIdSin		Decimal ( 10 ) , -- [PI062]
	@adcIdRegBase   Decimal (7),		
	@adcMtRM		Decimal (11, 2 ),
	@asLibRM		VarChar ( 35 ),
	@asCodOper		VarChar ( 4 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @dcIdInterRM Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMRPPrecedent Decimal (11,2)
Declare @iRowCountReg Integer 
Declare @sVentilFraisOrig VarChar ( 100 )
Declare @sVentilFraisEncoursAff VarChar ( 100 )
Declare @sVentilFraisEncoursCtrle VarChar ( 100 )
Declare @dcMtFraisAnexExistant Decimal ( 11,2 )
Declare @dcMtFraisAPasser Decimal ( 11,2 )
Declare @iTypeDuFrais Integer
Declare @dcMtDifFraisAnx Decimal ( 11,2 ) 
Declare @iRetCtrleSomFrais Integer

If Exists ( 
		Select Top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10 ) , @adcIdSin )
		And   alt_occupe = 'O' )
 Begin
	Set @asResult = 'ERREUR : Un travail occupé est présent sur le dossier, quelqu''un travaille dessus.'
	Return -1
 End

If @adcIdRegBase is null
 Begin
	Set @asResult = 'ERREUR : Le numéro de règlement de base (RN) doit être renseigné'
	Return -1
 End 

If @adcMtRM = 0 
 Begin
	Set @asResult = 'ERREUR : RM de 0€ interdit'
	Return -1
 End 

Set @adcMtRM = abs ( @adcMtRM )
Set @adcMtRM = @adcMtRM * (-1)

Select @dcIdReg = r.id_reg
From   sysadm.reglement r
Where  r.id_sin = @adcIdSin
And	   r.mt_tot_reg = @adcMtRM
And    r.cod_mot_reg = 'RM'

If @dcIdReg > 0 
  Begin
	Set @asResult = 'ERREUR (Doublon): RM simple déjà passé pour ce fournisseur, pour le même montant, sur le règlement numéro ' + CONVERT ( varchar ( 10 ), @dcIdReg ) + ', passez en manuel si vous voulez continuer.'
	Return -1
  End 
Set @dcIdReg = 0


Select  Top 1
		@sCodInter = r.cod_inter,
		@dcIdInterRM = r.id_i,
		@sCodModeReg =	Case r.cod_mode_reg
						  When 'XA' Then r.cod_mode_reg
						  Else 'C'
						End, -- [PC151259-2] 'XA' ou 'C' selon contexte
		@dcIdGtiBase = rg.id_gti,
		@dcMtTotReg = r.mt_tot_reg
		
From	sysadm.reglement r,
		sysadm.reg_gti  rg
		
Where   r.id_sin = @adcIdSin
And		r.id_reg = @adcIdRegBase
And		r.cod_mot_reg = 'RN'
And     rg.id_sin = r.id_sin
And		rg.id_reg = r.id_reg
Set @iRowCountReg = @@ROWCOUNT

If @iRowCountReg = 0 
 Begin
	Set @asResult = 'ERREUR : Le numéro de règlement de base (RN), numéro ' + convert ( varchar, @adcIdRegBase ) + ' n''existe pas sur ce dossier.'
	Return -1
 End 

Select @dcSomRMRPPrecedent = SUM ( r.mt_tot_reg )
From sysadm.reglement r
Where r.id_sin = @adcIdSin
And   r.id_reg_base = @adcIdRegBase
And   r.lib_reg not in ( 'RM/FRANCHISE (FR5)', 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) -- [ITSM249772] -- [PM462-1][V3]
And   r.cod_mot_reg in ( 'RM', 'RP' ) -- [ITSM429073]

If @dcSomRMRPPrecedent is null set @dcSomRMRPPrecedent = 0

If ( @dcSomRMRPPrecedent + @dcMtTotReg ) - Abs ( @adcMtRM ) < 0 
	Begin
		Set @asResult = 'ERREUR : La somme des RM/RP précédents liés à ce règlement d''origine + le règlement d''origine lui-même, est strictement inférieur au présent RM: ' + CONVERT ( VarChar ( 20), @dcSomRMRPPrecedent ) + ' + ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + ' < ' + CONVERT ( VarChar ( 20), @adcMtRM ) + '.'
		Return -1
	End 

-- [PM80_FA12_FRANEX]
-- Type de frais du RM jamais passé sur RN+RPs

Set @sVentilFraisOrig = SPACE ( 100)
Set @sVentilFraisEncoursAff = SPACE ( 100)
Set @sVentilFraisEncoursCtrle = SPACE ( 100)

exec sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF 
		@adcIdSin,
		@adcIdRegBase,
		@adcMtIndemPrinc_1,
		@adcMtFraisAnex_2,
		@adcMtFraisAnex_3,
		@adcMtFraisAnex_4,
		@adcMtFraisAnex_5,
		@adcMtFraisAnex_6,
		@adcMtFraisAnex_7,
		@adcMtFraisAnex_8,
		@adcMtFraisAnex_9,
		@adcMtFraisAnex_10,
		@adcMtFraisAnex_11,
		@sVentilFraisOrig OutPut,
		@sVentilFraisEncoursAff OutPut,
		@sVentilFraisEncoursCtrle OutPut

If @sVentilFraisEncoursCtrle <> @sVentilFraisOrig
	Begin
		Set @asResult = 'ERREUR : Un ou plusieurs types de frais du RM (' + @sVentilFraisEncoursAff + ') n''ont jamais été réglé sur le RN d''origine ou RP lié au RN d''origine (' + @sVentilFraisOrig + ').' 
		Return -1
	End 

-- Les sommes de ventilation de chaque type de frais sur les RM sont supérieurs à la somme des RN+RP du même frais
Exec @iRetCtrleSomFrais = sysadm.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO
		@adcIdSin,
		@adcIdRegBase,
		@adcMtIndemPrinc_1,
		@adcMtFraisAnex_2,
		@adcMtFraisAnex_3,
		@adcMtFraisAnex_4,
		@adcMtFraisAnex_5,
		@adcMtFraisAnex_6,
		@adcMtFraisAnex_7,
		@adcMtFraisAnex_8,
		@adcMtFraisAnex_9,
		@adcMtFraisAnex_10,
		@adcMtFraisAnex_11,
		@dcMtFraisAnexExistant OutPut,
		@dcMtFraisAPasser OutPut, 
		@iTypeDuFrais OutPut,
		@dcMtDifFraisAnx OutPut

If @iRetCtrleSomFrais < 0 
	Begin
		Set @asResult = 'ERREUR : La somme des RN/RM/RP du frais ' + Convert ( varchar ( 20), @iTypeDuFrais) + ' (' + sysadm.FN_CODE_NUM ( @iTypeDuFrais, '-W7' ) + ') est de ' + CONVERT ( varchar ( 20), @dcMtFraisAnexExistant) + '€, vous ne pouvez donc soustraire un RM de -' + CONVERT ( varchar ( 20), abs (@dcMtFraisAPasser) ) + '€, cela donnerait un nombre négatif au final (' + CONVERT ( varchar ( 20), @dcMtDifFraisAnx ) + '€).'
		Return -1
	End 
 
Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select @dcIdReg = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdReg,
@adcMtRM,
@asLibRM,
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
@sCodInter,
@sCodModeReg, 
'RM',
@dcIdInterRM,
@adcIdRegBase,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdReg,
@dcIdGtiBase,
@dcIdGtiBase,
@dcIdInterRM,
@adcMtRM,
@adcMtRM,
Getdate(),
Getdate(),
@asCodOper
)

-- [PM80_FA12_FRANEX]
Exec sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01 
	@adcIdSin,
	@dcIdReg,
	@dcIdInterRM,
	@dcIdGtiBase,
	-1,
	@adcMtIndemPrinc_1,
	@adcMtFraisAnex_2,
	@adcMtFraisAnex_3,
	@adcMtFraisAnex_4,
	@adcMtFraisAnex_5,
	@adcMtFraisAnex_6,
	@adcMtFraisAnex_7,
	@adcMtFraisAnex_8,
	@adcMtFraisAnex_9,
	@adcMtFraisAnex_10,
	@adcMtFraisAnex_11,
	@asCodOper

Update sysadm.w_sin
Set mt_reg = mt_reg + @adcMtRM
Where id_sin = @adcIdSin

Update sysadm.sinistre
Set mt_reg = mt_reg + @adcMtRM
Where id_sin = @adcIdSin

Update sysadm.inter
Set mt_reg = mt_reg + @adcMtRM
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRM

Update sysadm.w_inter
Set mt_reg = mt_reg + @adcMtRM
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRM

Update sysadm.w_gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtRM,
    mt_plaf_reg  = mt_plaf_reg + @adcMtRM
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Update sysadm.gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtRM,
    mt_plaf_reg  = mt_plaf_reg + @adcMtRM
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

If @iCtrle = 1 
 Begin 
	
	-- [VDOC21687]
	If abs ( @adcMtRM ) < abs ( @dcMtTotReg )
	 Begin
		Set @asResult = '(RM inférieur) >> SUCCES : RM simple de ' + CONVERT ( VarChar ( 20), @adcMtRM )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 End
	Else
	 Begin
		Set @asResult = 'SUCCES : RM simple de ' + CONVERT ( VarChar ( 20), @adcMtRM )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 End

	Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) 
	Set @asResult = @asResult + ' en référence de l''id_reg_base ' + CONVERT ( VarChar ( 10 ), @adcIdRegBase ) + ' d''un montant de ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + '€'
	Set @asResult = @asResult + ' non lié à une prestation.'
	Set @asResult = @asResult + 'Libellé du RM : ' + @asLibRM + '.'

	Set @sMess = Right ( rtrim( @asResult ), LEN ( rtrim( @asResult )) - 9 )

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT			
	END


	Return 1
 End
Else
 Begin
	Set @asResult = 'ERREUR : Problème Insertion du RM en base, contacter Jean-François' + @asLibRM + '.'
	Return -1
 End 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RP_SIMPLE_PM375
-- Auteur               :       JFF
-- Date                 :       30/11/2016
-- Libell‚              :       [VDOC12917]
-- Commentaires         :       [MASSE_RP_SPL]
-- R‚f‚rences           :       [PM375-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      29/05/2017   [PC151259-2]
-- JFF      09/09/2022   [PM80_FA12_FRANEX] rien en V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RP_SIMPLE_PM375_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_RP_SIMPLE_PM375_V01
GO

CREATE procedure sysadm.PS_I_RP_SIMPLE_PM375_V01
	@adcIdSin		Decimal ( 10 ) , -- [PI062]
	@adcIdRegBase   Decimal (7),		
	@adcMtRP		Decimal (11, 2 ),
	@asLibRP		VarChar ( 35 ),
	@asCodOper		VarChar ( 4 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @dcIdInterRP Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMRPPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )
Declare @iRowCountReg Integer 

If Exists ( 
		Select Top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10 ) , @adcIdSin )
		And   alt_occupe = 'O' )
 Begin
	Set @asResult = 'ERREUR : Un travail occupé est présent sur le dossier, quelqu''un travaille dessus.'
	Return -1
 End


If @adcIdRegBase is null
 Begin
	Set @asResult = 'ERREUR : Le numéro de règlement de base (RN) doit être renseigné'
	Return -1
 End 

If @adcMtRP = 0 
 Begin
	Set @asResult = 'ERREUR : RP de 0€ interdit'
	Return -1
 End 

Set @adcMtRP = abs ( @adcMtRP )

Select @dcIdReg = r.id_reg
From   sysadm.reglement r
Where  r.id_sin = @adcIdSin
And	   r.mt_tot_reg = @adcMtRP
And    r.cod_mot_reg = 'RP'

If @dcIdReg > 0 
  Begin
	Set @asResult = 'ERREUR (Doublon): RP simple déjà passé pour ce fournisseur, pour le même montant, sur le règlement numéro ' + CONVERT ( varchar ( 10 ), @dcIdReg ) + ', passez en manuel si vous voulez continuer.'
	Return -1
  End 
Set @dcIdReg = 0

Select  Top 1
		@sCodInter = r.cod_inter,
		@dcIdInterRP = r.id_i,
		@sCodModeReg = Case r.cod_mode_reg
						  When 'XA' Then r.cod_mode_reg
						  Else 'C'
						End, -- [PC151259-2] 'XA' ou 'C' selon contexte
		@dcIdGtiBase = rg.id_gti,
		@dcMtTotReg = r.mt_tot_reg
		
From	sysadm.reglement r,
		sysadm.reg_gti  rg
		
Where   r.id_sin = @adcIdSin
And		r.id_reg = @adcIdRegBase
And		r.cod_mot_reg = 'RN'
And     rg.id_sin = r.id_sin
And		rg.id_reg = r.id_reg
Set @iRowCountReg = @@ROWCOUNT

If @iRowCountReg = 0 
 Begin
	Set @asResult = 'ERREUR : Le numéro de règlement de base (RN), numéro ' + convert ( varchar, @adcIdRegBase ) + ' n''existe pas sur ce dossier.'
	Return -1
 End 


Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select @dcIdReg = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdReg,
@adcMtRP,
@asLibRP,
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
@sCodInter,
@sCodModeReg, 
'RP',
@dcIdInterRP,
@adcIdRegBase,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdReg,
@dcIdGtiBase,
@dcIdGtiBase,
@dcIdInterRP,
@adcMtRP,
@adcMtRP,
Getdate(),
Getdate(),
@asCodOper
)

-- [PM80_FA12_FRANEX]
Exec sysadm.PS_I_REG_FRAIS_ANNEXE_FRN_V01 
	@adcIdSin,
	@dcIdReg,
	@dcIdInterRP,
	@dcIdGtiBase,
	-1,
	@adcMtIndemPrinc_1,
	@adcMtFraisAnex_2,
	@adcMtFraisAnex_3,
	@adcMtFraisAnex_4,
	@adcMtFraisAnex_5,
	@adcMtFraisAnex_6,
	@adcMtFraisAnex_7,
	@adcMtFraisAnex_8,
	@adcMtFraisAnex_9,
	@adcMtFraisAnex_10,
	@adcMtFraisAnex_11,
	@asCodOper

Update sysadm.w_sin
Set mt_reg = mt_reg + @adcMtRP
Where id_sin = @adcIdSin

Update sysadm.sinistre
Set mt_reg = mt_reg + @adcMtRP
Where id_sin = @adcIdSin

Update sysadm.inter
Set mt_reg = mt_reg + @adcMtRP
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRP

Update sysadm.w_inter
Set mt_reg = mt_reg + @adcMtRP
Where id_sin = @adcIdSin
and   id_i = @dcIdInterRP

Update sysadm.w_gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtRP,
    mt_plaf_reg  = mt_plaf_reg + @adcMtRP
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Update sysadm.gar_sin
Set mt_nplaf_reg = mt_nplaf_reg + @adcMtRP,
    mt_plaf_reg  = mt_plaf_reg + @adcMtRP
Where id_sin = @adcIdSin
and   id_gti = @dcIdGtiBase

Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

If @iCtrle = 1 
 Begin 
	
	-- [VDOC21687]
	Set @asResult = 'SUCCES : RP simple de ' + CONVERT ( VarChar ( 20), @adcMtRP )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 
	Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) 
	Set @asResult = @asResult + ' en référence de l''id_reg_base ' + CONVERT ( VarChar ( 10 ), @adcIdRegBase ) + ' d''un montant de ' + CONVERT ( VarChar ( 20), @dcMtTotReg ) + '€'
	Set @asResult = @asResult + ' non lié à une prestation.'
	Set @asResult = @asResult + 'Libellé du RP : ' + @asLibRP + '.'

	Set @sMess = Right ( rtrim( @asResult ), LEN ( rtrim( @asResult )) - 9 )

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT			
	END


	Return 1
 End
Else
 Begin
	Set @asResult = 'ERREUR : Problème Insertion du RP en base, contacter Jean-François' + @asLibRP + '.'
	Return -1
 End 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RN_FRAIS_FACTU_PM375
-- Auteur               :       JFF
-- Date                 :       30/11/2016
-- Libell‚              :       [VDOC12917]
-- Commentaires         :       [MASSE_RN_1FRAIS]
-- R‚f‚rences           :       [PM375-1]
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      22/10/2019   [PI087_PM473_2]
-- JFF      09/09/2022   [PM80_FA12_FRANEX] rien en V01
-- JFF      30/05/2023   [PMO89_RS4822]
-- JFF      07/03/2023   [LGY38]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RN_FRAIS_FACTU_PM375_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_RN_FRAIS_FACTU_PM375_V01
GO

CREATE procedure sysadm.PS_I_RN_FRAIS_FACTU_PM375_V01
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@adcMtRN		Decimal (11, 2 ),
	@asLibRN		VarChar ( 35 ),
	@asIdFourFct	VarChar ( 3 ),
	@asCodOper		VarChar ( 4 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @dcIdInterRP Decimal (7)
Declare @dcIdRegBase Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMRPPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )
Declare @iRowCountReg Integer 
Declare @dcNewIdDetail Decimal ( 7 )
Declare @dcMtValAchat Decimal (11,2)
Declare @dcMtValPublique Decimal (11,2)
Declare @dcIdProd Decimal ( 7 )
Declare @dcIdRev Decimal ( 7 )
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @dcIdI Decimal ( 7 )
Declare @sNoBoite       Varchar ( 10   )
Declare @iRet Integer
Declare @sProc          Varchar ( 60   )
Declare @sMethode	VarChar ( 3 ) 
Declare @dtValideLe     DateTime 
Declare @sMsgTemp VarChar ( 500 )
Declare @sErr varchar(60)
Declare @dtDteDet DateTime 

If Exists ( 
		Select Top 1 1 
		From sysadm.w_queue wq
		Where wq.id_sin = Convert ( varchar ( 10 ) , @adcIdSin )
		And   alt_occupe = 'O' )
 Begin
	Set @asResult = 'ERREUR : Un travail occupé est présent sur le dossier, quelqu''un travaille dessus.'
	Return -1
 End
 
If @asIdFourFct is null Or ltrim ( rtrim ( @asIdFourFct  )) = '' Or len ( ltrim ( rtrim ( @asIdFourFct  )) ) < 3
 Begin
	Set @asResult = 'ERREUR : Le fournisseur de facturation est mal renseigné (non valide).'
	Return -1
 End

If Not Exists ( 
		Select Top 1 1 
		From   agence a, code_car c
		where  a.id_ag = c.id_code
		and    c.id_typ_code  = '-FR'
		and	   a.id_bq = @asIdFourFct
	)
 Begin
	Set @asResult = 'ERREUR : Le fournisseur de facturation ' + @asIdFourFct + ' n''existe pas.'
	Return -1
 End 

If @adcMtRN = 0 
 Begin
	Set @asResult = 'ERREUR : RN de 0€ interdit'
	Return -1
 End 

Set @adcMtRN = abs ( @adcMtRN )

Select  Top 1 
		@dcIdRegBase = r.id_reg,
		@sCodInter = r.cod_inter,
		@dcIdInterRP = r.id_i,
		@sCodModeReg = r.cod_mode_reg,
		@dcMtTotReg = r.mt_tot_reg


From	sysadm.reglement r,
		sysadm.inter i
		
Where   r.id_sin = @adcIdSin
And     r.cod_mode_reg = 'FM'
And		i.id_sin = r.id_sin
And		i.id_i = r.id_i
And		i.id_four = @asIdFourFct

Set @iRowCountReg = @@ROWCOUNT

/*
If @iRowCountReg > 0
 Begin
	Set @asResult = 'ERREUR : Le fournisseur de facturation ' + @asIdFourFct + ' a déjà reçu un règlement sur ce dossier (reglement numéro ' + convert ( varchar, @dcIdRegBase) + '), pour un montant ' + convert ( varchar, @dcMtTotReg ) + '€. Passez par un RP avec AVOIR.'
	Return -1
 End 
*/

Select  @dcIdProd = s.id_prod,
		@dcIdRev = s.id_rev
From	sysadm.sinistre s
Where   s.id_sin = @adcIdSin

Select Top 1 
		@dcIdGtiBase = c.id_gti 
From sysadm.commande c 
where c.id_sin = @adcIdSin 

If @dcIdGtiBase = 0 Or @dcIdGtiBase is null
 Begin
	Select Top 1 
			@dcIdGtiBase = g.id_gti 
	From sysadm.gar_sin g 
	where g.id_sin = @adcIdSin 
	And   g.id_gti not in ( 8 )
 End 

If @dcIdGtiBase = 0 Or @dcIdGtiBase is null
 Begin
	Set @asResult = 'ERREUR : Impossible de déterminer la garantie sur laquelle faire le règlement, passez en manuel.'
	Return -1
 End 

Select Top 1 @dcMtValAchat = d.mt_val_achat
From   sysadm.detail d
Where  d.id_sin = @adcIdSin
And    d.id_gti = @dcIdGtiBase
And    d.mt_val_achat > 0
And    d.mt_val_achat <> 9999

If @dcMtValAchat is null Set @dcMtValAchat = 0

Select Top 1 @dcMtValPublique = d.mt_val_publique
From   sysadm.detail d
Where  d.id_sin = @adcIdSin
And    d.id_gti = @dcIdGtiBase
And    d.mt_val_publique > 0
And    d.mt_val_publique <> 9999

If @dcMtValPublique is null Set @dcMtValPublique = 0


Select	@dcNewIdDetail = max ( id_detail ) 
From	sysadm.detail
where   id_sin = @adcIdSin
and     id_gti = @dcIdGtiBase 

Select Top 1 @dtDteDet = dt.dte_det
From	sysadm.detail dt
Where   dt.id_sin = @adcIdSin
And		dt.dte_det is not null

If @dcNewIdDetail is null Set @dcNewIdDetail = 0
Set @dcNewIdDetail = @dcNewIdDetail + 1

If Not exists ( 
	Select Top 1 1
	From sysadm.code_condition cc,
		 sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And	  cc.id_prod = s.id_prod
	And   cc.id_typ_code = '+EV'
	And   cc.id_code = 1091
	And   cc.id_gti = @dcIdGtiBase
	)
	Begin
		Insert into sysadm.code_condition values ( @dcIdProd, '+EV', 1091, @dcIdGtiBase, null, getdate(), getdate(), 'AUTO' )
	End 

Select '@dcIdGtiBase', @dcIdGtiBase

If Not exists ( 
	Select Top 1 1
	From sysadm.condition cc,
		 sysadm.sinistre s
	Where s.id_sin = @adcIdSin
	And   s.id_rev >= 0 
	And	  cc.id_prod = s.id_prod
	And   cc.id_rev = s.id_rev 
	And   cc.id_typ_code = '+EV'
	And   cc.id_code = 1091
	And   cc.id_gti = @dcIdGtiBase
	)
	Begin
		Insert into sysadm.condition values ( @dcIdProd, @dcIdRev , @dcIdGtiBase, 1091, '+EV', 'O', 'N', 'N', 'N', getdate(), getdate(), 'AUTO' )
	End 
		
Select  @dDteRecu=getdate(),
		@dDteFinGti=s.dte_fin_gti
From sysadm.w_sin s
Where s.id_sin = @adcIdSin

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@adcIdSin
				,2
				,''
				,'ML'
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
END
ELSE
BEGIN
	exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@adcIdSin
				,2
				,''
				,'ML'
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
END

-- [LGY38]
If sysadm.FN_CLE_NUMERIQUE ( 'LGY38') > 0 
	Begin
		Update sysadm.w_queue Set etat_iwd = 99 Where id_sin = @adcIdSin
	End 

-- Le travail doit être occupé !!
Update w_queue set alt_occupe = 'O' where id_sin = @adcIdSin

-- L'inter fournisseur Fourn existe-til ?
If Not Exists ( 
	Select *
	From w_inter wi
	Where wi.id_sin = @adcIdSin
	And   wi.id_four = @asIdFourFct
	And   wi.cod_inter = 'F'
		    )
	Begin
		-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
					From   sysadm.w_inter i
					Where  i.id_sin = @adcIdSin )

		Insert into w_inter 
		Select	
			@adcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
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
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@asIdFourFct ,
			'N',
			null,
			null,
			null,
			null, -- [PMO89_RS4822]
			null, -- [PMO89_RS4822]
			null, -- [PMO89_RS4822]
			null -- [PMO89_RS4822]

		From   	sysadm.agence a
		Where 	a.id_bq = @asIdFourFct 
	End 
   Else
    Begin
		Select @dcIdI = wi.id_i
		From w_inter wi
		Where wi.id_sin = @adcIdSin
		And   wi.id_four = @asIdFourFct 
		And   wi.cod_inter = 'F'
    End 

Insert into sysadm.w_detail 
	Select 
	@adcIdSin,
	@dcIdGtiBase,
	@dcNewIdDetail,
	1091,
	@asLibRN,
	@dtDteDet,
	null,
	null,
	@adcMtRN,
	0,
	@adcMtRN,
	@adcMtRN,
	@dcIdI,
	'N',
	'N',
	'N',
	'O',
	'N',
	'O',
	0,
	'N',
	0,
	500,
	500,
	500,
	0,
	'00',
	getdate(),
	getdate(),
	@asCodOper,
	null,
	getdate(),
	@dcMtValAchat,
	@dcMtValPublique,
	@asLibRN

-- Taguer que le dossier a subi l'automatisation avec succès + contact (sans travail bien sûr)
	Insert into sysadm.w_div_det 
	(
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
	cpt_valide,
	cree_le,
	maj_le,
	maj_par
	)
	Values 
	(
	@adcIdSin,
	@dcIdGtiBase,
	@dcNewIdDetail,
	'rn_1er_frais_factu_pm375_auto',
	'RN 1er Frais Factu PM375 AUTO',
	-1,
	'N',
	'X',
	'N',
	'O',
	800,
	null,
	null,
	null,
	'O',
	0,
	getdate (),
	Getdate (),
	@asCodOper
	)

Update sysadm.w_gar_sin
Set	mt_tot_prej = mt_tot_prej + @adcMtRN,
	mt_prej_areg = @adcMtRN,
	mt_nplaf_areg = @adcMtRN,
	mt_plaf_areg = @adcMtRN,
	cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @adcIdSin, @dcIdGtiBase, 'W' ) ,
	alt_bloc = 'N',
	alt_att = 'N',
	alt_ssui = 'N',
	cod_mot_ssui = 0,
	alt_valide = 'O',
	cpt_i_areg = 1,
	maj_le = GETDATE(),
	maj_par = @asCodOper
Where  id_sin = @adcIdSin
And     id_gti = @dcIdGtiBase

Update sysadm.w_gar_sin
set	cod_dec_ope = cod_dec_mac,
	cod_etat = cod_dec_mac
Where  id_sin = @adcIdSin
And     id_gti = @dcIdGtiBase

Update sysadm.w_inter
Set	mt_a_reg = @adcMtRN,
	alt_valide = 'O',
	maj_le = GETDATE(),
	maj_par = @asCodOper
Where  id_sin = @adcIdSin
And	id_i = @dcIdI

Update sysadm.w_sin
Set	mt_a_reg = @adcMtRN,
	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @adcIdSin, 'W' ) ,
	alt_ssui = 'N',
	cod_mot_ssui = 0,
	alt_bloc = 'N',
	maj_le = GETDATE(),
	maj_par = @asCodOper
Where  id_sin = @adcIdSin
  	 
Update sysadm.w_sin
Set	cod_dec_ope = cod_dec_mac ,
	cod_etat = cod_dec_mac 
Where  id_sin = @adcIdSin		

Delete from sysadm.w_reg_gti Where id_sin = @adcIdSin
Insert into sysadm.w_reg_gti ( 
	id_sin,
    id_i,
    id_gti,
    id_rgpt,
    id_reg,
    mt_reg,
    mt_rgpt,
	cree_le,
    maj_le,
    maj_par               
    )
	
	values 
	(
	@adcIdSin,
	@dcIdI,
	@dcIdGtiBase,
	@dcIdGtiBase,
	0,
	@adcMtRN,
	@adcMtRN,
    GETDATE(),
	GETDATE(),            
	@asCodOper 
	)

		-- [PM80_FA12_FRANEX]
	Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
		@adcIdSin,
		@dcIdI,
		@dcIdGtiBase,
		@dcNewIdDetail,
		@adcMtIndemPrinc_1,
		@adcMtFraisAnex_2,
		@adcMtFraisAnex_3,
		@adcMtFraisAnex_4,
		@adcMtFraisAnex_5,
		@adcMtFraisAnex_6,
		@adcMtFraisAnex_7,
		@adcMtFraisAnex_8,
		@adcMtFraisAnex_9,
		@adcMtFraisAnex_10,
		@adcMtFraisAnex_11,
		'ML'

--  Validation
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	Set @dtValideLe = getdate()
	set @sMethode = 'SVE'


	Exec @iRet = sysadm.PS_VALIDATION
			@adcIdSin,
			@asCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	If @iRet < 0 
		Begin
			Return -2
		End 

	Delete sysadm.w_queue Where id_sin = @adcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @adcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @adcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @adcIdSin, @asCodOper

Set @dcIdReg = -1
Select @dcIdReg = id_reg
From sysadm.reglement 
where id_sin = @adcIdSin 
and   id_i = @dcIdI 
And   mt_tot_reg = @adcMtRN
And   id_reg = ( Select Max ( id_reg ) From sysadm.reglement where id_sin = @adcIdSin )

-- And   lib_reg = @asLibRN

If @dcIdReg > 0 
 Begin 
	
	Update sysadm.reglement
	Set lib_reg = @asLibRN
	Where id_sin = @adcIdSin
	And id_reg = @dcIdReg

	-- [VDOC21687]
	Set @asResult = 'SUCCES : RN de ' + CONVERT ( VarChar ( 20), @adcMtRN )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
	 
	Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) 
	Set @asResult = @asResult + ' non lié à un prestation.'
	Set @asResult = @asResult + 'Libellé du RN : ' + @asLibRN + '.'

	Set @sMess = Right ( rtrim( @asResult ), LEN ( rtrim( @asResult )) - 9 )

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@asCodOper, 300, @iIdCt OUTPUT			
	END

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @adcIdSin, 'VALIDATION', @asCodOper

	Return 1

 End
Else
 Begin
	Set @asResult = 'ERREUR : Problème Insertion du RP en base, contacter Jean-François' + @asLibRN + '.'
	Return -1
 End 

 Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_REMB_FRANCHISE_PAYBOX
-- Auteur               :       JFF
-- Date                 :       06/06/2018
-- Libell‚              :       [PC151425-1]
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_REMB_FRANCHISE_PAYBOX' AND type = 'P' )
        DROP procedure sysadm.PS_I_REMB_FRANCHISE_PAYBOX
GO

CREATE procedure sysadm.PS_I_REMB_FRANCHISE_PAYBOX
	@adcIdSin		Decimal ( 10 ) -- [PI062]
As

Declare @iFranchisePaye  integer
Declare @dcMtFranchisePaye Decimal ( 11, 2 )
Declare @iDossierRefuse  integer
Declare @iPresenceRMFR5  integer
Declare @iPresenceRPFR5  integer
Declare @dcMaxIdfrais	 Decimal ( 7 ) 
Declare @dcCptReg       Decimal (  2,0 )
Declare @sCodModereg	VarChar ( 2 )
Declare @sRibBq		 VarChar ( 5 )
Declare @sRibAg		 VarChar ( 5 )
Declare @sRibCpt	 VarChar ( 11 )
Declare @sRibCle		VarChar ( 2 )
Declare @sVal		 VarChar ( 35 )

Set @iFranchisePaye  = 0 
Set @dcMtFranchisePaye = 0 
Set @iDossierRefuse  = 0 
Set @iPresenceRMFR5  = 0 
Set @iPresenceRPFR5  = 0 

If Exists ( 
	Select top 1 1 
	From   sysadm.frais fr
	Where  fr.id_sin = @adcIdSin
	And	   fr.id_typ_frais = 7 
)
  Begin
	Return 
  End 

Select @iDossierRefuse  = Case 
							When sysadm.FN_LIB_ETAT_DOS_ASSURE ( @adcIdSin, 'CODE' ) in ( 200, 1530 ) Then 1
							Else 0
						  End

If @iDossierRefuse <> 1 
  Begin 
	return
  End 


-- Obetention des Données pour évaluer le cas
Select @iFranchisePaye = Case sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'franchise_paybox', 'P', '' )
							When 'O' Then 1
							Else 0
						 End 

Set @sVal = sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'mt_franchise_paybox', 'P', '' ) 
If @sVal  is null Set @sVal = ''
If IsNumeric ( @sVal ) = 0 
  Begin
    Return
  End

Select @dcMtFranchisePaye = Convert ( Decimal ( 11, 2 ), @sVal )
 
Select @iPresenceRMFR5 = Case 
							When Exists ( 
									Select	Top 1 1
									From	sysadm.reglement r
									Where	r.id_sin = @adcIdSin
									And     r.cod_mot_reg = 'RM'
									And     r.lib_reg = 'RM/FRANCHISE (FR5)'
							)						  	
								Then 1
							Else 0
						 End

Select @iPresenceRPFR5 = Case 
							When Exists ( 
									Select	Top 1 1
									From	sysadm.reglement r
									Where	r.id_sin = @adcIdSin
									And     r.cod_mot_reg = 'RP'
									And     r.lib_reg = 'RP/FRANCHISE (FR5)'
							)						  	
								Then 1
							Else 0
						 End


/* => Règles à appliquer
on créé un réglement + Reg_gti 
+
on créé un frais de remboursement pour l’assuré en auto SQL
ET 
(
	on créé un frais de remboursement pour l’assuré en auto SQL + Reglement + Reg_gti
	ET 
	( Si Gti refusé ET si franchise_paybox coché (donc payé) Et si ‘RM/FRANCHISE (FR5)’ existe alors on créé laisse
	  ainsi (on ne créé pas de RM qui rembourse le frais à l’assureur)
	OU 
	Si Gti refusé ET si franchise_paybox coché (donc payé) ET ‘RM/FRANCHISE (FR5)’ n’existe pas Alors on décoche la
	franchise_paybox afin qu’un éventuellement prochain règlement ne créé pas le RM/FR5 puisque l’on a remboursé l’assuré ET on créé un RM simple pour remboursement le Frais à l’assureur créé.
)

*/

-- Création du remboursement de la franchise via un Frais.
Select	@dcCptReg = s.cpt_reg
From	sysadm.sinistre s
Where	s.id_sin = @adcIdSin

If @dcCptReg is null Set @dcCptReg = 0
Set @dcCptReg = @dcCptReg + 1

Select  @sCodModereg = i.cod_mode_reg,
		@sRibBq		 = i.rib_bq,
		@sRibAg		 = i.rib_gui,
		@sRibCpt	 = i.rib_cpt,		
		@sRibCle	 = i.rib_cle		
From	sysadm.inter i
Where	i.id_sin = @adcIdSin
And		i.cod_inter = 'A'

If @sCodModereg is null Set @sCodModereg = 'C'

If ( @sRibBq + @sRibAg + @sRibCpt	+ @sRibCle is null ) or @sCodModereg = 'C'
  Begin
	Set @sCodModereg = 'C'
	Set @sRibBq = null
	Set @sRibAg = null
	Set @sRibCpt = null
	Set @sRibCle = null
  End 
			
INSERT INTO sysadm.reglement
	(       
		reglement.id_sin,
		reglement.id_reg,
		reglement.mt_tot_reg,
		reglement.lib_reg,
		reglement.dte_reg,
		reglement.rib_bq,
		reglement.rib_gui,
		reglement.rib_cpt,
		reglement.rib_cle,
		reglement.cod_inter,
		reglement.cod_mode_reg,
		reglement.cod_mot_reg,
		reglement.id_i,
		reglement.id_reg_base,
		reglement.cree_le,
		reglement.maj_le,
		reglement.maj_par,
		reglement.valide_le,
		reglement.valide_par,
		reglement.num_let_cheque    )
VALUES  ( 
        @adcIdSin,
		@dcCptReg,
		@dcMtFranchisePaye,
		'Remb. Franchise PayBox suite refus',
		Convert ( DateTime, Convert ( Varchar ( 10 ), GetDate(), 103 ) ),
		@sRibBq,
		@sRibAg,
		@sRibCpt,
		@sRibCle,
		'A',
		@sCodModereg,
		'RN',
		0,
		null,
		GetDate(),
		GetDate(),
		'AUTO',
		GetDate(),
		'AUTO',
		null  )	 
						
-- On mets un enregistrement dans reg_gti
INSERT INTO  sysadm.reg_gti
	(       reg_gti.id_sin,
			reg_gti.id_reg,
			reg_gti.id_gti,
			reg_gti.id_rgpt,								
			reg_gti.id_i,
			reg_gti.mt_reg,
			reg_gti.mt_rgpt,
			reg_gti.cree_le,
			reg_gti.maj_le,
			reg_gti.maj_par
	)
Values
	( 
	@adcIdSin,
	@dcCptReg,
	-1,
	7,
	0,
	@dcMtFranchisePaye,
	@dcMtFranchisePaye,
	Getdate (),
	Getdate (),
	'AUTO'
	)

-- Création du frais
Select dcMaxIdfrais = max ( fr.id_frais )
From   sysadm.frais fr
WHere  fr.id_sin = @adcIdSin

If @dcMaxIdfrais is null Set @dcMaxIdfrais = 0

Set @dcMaxIdfrais = @dcMaxIdfrais + 1

Insert into sysadm.frais values ( @adcIdSin, 0, @dcMaxIdfrais, 7, 'Remb. Franchise PayBox suite refus', @dcMtFranchisePaye, @dcCptReg, 600, getdate(), 'AUTO', getdate(), getdate(), 'AUTO' ) 

If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin ) 
  Begin
	Insert into sysadm.w_frais values ( @adcIdSin, 0, @dcMaxIdfrais, 7, 'Remb. Franchise PayBox suite refus', 'O', @dcMtFranchisePaye, 600, getdate(), getdate(), 'AUTO' ) 
  End 

Update sysadm.sinistre 
Set mt_reg = mt_reg + @dcMtFranchisePaye
Where id_sin = @adcIdSin

Update sysadm.w_sin 
Set mt_reg = mt_reg + @dcMtFranchisePaye
Where id_sin = @adcIdSin

Update sysadm.inter
Set mt_reg = mt_reg + @dcMtFranchisePaye
Where id_sin = @adcIdSin
And   cod_inter = 'A'

Update sysadm.w_inter
Set mt_reg = mt_reg + @dcMtFranchisePaye
Where id_sin = @adcIdSin
And   cod_inter = 'A'

-- Régularisation Assureur ou pas
/*
	on créé un frais de remboursement pour l’assuré en auto SQL + Reglement + Reg_gti
	ET 
	( Si Gti refusé ET si franchise_paybox coché (donc payé) Et si ‘RM/FRANCHISE (FR5)’ existe alors on créé laisse
	  ainsi (on ne créé pas de RM qui rembourse le frais à l’assureur)
	OU 
		Si Gti refusé ET si franchise_paybox coché (donc payé) ET ‘RM/FRANCHISE (FR5)’ n’existe pas Alors on décoche la
		franchise_paybox afin qu’un éventuellement prochain règlement ne créé pas le RM/FR5 puisque l’on a remboursé l’assuré 
		ET on créé un RM simple pour remboursement le Frais à l’assureur créé.
*/
If @iDossierRefuse > 0 And @iFranchisePaye > 0 And @iPresenceRMFR5 > 0
	Begin
		-- On ne fait rien, opération blanche
		-- Assuré ---- CB --------> SPB ----- RM/FR5 ---------------> Assureur
		-- Assuré <---- RN Frais--- SPB <----- RN VolcMens Normal---- Assureur

		-- Je mets juste cette ligne ci-dessous pour le begin/end
		Set @iDossierRefuse = @iDossierRefuse 
	End 

If @iDossierRefuse > 0 And @iFranchisePaye > 0 And NOT ( @iPresenceRMFR5 > 0 )
	Begin
		-- Assuré ---- CB --------> SPB ///// Le RM/FR5 n'a pas eu lieu /////  Assureur
		-- Assuré <---- RN Frais--- SPB <----- RN VolcMens Normal ------------ Assureur
		--                          SPB -----  RM simple normal   -----------> Assureur

		Update sysadm.div_sin
		Set    val_car = 'N'
		Where  id_sin = @adcIdSin
		And    nom_zone = 'franchise_paybox'

		Update sysadm.w_div_sin
		Set    val_car = 'N'
		Where  id_sin = @adcIdSin
		And    nom_zone = 'franchise_paybox'

		Set @dcCptReg = @dcCptReg + 1

		INSERT INTO sysadm.reglement
			(   reglement.id_sin,
				reglement.id_reg,
				reglement.mt_tot_reg,
				reglement.lib_reg,
				reglement.dte_reg,
				reglement.rib_bq,
				reglement.rib_gui,
				reglement.rib_cpt,
				reglement.rib_cle,
				reglement.cod_inter,
				reglement.cod_mode_reg,
				reglement.cod_mot_reg,
				reglement.id_i,
				reglement.id_reg_base,
				reglement.cree_le,
				reglement.maj_le,
				reglement.maj_par,
				reglement.valide_le,
				reglement.valide_par,
				reglement.num_let_cheque    )
		VALUES  ( 
			    @adcIdSin,
				@dcCptReg,
				@dcMtFranchisePaye * (-1),
				'Remb.FrPayBox Sans RM/FR5',
				Convert ( DateTime, Convert ( Varchar ( 10 ), GETDATE(), 103 ) ),
				null,
				null,
				null,
				null,
				'A',
				'C',
				'RM',
				0,
				@dcCptReg - 1,
				getdate(),
				getdate(),
				'AUTO',
				getdate(),
				'AUTO',
				null  )	 
						

			-- On met un enregistrement dans W_reg_gti, pour le traitement suivante.
			INSERT INTO     sysadm.reg_gti
				(       reg_gti.id_sin,
						reg_gti.id_reg,
						reg_gti.id_gti,
						reg_gti.id_rgpt,								
						reg_gti.id_i,
						reg_gti.mt_reg,
						reg_gti.mt_rgpt,
						reg_gti.cree_le,
						reg_gti.maj_le,
						reg_gti.maj_par
				)
			Values
				( 
				@adcIdSin,
				@dcCptReg,
				-1,
				7,
				0,
				@dcMtFranchisePaye * (-1),
				@dcMtFranchisePaye * (-1),
				GETDATE(),
				GETDATE(),
				'AUTO'
				)


		INSERT INTO sysadm.w_a_virer
			(       
			    w_a_virer.id_sin,
				w_a_virer.id_i,
				w_a_virer.id_reg,
				w_a_virer.cod_inter,
				w_a_virer.id_prod,
				w_a_virer.id_ets,
				w_a_virer.id_adh,
				w_a_virer.id_sdos,
				w_a_virer.rib_bq_dest,
				w_a_virer.rib_gui_dest,
				w_a_virer.rib_cpt_dest,
				w_a_virer.rib_cle_dest,
				w_a_virer.mt_vir,
				w_a_virer.cod_mode_reg,
				w_a_virer.cod_pos,
				w_a_virer.cree_le,
				w_a_virer.maj_le,
				w_a_virer.maj_par       )
		SELECT  @adcIdSin,
				0,
				@dcCptReg,
				'A',
				s.id_prod,
				s.id_ets,
				s.id_adh,
				s.id_sdos,
				@sRibBq,
				@sRibAg,
				@sRibCpt,
				@sRibCle,
				@dcMtFranchisePaye,
				@sCodModereg,
				'0',
				GETDATE(),
				GETDATE(),
				'JFF'
		FROM    sysadm.sinistre s
		WHERE   s.id_sin = @adcIdSin



	End 

Update sysadm.sinistre Set cpt_reg = @dcCptReg Where id_sin = @adcIdSin

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PC801_LOT1_V2]                        
-- Commentaires         :       Code déporté
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      23/06/2020   [PC202553_SELECTRA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2' AND type = 'P' )
        DROP procedure sysadm.PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2
GO

CREATE procedure sysadm.PS_I_FRANCHISE_PAYBOX_PC801_LOT1_V2
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@adcIdI			Decimal (  7,0 ),
	@sCodInter      VarChar ( 1 ),
	@adcCptRegTour   Decimal (  2,0 ),
	@adtValideLe     DateTime,
	@adcCptReg       Decimal (  2,0 ) OUTPUT
As

Declare @dcMtFranchise  Decimal ( 11,2 )		
Declare @dcIdGti Decimal ( 7 )
Declare @altFranchisePaye VarChar ( 1 ) 
Declare @NbreRM_Franchise Integer
Declare @NbreRN_SuperieurFranchise Integer

Select 	Top 1 @dcMtFranchise = f.mt_fra,
 			@dcIdGti = f.id_gti
from   	sysadm.franchise f,
	sysadm.w_sin ws,
	sysadm.w_reg_gti wrg
Where   ws.id_sin = @adcIdSin
And     wrg.id_sin = ws.id_sin
And     wrg.id_i = @adcIdI
And		f.id_prod = ws.id_prod
And		f.id_rev  = ws.id_rev
And     f.id_gti  = wrg.id_gti
And     f.id_typ_fra = 5
	 	
If @dcMtFranchise is null Set @dcMtFranchise = 0
If @dcMtFranchise <= 0 Return 0


Select @altFranchisePaye = wds.val_car
From   sysadm.w_sin ws,
	sysadm.w_div_sin wds
Where  ws.id_sin = @adcIdSin
And    wds.id_sin = ws.id_sin
And    wds.nom_zone = 'franchise_paybox'

Select @NbreRM_Franchise = count(*) 
From   sysadm.reglement r
Where  r.id_sin = @adcIdSin
And    r.cod_mot_reg = 'RM'
And    r.lib_reg = 'RM/FRANCHISE (FR5)'
If @NbreRM_Franchise is null Set @NbreRM_Franchise = 0

-- [PC151425-1]
-- [PC202553_SELECTRA]
Set @NbreRN_SuperieurFranchise = 1

/* Ancien code
 End
Else
 Begin
	Select @NbreRN_SuperieurFranchise = count(*) 
	From   sysadm.reglement r
	Where  r.id_sin = @adcIdSin
	And    r.cod_mot_reg = 'RN'
	And    r.mt_tot_reg > @dcMtFranchise
	If @NbreRN_SuperieurFranchise is null Set @NbreRN_SuperieurFranchise = 0				
 End
*/

If @altFranchisePaye = 'O' And @NbreRN_SuperieurFranchise > 0 And @NbreRM_Franchise = 0
 Begin
	Set @adcCptReg = @adcCptReg + 1
				
	INSERT INTO     sysadm.reglement
		(       reglement.id_sin,
			reglement.id_reg,
			reglement.mt_tot_reg,
			reglement.lib_reg,
			reglement.dte_reg,
			reglement.rib_bq,
			reglement.rib_gui,
			reglement.rib_cpt,
			reglement.rib_cle,
			reglement.cod_inter,
			reglement.cod_mode_reg,
			reglement.cod_mot_reg,
			reglement.id_i,
			reglement.id_reg_base,
			reglement.cree_le,
			reglement.maj_le,
			reglement.maj_par,
			reglement.valide_le,
			reglement.valide_par,
			reglement.num_let_cheque    )
	VALUES  (       @adcIdSin,
			@adcCptReg,
			@dcMtFranchise * (-1),
			'RM/FRANCHISE (FR5)',
			Convert ( DateTime, Convert ( Varchar ( 10 ), @adtValideLe, 103 ) ),
			null,
			null,
			null,
			null,
			@sCodInter,
			'C',
			'RM',
			@adcIdI,
			@adcCptRegTour,
			@adtValideLe,
			@adtValideLe,
			'AUTO',
			@adtValideLe,
			'AUTO',
			null  )	 
						
		IF      @@RowCount <> 1 
				Begin
					Return -1
				End

		-- On mets un enregistrement dans W_reg_gti, pour le traitement suivante.
		INSERT INTO     sysadm.reg_gti
			(       reg_gti.id_sin,
					reg_gti.id_reg,
					reg_gti.id_gti,
					reg_gti.id_rgpt,								
					reg_gti.id_i,
					reg_gti.mt_reg,
					reg_gti.mt_rgpt,
					reg_gti.cree_le,
					reg_gti.maj_le,
					reg_gti.maj_par
			)
		Values
			( 
			@adcIdSin,
			@adcCptReg,
			@dcIdGti,
			@dcIdGti,
			@adcIdI,
			@dcMtFranchise * (-1),
			@dcMtFranchise * (-1),
			@adtValideLe,
			@adtValideLe,
			'AUTO'
			)

		IF      @@RowCount <> 1 
				Begin
					Return -1
				End
 End

		-- [PC801_LOT1_V2]                        	 

Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_CPLT_PAYBOX_SCM_PM462_1
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PM462-1]                        
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      04/10/2019   [PM462-1][V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CPLT_PAYBOX_SCM_PM462_1' AND type = 'P' )
        DROP procedure sysadm.PS_I_CPLT_PAYBOX_SCM_PM462_1
GO

CREATE procedure sysadm.PS_I_CPLT_PAYBOX_SCM_PM462_1
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@adcIdI			Decimal (  7,0 ),
	@sCodInter      VarChar ( 1 ),
	@adcCptRegTour   Decimal (  2,0 ),
	@adtValideLe     DateTime,
	@adcMtAReg		 Decimal ( 11, 2 ),
	@adcCptReg       Decimal (  2,0 ) OUTPUT
As
Declare @dcMtCpltPayBoxSCM Decimal ( 11,2 ) -- [PM462-1]
Declare @dcIdGti Decimal ( 7 )
Declare @dcIdEvt Decimal ( 7 )
Declare @dcIdRegBase Decimal ( 7 )

Select  @dcIdEvt = dt.id_evt,
		@dcIdGti = rg.id_gti
From   sysadm.reg_gti rg,
		sysadm.detail dt
Where  rg.id_sin = @adcIdSin
And    rg.id_i = @adcIdI
And    dt.id_sin = rg.id_sin
And    dt.id_gti = rg.id_gti
And    dt.id_i_reg = rg.id_i
And    dt.id_reg = @adcCptRegTour
And    dt.id_evt = 1461

-- CAS1 : Règlement du fournisseur et déduction de la Franchise à l'assureur.
If @sCodInter = 'F' 
  Begin
	-- Récupération du montant PayBox le cas échéant
	-- (il ne peut y avoir qu'un règlement fournisseur par validation
	Select @dcMtCpltPayBoxSCM = 
			Case 
				When IsNumeric ( sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', wcmd.info_spb_frn_cplt, ';') ) > 0 
					Then Convert ( Decimal (11, 2 ), sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', wcmd.info_spb_frn_cplt, ';'))
				Else 0
			End,
			@dcIdGti = wrg.id_gti
	From   sysadm.w_reg_gti wrg,
			sysadm.w_detail wdt,
			sysadm.w_commande wcmd
	Where  wrg.id_sin = @adcIdSin
	And    wrg.id_i = @adcIdI
	And    wdt.id_sin = wrg.id_sin
	And    wdt.id_gti = wrg.id_gti
	And    wdt.id_i_reg = wrg.id_i
	And    wcmd.id_sin = wdt.id_sin
	And    wcmd.id_gti = wdt.id_gti
	And    wcmd.id_detail = wdt.id_detail
						 
	If @dcMtCpltPayBoxSCM is null Set @dcMtCpltPayBoxSCM = 0

	If @dcMtCpltPayBoxSCM <= 0 Return 0

	Set @adcCptReg = @adcCptReg + 1
				
	INSERT INTO     sysadm.reglement
		(       
			reglement.id_sin,
			reglement.id_reg,
			reglement.mt_tot_reg,
			reglement.lib_reg,
			reglement.dte_reg,
			reglement.rib_bq,
			reglement.rib_gui,
			reglement.rib_cpt,
			reglement.rib_cle,
			reglement.cod_inter,
			reglement.cod_mode_reg,
			reglement.cod_mot_reg,
			reglement.id_i,
			reglement.id_reg_base,
			reglement.cree_le,
			reglement.maj_le,
			reglement.maj_par,
			reglement.valide_le,
			reglement.valide_par,
			reglement.num_let_cheque    )
	VALUES  ( 
			@adcIdSin,
			@adcCptReg,
			@dcMtCpltPayBoxSCM * (-1),
			'RM/REMB. FRANCHISE CB A L''ASSUREUR',
			Convert ( DateTime, Convert ( Varchar ( 10 ), @adtValideLe, 103 ) ),
			null,
			null,
			null,
			null,
			@sCodInter,
--			'C', -- Important C ! , Pas FM car pas de rapprochement au quotidien, et on ne redonne de l'argent qu'çà l'assureur, pas d'avoir fournisseur
--			'FM', -- Et bien non ! suite mail de Sylvie, elle souhaite un FM ici qu'elle traitera différemment car il sera tagué par le trt mensuel d'un FR
			'C', -- je reviens à C sur SIMPA2, mais je passerai FM sur le TRT Mens pour une clarté sur SIMPA2.
			'RM',
			@adcIdI,
			@adcCptRegTour, -- (je le remet vu qu'on est en C now) On ne met pas @adcCptRegTour ici, pas de référence car sinon cela gnère l'éventuel RM/FM sur le règlement fournisseur. La franchise ne doit pas être rélié au règlement fourn. pas ce biais.
			@adtValideLe,
			@adtValideLe,
			'AUTO',
			@adtValideLe,
			'AUTO',
			null  )	 
						
		IF      @@RowCount <> 1 
				Begin
						Return -1
				End

		-- On met un enregistrement dans W_reg_gti, pour le traitement suivante.
		INSERT INTO     sysadm.reg_gti
			(       reg_gti.id_sin,
					reg_gti.id_reg,
					reg_gti.id_gti,
					reg_gti.id_rgpt,								
					reg_gti.id_i,
					reg_gti.mt_reg,
					reg_gti.mt_rgpt,
					reg_gti.cree_le,
					reg_gti.maj_le,
					reg_gti.maj_par
			)
		Values
			( 
			@adcIdSin,
			@adcCptReg,
			@dcIdGti,
			@dcIdGti,
			@adcIdI,
			@dcMtCpltPayBoxSCM * (-1),
			@dcMtCpltPayBoxSCM * (-1),
			@adtValideLe,
			@adtValideLe,
			'AUTO'
			)

		IF      @@RowCount <> 1 
				Begin
						Return -1
				End

		Return 0
  End 


-- CAS2 : Le GT rembourse manuellement la Franchise à l'assuré (On n'a pas réglé le fournisseur du tout)
If @dcIdEvt = 1461 And @sCodInter = 'A' 
  Begin
	-- C/RM
	Set @adcCptReg = @adcCptReg + 1
				
	INSERT INTO     sysadm.reglement
		(       
			reglement.id_sin,
			reglement.id_reg,
			reglement.mt_tot_reg,
			reglement.lib_reg,
			reglement.dte_reg,
			reglement.rib_bq,
			reglement.rib_gui,
			reglement.rib_cpt,
			reglement.rib_cle,
			reglement.cod_inter,
			reglement.cod_mode_reg,
			reglement.cod_mot_reg,
			reglement.id_i,
			reglement.id_reg_base,
			reglement.cree_le,
			reglement.maj_le,
			reglement.maj_par,
			reglement.valide_le,
			reglement.valide_par,
			reglement.num_let_cheque    )
	VALUES  ( 
			@adcIdSin,
			@adcCptReg,
			@adcMtAReg * (-1),
			'RM SUITE REMB. FRANCHISE ASSURE',
			Convert ( DateTime, Convert ( Varchar ( 10 ), @adtValideLe, 103 ) ),
			null,
			null,
			null,
			null,
			@sCodInter,
			'C', 
			'RM',
			@adcIdI,
			@adcCptRegTour,
			@adtValideLe,
			@adtValideLe,
			'AUTO',
			@adtValideLe,
			'AUTO',
			null  )	 
						
		IF      @@RowCount <> 1 
				Begin
						Return -1
				End

		-- On met un enregistrement dans W_reg_gti, pour le traitement suivante.
		INSERT INTO     sysadm.reg_gti
			(       reg_gti.id_sin,
					reg_gti.id_reg,
					reg_gti.id_gti,
					reg_gti.id_rgpt,								
					reg_gti.id_i,
					reg_gti.mt_reg,
					reg_gti.mt_rgpt,
					reg_gti.cree_le,
					reg_gti.maj_le,
					reg_gti.maj_par
			)
		Values
			( 
			@adcIdSin,
			@adcCptReg,
			@dcIdGti,
			@dcIdGti,
			@adcIdI,
			@adcMtAReg * (-1),
			@adcMtAReg * (-1),
			@adtValideLe,
			@adtValideLe,
			'AUTO'
			)

		IF      @@RowCount <> 1 
				Begin
						Return -1
				End


	-- CB/RF
	Set @adcCptReg = @adcCptReg + 1
	
	-- Retrouver le PF lié.... pas simple
	Select Top 1 @dcIdRegBase = min ( r.id_reg )
	From   sysadm.reglement r
	Where  r.id_sin = @adcIdSin
	And    r.cod_mot_reg = 'PF'
	And    r.mt_tot_reg = @adcMtAReg
	And    Not Exists ( -- Le PF ne doit pas déjà être pris sur un RF
			Select Top 1 1 
			From sysadm.reglement r1
			Where r1.id_sin = r.id_sin
			And   r1.cod_mot_reg = 'RF'
			And   r1.mt_tot_reg = @adcMtAReg * (-1)
			And   r1.id_reg_base = r.id_reg
	)
	
	If @dcIdRegBase is null Set @dcIdRegBase = 0 
	If @dcIdRegBase = 0 Return -1
				
	INSERT INTO     sysadm.reglement
		(       
			reglement.id_sin,
			reglement.id_reg,
			reglement.mt_tot_reg,
			reglement.lib_reg,
			reglement.dte_reg,
			reglement.rib_bq,
			reglement.rib_gui,
			reglement.rib_cpt,
			reglement.rib_cle,
			reglement.cod_inter,
			reglement.cod_mode_reg,
			reglement.cod_mot_reg,
			reglement.id_i,
			reglement.id_reg_base,
			reglement.cree_le,
			reglement.maj_le,
			reglement.maj_par,
			reglement.valide_le,
			reglement.valide_par,
			reglement.num_let_cheque    )
	VALUES  ( 
			@adcIdSin,
			@adcCptReg,
			@adcMtAReg * (-1),
			'RF SUITE REMB. FRANCHISE ASSURE',
			Convert ( DateTime, Convert ( Varchar ( 10 ), @adtValideLe, 103 ) ),
			null,
			null,
			null,
			null,
			@sCodInter,
			'CB', 
			'RF',
			@adcIdI,
			@dcIdRegBase,
			@adtValideLe,
			@adtValideLe,
			'AUTO',
			@adtValideLe,
			'AUTO',
			null  )	 
						
		IF      @@RowCount <> 1 
				Begin
						Return -1
				End

		-- On met un enregistrement dans W_reg_gti, pour le traitement suivante.
		INSERT INTO     sysadm.reg_gti
			(       reg_gti.id_sin,
					reg_gti.id_reg,
					reg_gti.id_gti,
					reg_gti.id_rgpt,								
					reg_gti.id_i,
					reg_gti.mt_reg,
					reg_gti.mt_rgpt,
					reg_gti.cree_le,
					reg_gti.maj_le,
					reg_gti.maj_par
			)
		Values
			( 
			@adcIdSin,
			@adcCptReg,
			@dcIdGti,
			@dcIdGti,
			@adcIdI,
			@adcMtAReg * (-1),
			@adcMtAReg * (-1),
			@adtValideLe,
			@adtValideLe,
			'AUTO'
			)

		IF      @@RowCount <> 1 
				Begin
						Return -1
				End

	Return 0

  End 


Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_PM462_1_CTRLE_REMB_FRANCHISE
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PM462-1][V3]                     
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM462_1_CTRLE_REMB_FRANCHISE' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM462_1_CTRLE_REMB_FRANCHISE
GO

CREATE procedure sysadm.PS_I_PM462_1_CTRLE_REMB_FRANCHISE
	@adcIdSin  Decimal ( 10 ),
	@asCas	VarChar ( 100 ),
	@adcMtFranCBprej Decimal ( 11, 2 )
As

Declare @SumRegCB Decimal ( 11, 2 )

Set @adcMtFranCBprej = ABS ( @adcMtFranCBprej ) 

-- Uf_ControlerGestion_Franchise_CB_EXTR :: 1/ Contrôle sur l’evt : On autorise si la SUM des reglements CB (+/-) > 0 car si =0, plus rien n’est à rembourser.
If @asCas = 'SUM_FRANCHISE_CB_REG_POSITIF'
  Begin
	Select @SumRegCB  = Sum ( r.mt_tot_reg ) 
	From   sysadm.reglement r
	Where  r.id_sin = @adcIdSin  
	And    r.cod_mot_reg in ( 'PF', 'RF' )

	If @SumRegCB is null Set @SumRegCB = 0

	If @SumRegCB <= 0 Return -10 
	
	Return 0

  End 

-- Uf_ControlerGestion_Franchise_CB_EXTR :: 2/ Le remboursement d’une franchise sur l’evt (le montant) doit correspondre à un des montants de franche CB/EXTR existant dans reglement.
If @asCas = 'FRANCHISE_EGALE_AMU_MT_CB_DS_REGL'
  Begin

	If Not Exists ( 
		Select Top 1 1 
		From   sysadm.reglement r
		Where  r.id_sin = @adcIdSin  
		And    r.mt_tot_reg = @adcMtFranCBprej 
		And    r.cod_mot_reg = 'PF'
	)
	  Begin
		Return -20
	  End 

	  Return 0
  End 

-- Uf_ControlerGestion_Franchise_CB_EXTR :: 3/ La SUM des reglements CB (+/-) > 0 + le présent remboursement (négatif) ne doit pas donner un nombre négatif, sinon, interdire (problème cas anormal).
-- Cela doit rester positif ou nulle (0)
If @asCas = 'SUM_FRANCHISE_CB_PLUS_MT_PREJ_POSITIF_OU_ZERO'
  Begin
	Select @SumRegCB = Sum ( r.mt_tot_reg ) 
	From   sysadm.reglement r
	Where  r.id_sin = @adcIdSin  
	And    r.cod_mot_reg in ( 'PF', 'RF' )

	If @SumRegCB is null Set @SumRegCB = 0

	-- Je l'écris sous cette forme pour bien montré qu'au final, ce sera un montant négatif (CB/RF)
	IF @SumRegCB + abs ( @adcMtFranCBprej ) * (-1) < 0 Return -30

	Return 0
  End 

-- Uf_ControlerGestion_Franchise_CB_EXTR :: 4/ A contrôler sur un RN : si le montant de l’evt (quel qu’il soit) soit égale à un des montants de Franchise payé, alors avertir le GT par un message « Erreur ou Ok ? »
If @asCas = 'RN_REEL_OU_REMB_FRANCHISE'
  Begin
	If Exists ( 
		Select Top 1 1 
		From   sysadm.reglement r
		Where  r.id_sin = @adcIdSin  
		And    r.mt_tot_reg = @adcMtFranCBprej 
		And    r.cod_mot_reg = 'PF'
	)
	  Begin
		Return -40
	  End 	
  End 

Return 0

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RPFM_TAGFR_REGUL_FRANCHISE_CB
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PM462-1][V3]                     
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RPFM_TAGFR_REGUL_FRANCHISE_CB' AND type = 'P' )
        DROP procedure sysadm.PS_I_RPFM_TAGFR_REGUL_FRANCHISE_CB
GO

CREATE procedure sysadm.PS_I_RPFM_TAGFR_REGUL_FRANCHISE_CB
	@adcIdSin  Decimal ( 10 ),
	@adcIdReg  Decimal ( 7 ),
	@asMtPaiementPayBox Varchar ( 50 ),
	@asIdRegFranchiseOrigCBPF Varchar ( 50 ),
	@asCodInter varchar ( 1 ),
	@asCodModeReg Varchar ( 5 ),
	@adcIdInterRM Decimal (7),
	@asCodOper varchar (4),
	@adcIdGtiBase Decimal (7),
	@aiCtrleRPFranchise Integer OUTPUT
As

Declare @dcIdRegRPFMFranchise Decimal (7)
Declare @dcIdRegRNAssure Decimal (7)
Declare @dcIdRegRMAssure Decimal (7)
Declare @dcIdRegRFAssure Decimal (7)
Declare @dcIdInterAssure Decimal (7)
Declare @sCodBanque  VarChar (   5  )
Declare @sCodGuichet VarChar (   5  )  
Declare @sNumCpt     VarChar (  11  )  
Declare @sCodModeRegAssure VarChar (  5  )  
Declare @sCleRib VarChar (  5  )  
Declare @sOrdre VarChar (  35 )  

Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select 	@dcIdRegRPFMFranchise = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

-- On réclame à l'assureur (RP/FM teg FR) la part de franchise qu'on lui a redonné en trop par le présent RM/FM
Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdRegRPFMFranchise,
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ), -- + (Positif) 
'RP/REMB. FRANCHISE CB A L''ASSUREUR',
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
@asCodInter,
'C', -- Oui C et pas FM même sur le TRT MENS je passe FM, @asCodModeReg, 
'RP',
@adcIdInterRM, -- Même inter RM pour ce présent RP 
@adcIdReg, -- (Je le remets vu qu'on est en C now) On ne met pas @adcIdReg ici, pas de référence car sinon cela gnère l'éventuel RP/FM sur le règlement fournisseur. La franchise ne doit pas être rélié au règlement fourn. pas ce biais.
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdRegRPFMFranchise,
@adcIdGtiBase,
@adcIdGtiBase,
@adcIdInterRM, -- Même inter RM pour ce présent RP
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ),
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ),
Getdate(),
Getdate(),
@asCodOper
)		

-- On rend sa Franchise à l'assuré par VA ou C
Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select 	@dcIdRegRNAssure = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

-- Détermination du mode de règlement de l'assuré
Select @sCodBanque = i.rib_bq,
	   @sCodGuichet = i.rib_gui,
	   @sNumCpt = i.rib_cpt,
	   @sCleRib = i.rib_cle,
	   @dcIdInterAssure = i.id_i,
	   @sOrdre = Case 
					When i.ordre_cheque is null Or rtrim ( ltrim ( i.ordre_cheque )) = '' Then i.nom
					Else i.ordre_cheque 
				 End 
From   sysadm.inter i
Where  i.id_sin = @adcIdSin
And    i.cod_inter = 'A' 

Set @sCodModeRegAssure = 'VA'
If @sCodBanque is null OR @sCodGuichet is null OR @sNumCpt is null OR @sCleRib is null 
	Begin 
		Set @sCodModeRegAssure = 'C'
		Set @sCodBanque = null
		Set @sCodGuichet = null
		Set @sNumCpt = null
		Set @sCleRib = null
	End 

If @sCleRib <> sysadm.SPB_FN_RIB_CLE_V01 ( @sCodBanque, @sCodGuichet, @sNumCpt ) Set @sCodModeRegAssure = 'C'

If @sCodModeRegAssure = 'C' 
 Begin
	Update sysadm.inter Set cod_mode_reg = 'C', ordre_cheque = @sOrdre Where id_sin = @adcIdSin And cod_inter = 'A'
	Update sysadm.w_inter Set cod_mode_reg = 'C', ordre_cheque = @sOrdre Where id_sin = @adcIdSin And cod_inter = 'A'
 End 

 If @sCodModeRegAssure = 'VA' 
 Begin
	Update sysadm.inter Set cod_mode_reg = 'VA' Where id_sin = @adcIdSin And cod_inter = 'A'
	Update sysadm.w_inter Set cod_mode_reg = 'VA' Where id_sin = @adcIdSin And cod_inter = 'A'
 End 


Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdRegRNAssure,
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ), -- + (Positif) 
'RN/REMB. FRANCHISE A L''ASSURE', 
Convert ( Varchar ( 20 ), Getdate(), 103 ),
@sCodBanque, 
@sCodGuichet,
@sNumCpt,
@sCleRib,
'A', -- L'assuré
@sCodModeRegAssure, 
'RN',
@dcIdInterAssure, -- L'assuré
null,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdRegRNAssure,
@adcIdGtiBase,
@adcIdGtiBase,
@dcIdInterAssure, -- Même inter pour ce présent RP
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ),
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ),
Getdate(),
Getdate(),
@asCodOper
)	

-- ET on pense à ajouter dans w_a_virer car mvt financier réél.
INSERT INTO     sysadm.w_a_virer
(   w_a_virer.id_sin,
	w_a_virer.id_i,
	w_a_virer.id_reg,
	w_a_virer.cod_inter,
	w_a_virer.id_prod,
	w_a_virer.id_ets,
	w_a_virer.id_adh,
	w_a_virer.id_sdos,
	w_a_virer.rib_bq_dest,
	w_a_virer.rib_gui_dest,
	w_a_virer.rib_cpt_dest,
	w_a_virer.rib_cle_dest,
	w_a_virer.mt_vir,
	w_a_virer.cod_mode_reg,
	w_a_virer.cod_pos,
	w_a_virer.cree_le,
	w_a_virer.maj_le,
	w_a_virer.maj_par       )
SELECT
    @adcIdSin,
	@dcIdInterAssure,
	@dcIdRegRNAssure,
	'A',
	s.id_prod,
	s.id_ets,
	s.id_adh,
	s.id_sdos,
	@sCodBanque,
	@sCodGuichet,
	@sNumCpt,
	@sCleRib,
	Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ),
	@sCodModeRegAssure,
	'0',
	Getdate(),
	Getdate(),
	@asCodOper
FROM   sysadm.sinistre s
WHERE  s.id_sin = @adcIdSin


-- On Rembourse l'assureur du montant que l'on vient de rembourser à l'assuré, montant qui lui sera réclamé au trt mens.
Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select 	@dcIdRegRMAssure = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdRegRMAssure,
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1), -- - (Négatif) 
'RM/REMB. FRANCHISE A L''ASSURE', 
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
'A', -- L'assuré
'C', 
'RM',
@dcIdInterAssure, -- L'assuré
@dcIdRegRNAssure,
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdRegRMAssure,
@adcIdGtiBase,
@adcIdGtiBase,
@dcIdInterAssure, -- Même inter pour ce présent RP
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1),
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1),
Getdate(),
Getdate(),
@asCodOper
)

-- Enfin, On inverse le premier mouvement CB/PF en CB/RF
Update sysadm.sinistre 
Set    cpt_reg = cpt_reg + 1
where  id_sin = @adcIdSin

Select 	@dcIdRegRFAssure = cpt_reg 
From sysadm.sinistre 
where id_sin = @adcIdSin

Insert Into sysadm.reglement values ( 
@adcIdSin,
@dcIdRegRFAssure,
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1), -- - (Négatif) 
'REGUL. PF. FRANCHISE SPB>ASSURE',
Convert ( Varchar ( 20 ), Getdate(), 103 ),
null, 
null,
null,
null,
'A', -- L'assuré
'CB', 
'RF',
@dcIdInterAssure, -- L'assuré
Convert ( Decimal (7), @asIdRegFranchiseOrigCBPF),
Getdate(),
@asCodOper,
Getdate(),
Getdate(),
@asCodOper,
null
)
  
Insert Into sysadm.reg_gti values ( 
@adcIdSin,
@dcIdRegRFAssure,
@adcIdGtiBase,
@adcIdGtiBase,
@dcIdInterAssure, -- Même inter pour ce présent RP
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1),
Abs ( Convert ( Decimal ( 11,2 ), @asMtPaiementPayBox ) ) * (-1),
Getdate(),
Getdate(),
@asCodOper
)


-- On contrôle
Select @aiCtrleRPFranchise = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdRegRPFMFranchise 
If @aiCtrleRPFranchise is null Set @aiCtrleRPFranchise = 0 


Go



--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PM462-1][V3]                     
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB' AND type = 'P' )
        DROP procedure sysadm.PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB
GO

CREATE procedure sysadm.PS_S_ANNUL_PRESTA_CTRLE_FRANCHISE_CB
	@adcIdSin  Decimal ( 10 ),
	@aiIdSeq   Integer,
	@adcMtFranchiseARemb Decimal ( 11, 2 )
AS

Declare	@sMtPaiementPayBox Varchar ( 50 )
Declare	@sIdRegFranchiseOrig Varchar ( 50 )
Declare	@dcIdRegFranchiseOrig Decimal ( 7 )
Declare	@SumRegCB Decimal ( 11, 2 ) 

Select @sMtPaiementPayBox = sysadm.FN_CLE_VAL ( 'MT_CPLT_PAYBOX_SCM', c.info_spb_frn_cplt, ';' ),  -- [PM462-1][V3]
	   @sIdRegFranchiseOrig = sysadm.FN_CLE_VAL ( 'ID_REG_FRANCHISE', c.info_spb_frn_cplt, ';' )  -- [PM462-1][V3]
From sysadm.commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeq

Set @adcMtFranchiseARemb = Convert ( decimal ( 11, 2 ), @sMtPaiementPayBox ) 
If @adcMtFranchiseARemb  is null Set @adcMtFranchiseARemb =0 
If @adcMtFranchiseARemb = 0 Return 0

Set @dcIdRegFranchiseOrig = Convert ( decimal ( 11, 2 ), @sIdRegFranchiseOrig ) 

Select @SumRegCB = Sum ( r.mt_tot_reg ) 
From   sysadm.reglement r
Where  r.id_sin = @adcIdSin  
And    ( 
		 ( r.cod_mot_reg = 'PF' And r.id_reg = @dcIdRegFranchiseOrig )
		 Or 
		 ( r.cod_mot_reg = 'RF' And r.id_reg_base = @dcIdRegFranchiseOrig )
	   )

If @SumRegCB is null Set @SumRegCB = 0

-- La franchise n'a pas été remboursée à l'assuré
IF @SumRegCB > 0 Return -10

Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_PRESENCE_FRANCHISE_CB
-- Auteur               :       JFF
-- Date                 :       07/08/2019
-- Libell‚              :       [PM462-1][V3]                     
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PRESENCE_FRANCHISE_CB' AND type = 'P' )
        DROP procedure sysadm.PS_S_PRESENCE_FRANCHISE_CB
GO

CREATE procedure sysadm.PS_S_PRESENCE_FRANCHISE_CB
	@adcIdSin  Decimal ( 10 )
AS
If Exists ( 
	Select Top 1 1 
	From  sysadm.reglement r
	Where r.cod_mot_reg = 'PF'
	And   r.id_sin = @adcIdSin  
	)
	Begin 
		Return 1
	End 

Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_REGLEMENT_RM_SPEC_DT458
-- Auteur               :       JFF
-- Date                 :       11/03/2020
-- Libell‚              :       [DT458]
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_REGLEMENT_RM_SPEC_DT458' AND type = 'P' )
        DROP procedure sysadm.PS_I_REGLEMENT_RM_SPEC_DT458
GO

CREATE procedure sysadm.PS_I_REGLEMENT_RM_SPEC_DT458
	@adcIdSin  Decimal ( 10 )
AS

Declare @dcIdReg decimal ( 2 )
Declare @dcCptReg decimal ( 2 )
Declare @dcIdRegBase decimal ( 2 )
Declare @dcMtFixeUnit decimal ( 11,2 )
Declare @dcMtRMtotal decimal ( 11,2 )
Declare @iNbreBillet integer
Declare @dcIdGti decimal ( 7 )

Set @dcMtFixeUnit = 0.01 -- €

Select @dcCptReg = s.cpt_reg
From sysadm.sinistre s
Where s.id_sin = @adcIdSin 

If @dcCptReg is null Set @dcCptReg = 0
Set @dcCptReg = @dcCptReg + 1

Update sysadm.sinistre Set cpt_reg = @dcCptReg Where id_sin = @adcIdSin
Set @dcIdReg = @dcCptReg

Select @dcIdRegBase = max ( id_reg ) from sysadm.reglement where id_sin = @adcIdSin and id_i = 0 and mt_tot_reg > 0 and cod_mot_reg = 'RN'
If @dcIdRegBase is null Or @dcIdRegBase = 0 Set @dcIdRegBase = @dcIdReg

Select Top 1 @dcIdGti = rg.id_gti
From   sysadm.reg_gti rg
Where  rg.id_sin = @adcIdSin
And    rg.id_reg = @dcIdRegBase

If @dcIdGti is null Or @dcIdGti = 0 
  Begin
	Select Top 1 @dcIdGti = ga.id_gti
	From   sysadm.gar_sin ga
	Where  ga.id_sin = @adcIdSin
  End 

Select @iNbreBillet = sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'nbre_billet_1', 'P', '' ) 

Set @dcMtRMtotal = ( @iNbreBillet * @dcMtFixeUnit ) * (-1)

Insert into sysadm.reglement values ( @adcIdSin, @dcIdReg, @dcMtRMtotal, 'REVENTE BILLET REMB PART ASSUREUR', Convert ( varchar ( 10), getdate(), 103), null,null,null,null, 'A', 'C', 'RM', 0, @dcIdRegBase, GETDATE (), 'JFF', GETDATE (), GETDATE (), 'JFF', null )
Insert into sysadm.reg_gti values ( @adcIdSin, @dcIdReg, @dcIdGti , @dcIdGti, 0, @dcMtRMtotal, @dcMtRMtotal, GETDATE (), GETDATE (), 'JFF' )

Update sysadm.w_div_sin Set nom_zone = 'revente_traitee_1', alt_prot = 'O', lib_label = 'Revente traitée', cpt_tri = cpt_tri - 1 Where id_sin = @adcIdSin and nom_zone = 'revente_a_traiter_1'
Update sysadm.div_sin Set nom_zone = 'revente_traitee_1', alt_prot = 'O', lib_label = 'Revente traitée', cpt_tri = cpt_tri - 1 Where id_sin = @adcIdSin and nom_zone = 'revente_a_traiter_1'

Update sysadm.div_sin Set alt_prot = 'O' Where id_sin = @adcIdSin and nom_zone in ( 'dte_revente_1', 'mt_revente_1', 'nbre_billet_1' ) 
Update sysadm.w_div_sin Set alt_prot = 'O' Where id_sin = @adcIdSin and nom_zone in ( 'dte_revente_1', 'mt_revente_1', 'nbre_billet_1' ) 

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_PM80_CTRLE_VENTIL_REG_BASE
-- Auteur               :       JFF
-- Date                 :       30/11/2016
-- Libell‚              :       [PM80_FA12_FRANEX]
-- Commentaires         :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM80_CTRLE_VENTIL_REG_BASE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM80_CTRLE_VENTIL_REG_BASE
GO

CREATE procedure sysadm.PS_S_PM80_CTRLE_VENTIL_REG_BASE
	@adcIdSin		Decimal ( 10 ) , -- [PI062]
	@adcIdRegBase   Decimal (7) OutPut,		
	@aiIdSeq		Integer,
	@adtDteRegBase DateTime OutPut,
	@adtDtePivotMepPM80 DateTime OutPut,
	@asResult		Varchar ( 255 ) OUTPUT
As

Declare @asCas VarChar ( 20 )

Select Top 1 @adtDtePivotMepPM80 = dtp.dte_1
From sysadm.date_pivot dtp
Where dtp.id_cle = 'PM80_FA12_FRANEX'

If @adcIdRegBase > 0 And @aiIdSeq > 0 
	Begin
		Set @asResult = 'ERREUR (technique/JFF) : Le contrôle doit se faire sur l''ID_REG ou l''ID_SEQ, mais pas les deux'
		Return -1
	End 

If @aiIdSeq > 0 Set @asCas = 'ID_SEQ'
If @adcIdRegBase > 0 Set @asCas = 'ID_REG'

If  @asCas = 'ID_SEQ'
  Begin 
	Select  Top 1 @adtDteRegBase = r.cree_le,
				  @adcIdRegBase = r.id_reg
	From	sysadm.commande c,
			sysadm.detail d,
			sysadm.reglement r
	Where   c.id_sin = @adcIdSin
	And		c.id_seq = @aiIdSeq
	And		d.id_sin = c.id_sin
	And		d.id_gti = c.id_gti
	And		d.id_detail = c.id_detail
	And     r.id_sin = d.id_sin
	And		r.id_reg = d.id_reg
	And     r.cod_mode_reg = 'FM'

	If @adtDteRegBase is null 
		Begin
			Set @asResult = 'ERREUR : Impossible de déterminer la date du règlement d''origine lié à cette prestation (' + CONVERT ( Varchar ( 10), @adcIdSin ) + '-' + CONVERT ( Varchar ( 10), @aiIdSeq ) + ').'
			Return -1
		End 
  End 

If @asCas = 'ID_REG'
  Begin 
	Select   Top 1 @adtDteRegBase = r.cree_le
	From	sysadm.reglement r
	Where   r.id_sin = @adcIdSin
	And		r.id_reg = @adcIdRegBase
	And		r.cod_mot_reg = 'RN'

	If @adtDteRegBase is null 
		Begin
			Set @asResult = 'ERREUR : Impossible de déterminer la date du règlement numéro ' +  CONVERT ( Varchar ( 10),@adcIdRegBase ) + ' (règlement d''origine).'
			Return -1
		End 
  End 

Return 1
Go
