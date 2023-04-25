-------------------------------------------------------------------
--
-- Fichier              :       RS5045_MAPT_KSL.CP
-- Auteur               :       Fabry Jf
-- Date                 :       25/04/2023
--
-- Commentaires         :       A compiler sur TRACE_MAIL_XXX
--
-- Procedures           :       
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.PS_RS5045_S_LISTE_VARIABLE_XML_KSL
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libelle              :        
-- Commentaires         :       Select sur la table COMMANDE
-- References           :       En consultation permanente
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-- #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMMANDE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_COMMANDE
GO

CREATE procedure sysadm.DW_S01_COMMANDE
        @dcIdSin        Decimal (  10, 0 ) -- [PI062]
AS


Go
