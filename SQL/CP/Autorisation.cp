-------------------------------------------------------------------
--
-- Fichier              :       AUTORISATION.CP
-- Auteur               :       Fabry JF
-- Date                 :       19/02/2004
--
-- Commentaires         :       
--
-- Procedures           :       
-- IM_S01_AUTORISATION
-- sysadm.DW_S01_AUTORISATION
-- sysadm.DW_S01_AUTORISATION_V01
-- sysadm.DW_S01_DROIT_EXISTANT
-- sysadm.DW_S01_DROIT_EXISTANT_V01
-- sysadm.DW_S01_DROIT_PARAMETRE_VIDE
-- sysadm.DW_S01_DROIT_PRODUIT
-- sysadm.PS_S01_AUTORISATION
-- TRIGGER sysadm.TR_D_DROIT_31_VERS_TB
-- TRIGGER sysadm.TR_I_DROIT_31_VERS_TB
-- TRIGGER sysadm.TR_D_DROIT_19_VERS_223
-- TRIGGER sysadm.TR_I_DROIT_19_VERS_223
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_DROIT_PRODUIT
-- Auteur               :       Fabry JF
-- Date                 :       19/02/2004
-- Libelle              :        
-- Commentaires         :       Lecture des droits de modification pour les courriers 
-- References           :       
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DROIT_PRODUIT' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DROIT_PRODUIT
GO

CREATE procedure sysadm.DW_S01_DROIT_PRODUIT
AS

Select 	co.id_oper,
	co.id_corb,
	p.id_prod,
	p.lib_long,
	'N'

From   	sysadm.corb_oper co
	INNER JOIN sysadm.produit p ON co.id_corb = p.id_corb
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_DROIT_PARAMETRE_VIDE
-- Auteur               :       Fabry JF
-- Date                 :       19/02/2004
-- Libelle              :        
-- Commentaires         :       Modele à nu de la datawindow de paramètrage
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--       JFF   13/09/2012     [DROIT223_19]
-- 		FPI		20/11/2012		[VDoc8992]
--      JFF    04/02/2014     [DROITS_SANDRINE]
--		FPI	   03/07/2014	[VDOC14806]
--      JFF    30/07/2014   [PM234-4_V1]
--    JFF      12/06/2014   [PI052]
--		FPI		08/10/2014	[FORCER_PAIEMENT_PAYBOX]
-- JFF      29/09/2014   [DT081-1_AUTORISATION]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DROIT_PARAMETRE_VIDE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DROIT_PARAMETRE_VIDE
GO
CREATE procedure sysadm.DW_S01_DROIT_PARAMETRE_VIDE

AS

Select 	id_code,
	Case id_code
	 When 2 Then 'Modifier courrier demande de pièce'
	 When 3 Then 'Modifier courrier prise en charge'
	 When 4 Then 'Modifier courrier refus'
	 When 5 Then 'Modifier courrier réglement'
         
         --Le 27/07/2006 MADM Projet DNTMAIL1/2 : Gestion des 5 nouveaux droits (12,13,14,15,16)
