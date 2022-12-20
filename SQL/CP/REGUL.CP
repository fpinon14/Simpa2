-------------------------------------------------------------------
--
-- Fichier              :       REGUL.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des r‚gularisations
--      
-- Procédures           :       PS_I01_REGLEMENT_REGUL
--                      :       PS_I01_W_A_VIRER_REGUL
--                      :       DW_S01_W_A_VIRER_REGUL
--                      :       DW_S01_REGLEMENT_REGUL
--                      :       DW_S01_REG_GTI_REGUL
--                      :       PS_I01_REG_GTI_REGUL
--                      :       PS_VAL_REGUL
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_REGLEMENT_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table REGLEMENT
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcCptReg       Decimal (  2,0 )        (Val)
--                      :       @dcMtTotReg     Decimal ( 11,2 )        (Val)
--                      :       @sLibReg        Varchar ( 35   )        (Val)
--                      :       @dtDteReg       DateTime                (Val)
--                      :       @sRibBq         Varchar (  5   )        (Val)
--                      :       @sRibGui        Varchar (  5   )        (Val)
--                      :       @sRibCpt        Varchar ( 11   )        (Val)
--                      :       @sRibCle        Varchar (  2   )        (Val)
--                      :       @sCodInter      Varchar (  2   )        (Val)
--                      :       @sCodModeReg    Varchar (  2   )        (Val)
--                      :       @sCodMotReg     Varchar (  2   )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdRegBase    Decimal (  2   )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REGLEMENT_REGUL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_REGLEMENT_REGUL
GO

CREATE procedure sysadm.PS_I01_REGLEMENT_REGUL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcCptReg       Decimal (  2,0 ),
        @dcMtTotReg     Decimal ( 11,2 ),
        @sLibReg        Varchar ( 35   ),
        @dtDteReg       DateTime        ,
        @sRibBq         Varchar (  5   ),
        @sRibGui        Varchar (  5   ),
        @sRibCpt        Varchar ( 11   ),
        @sRibCle        Varchar (  2   ),
        @sCodInter      Varchar (  2   ),
        @sCodModeReg    Varchar (  2   ),
        @sCodMotReg     Varchar (  2   ),
        @dcIdI          Decimal (  7,0 ),
        @dcIdRegBase    Decimal (  2   ),
        @dtCreeLe       DateTime        ,
        @sCodOper       Varchar (  4   ) 
