--------------------------------------------------------------------
--
-- Procédure            :       PS_D02_W_DIV_SIN_TRACE
-- Auteur               :       MADANI M
-- Date                 :       21/12/2005
-- Libellé              :
-- Commentaires         :       Suppression zone tempo sur W_Div_Sin et Div_Sin
-- Références           :
--
-- Arguments            :       @dcIdSin                        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D02_W_DIV_SIN_TRACE' AND type = 'P' )
        DROP procedure sysadm.PS_D02_W_DIV_SIN_TRACE
GO

CREATE procedure sysadm.PS_D02_W_DIV_SIN_TRACE
	@dcIdSin           decimal ( 10, 0 ) -- [PI062] 

AS
  
  Delete from sysadm.w_div_sin
  where  id_sin = @dcIdSin
  And    nom_zone = 'id_cle_ttmob'

  Delete from sysadm.div_sin
  where  id_sin = @dcIdSin
  And    nom_zone = 'id_cle_ttmob'

Go