--         When 12 Then 'Envoi courrier par mail'
--         When 16 Then 'Envoi courrier particulier par mail'
--         When 13 Then 'Modifier courrier canal mail'
--         When 14 Then 'Modifier courrier régl. canal  mail'
--         When 15 Then 'Modifier courrier Refus canal mail'
         --Fin MADM 27/07/2006
         
	 When 10 Then 'Prén&Nom gestionnaire sur courrier'	 
	 When 8 Then 'Signature personnalisée informatique'
	 When 11 Then 'Signature manuelle'	 	 
	 When 7 Then 'Droit de valider'
	 -- 07/03/2007 - JCA - DCMP 070161
	 When 17 Then 'Droit de valider avec réglement'
	 When 6 Then 'Enchaînement auto. phase validation'
	 When 9 Then 'Gestionnaire du DR'	 -- [VDOC14806] - renommage
	 When 18 Then 'Forçage PEC avec mt à la baisse'  -- [VDOC4684]
	 When 19 Then '!! Saisie reprise base manuelle !!' -- [DROIT223_19]
	 When 20 Then 'Modification statut CRAO' -- [VDoc8992]
	 When 21 Then 'Bouton TOUT MOBILE' -- [DROITS_SANDRINE]
	 When 22 Then 'Cmde Swap suite irréparable' -- [DROITS_SANDRINE]
	 When 23 Then 'Action suite 2 presta de réparation' -- [DROITS_SANDRINE]	 
	 When 24 Then 'Annuler prestation FNAC/CONFO' -- [DROITS_SANDRINE]	 
	 When 25 Then 'Double validation' -- [DROITS_SANDRINE]	 
	 When 26 Then 'Annulation Diag O2M non répondu' -- [DROITS_SANDRINE]	 
	 When 27 Then 'Déconnexion décla Atlas Orange' -- [PM234-4_V1]	 	 
	 When 28 THen 'Retour courrier KSL de type Word' -- [PI052]
	 When 29 Then 'Forcer paiement franchise Paybox/CB' -- [FORCER_PAIEMENT_PAYBOX]
	 When 30 Then 'Recrédit manuel d''une caution' -- [DT081-1_AUTORISATION]
	 When 31 Then 'Gestionnaire hors site Européen' -- [CONS_REST_CARDIF]
	 Else 'DW_S01_DROIT_PARAMETRE_VIDE'
	End Libelle,
	Case id_code
	 When 2  Then 20
	 When 3  Then 30
	 When 4  Then 40
	 When 5  Then 50
         
         --Le 27/07/2006 MADM Projet DNTMAIL1/2 : Gestion des tris pour les 5 nouveaux droits (12,13,14,15,16)
--         When 12 Then 60
--         When 16 Then 70
--         When 13 Then 80
--         When 14 Then 90
--         When 15 Then 100
         --Fin MADM 27/07/2006
         
	 When 10 Then 110
	 When 11 Then 120
	 When 8  Then 130
	 When 7  Then 140
	 -- 07/03/2007 - JCA - DCMP 070161
	 When 17  Then 150
	 When 6  Then 160	 
	 When 9  Then 170
	 When 18 Then 180  -- [VDOC4684]
	 When 19 Then 190  -- [DROIT223_19] 
	 When 20 Then 200	 
	 When 21 Then 210  -- [DROITS_SANDRINE]	 	 	 
	 When 22 Then 220  -- [DROITS_SANDRINE]	 	 	 
	 When 23 Then 230  -- [DROITS_SANDRINE]	 	 	 
	 When 24 Then 240  -- [DROITS_SANDRINE]	 	 	 
	 When 25 Then 250  -- [DROITS_SANDRINE]	 	 	 
	 When 26 Then 260  -- [DROITS_SANDRINE]	 	 	 
	 When 27 Then 270  -- [PM234-4_V1]	
	 When 28 Then 280  -- [PI052]	
	 When 29 Then 290 -- [FORCER_PAIEMENT_PAYBOX]
	 When 30 Then 300 -- [DT081-1_AUTORISATION]
	 When 31 Then 310 -- [CONS_REST_CARDIF]
	 Else 1000
	End Tri,
	'N' Autoriser,
	'N' Refuser
from  	sysadm.code c 

where  	c.id_typ_code = '-NA'
And 	id_code <= 100
And     ( id_code <> 28 Or sysadm.FN_CLE_NUMERIQUE ( 'PI052') > 0  ) -- [PI052]

Go

grant execute on sysadm.DW_S01_DROIT_PARAMETRE_VIDE to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_DROIT_EXISTANT
-- Auteur               :       Fabry JF
-- Date                 :       19/02/2004
-- Libelle              :        
-- Commentaires         :       Chargement des droits existant
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DROIT_EXISTANT' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DROIT_EXISTANT
GO
CREATE procedure sysadm.DW_S01_DROIT_EXISTANT
AS
Select 	a.id_nat_oper,
	a.id_oper,
	a.id_prod,
	a.cree_le,
	a.maj_le,
	a.maj_par
from  	sysadm.autorisation a 
where  	id_nat_oper between 1 And 100
Or	id_nat_oper between 101 And 199

Go

-- [VDoc2280] - FPI - 09/12/2010

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DROIT_EXISTANT_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DROIT_EXISTANT_V01
GO
CREATE procedure sysadm.DW_S01_DROIT_EXISTANT_V01
AS
Select 	a.id_nat_oper,
	a.id_oper,
	a.id_prod,
	a.val_car,
	a.cree_le,
	a.maj_le,
	a.maj_par
