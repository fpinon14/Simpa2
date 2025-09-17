-------------------------------------------------------------------
--
-- Fichier              :       SOUPLESSE.CP
-- Auteur               :       Fabry JF
-- Date                 :       25/09/2018
--
-- Commentaires         :       
--
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_S_SOUPLESSE
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      04/07/2017   [DF005]
-- JFF      26/09/2017   [DF006]
-- JFF      14/12/2017   [DF005-1-LOT2]
-- JFF      15/06/2018   [DF005-1-LOT3]
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SOUPLESSE_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_SOUPLESSE_V01
GO

CREATE procedure sysadm.PS_S_SOUPLESSE_V01
	@adcIdProd   Decimal (7),
	@adcIdRev    Integer,
	@adcIdGti    Decimal (7),
	@asIdSpl     VarChar (10)

AS

If Exists ( 
	Select Top 1 1
	From   sysadm.souplesse sp with (nolock)
	Where  sp.id_prod = @adcIdProd
	And    ( sp.id_rev  = @adcIdRev Or sp.id_rev = -1 )
	And	   sp.id_gti  = @adcIdGti
	And	   sp.id_spl  = @asIdSpl
 )
 Begin 
	Return 1
 End

Return -1

Go

--------------------------------------------------------------------
-- Procédure            :       IM_I01_SOUPLESSE
-- Auteur               :       FPI
-- Date                 :       10/09/2025
-- Libellé              :		Création d'une nouvelle révision de souplesse - copie toutes les garanties de la rev -1
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_SOUPLESSE' AND type = 'P' )
        DROP procedure sysadm.IM_I01_SOUPLESSE
GO

CREATE procedure sysadm.IM_I01_SOUPLESSE 
            @dcIdProd        decimal ( 7, 0 ),  
            @dcIdRev         decimal ( 7, 0 ),  
            @dcIdRevAnc      decimal ( 7, 0 ),  
            @dtCreeLe        DateTime,  
            @dtMajLe         DateTime,  
            @sMajPar         Varchar ( 4 )  
AS  
  
 INSERT INTO sysadm.souplesse  
           ( id_prod,  
             id_rev,  
             id_gti,  
             id_spl, 
             cree_le,  
             maj_le,  
             maj_par )  
      SELECT id_prod,  
             @dcIdRev,  
             id_gti,  
             id_spl, 
             @dtCreeLe,  
             @dtMajLe,  
             @sMajPar  
        FROM sysadm.souplesse
       WHERE id_prod = @dcIdProd   AND  
             id_rev  = @dcIdRevAnc;
Go

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_SOUPLESSE
-- Auteur               :       FPI
-- Date                 :       10/09/2025
-- Libellé              :       Delete sur table SOUPLESSE.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_SOUPLESSE' AND type = 'P' )
            DROP procedure sysadm.IM_D01_SOUPLESSE
GO

CREATE PROC sysadm.IM_D01_SOUPLESSE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.souplesse
       WHERE id_prod = @dcIdProd AND
             id_rev  = @dcIdRev


GO