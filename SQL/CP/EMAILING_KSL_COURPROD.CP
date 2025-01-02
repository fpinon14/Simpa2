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
