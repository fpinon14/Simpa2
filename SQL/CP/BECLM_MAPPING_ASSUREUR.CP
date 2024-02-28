-------------------------------------------------------------------
--
-- Fichier              :       BECLM_MAPPING_ASSUREUR.CP
-- Auteur               :       JFF
-- Date                 :       28/02/2024
--
-- Commentaires         :       Gestion du mapping entre les assureurs SPB et les assureurs BECLM
--
-- Proc‚dures           :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_RECUP_FLOW_NAME_BECLM
-- Auteur               :       JFF
-- Date                 :       28/02/2024
-- Libell‚              :       [MCO_190_191_BECLM]
-- Commentaires         :       Récupère le flow Name
--
-- Arguments            :       @adcIdSin         decimal (10)        (Val)
--								@adcIdRev		  decimal (7)
--								@asFlowNameBeCLM VarChar ( 50 ) OutPut
--
-- Retourne             :       rien
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_RECUP_FLOW_NAME_BECLM' AND type = 'P' )
        DROP procedure sysadm.PS_S_RECUP_FLOW_NAME_BECLM
GO


CREATE procedure sysadm.PS_S_RECUP_FLOW_NAME_BECLM
	    @adcIdSin         decimal (10),
		@adcIdRev		  decimal (7),
		@asFlowNameBeCLM VarChar ( 50 ) OutPut
AS

Declare @iIdCie Decimal ( 7 )

-- Révision négative
If @adcIdRev < 0 
Begin 
	Select	Top 1 @asFlowNameBeCLM = rtrim ( lTrim ( nom_flux ))
	From	sysadm.beclm_mapping_assureur bcl
	Where   bcl.id_cie = -1

	Return
End 

-- Détermination de l'id_cie
Select Top 1 @iIdCie = po.id_cie
From   sysadm.w_sin ws,
	   sysadm.garantie ga,
	   sysadm.police po
Where  ws.id_sin = @adcIdSin
And    ga.id_prod = ws.id_prod
And    ga.id_rev = ws.id_rev
And    po.id_police = ga.id_police

If @iIdCie is null Or @iIdCie < 0 
Begin 
	Select	Top 1 @asFlowNameBeCLM = rtrim ( lTrim ( nom_flux ))
	From	sysadm.beclm_mapping_assureur bcl
	Where   bcl.id_cie = -1

	Return
End 

Select	Top 1 @asFlowNameBeCLM = rtrim ( lTrim ( nom_flux ))
From	sysadm.beclm_mapping_assureur bcl
Where   bcl.id_cie = @iIdCie

If @@ROWCOUNT = 0 
  Begin 
	Select	Top 1 @asFlowNameBeCLM = rtrim ( lTrim ( nom_flux ))
	From	sysadm.beclm_mapping_assureur bcl
	Where   bcl.id_cie = -1

	Return
  End 
Go