from  	sysadm.autorisation a 
where  	id_nat_oper between 1 And 100
Or	id_nat_oper between 101 And 199

Go
--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_AUTORISATION
-- Auteur               :       Fabry JF
-- Date                 :       01/03/2004
-- Libelle              :        
-- Commentaires         :       Chargement des droits d'un user
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_AUTORISATION' AND type = 'P' )
        DROP procedure sysadm.DW_S01_AUTORISATION
GO
CREATE procedure sysadm.DW_S01_AUTORISATION
	@sIdOper VarChar ( 4 ),
	@dcIdProd Decimal ( 7 )
	
AS
Select 	a.id_nat_oper,
	a.id_oper,
	a.id_prod

from  	sysadm.autorisation a 
where  	( a.id_oper = @sIdOper
And	( a.id_prod = -1 or a.id_prod = @dcIdProd ) )

Or 	@sIdOper = '*'


Go

-- [VDoc2280] - FPI - 09/12/2010
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_AUTORISATION_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_AUTORISATION_V01
GO
CREATE procedure sysadm.DW_S01_AUTORISATION_V01
	@sIdOper VarChar ( 4 ),
	@dcIdProd Decimal ( 7 )
	
AS
Select 	a.id_nat_oper,
	a.id_oper,
	a.id_prod,
	a.val_car

from  	sysadm.autorisation a 
where  	( a.id_oper = @sIdOper
And	( a.id_prod = -1 or a.id_prod = @dcIdProd ) )

Or 	@sIdOper = '*'


