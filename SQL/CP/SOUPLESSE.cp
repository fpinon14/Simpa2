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

