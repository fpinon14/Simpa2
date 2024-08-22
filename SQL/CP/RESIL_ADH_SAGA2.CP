-------------------------------------------------------------------
--
-- Fichier              :       RESIL_ADH_SAGA2.CP
-- Auteur               :       Fabry Jf
-- Date                 :       22/08/2024
--
-- Commentaires         :       
--
-- Procedures           :       
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_RESIL_ADH_SAGA2
-- Auteur               :       Fabry JF
-- Date                 :       22/08/2024
-- Libelle              :        
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RESIL_ADH_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_I_RESIL_ADH_SAGA2
GO

CREATE procedure sysadm.PS_I_RESIL_ADH_SAGA2
        @dcIdSin        Decimal (  10, 0 ) -- [PI062]
AS


Go

