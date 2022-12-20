-------------------------------------------------------------------
--
-- Fichier              :       PM497_TYPO_COURRIER.CP
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2020
--
-- Commentaires         :       PS afférants aux PM497-1 Typologie courrier
--
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_S_TYPO_COURRIER_TOTAL
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2020
-- Libellé              :		-- [PM497-1]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TYPO_COURRIER_TOTAL' AND type = 'P' )
        DROP procedure sysadm.PS_S_TYPO_COURRIER_TOTAL
GO

CREATE procedure sysadm.PS_S_TYPO_COURRIER_TOTAL
AS

Select 
	id_cour,
	typo_court,
	typo_long
From sysadm.typo_courrier with (nolock)
Order by id_cour

Go

--------------------------------------------------------------------
-- Procédure            :       PS_S_TYPO_COURRIER_PROD
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2020
-- Libellé              :		-- [PM497-1]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TYPO_COURRIER_PROD_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_TYPO_COURRIER_PROD_V01
GO

CREATE procedure sysadm.PS_S_TYPO_COURRIER_PROD_V01
	@dcIdProd  Decimal ( 7 )
AS

Select	Distinct
		p.id_nat_cour,
		p.id_cour,
		IsNull ( tc.typo_court, 'NON CATEGORISE' ) typo_court,
		IsNull ( tc.typo_long, 'NON CATEGORISE' ) typo_long
From sysadm.cour_prod p with (nolock)
	 Left outer join sysadm.typo_courrier tc with (nolock) on p.id_cour = tc.id_cour
Where p.id_prod = @dcIdProd
Order by typo_court, id_cour

Go


--------------------------------------------------------------------
-- Procédure            :       PS_S_TYPO_DDDW_TYPO_COURT
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2020
-- Libellé              :		-- [PM497-1]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TYPO_DDDW_TYPO_COURT' AND type = 'P' )
        DROP procedure sysadm.PS_S_TYPO_DDDW_TYPO_COURT
GO

CREATE procedure sysadm.PS_S_TYPO_DDDW_TYPO_COURT
	@dcIdProd  Decimal ( 7 )
AS

Select 'NON CATEGORISE' typo_court
Union 
Select	Distinct
		typo_court
From sysadm.cour_prod p with (nolock)
	 Left outer join sysadm.typo_courrier tc with (nolock) on p.id_cour = tc.id_cour
Where p.id_prod = @dcIdProd
Order by typo_court


Go

--------------------------------------------------------------------
-- Procédure            :       PS_S_TYPO_DDDW_TYPO_LONG
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2020
-- Libellé              :		-- [PM497-1]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TYPO_DDDW_TYPO_LONG' AND type = 'P' )
        DROP procedure sysadm.PS_S_TYPO_DDDW_TYPO_LONG
GO

CREATE procedure sysadm.PS_S_TYPO_DDDW_TYPO_LONG
	@dcIdProd  Decimal ( 7 )
AS

Select 'NON CATEGORISE' typo_court,
	   'NON CATEGORISE' typo_long 
Union 
Select	Distinct
		typo_court,
		typo_long
From sysadm.cour_prod p with (nolock)
	 Left outer join sysadm.typo_courrier tc with (nolock) on p.id_cour = tc.id_cour
Where p.id_prod = @dcIdProd
Order by typo_court, typo_long

Go

