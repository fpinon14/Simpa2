-------------------------------------------------------------------
--
-- Fichier              :       codecon.cp
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 13:28:51
--
-- Commentaires         :       Liste des proc afférant a la table code_condition
--
-- Procédures           :
--                              DW_S01_CODE_CONDITION
--                              IM_D01_CODE_CONDITION
--                              IM_D02_CODE_CONDITION
--                              DW_I01_CODE_CONDITION
--                              DW_D01_CODE_CONDITION
--                              DD_S01_CODE_CONDITION
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_CODE_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:31:32
-- Libellé              :       Selection des codes condition affectés aux 
-- Commentaires         :       garanties d'un produit
-- Références           :       w_td_sp_code_condition
--
-- Arguments            :       @dcIdProduit     decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CODE_CONDITION
GO

CREATE PROC sysadm.DW_S01_CODE_CONDITION
            @dcIdProduit      decimal ( 7, 0 )
AS
 SELECT sysadm.code_condition.id_prod,
        sysadm.code_condition.id_gti,
        sysadm.code_condition.id_typ_code,
        sysadm.code_condition.id_code,
        sysadm.code.lib_code,
        sysadm.code_condition.lib_evt,
        sysadm.code_condition.cree_le,
        sysadm.code_condition.maj_le,
        sysadm.code_condition.maj_par
   FROM sysadm.code_condition,
        sysadm.code
  WHERE sysadm.code_condition.id_prod     = @dcIdProduit    			AND
        sysadm.code_condition.id_typ_code = sysadm.code.id_typ_code	AND
        sysadm.code_condition.id_code     = sysadm.code.id_code 

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_CODE_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:01:06
-- Libellé              :       Delete sur table CODE_CONDITION.
-- Commentaires         :
-- Références           :       PS_SUPCODEGARANTIE
--
-- Arguments            :       @dcIdProd   decimal ( 7, 0 ),
--                              @dcIdGti    decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_D01_CODE_CONDITION
GO

CREATE PROC sysadm.IM_D01_CODE_CONDITION
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdGti   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.code_condition
       WHERE code_condition.id_prod = @dcIdProd AND
             code_condition.id_gti  = @dcIdGti
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_CODE_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:18:40
-- Libellé              :       Delete sur table CODE_CONDITION.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_D02_CODE_CONDITION
GO

CREATE PROC sysadm.IM_D02_CODE_CONDITION
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.code_condition
       WHERE code_condition.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_CODE_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:49:24
-- Libellé              :       Insertion d'un code condition affecté à une garantie
-- Commentaires         :
-- Références           :       w_tm_sp_produit, dw_CodCon
--
-- Arguments            :       @dcIdProd      decimal ( 7, 0 ),
--                              @dcIdGti       decimal ( 7, 0 ),
--                              @sIdTypCode    Varchar(3),
--                              @dcIdCode      decimal ( 7, 0 ),
--                              @dtCreeLe      DateTime,
--                              @dtMajLe       DateTime,
--                              @sMajPar       Varchar(4)
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_I01_CODE_CONDITION
GO

CREATE PROC sysadm.DW_I01_CODE_CONDITION
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 ),
            @sIdTypCode   Varchar(3),
            @dcIdCode     decimal ( 7, 0 ),
            @sLibEvt      Varchar(65),
            @dtCreeLe     DateTime,
            @dtMajLe      DateTime,
            @sMajPar      Varchar(4)
AS
 INSERT INTO sysadm.code_condition
             ( sysadm.code_condition.id_prod,
               sysadm.code_condition.id_gti,
               sysadm.code_condition.id_typ_code,
               sysadm.code_condition.id_code,
               sysadm.code_condition.lib_evt,
               sysadm.code_condition.cree_le,
               sysadm.code_condition.maj_le,
               sysadm.code_condition.maj_par )
      VALUES ( @dcIdProd,
               @dcIdGti,
               @sIdTypCode,
               @dcIdCode,
	       @sLibEvt,
               @dtCreeLe,
               @dtMajLe,
               @sMajPar )
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_CODE_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:53:48
-- Libellé              :       Destruction d'un code condition
-- Commentaires         :
-- Références           :       w_tm_sp_produit, 
--
-- Arguments            :       dw_codcon
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_CODE_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_D01_CODE_CONDITION
GO

CREATE PROC sysadm.DW_D01_CODE_CONDITION
@dcIdProd       decimal ( 7, 0 ),
@dcIdGti        decimal ( 7, 0 ),
@sIdTypCode     Varchar(3),
@dcIdCode       decimal ( 7, 0 )
AS

 DELETE FROM sysadm.code_condition
        WHERE sysadm.code_condition.id_prod     = @dcIdProd         And
              sysadm.code_condition.id_gti      = @dcIdGti          And
              sysadm.code_condition.id_typ_code = @sIdTypCode   And
              sysadm.code_condition.id_code     = @dcIdCode
GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_CONDITION
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )
--                      :       @sIdTypCode     Varchar (  3 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_CONDITION' AND type = 'P' )
        DROP procedure sysadm.DD_S01_CODE_CONDITION
GO

CREATE procedure sysadm.DD_S01_CODE_CONDITION
        @dcIdProd       decimal ( 7, 0 ),
        @sIdTypCode     Varchar (  3 )
AS
 SELECT code.id_code,
        code.lib_code,
        code_condition.id_gti,
        code_condition.lib_evt
 FROM   sysadm.code,
        sysadm.code_condition
 WHERE  code.id_typ_code        = code_condition.id_typ_code    AND
        code.id_code            = code_condition.id_code        AND
        code.id_typ_code        = @sIdTypCode                   AND
        code_condition.id_prod  = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_DETERMINER_EVT_REPA
-- Auteur               :       FABRY JF
-- Date                 :       11/04/2017
-- Libellé              :       [DT307] 
-- Commentaires         :       
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DETERMINER_EVT_REPA' AND type = 'P' )
        DROP procedure sysadm.PS_S_DETERMINER_EVT_REPA
GO

CREATE procedure sysadm.PS_S_DETERMINER_EVT_REPA
        @dcIdProd       decimal ( 7, 0 ),
        @dcIdGti	    decimal ( 7, 0 ),
		@sMarqPort		varchar ( 35 ),
		@dcIdEvt		decimal ( 7, 0 ) OUTPUT
AS

Declare @iPresenceCordon Integer

Set @iPresenceCordon = 0
If Exists ( 
		Select Top 1 1
		From sysadm.commande_type ct
		Where ct.id_prod = @dcIdProd
		And   ct.id_gti = @dcIdGti
		And   ct.id_code_art = 'PRS'
		And   ct.id_code_frn = 'COR'
	)
	Begin
		Set @iPresenceCordon = 1
	End 

If @dcIdGti = 24 Set @dcIdEvt = 1377

If ( @dcIdGti = 24 And @iPresenceCordon = 1 and @sMarqPort = 'APPLE' ) Or @dcIdGti <> 24 
 Begin
	If Exists ( 
		Select Top 1 1 
		From sysadm.code_condition cc
		Where cc.id_prod = @dcIdProd
		And   cc.id_gti  = @dcIdGti
		And   cc.id_code = 932
		)
	 Begin
		Set @dcIdEvt = 932
	 End 
	Else
	 Begin
		Set @dcIdEvt = 937
	 End 
 End 
GO

