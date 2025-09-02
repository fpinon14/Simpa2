-------------------------------------------------------------------
--
-- Fichier              :       EMAILING_KSL_COURPROD.CP
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
--
-- Commentaires         :      
--
-- Procedures           :       
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.TR_IU_EMAILING_KSL_COURPROD
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
-- Libelle              :        
-- Commentaires         :       Trigger Insert/Update
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/*
If Exists ( Select Top 1 1 From sys.objects where name = 'TR_IU_EMAILING_KSL_COURPROD' and type = 'TR' ) Drop trigger  sysadm.TR_IU_EMAILING_KSL_COURPROD
Go
Create Trigger sysadm.TR_IU_EMAILING_KSL_COURPROD
	on [sysadm].[emailing_ksl_courprod]
For Insert, Update
As
	Update em
	Set em.cod_maq = rtrim ( ltrim ( Upper ( em.cod_maq ) ))
	From inserted i,
		 sysadm.emailing_ksl_courprod em
	Where i.cod_maq = em.cod_maq
	And   i.id_prod = em.id_prod

Go
*/


--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MIG1_S_EMAILING_KSL_COURPROD' AND type = 'P' )
        DROP procedure sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD
GO

CREATE procedure sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD
	@adcIdProd Decimal ( 7 )
AS

Select	emc.typ_mail,
		emc.cod_maq,
		emc.categorie,
		emc.lib_cour,
		emc.regl,
		emc.piece,
		emc.refus,
		emc.cod_inter,
		( 
		   Select stuff ( 
					( SELECT Distinct ', ' + CAST(rtrim ( cc.lib_code ) AS VARCHAR(250)) 
					  FROM sysadm.code_car cc
					  Where cc.id_typ_code = '-IN'
					  And CharIndex ( '#' + rtrim ( cc.id_code ) + '#', emc.cod_inter ) > 0 
					  For XML PATH ('') )
					, 1, 2, '' )
		) lst_inter

From sysadm.emailing_ksl_courrier emc with ( nolock) ,
	 sysadm.emailing_ksl_courprod emp with ( nolock)
Where emp.id_prod = @adcIdProd
And emc.typ_mail = emp.typ_mail
And emc.cod_maq = emp.cod_maq

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_MIG1_S_CTG_DDDW
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MIG1_S_CTG_DDDW' AND type = 'P' )
        DROP procedure sysadm.PS_MIG1_S_CTG_DDDW
GO
CREATE procedure sysadm.PS_MIG1_S_CTG_DDDW  
 @adcIdProd  Decimal ( 7 )  
AS  
  
Select 'NON CATEGORISE' categorie
Union   
Select Distinct  
		categorie
From sysadm.emailing_ksl_courrier emc with ( nolock) ,
	 sysadm.emailing_ksl_courprod emp with ( nolock)
Where emp.id_prod = @adcIdProd
And emc.cod_maq = emp.cod_maq
Order by categorie  

Go

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD_EXISTE
-- Auteur               :       Fabry JF
-- Date                 :       22/07/2025 
-- Libelle              :       [MIG165_BOUYGUES]
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MIG1_S_EMAILING_KSL_COURPROD_EXISTE' AND type = 'P' )
        DROP procedure sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD_EXISTE
GO

CREATE procedure sysadm.PS_MIG1_S_EMAILING_KSL_COURPROD_EXISTE
	@adcIdProd Decimal ( 7 ),
	@asTypMail VarChar ( 6 ),
	@asCodMaq  VarChar ( 255 ) OutPut,
	@asLibCour  VarChar ( 255 ) OutPut
AS

Select	Top 1 
		@asCodMaq = Trim ( emc.cod_maq ),
		@asLibCour = Trim ( emc.lib_cour )
From sysadm.emailing_ksl_courrier emc with ( nolock) ,
		sysadm.emailing_ksl_courprod emp with ( nolock)
Where emp.id_prod = @adcIdProd
And emp.typ_mail = @asTypMail
And emc.typ_mail = emp.typ_mail
And emc.cod_maq = emp.cod_maq

If @@ROWCOUNT > 0 Return 1

Return 0

Go