AS
 INSERT INTO    sysadm.reglement
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
                reglement.num_let_cheque )
 VALUES  (      @dcIdSin,
                @dcCptReg,
                @dcMtTotReg,
                @sLibReg,
                @dtDteReg,
                @sRibBq,
                @sRibGui,
                @sRibCpt,
                @sRibCle,
                @sCodInter,
                @sCodModeReg,
                @sCodMotReg,
                @dcIdI,
                @dcIdRegBase,
                @dtCreeLe,
                @dtCreeLe,
                @sCodOper,
                @dtCreeLe,
                @sCodOper,
                null )

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_A_VIRER_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table W_A_VIRER
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcCptReg       Decimal (  2,0 )        (Val)
--                      :       @sCodInter      Varchar (  2   )        (Val)
--                      :       @sRibBq         Varchar (  5   )        (Val)
--                      :       @sRibGui        Varchar (  5   )        (Val)
--                      :       @sRibCpt        Varchar ( 11   )        (Val)
--                      :       @sRibCle        Varchar (  2   )        (Val)
--                      :       @sCodMotReg     Varchar (  2   )        (Val)
--                      :       @sCodModeReg    Varchar (  2   )        (Val)
--                      :       @dcMtTotReg     Decimal ( 11,2 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_A_VIRER_REGUL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_A_VIRER_REGUL
GO

CREATE procedure sysadm.PS_I01_W_A_VIRER_REGUL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcCptReg       Decimal (  2,0 ),
        @sCodInter      Varchar (  2   ),
        @sRibBq         Varchar (  5   ),
        @sRibGui        Varchar (  5   ),
        @sRibCpt        Varchar ( 11   ),
        @sRibCle        Varchar (  2   ),
        @sCodMotReg     Varchar (  2   ),
        @sCodModeReg    Varchar (  2   ),
        @dcMtTotReg     Decimal ( 11,2 ),
        @dtCreeLe       DateTime        ,
        @sCodOper       Varchar (  4   )
AS

 INSERT INTO    sysadm.w_a_virer
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
 SELECT         @dcIdSin,
                @dcIdI,
                @dcCptReg,
                @sCodInter,
                sinistre.id_prod,
                sinistre.id_ets,
                sinistre.id_adh,
                sinistre.id_sdos,
                @sRibBq,
                @sRibGui,
                @sRibCpt,
                @sRibCle,
                @dcMtTotReg,
                @sCodModeReg,
                '0',
                @dtCreeLe,
                @dtCreeLe,
                @sCodOper
 FROM           sysadm.sinistre
 WHERE          sinistre.id_sin    = @dcIdSin

 Return @@RowCount

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_REG_GTI_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table REG_GTI
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcCptReg       Decimal (  2,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdRgpt       Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcMtTotReg     Decimal ( 11,2 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REG_GTI_REGUL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_REG_GTI_REGUL
GO

CREATE procedure sysadm.PS_I01_REG_GTI_REGUL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @dcCptReg       Decimal (  2,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdRgpt       Decimal (  7,0 ),
        @dcIdI          Decimal (  7,0 ),
        @dcMtTotReg     Decimal ( 11,2 ),
        @dtCreeLe       DateTime        ,
        @sCodOper       Varchar (  4   ) 
AS
 INSERT INTO    sysadm.reg_gti
        (       reg_gti.id_sin,
                reg_gti.id_reg,
                reg_gti.id_gti,
                reg_gti.id_rgpt,
                reg_gti.id_i,
                reg_gti.mt_reg,
                reg_gti.mt_rgpt,
                reg_gti.cree_le,
                reg_gti.maj_le,
                reg_gti.maj_par         )
 VALUES  (      @dcIdSin,
                @dcCptReg,
                @dcIdGti,
                @dcIdRgpt,
                @dcIdI,
                @dcMtTotReg,
                @dcMtTotReg,
                @dtCreeLe,
                @dtCreeLe,
                @sCodOper               )

 Return @@RowCount

GO



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_A_VIRER_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_A_VIRER
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_A_VIRER_REGUL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_A_VIRER_REGUL
GO

CREATE procedure sysadm.DW_S01_W_A_VIRER_REGUL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT	w_a_virer.id_sin,
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
	w_a_virer.cod_pos,	
	w_a_virer.cod_mode_reg,
	w_a_virer.cree_le,
	w_a_virer.maj_le,
	w_a_virer.maj_par		
  FROM  sysadm.w_a_virer
 WHERE	w_a_virer.id_sin        = @dcIdSin      And
        w_a_virer.cod_pos       = '0'


GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REGLEMENT_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       30/07/1998
-- Libell‚              :        
-- Commentaires         :       S‚lect sur la table REGLEMENT
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
--  JFF     17/10/2022      [202210171224] _V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REGLEMENT_REGUL_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REGLEMENT_REGUL_V01
GO

CREATE procedure sysadm.DW_S01_REGLEMENT_REGUL_V01
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS


 SELECT r.id_sin,
        r.id_reg,
        r.mt_tot_reg,
        r.lib_reg,
        r.dte_reg,
		r.rib_bq,
        r.rib_gui,
        r.rib_cpt,
        r.rib_cle,
        r.cod_inter,
        r.cod_mode_reg,
        r.cod_mot_reg,
        r.id_i,
        r.cree_le,
        r.maj_le,
        r.maj_par,
        r.valide_le,
        r.valide_par,
        r.id_reg_base,
        0,
        0,
        r.num_let_cheque,
		IsNull( 
			Case r.cod_mot_reg 
					When 'RN' Then 
						Abs ( 
								(  r.mt_tot_reg +
										( 
										ISNULL ( 
										(
										Select Sum ( r2.mt_tot_reg )
										From sysadm.reglement r2
										Where r2.id_sin = r.id_sin
										And   r2.id_reg_base = r.id_reg
										And   r2.lib_reg not in ( 'RM/FRANCHISE (FR5)', 'RM/REMB. FRANCHISE CB A L''ASSUREUR' ) 
										And   r2.cod_mot_reg in ( 'RM', 'RP' ) 
										), 0 )
										)
								)
							) * (-1)
					Else 0
		    End,
			0 ) 'som_rn_rp'

 FROM  sysadm.reglement r
  WHERE  r.id_sin = @dcIdSin
 GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_REG_GTI_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       30/07/1998
-- Libell‚              :        
-- Commentaires         :       S‚lect sur la table REG_GTI
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REG_GTI_REGUL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REG_GTI_REGUL
GO

CREATE procedure sysadm.DW_S01_REG_GTI_REGUL
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT reg_gti.id_sin,
        reg_gti.id_reg,
        reg_gti.id_gti,
        reg_gti.id_rgpt,
        reg_gti.id_i,
	reg_gti.mt_reg,
        reg_gti.mt_rgpt,
        code.lib_code
  FROM  sysadm.reg_gti,
        sysadm.code
 WHERE  reg_gti.id_sin          = @dcIdSin              And
        code.id_typ_code        = '-GS'                 And
        code.id_code            = reg_gti.id_rgpt       And
        reg_gti.id_gti         <> -1
 UNION
 SELECT reg_gti.id_sin,
        reg_gti.id_reg,
        reg_gti.id_gti,
        reg_gti.id_rgpt,
        reg_gti.id_i,
	reg_gti.mt_reg,
        reg_gti.mt_rgpt,
        code.lib_code
  FROM  sysadm.reg_gti,
        sysadm.code
 WHERE  reg_gti.id_sin          = @dcIdSin              And
        code.id_typ_code        = '+NF'                 And
        code.id_code            = reg_gti.id_rgpt       And
        reg_gti.id_gti          = -1
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_VAL_REGUL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion d'une r‚gularisation
-- Références           :       
--
-- Arguments            :       @sLibReg        Varchar ( 35   )        (Val)
--                      :       @sCodModeReg    Varchar (  2   )        (Val)
--                      :       @sRibBq         Varchar (  5   )        (Val)
--                      :       @sRibGui        Varchar (  5   )        (Val)
--                      :       @sRibCpt        Varchar ( 11   )        (Val)
--                      :       @sRibCle        Varchar (  2   )        (Val)
--                      :       @dtDteReg       DateTime                (Val)
--                      :       @dcMtTotReg     Decimal ( 11,2 )        (Val)
--                      :       @sCodMotReg     Varchar (  2   )        (Val)
--                      :       @dcIdRegBase    Decimal (  2,0 )        (Val)
--                      :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcCptReg       Decimal (  2,0 )        (Val)
--                      :       @sCodInter      Varchar (  2   )        (Val)
--                      :       @dcIdRgpt       Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @sProc          Varchar ( 60   )        (R‚f)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- Le 05/07/2005 MAJ JFF suite Demande PLJ/LR : On insert dans w_a_virer les RM s'ils sont FM 
-- Le 05/08/2005 MAJ JFF On insert aussi dans w_a_virer les RP s'ils sont FM 
-- Le 18/03/2016 MAJ JFF [VDOC20293] - On traite le cas LBE à part, part de réglement sur les RM/RP Type FM.
-- JFF      12/02/2016   [PI062]
--  JFF     17/10/2022      [202210171224] 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VAL_REGUL' AND type = 'P' )
        DROP procedure sysadm.PS_VAL_REGUL
GO


CREATE procedure sysadm.PS_VAL_REGUL
        @sLibReg        Varchar ( 35   ),
        @sCodModeReg    Varchar (  2   ),
        @sRibBq         Varchar (  5   ),
        @sRibGui        Varchar (  5   ),
        @sRibCpt        Varchar ( 11   ),
        @sRibCle        Varchar (  2   ),
        @dtDteReg       DateTime        ,
        @dcMtTotReg     Decimal ( 11,2 ),
        @sCodMotReg     Varchar (  2   ),
        @dcIdRegBase    Decimal (  2,0 ),
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcCptReg       Decimal (  2,0 ),
        @sCodInter      Varchar (  2   ),
        @dcIdRgpt       Decimal (  7,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dtCreeLe       DateTime        ,
        @sCodOper       Varchar (  4   ),
        @sProc          Varchar ( 60   ) OUTPUT
		AS

Declare @iRet           Integer
Declare @iWSin          Integer
Declare @sIdFour		VarChar ( 10 ) -- [VDOC

SELECT  @dcCptReg       = @dcCptReg + 1

SELECT  @iWSin          = Count(*)
FROM    sysadm.w_sin
WHERE   w_sin.id_sin    = @dcIdSin

If      @sCodMotReg      = 'RI'
        Begin
        /* ... Cr‚ation dans la table REGLEMENT ... */
                Select @sProc = 'Creation REGLEMENT (REGUL RI)'

                EXEC @iRet = sysadm.PS_I01_REGLEMENT_REGUL
                             @dcIdSin, @dcCptReg, @dcMtTotReg, @sLibReg,
                             @dtDteReg, @sRibBq, @sRibGui, @sRibCpt, @sRibCle,
                             @sCodInter, @sCodModeReg, @sCodMotReg, @dcIdI,
                             @dcIdRegBase, @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet


        /* ... Cr‚ation dans la table W_A_VIRER ... */
                Select @sProc = 'Creation dans W_A_VIRER (REGUL RI)'
                EXEC @iRet = sysadm.PS_I01_W_A_VIRER_REGUL
                             @dcIdSin, @dcIdI, @dcCptReg, @sCodInter,
                             @sRibBq, @sRibGui, @sRibCpt, @sRibCle,
                             @sCodMotReg, @sCodModeReg, @dcMtTotReg, 
                             @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet

        /* ... Modification dans la table SINISTRE ... */
                Select @sProc = 'Modification SINISTRE (REGUL RI)'

                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.cpt_reg        = @dcCptReg
                WHERE   sinistre.id_sin         = @dcIdSin      And
                        sinistre.cpt_reg        = ( @dcCptReg - 1 )

                If      @@RowCount <> 1 Return -1       

        Select @sProc = ''
        
        End

If      @sCodMotReg      = 'RM' Or @sCodMotReg = 'RP'
        Begin
        /* ... Cr‚ation dans la table REGLEMENT ... */
                Select @sProc = 'Creation REGLEMENT (REGUL RM/RP)'

                EXEC @iRet = sysadm.PS_I01_REGLEMENT_REGUL
                             @dcIdSin, @dcCptReg, @dcMtTotReg, @sLibReg,
                             @dtDteReg, @sRibBq, @sRibGui, @sRibCpt, @sRibCle,
                             @sCodInter, @sCodModeReg, @sCodMotReg, @dcIdI,
                             @dcIdRegBase, @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet

        /* ... Cr‚ation dans la table REG_GTI ... */
                Select @sProc = 'Creation REG_GTI (REGUL RM/RP)'

                EXEC @iRet = sysadm.PS_I01_REG_GTI_REGUL
                             @dcIdSin, @dcCptReg, @dcIdGti, @dcIdRgpt,
                             @dcIdI, @dcMtTotReg, @dtCreeLe, @sCodOper
                If @iRet <> 1 Return @iRet


        /* ... Cr‚ation dans la table W_A_VIRER ... */
		-- [VDOC20293]
		Set @sIdFour = ''
		Select @sIdFour = i.id_four
		From   sysadm.inter i
		Where  i.id_sin = @dcIdSin
		And    i.id_i = @dcIdI

		If @sIdFour is null Set @sIdFour = ''

		-- Le 05/07/2005 MAJ JFF suite Demande PLJ/LR : On insert dans w_queue les RM/RP s'ils sont FM 
		if Upper ( @sCodModeReg ) = 'FM' And ( Upper ( @sCodMotReg ) = 'RM' Or Upper ( @sCodMotReg ) = 'RP' ) And @sIdFour <> 'LBE'
			Begin
				Select @sProc = 'Creation dans W_A_VIRER (REGUL RM/FM)'
				EXEC @iRet = sysadm.PS_I01_W_A_VIRER_REGUL
					     @dcIdSin, @dcIdI, @dcCptReg, @sCodInter,
					     @sRibBq, @sRibGui, @sRibCpt, @sRibCle,
					     @sCodMotReg, @sCodModeReg, @dcMtTotReg, 
					     @dtCreeLe, @sCodOper
				If @iRet <> 1 Return @iRet
			End


        /* ... Modification dans la table SINISTRE ... */
                Select @sProc = 'Modification SINISTRE (REGUL RM/RP)'

                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.cpt_reg        = @dcCptReg,
                        sysadm.sinistre.mt_reg         = 
										Case 
											When sinistre.mt_reg + @dcMtTotReg < 0 Then 0
											Else sinistre.mt_reg + @dcMtTotReg 
										End 
                WHERE   sinistre.id_sin         = @dcIdSin      And
                        sinistre.cpt_reg        = ( @dcCptReg - 1 )

                If      @@RowCount <> 1 Return -1

                If      @dcIdGti <> -1
                        Begin             
        /* ... Modification dans la table GAR_SIN ... */
                                Select @sProc = 'Modification GAR_SIN (REGUL RM/RP)'

                                UPDATE  sysadm.gar_sin
                                SET     sysadm.gar_sin.mt_plaf_reg     = 
														Case 
															When gar_sin.mt_plaf_reg + @dcMtTotReg < 0 Then 0
															Else gar_sin.mt_plaf_reg + @dcMtTotReg 
														End,
                                        sysadm.gar_sin.valide_le       = @dtCreeLe                             ,
                                        sysadm.gar_sin.valide_par      = @sCodOper
                                WHERE   gar_sin.id_sin          = @dcIdSin      And
                                        gar_sin.id_gti          = @dcIdGti

                                If      @@RowCount <> 1 Return -1       
                        End     

        /* ... Modification dans la table INTER ... */
                Select @sProc = 'Modification INTER (REGUL RM/RP)'

                UPDATE  sysadm.inter
                SET     sysadm.inter.mt_reg     =
										Case 
											When inter.mt_reg + @dcMtTotReg < 0 Then 0
											Else inter.mt_reg + @dcMtTotReg 
										End 
                WHERE   inter.id_sin            = @dcIdSin      And
                        inter.id_i              = @dcIdI

                If      @@RowCount <> 1 Return -1       

                If      @iWSin = 1
                        Begin

        /* ... Modification dans la table W_SIN ... */
                                Select @sProc = 'Modification W_SIN (REGUL RM/RP)'

                                UPDATE  sysadm.w_sin
                                SET     sysadm.w_sin.mt_reg  = 
													Case 
														When w_sin.mt_reg + @dcMtTotReg < 0 Then 0
														Else w_sin.mt_reg + @dcMtTotReg 
													End 
                                WHERE   w_sin.id_sin         = @dcIdSin

                                If      @@RowCount <> 1 Return -1       

                                If      @dcIdGti <> -1
                                        Begin
        /* ... Modification dans la table W_GAR_SIN ... */
                                                Select @sProc = 'Modification W_GAR_SIN (REGUL RM/RP)'

                                                UPDATE  sysadm.w_gar_sin
                                                SET     sysadm.w_gar_sin.mt_plaf_reg   = 
																	Case 
																		When w_gar_sin.mt_plaf_reg + @dcMtTotReg < 0 Then 0
																		Else w_gar_sin.mt_plaf_reg + @dcMtTotReg 
																	End,
                                                        sysadm.w_gar_sin.maj_le        = @dtCreeLe                             ,
                                                        sysadm.w_gar_sin.maj_par       = @sCodOper
                                                WHERE   w_gar_sin.id_sin        = @dcIdSin      And
                                                        w_gar_sin.id_gti        = @dcIdGti

                                                If      @@RowCount <> 1 Return -1       
                                        End 

        /* ... Modification dans la table W_INTER ... */
                                Select @sProc = 'Modification W_INTER (REGUL RM/RP)'

                              UPDATE  sysadm.w_inter
                                SET     sysadm.w_inter.mt_reg   = 
													Case 
														When w_inter.mt_reg + @dcMtTotReg < 0 Then 0
														Else w_inter.mt_reg + @dcMtTotReg 
													End 
                                WHERE   w_inter.id_sin          = @dcIdSin      And
                                        w_inter.id_i            = @dcIdI

                                If      @@RowCount <> 1 Return -1       

                        End


        Select @sProc = ''
        
        End

GO
