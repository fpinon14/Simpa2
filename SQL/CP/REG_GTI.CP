-------------------------------------------------------------------
--
-- Fichier              :       REG_GTI.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table REG_GTI dans SIMPA2
--
-- Procédures           :       PS_I01_REG_GTI_VAL
--				DW_S01_REG_GTI
--				DW_S02_REG_GTI_STAT
--				DW_S03_REG_GTI_STAT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_REG_GTI_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table REG_GTI
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_REG_GTI_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_REG_GTI_VAL
GO

CREATE procedure sysadm.PS_I01_REG_GTI_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
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
 SELECT         w_reg_gti.id_sin,
                w_reg_gti.id_reg,
                w_reg_gti.id_gti,
                w_reg_gti.id_rgpt,
                w_reg_gti.id_i,
                w_reg_gti.mt_reg,
                w_reg_gti.mt_rgpt,
                w_reg_gti.cree_le,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_reg_gti
 WHERE          w_reg_gti.id_sin        = @dcIdSin

 Return @@Error

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_REG_GTI
-- Auteur               :       Fabry JF
-- Date                 :       10/12/98 10:19:00
-- Libellé              :        
-- Commentaires         :       Sélection de certains champs de REG_GTI
-- Références           :       Utilisé dans W_CM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdReg        Decimal (  2,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_REG_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_S01_REG_GTI
GO

CREATE procedure sysadm.DW_S01_REG_GTI
        @dcIdSin        Decimal (  10,0 ) -- [PI062]

AS
 SELECT reg_gti.id_reg,
	reg_gti.id_gti,
	reg_gti.mt_reg

 FROM   sysadm.reg_gti

 WHERE  reg_gti.id_sin = @dcIdSin
 
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_REG_GTI_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table REG_GTI pour les stats
-- Références           :       Utilisé dans W_A_SP_TRT_STAT_SIN
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdRgpt       Decimal (  7,0 )        (Val)
--                      :       @dtDteDeb       DateTime                (Val)
--                      :       @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1  JFF  22/05/2008  [3SUISSE].COD_MODE_REG 
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_REG_GTI_STAT' AND type = 'P' )
        DROP procedure sysadm.DW_S02_REG_GTI_STAT
GO

CREATE procedure sysadm.DW_S02_REG_GTI_STAT
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdRgpt       Decimal (  7,0 ),
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

-- #1 [3SUISSE].COD_MODE_REG 
-- Ajout d'une jointure sur sysadm.reglement et d'une sélection hors XA,XX,BA

 IF     @dcIdRgpt       = -1
        /* ... S‚lection sur les FRAIS ... */
        Begin
                SELECT  
			-- #1 [3SUISSE].COD_MODE_REG                 	
                	Case reglement.cod_mode_reg 
				When 'BA' Then 0
				When 'XA' Then 0
				When 'XX' Then 0				
				Else reg_gti.mt_reg
			End 'mt_reg',            
			Case reglement.cod_mode_reg 
				When 'BA' Then 0
				When 'XA' Then 0
				When 'XX' Then 0				
				Else reg_gti.mt_rgpt
			End 'mt_rgpt',
			-- :#1 [3SUISSE].COD_MODE_REG 
                        reg_gti.id_reg,
                        reg_gti.id_i
                FROM    sysadm.reg_gti,
                	sysadm.reglement --#1
                WHERE   reg_gti.id_sin          = @dcIdSin              AND
                        reg_gti.id_gti          = -1                    AND
                        reg_gti.maj_le          >= @dtDteDeb            AND
                        reg_gti.maj_le          <= @dtDteFin		
		-- #1
		AND	reglement.id_sin = reg_gti.id_sin
		AND	reglement.id_reg = reg_gti.id_reg
		--:#1
		                        
        End

 IF     @dcIdRgpt       <> -1
        /* ... S‚lection pour les garanties ... */
        Begin
                SELECT  -- #1 [3SUISSE].COD_MODE_REG                 	
                	Case reglement.cod_mode_reg 
				When 'BA' Then 0
				When 'XA' Then 0
				When 'XX' Then 0				
				Else reg_gti.mt_reg
			End 'mt_reg',            
			Case reglement.cod_mode_reg 
				When 'BA' Then 0
				When 'XA' Then 0
				When 'XX' Then 0				
				Else reg_gti.mt_rgpt
			End 'mt_rgpt',
			-- :#1 [3SUISSE].COD_MODE_REG 
                        reg_gti.id_reg,
                        reg_gti.id_i
                FROM    sysadm.reg_gti,
                	sysadm.reglement --#1                
                WHERE   reg_gti.id_sin          = @dcIdSin              AND
                        reg_gti.id_rgpt         = @dcIdRgpt             AND
                        reg_gti.maj_le          >= @dtDteDeb            AND
                        reg_gti.maj_le          <= @dtDteFin
		-- #1
		AND	reglement.id_sin = reg_gti.id_sin
		AND	reglement.id_reg = reg_gti.id_reg
		--:#1                        
        End

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_REG_GTI_STAT
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table REG_GTI pour les stats (FRAIS)
-- Références           :       Utilisé dans W_A_SP_TRT_STAT_SIN
--
-- Arguments            :       @dtDteDeb       DateTime                (Val)
--                      :       @dtDteFin       DateTime                (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_REG_GTI_STAT' AND type = 'P' )
        DROP procedure sysadm.DW_S03_REG_GTI_STAT
GO

CREATE procedure sysadm.DW_S03_REG_GTI_STAT
        @dtDteDeb       DateTime        ,
        @dtDteFin       DateTime
AS

 SELECT distinct reg_gti.id_sin
 FROM   sysadm.reg_gti
 WHERE  reg_gti.maj_le          >= @dtDteDeb            AND
        reg_gti.maj_le          <= @dtDteFin            AND
        reg_gti.id_gti           = -1


GO