Go
--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_AUTORISATION
-- Auteur               :       Fabry JF
-- Date                 :       01/03/2004
-- Libelle              :        
-- Commentaires         :       Recherche d'un droti en direct sur la base
-- References           :       
--
-- Arguments            :       @sIdOper VarChar ( 4 ),
--                              @dcIdProd Decimal ( 7 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_AUTORISATION' AND type = 'P' )
        DROP procedure sysadm.PS_S01_AUTORISATION
GO
CREATE procedure sysadm.PS_S01_AUTORISATION
        @iIdNatOper integer,
        @sIdOper VarChar ( 4 ),
        @dcIdProd Decimal ( 7 ),
        @iTrouve Integer OUTPUT
        
AS
Select  @iTrouve  = count ( * )

from    sysadm.autorisation a
-- JCA - DCMP 070500 
-- where   ( a.id_oper = @sIdOper Or @sIdOper = '*'  )
-- And     ( a.id_prod = @dcIdProd Or @dcIdProd = -1 )
-- And     ( a.id_nat_oper = @iIdNatOper Or a.id_nat_oper = -1 )
/* JFF le 29/08/2007
WHERE   ( a.id_oper = @sIdOper OR a.id_oper = '*'  )
AND     ( a.id_prod = @dcIdProd OR a.id_prod = -1 )
AND     ( a.id_nat_oper = @iIdNatOper OR a.id_nat_oper = -1 )
*/
WHERE   ( a.id_oper = @sIdOper OR @sIdOper = '*'  )
--AND     ( a.id_prod = @dcIdProd OR @dcIdProd = -1 ) JFF le 29/04/08
AND     ( a.id_prod = @dcIdProd OR a.id_prod = -1 ) -- JFF le 29/04/08
AND     ( a.id_nat_oper = @iIdNatOper OR a.id_nat_oper = -1 )


Go

--------------------------------------------------------------------
--
-- Procedure    : IM_S01_AUTORISATION
-- Auteur       : FPI
-- Date         : 19/08/2008 
-- Libelle      : Sélection de l'autorisation d'un opérateur
-- Commentaires :
-- References   : U_GS_SP_SINISTRE
--
-- Arguments    : @iIdNatOper  Integer,
--				  @sCodOper    Varchar(4)
--				  @sAlt        Char(1) Output
--
-- Retourne     : La s‚lection
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_AUTORISATION' AND type = 'P' )
 DROP procedure sysadm.IM_S01_AUTORISATION
GO

CREATE procedure IM_S01_AUTORISATION
 @iIdNatOper  Integer,
 @sCodOper    Varchar(4),
 @sAlt        Char(1) Output
 
AS

Select @sAlt = 'N'

SELECT @sAlt = 'O' FROM sysadm.autorisation WHERE id_nat_oper = @iIdNatOper And id_oper = @sCodOper
GO

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_DROIT_19_VERS_223
-- Auteur               :       Fabry JF
-- Date                 :       13/09/2012
-- Libelle              :       [DROIT223_19]
-- Commentaires         :       Traduit le droit 19 en 223 et le 119 en suppr du 223 et l'absence du 19 en l'absence du 223. 
-- References           :       [DROIT223_19]
--
--
-- Retourne             :       Rien
--      JFF    04/02/2014     [DROITS_SANDRINE]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_DROIT_19_VERS_223' AND type = 'TR' )
        DROP trigger sysadm.TR_I_DROIT_19_VERS_223
GO


CREATE TRIGGER TR_I_DROIT_19_VERS_223
            ON sysadm.autorisation
    FOR INSERT
AS 

Insert into sysadm.autorisation
Select Case i.id_nat_oper
			When 19 Then 223
			When 21 Then 204
			When 22 Then 210
			When 23 Then 212
			When 24 Then 213 -- Restreint, voir val_car
			When 25 Then 214			
			When 26 Then 218						
	   End,
	   i.id_oper, 
	   i.id_prod, 
	   Case i.id_nat_oper
		 When 24 Then 'ID_FOUR=#FNC#CFM#' -- 213 Restreint
		 Else i.val_car
	   End,
	   i.cree_le,
	   i.maj_le,
	   i.maj_par
From inserted i
Where i.id_nat_oper in ( 19, 21, 22, 23, 24, 25, 26 )
and not exists (
		select * 
		from sysadm.autorisation a 
		where a.id_nat_oper=Case i.id_nat_oper
								When 19 Then 223
								When 21 Then 204
								When 22 Then 210
								When 23 Then 212
								When 24 Then 213 
								When 25 Then 214			
								When 26 Then 218						
							  End				
		and   a.id_oper=i.id_oper
	) -- pour la recopie de produits

Delete From sysadm.autorisation
From sysadm.autorisation a, inserted i
Where a.id_oper = i.id_oper
And   ( 
		( i.id_nat_oper = 119 And a.id_nat_oper = 223 ) Or
		( i.id_nat_oper = 121 And a.id_nat_oper = 204 ) Or
		( i.id_nat_oper = 122 And a.id_nat_oper = 210 ) Or
		( i.id_nat_oper = 123 And a.id_nat_oper = 212 ) Or
		( i.id_nat_oper = 124 And a.id_nat_oper = 213 and a.val_car = 'ID_FOUR=#FNC#CFM#' ) Or
		( i.id_nat_oper = 125 And a.id_nat_oper = 214 ) Or
		( i.id_nat_oper = 126 And a.id_nat_oper = 218 ) 
	  )

Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_D_DROIT_19_VERS_223
-- Auteur               :       Fabry JF
-- Date                 :       13/09/2012
-- Libelle              :       [DROIT223_19]
-- Commentaires         :       Traduit le droit 19 en 223 et le 119 en suppr du 223 et l'absence du 19 en l'absence du 223. 
-- References           :       [DROIT223_19]
--
--
-- Retourne             :       Rien
--      JFF    04/02/2014     [DROITS_SANDRINE]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_D_DROIT_19_VERS_223' AND type = 'TR' )
        DROP trigger sysadm.TR_D_DROIT_19_VERS_223
GO

CREATE TRIGGER sysadm.TR_D_DROIT_19_VERS_223
            ON sysadm.autorisation
    FOR DELETE
AS 

Delete From sysadm.autorisation
From sysadm.autorisation a, deleted d
Where a.id_oper = d.id_oper
And	( 
		( d.id_nat_oper in ( 119, 19 ) And a.id_nat_oper = 223 ) Or
		( d.id_nat_oper in ( 121, 21 ) And a.id_nat_oper = 204 ) Or
		( d.id_nat_oper in ( 122, 22 ) And a.id_nat_oper = 210 ) Or
		( d.id_nat_oper in ( 123, 23 ) And a.id_nat_oper = 212 ) Or
		( d.id_nat_oper in ( 124, 24 ) And a.id_nat_oper = 213 and a.val_car = 'ID_FOUR=#FNC#CFM#' ) Or
		( d.id_nat_oper in ( 125, 25 ) And a.id_nat_oper = 214 ) Or
		( d.id_nat_oper in ( 126, 26 ) And a.id_nat_oper = 218 ) 
	)
	
Go


--------------------------------------------------------------------
--
-- Procedure            :       TR_I_DROIT_31_VERS_TB
-- Auteur               :       Fabry JF
-- Date                 :       29/10/2018
-- Libelle              :       [CONS_REST_CARDIF]
-- Commentaires         :       
-- References           :       
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      11/02/2019   [PM473-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_DROIT_31_VERS_TB' AND type = 'TR' )
        DROP trigger sysadm.TR_I_DROIT_31_VERS_TB
GO

CREATE TRIGGER sysadm.TR_I_DROIT_31_VERS_TB
            ON sysadm.autorisation
    FOR INSERT
AS 

Update sysadm.autorisation
Set id_prod = -1
From inserted i, sysadm.autorisation a
Where a.id_oper = i.id_oper 
And   a.id_nat_oper = i.id_nat_oper 
And   i.id_nat_oper = 31  

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Delete From SHERPA_PRO.sysadm.consult_restreinte
		From SHERPA_PRO.sysadm.consult_restreinte cr, inserted i
		Where i.id_nat_oper = 31  
		And   cr.id_oper = i.id_oper
		And   cr.id_acces = 'E'
		And   cr.id_fam in ( 150, 250 )

		Insert into SHERPA_PRO.sysadm.consult_restreinte
		Select i.id_oper, 'E', 150, i.cree_le, i.maj_par, i.maj_le, i.maj_par
		From inserted i
		Where i.id_nat_oper = 31
		
		Insert into SHERPA_PRO.sysadm.consult_restreinte
		Select i.id_oper, 'E', 250, i.cree_le, i.maj_par, i.maj_le, i.maj_par
		From inserted i
		Where i.id_nat_oper = 31

	END
Else
	BEGIN
		Delete From SHERPA_SIM.sysadm.consult_restreinte
		From SHERPA_SIM.sysadm.consult_restreinte cr, inserted i
		Where i.id_nat_oper = 31  
		And   cr.id_oper = i.id_oper
		And   cr.id_acces = 'E'
		And   cr.id_fam in ( 150, 250 )

		Insert into SHERPA_SIM.sysadm.consult_restreinte
		Select i.id_oper, 'E', 150, i.cree_le, i.maj_par, i.maj_le, i.maj_par
		From inserted i
		Where i.id_nat_oper = 31		

		Insert into SHERPA_SIM.sysadm.consult_restreinte
		Select i.id_oper, 'E', 250, i.cree_le, i.maj_par, i.maj_le, i.maj_par
		From inserted i
		Where i.id_nat_oper = 31

	END
Go


--------------------------------------------------------------------
--
-- Procedure            :       TR_D_DROIT_31_VERS_TB
-- Auteur               :       Fabry JF
-- Date                 :       29/10/2018
-- Libelle              :       [CONS_REST_CARDIF]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      11/02/2019   [PM473-1]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_D_DROIT_31_VERS_TB' AND type = 'TR' )
        DROP trigger sysadm.TR_D_DROIT_31_VERS_TB
GO

CREATE TRIGGER sysadm.TR_D_DROIT_31_VERS_TB
            ON sysadm.autorisation
    FOR DELETE
AS 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Delete From SHERPA_PRO.sysadm.consult_restreinte
		From SHERPA_PRO.sysadm.consult_restreinte cr, deleted i
		Where i.id_nat_oper = 31  
		And   cr.id_oper = i.id_oper
		And   cr.id_acces = 'E'
		And   cr.id_fam in ( 150, 250 )

	END
Else
	BEGIN
		Delete From SHERPA_SIM.sysadm.consult_restreinte
		From SHERPA_SIM.sysadm.consult_restreinte cr, deleted i
		Where i.id_nat_oper = 31  
		And   cr.id_oper = i.id_oper
		And   cr.id_acces = 'E'
		And   cr.id_fam in ( 150, 250 )

	END

Go
