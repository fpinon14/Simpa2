-------------------------------------------------------------------
--
-- Fichier              :       Produit.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 11:01:18
--
-- Commentaires         :       Liste des proc‚dures aff‚rentes … la table produit
--
-- Proc‚dures           :       DD_S01_PRODUIT
--                              DW_S01_PRODUIT
--                              DW_I01_PRODUIT
--                              DW_D01_PRODUIT
--                              IM_S03_PRODUIT
--                              IM_U01_PRODUIT
--                              DW_S02_PRODCORB
--				DD_S02_PRODUIT
--				DD_S03_PRODUIT
--							PS_S01_GESTION_APPAREIL_V00
--				PS_I01_RECOPIE_PRODUIT 	- FPI - 11/12/2008
--				PS_D01_DET_PRO			- FPI - 11/12/2008
--				PS_D01_GARANTIE			- FPI - 11/12/2008
--				PS_S01_VERIF_COMPTE
--				PS_U01_CLOTURE_PRODUIT
--				PS_I02_RECOPIE_PRODUIT
--				PS_V01_RECOPIE_PRODUIT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DD_S01_PRODUIT
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 11:01:51
-- Libell‚              :       S‚lection des produits pour une DDDW
-- Commentaires         :
-- R‚f‚rences           :       dddw_sp_produit
--
-- Arguments            :       Aucun
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DD_S01_PRODUIT
GO

CREATE PROC sysadm.DD_S01_PRODUIT
AS

SELECT  produit.id_prod,
        produit.lib_long,
        produit.lib_court,
        produit.id_dept,
        produit.id_depts
FROM    sysadm.produit

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_PRODUIT
-- Auteur               :       NÝ6
-- Date                 :       22/07/97 16:16:48
-- Libell‚              :       S‚lection d'un Produit
-- Commentaires         :
-- R‚f‚rences           :       D_SP_PRODUIT
--
-- Arguments            :       @dcIdProd  Decimal ( 7, 0 ) ( Val )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PRODUIT
GO

CREATE PROC sysadm.DW_S01_PRODUIT
       @dcIdProd  Decimal ( 7, 0 )
AS

 SELECT produit.id_prod,
        produit.id_dept,
        produit.id_grp,
        produit.lib_court,
        produit.lib_long,
        produit.cod_rev_surv,
        produit.cod_rev_sous,
        produit.cod_rev_rnv,
        produit.cod_niv_ope,
        produit.dur_perrnv_adh,
        produit.unt_perrnv_adh,
        produit.cod_mode_reg,
        produit.lib_bq_debit,
        produit.rib_bq,
        produit.rib_gui,
        produit.rib_cpt,
        produit.rib_cle,
        produit.cod_dest_reg,
        produit.cod_adh,
        produit.id_corb,
        produit.id_police,
        produit.num_tel,
        produit.num_fax,
        produit.id_depts,
        produit.cree_le,
        produit.maj_le,
        produit.maj_par,
	produit.cod_base_dms,
	produit.cod_adr_dms,
	produit.cod_prod_dms,
	produit.alt_crebq_dms,
	produit.nb_adherent,
	produit.cod_euro,
	produit.alt_info_prov,
	produit.alt_rl1,
	produit.dur_rl1_min,
	produit.dur_rl1_max,
	produit.unt_rl1,
    	produit.alt_rl2,
	produit.dur_rl2,
	produit.unt_rl2,
 	produit.alt_sold,
	produit.dur_sold_rl,
	produit.unt_sold_rl,
	produit.dur_sold_pc,
	produit.unt_sold_pc,
	produit.alt_contact,
        produit.cod_tel,
        produit.alt_ouvfenval,
        produit.alt_cmd_mobile,
        produit.id_prod_client,
        produit.alt_cod_boutique,
        groupe.id_grp_base
   FROM sysadm.produit,
   	sysadm.groupe
  WHERE produit.id_prod = @dcIdProd
    AND produit.id_grp = groupe.id_grp

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_I01_PRODUIT
-- Auteur               :       NÝ6
-- Date                 :       22/07/97 16:19:44
-- Libell‚              :       Insert sur table PRODUIT
-- Commentaires         :
-- R‚f‚rences           :       SQLPREVIEW de Dw_1, fenetre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd    Decimal ( 7, 0 )    ( Val ) 
--                              @dcIdDept          Decimal ( 7, 0 )     ( Val )
--                              @dcIdGrp           Decimal ( 7, 0 )     ( Val )
--                              @sLibCourt         String      ( Val )
--                              @sLibLong          String      ( Val )
--                              @dcCodRevSurv      Decimal ( 7, 0 )     ( Val )
--                              @dcCodRevSous      Decimal ( 7, 0 )     ( Val )
--                              @dcCodRevRnv       Decimal ( 7, 0 )     ( Val )
--                              @dcCodNivOpe       Decimal ( 1, 0 )     ( Val )
--                              @dcDurPerrnvAdh    Decimal ( 5, 0 )     ( Val )
--                              @sUntPerrnvAdh     String      ( Val )
--                              @sCodModeReg       String      ( Val )
--                              @sLibBqDebit       String      ( Val )
--                              @sRibBq            String      ( Val )
--                              @sRibGui           String      ( Val )
--                              @sRibCpt           String      ( Val )
--                              @sRibCle           String      ( Val )
--                              @sCodDestReg       String      ( Val )
--                              @sCodAdh           String      ( Val )
--                              @dcIdCorb          Decimal ( 3, 0 )     ( Val )
--                              @dcIdPolice        Decimal ( 7, 0 )     ( Val )
--                              @sNumTel           String      ( Val )
--                              @sNumFax           String      ( Val )
--                              @dcIdDepts         Decimal ( 7, 0 )     ( Val )
--                              @dtCreeLe          DateTime    ( Val )
--                              @dtMajLe           DateTime    ( Val )
--                              @sMajPar           String      ( Val )
--                              @dcCodEuro         Decimal ( 1,0 )      ( Val )
--                              @sAltInfoProv      VarChar ( 1 )        ( Val )
--				@sAltRl1           Varchar ( 1 )	( Val )
--				@dcDurRl1Min       Decimal ( 7, 0 )	( Val )
--				@dcDurRl1Max       Decimal ( 7, 0 )	( Val )
--				@sUntRl1           VarChar ( 1 )	( Val )
--				@sAltRl2           VarChar ( 1 )	( Val )
--				@dcDurRl2          Decimal ( 7, 0 )	( Val )
--				@sUntRl2           VarChar ( 1 )	( Val )
--				@sAltSold          VarChar ( 1 )	( Val )
--				@dcDurSoldRl       Decimal ( 7, 0 )	( Val )
--				@sUntSoldRl        VarChar ( 1 )	( Val )
--				@dcDurSoldPc       Decimal ( 7, 0 )	( Val )
--				@sUntSoldPc        VarChar ( 1 )	( Val )
--				@sAltContact       VarChar ( 1 )	( Val )
--                              @iCodTel           Integer              ( Val )
--				@sAltOuvFenVal     VarChar ( 1 )        ( Val )
--				@sAltCmdMobile     VarChar ( 1 )        ( Val )
--				@sIdProdClient	   VarChar ( 15 )       ( Val )
--				@sAltCodBoutique   VarChar ( 1 )        ( Val )
--
-- Retourne          :       Rien
--
-------------------------------------------------------------------
-- FPI - 21/01/2009 - [DCMP080728] Colonne lib_long passe de 35 à 65 caractères
-- JFF   12/05/2020   [PI085]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DW_I01_PRODUIT
GO

CREATE PROC sysadm.DW_I01_PRODUIT
 @dcIdProd         Decimal ( 7, 0 ),
 @dcIdDept         Decimal ( 7, 0 ),
 @dcIdGrp          Decimal ( 7, 0 ),
 @sLibCourt        Varchar ( 20 ),
 @sLibLong         Varchar ( 65 ), -- [DCMP080728]
 @dcCodRevSurv     Decimal ( 7, 0 ),
 @dcCodRevSous     Decimal ( 7, 0 ),
 @dcCodRevRnv      Decimal ( 7, 0 ),
 @dcCodNivOpe	   Decimal ( 1, 0 ),
 @dcDurPerrnvAdh   Decimal ( 5, 0 ),
 @sUntPerrnvAdh    Varchar ( 1 ),
 @sCodModeReg      Varchar ( 2 ),
 @sLibBqDebit      Varchar ( 35 ),
 @sRibBq           Varchar ( 5 ),
 @sRibGui          Varchar ( 5 ),
 @sRibCpt          Varchar ( 11 ),
 @sRibCle          Varchar ( 2 ),
 @sCodDestReg      Varchar ( 1 ),
 @sCodAdh          Varchar ( 1 ),
 @dcIdCorb         Decimal ( 3, 0 ),
 @dcIdPolice       Decimal ( 7, 0 ),  
 @sNumTel          Varchar ( 20 ),
 @sNumFax          Varchar ( 20 ),
 @dcIdDepts        Decimal ( 7, 0 ),
 @dcCodBaseDms     Decimal ( 1, 0 ),
 @dcCodAdrDms      Decimal ( 1, 0 ),
 @dcCodProdDms     Decimal ( 5, 0 ), -- [PI085]
 @sAltCreBqDms     Varchar ( 1 ),
 @dcNbAdherent     Decimal ( 2, 0 ),
 @dtCreeLe         DateTime,
 @dtMajLe          DateTime,
 @sMajPar          Varchar ( 4 ),
 @dcCodEuro        Decimal ( 1, 0 ),
 @sAltInfoProv	   VarChar ( 1 ),
 @sAltRl1          Varchar ( 1 ),
 @dcDurRl1Min      Decimal ( 7, 0 ),
 @dcDurRl1Max      Decimal ( 7, 0 ),
 @sUntRl1          VarChar ( 1 ),
 @sAltRl2          VarChar ( 1 ),
 @dcDurRl2         Decimal ( 7, 0 ),
 @sUntRl2          VarChar ( 1 ),
 @sAltSold         VarChar ( 1 ),
 @dcDurSoldRl      Decimal ( 7, 0 ),
 @sUntSoldRl       VarChar ( 1 ),
 @dcDurSoldPc      Decimal ( 7, 0 ),
 @sUntSoldPc       VarChar ( 1 ),
 @sAltContact      VarChar ( 1 ),
 @iCodTel          Integer,
 @sAltOuvFenVal	   VarChar ( 1 ),
 @sAltCmdMobile	   VarChar ( 1 ),
 @sIdProdClient	   VarChar ( 15 ),
 @sAltCodBoutique   VarChar ( 1 )
AS

 INSERT INTO sysadm.produit
           ( produit.id_prod,
             produit.id_dept,
             produit.id_grp,
             produit.lib_court,
             produit.lib_long,
             produit.cod_rev_surv,
             produit.cod_rev_sous,
             produit.cod_rev_rnv,
             produit.cod_niv_ope,
             produit.dur_perrnv_adh,
             produit.unt_perrnv_adh,
             produit.cod_mode_reg,
             produit.lib_bq_debit,
             produit.rib_bq,
             produit.rib_gui,
             produit.rib_cpt,
             produit.rib_cle,
             produit.cod_dest_reg,
             produit.cod_adh,
             produit.id_corb,
             produit.id_police,
             produit.num_tel,
             produit.num_fax,
             produit.id_depts,
	     produit.cod_base_dms,
	     produit.cod_adr_dms,
	     produit.cod_prod_dms,
	     produit.alt_crebq_dms,
	     produit.nb_adherent,
             produit.cree_le,
             produit.maj_le,
             produit.maj_par,
             produit.cod_euro,
             produit.alt_info_prov,
	     produit.alt_rl1,
 	     produit.dur_rl1_min,
	     produit.dur_rl1_max,
 	     produit.unt_rl1,
    	     produit.alt_rl2,
	     produit.dur_rl2,
	     produit.unt_rl2,
 	     produit.alt_sold,
	     produit.dur_sold_rl,
	     produit.unt_sold_rl,
	     produit.dur_sold_pc,
 	     produit.unt_sold_pc,
 	     produit.alt_contact,
             produit.cod_tel,
             produit.alt_ouvfenval,
             produit.alt_cmd_mobile,
             produit.id_prod_client,
             produit.alt_cod_boutique,
             produit.cpt_cmd)
      VALUES
           ( @dcIdProd, @dcIdDept, @dcIdGrp, @sLibCourt, @sLibLong, @dcCodRevSurv,
             @dcCodRevSous, @dcCodRevRnv, @dcCodNivOpe, @dcDurPerrnvAdh, @sUntPerrnvAdh,
             @sCodModeReg, @sLibBqDebit,  @sRibBq,      @sRibGui,      @sRibCpt,      @sRibCle,
             @sCodDestReg, @sCodAdh,      @dcIdCorb,    @dcIdPolice,   @sNumTel,      @sNumFax,
             @dcIdDepts,   @dcCodBaseDms, @dcCodAdrDms, @dcCodProdDms, @sAltCreBqDms, @dcNbAdherent,
	     @dtCreeLe,    @dtMajLe,      @sMajPar, @dcCodEuro, @sAltInfoProv,  @sAltRl1, @dcDurRl1Min ,
	     @dcDurRl1Max, @sUntRl1, @sAltRl2, @dcDurRl2, @sUntRl2, @sAltSold, @dcDurSoldRl, @sUntSoldRl,
	     @dcDurSoldPc, @sUntSoldPc, @sAltContact, @iCodTel, @sAltOuvFenVal, @sAltCmdMobile,
	     @sIdProdClient, @sAltCodBoutique, 0
	   )
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_D01_PRODUIT
-- Auteur               :       NÝ6
-- Date                 :       22/07/97 16:29:27
-- Libell‚              :       Suppression d'un produit
-- Commentaires         :
-- R‚f‚rences           :       SQLPREVIEW de Dw_1, fenetre W_TM_SP_PRODUIT
--
-- Arguments            :       @dcIdProd      Decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Rien
-- #1 JFF  12/12/2006   Ajout des delete manquant depuis 9 ans ! [DCMP060824]
-- #2 JCA	25/04/2007 DCMP 070051 - Merge des tables [composition] et [courrier] en [cour_prod]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DW_D01_PRODUIT
GO

CREATE PROC sysadm.DW_D01_PRODUIT
       @dcIdProd  Decimal ( 7, 0 )
AS


-- Debut #1

	DELETE
	FROM   sysadm.boutique
	WHERE  id_prod = @dcIdProd

	DELETE
	FROM   sysadm.div_pdet
	WHERE  id_prod = @dcIdProd

	DELETE
	FROM   sysadm.autorisation
	WHERE  id_prod = @dcIdProd

	DELETE
	FROM   sysadm.commande_type
	WHERE  id_prod = @dcIdProd

	DELETE
	FROM	sysadm.franchise
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.plafond
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.delai
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.piece
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.motif
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.code_garantie
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.affilier
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.condition
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.garantie
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.para_prod
	WHERE  	id_prod =@dcIdProd

-- #2
	DELETE
--	FROM	sysadm.courrier
	FROM	sysadm.cour_prod
	WHERE  	id_prod =@dcIdProd
-- #2 - FIN
	DELETE
	FROM	sysadm.option_adh
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.etablissement
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.revision
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM	sysadm.code_condition
	WHERE  	id_prod =@dcIdProd

	DELETE
	FROM   sysadm.det_pro
	WHERE  id_prod = @dcIdProd

	DELETE
	FROM	sysadm.div_pro
	WHERE	id_prod =@dcIdProd


-- Fin #1

 DELETE FROM sysadm.produit
       WHERE produit.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       IM_S03_PRODUIT
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 15:24:34
-- Libell‚              :       permet de savoir si l'identifiant du produit en cours de
--                              cr‚ation existe d‚j…
-- Commentaires         :
-- R‚f‚rences           :       U_SP_GS_PRODUIT, Uf_Gs_Id_Produit ()
--
-- Arguments            :       @dcIdProd      Decimal ( 7, 0 ),
--                              @sLibCourt     Varchar ( 20 ) OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S03_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.IM_S03_PRODUIT
GO

CREATE PROC sysadm.IM_S03_PRODUIT
       @dcIdProd      Decimal ( 7, 0 ),
       @sLibCourt     Varchar ( 20 ) OUTPUT
AS

  SELECT @sLibCourt = lib_court
    FROM sysadm.produit
   WHERE produit.id_prod = @dcIdProd

GO



--------------------------------------------------------------------
--
-- Proc‚dure            :   IM_U01_PRODUIT
-- Auteur               :   V.Capelle
-- Date                 :   11/12/1997 15:59:07
-- Libell‚              :   Mise … jour de la police pour un produit 
--                          suivant les cas.
--
-- Commentaires         :   
-- R‚f‚rences           :   
-- Arguments            :   @dcIdProduit   Decimal ( 7, 0 ),
--                          @dcIdPolice    Decimal ( 7, 0 )   
-- Retourne             :   Rien
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U01_PRODUIT' AND type = 'P')
	DROP procedure sysadm.IM_U01_PRODUIT
GO


CREATE PROC sysadm.IM_U01_PRODUIT
            @dcIdProduit   Decimal ( 7, 0 ),
            @dcIdPolice    Decimal ( 7, 0 )
AS

DECLARE	@iNbPolice Integer


SELECT   @iNbPolice = Count ( sysadm.garantie.id_police )
FROM     sysadm.garantie
WHERE    sysadm.garantie.id_prod  =  @dcIdProduit
  AND    sysadm.garantie.id_police  <>  @dcIdPolice

IF @iNbPolice > 0
   BEGIN

     UPDATE sysadm.produit
        SET id_police = Convert ( decimal, Null )
      WHERE    id_prod  =  @dcIdProduit
    
      
   END
ELSE
   BEGIN
     UPDATE sysadm.produit
        SET id_police = @dcIdPolice
      WHERE    id_prod  =  @dcIdProduit
    
   END
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_PRODCORB
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libell‚              :        
-- Commentaires         :       Liste des produits et de leur corbeille
-- R‚f‚rences           :       
--
-- Arguments            :       @sIdOper        Varchar (  4   )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PRODCORB' AND type = 'P' )
 DROP procedure sysadm.DW_S02_PRODCORB
GO

CREATE PROC sysadm.DW_S02_PRODCORB
        @sIdOper        Varchar (  4   )         
AS

 SELECT produit.id_prod,
        produit.lib_court,
        produit.lib_long,
        produit.id_corb,
        produit.cod_adh,
        produit.cod_base_dms,
        produit.cod_prod_dms,
        produit.cod_adr_dms,
        code.lib_code,
        produit.alt_crebq_dms,
        produit.cod_dest_reg,
        produit.cod_mode_reg,
        produit.nb_adherent,
        produit.alt_contact,
        produit.cod_tel,
        produit.alt_cmd_mobile
   FROM sysadm.produit,
        sysadm.code
  WHERE code.id_code     = produit.id_corb      AND
        code.id_typ_code = '-CO'                AND
        produit.id_corb IN
        (
        SELECT  corb_oper.id_corb
        FROM    sysadm.corb_oper
        WHERE   corb_oper.id_oper = @sIdOper
        )

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DD_S02_PRODUIT
-- Auteur               :       JFF
-- Date                 :       03/03/99 16:16:00
-- Libell‚              :       S‚lection des produits pour une DDDW
-- Commentaires         :	Diff‚rence avec la DD_S01_PRODUIT, je ramŠne le cod_adh
-- R‚f‚rences           :       dddw_prod_trt_dde
--
-- Arguments            :       Aucun
--
-- Retourne             :       Result Set
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DD_S02_PRODUIT
GO

CREATE PROC sysadm.DD_S02_PRODUIT
AS

SELECT  produit.id_prod,
        produit.lib_long,
	produit.cod_adh

FROM    sysadm.produit

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DD_S03_PRODUIT
-- Auteur               :       Fabry JF
-- Date                 :       15/10/01
-- Libell‚              :       S‚lection des produits pour une DDDW
--				Seulement les produits ayant la gestion des commandes.
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S03_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.DD_S03_PRODUIT
GO

CREATE PROC sysadm.DD_S03_PRODUIT
AS

SELECT  produit.id_prod,
        produit.lib_long
FROM    sysadm.produit
Where	alt_cmd_mobile = 'O'

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_GESTION_APPAREIL_V00
-- Auteur               :       JCA
-- Date                 :       06/02/2007
-- Libell‚              :       Controle que les options 25 ou 28 sont paramétrées pour le produit
-- Commentaires         :
--
-- Arguments            :       @dcIdProd decimal ( 7, 0 )
--
-- Retourne             :       @iRet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GESTION_APPAREIL_V00' And type = "P" )
	DROP PROCEDURE sysadm.PS_S01_GESTION_APPAREIL_V00
GO

CREATE PROCEDURE sysadm.PS_S01_GESTION_APPAREIL_V00
 @dcIdProd decimal ( 7, 0 )
AS

DECLARE @iRet integer
SET @iRet = 0

SELECT	@iRet = count (*)
FROM	produit p, det_pro dp
WHERE	p.id_prod = @dcIdProd
AND		dp.id_prod = p.id_prod
AND		( ( dp.id_code_dp = 25	AND	dp.id_code_car <> '-1' )
OR		( dp.id_code_dp = 28	AND	dp.id_code_car <> '-1' ) )

RETURN @iRet

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_RECOPIE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       11/12/2008
-- Libell‚              :       Recopie de produit
-- Commentaires         :
-- R‚f‚rences           :       u_sp_gs_recopie_produit
--
-- Arguments            :       
--
-- Retourne             :       1 si OK
--
-------------------------------------------------------------------
-- #1	FPI	28/01/2009	[DCMP080728] - Agrandissement de lib_long
-- #2	FPI	25/09/2009	Ajout des colonnes RIB
-- #3	FPI	01/10/2009	Utilisation explicite des noms de colonnes pour les INSERT
-- #4 	FPI 28/10/2009 [EXPANSION5_LIBPOLICE]
--	FPI	19/05/2011	Correction
--      FPI     23/06/2011      PM02
--	FPI - 09/09/2014 [20140909.FPI] Désactivation des relances pour la recopie
--	FPI	- 09/09/2016 [DP306] Suppression de la recopie de la DP 306
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_RECOPIE_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.PS_I01_RECOPIE_PRODUIT
GO

CREATE PROC sysadm.PS_I01_RECOPIE_PRODUIT 
	@dcIdProdSource		Decimal (7),
	@dcIdRevSource		Decimal (7),
 	@dcIdProdDest		Decimal (7),
 	@dcIdRevDest		Decimal (7),
	@sLibLong		varchar (65), -- #1
	@sLibCourt		varchar (20),
	@sCodEffRevDest 	varchar (20),
 	@sLibRev		varchar (35),
	@dtDeb_Eff		Datetime,
	@sTrigramme 		varchar (4),
	@sAltCopieBoutique	char (1)
AS

Declare 	@dcIdCorb		Decimal (7)
Declare 	@dtGetDate		Datetime
Declare 	@dtFin_Eff		Datetime

Select 	@dtGetDate 	= GetDate ()
Select  @dcIdCorb	= 999 -- Toujours en dur
Select  @dtFin_Eff      = '01/01/3000' -- en dur

DELETE
FROM   sysadm.boutique
WHERE  id_prod = @dcIdProdDest

DELETE
FROM   sysadm.div_pdet
WHERE  id_prod = @dcIdProdDest

DELETE
FROM   sysadm.autorisation
WHERE  id_prod = @dcIdProdDest

DELETE
FROM   sysadm.commande_type
WHERE  id_prod = @dcIdProdDest

DELETE
FROM	sysadm.franchise
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.plafond
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.delai
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.piece
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.motif
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.code_garantie
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.affilier
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.condition
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.garantie
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.para_prod
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.cour_prod
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.option_adh
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.etablissement
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.revision
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.code_condition
WHERE  	id_prod = @dcIdProdDest

DELETE
FROM   sysadm.det_pro
WHERE  id_prod = @dcIdProdDest

DELETE
FROM	sysadm.div_pro
WHERE	id_prod = @dcIdProdDest

DELETE
FROM	sysadm.det_article
WHERE	id_prod = @dcIdProdDest

DELETE
FROM   sysadm.produit
WHERE  id_prod = @dcIdProdDest

INSERT INTO sysadm.produit (id_prod, id_dept, id_grp, lib_court, lib_long, 
	cod_rev_surv, cod_rev_sous, cod_rev_rnv, dur_perrnv_adh, unt_perrnv_adh, 
	cod_mode_reg, lib_bq_debit, rib_bq, rib_gui, rib_cpt, rib_cle, 
	cod_dest_reg, cod_adh, id_corb, id_police, num_tel, num_fax, 
	id_depts, cod_niv_ope, cod_base_dms, cod_adr_dms, cod_prod_dms, alt_crebq_dms, 
	nb_adherent, cod_euro, alt_info_prov, alt_rl1, dur_rl1_min, dur_rl1_max, unt_rl1, 
	alt_rl2, dur_rl2, unt_rl2, alt_sold, dur_sold_rl, unt_sold_rl, dur_sold_pc, unt_sold_pc, 
	alt_contact, cod_tel, alt_ouvfenval, alt_cmd_mobile, id_prod_client, alt_cod_boutique, cpt_cmd, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_dept,
 id_grp,
 @sLibCourt,
 @sLibLong,
 CASE @sCodEffRevDest
	When 'DTE_SURV' Then @dcIdRevDest
        Else -1
 End,
 CASE @sCodEffRevDest
	When 'DTE_SOUS' Then @dcIdRevDest
        Else -1
 End,
 CASE @sCodEffRevDest
	When 'DTE_RNV' Then @dcIdRevDest
        Else -1
 End,
 dur_perrnv_adh,
 unt_perrnv_adh,
 cod_mode_reg,
 lib_bq_debit,
 rib_bq,
 rib_gui,
 rib_cpt,
 rib_cle,
 cod_dest_reg,
 cod_adh,
 999,
 id_police,
 num_tel,
 num_fax,
 id_depts,
 cod_niv_ope,
 cod_base_dms,
 cod_adr_dms,
 cod_prod_dms,
 alt_crebq_dms,
 nb_adherent,
 cod_euro,
 alt_info_prov,
 'N' as alt_rl1, -- [20140909.FPI]
 0 as dur_rl1_min, -- [20140909.FPI]
 0 as dur_rl1_max, -- [20140909.FPI]
 unt_rl1,
 'N' as alt_rl2, -- [20140909.FPI]
 '0' as dur_rl2, -- [20140909.FPI]
 unt_rl2,
 alt_sold,
 dur_sold_rl,
 unt_sold_rl,
 dur_sold_pc,
 unt_sold_pc,
 alt_contact,
 cod_tel,
 alt_ouvfenval,
 alt_cmd_mobile,
 id_prod_client,
 alt_cod_boutique,
 cpt_cmd,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM   sysadm.produit
WHERE  id_prod = @dcIdProdSource

INSERT INTO sysadm.para_prod(id_prod, id_para, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_para,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.para_prod
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.code_condition(id_prod, 
	id_typ_code, 
	id_code, 
	id_gti, 
	lib_evt, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_typ_code,
 id_code,
 id_gti,
 lib_evt,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.code_condition
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.cour_prod(id_prod, 
	id_nat_cour, 
	id_cour, 
	id_para, 
	id_ordre, 
	id_conf_deb, 
	id_conf_fin, 
	id_conf_n, 
	alt_conf, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_nat_cour,
 id_cour,
 id_para, -- #1
 id_ordre, -- #1
 id_conf_deb,
 id_conf_fin,
 id_conf_n,
 alt_conf,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.cour_prod
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.code_garantie(id_prod, 
	id_gti, lib_gti, 
	mt_cmt, 
	cod_rgpt_stat, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_gti,
 lib_gti,
 mt_cmt,
 cod_rgpt_stat,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.code_garantie
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.piece(id_prod, 
	id_rev, 
	id_gti, 
	id_pce, 
	id_para, 
	cod_typ_pce, 
	cpt_tri, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_pce,
 id_para,
 cod_typ_pce,
 cpt_tri,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.piece
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )

INSERT INTO sysadm.motif(id_prod, 
	id_rev, 
	id_gti, 
	id_motif, 
	id_para, 
	cod_typ_motif, 
	cod_nat_motif, 
	cpt_tri, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_motif,
 id_para,
 cod_typ_motif,
 cod_nat_motif,
 cpt_tri,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.motif
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.etablissement(id_prod, 
	id_grp, 
	id_rev, 
	id_ets, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_grp,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_ets,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.etablissement
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.revision(id_prod, 
	id_rev, 
	lib_rev, 
	cod_eff_rev, 
	dte_eff, 
	dte_fin, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 @dcIdRevDest,
 @sLibRev,
 @sCodEffRevDest,
 @dtDeb_Eff,
 @dtFin_Eff,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.revision
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )

INSERT INTO sysadm.garantie(id_prod, 
	id_rev, 
	id_gti, 
	id_police, 
	cod_typ_fra, 
	alt_plaf, 
	alt_del, 
	alt_fran, 
	cod_radical, 
	cree_le, maj_le, maj_par, 
	id_prefixe)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_police,
 cod_typ_fra,
 alt_plaf,
 alt_del,
 alt_fran,
 cod_radical,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme,
 id_prefixe
FROM	sysadm.garantie
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.affilier(id_prod, 
	id_rev, 
	id_gti, 
	id_carte, 
	dte_affiliation, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_carte,
 dte_affiliation,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.affilier
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.condition(id_prod, 
	id_rev, 
	id_gti, 
	id_code, 
	id_typ_code, 
	alt_reg, 
	alt_plaf, 
	alt_del, 
	alt_fran, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_code,
 id_typ_code,
 alt_reg,
 alt_plaf,
 alt_del,
 alt_fran,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.condition
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.franchise(id_prod, 
	id_rev, 
	id_gti, 
	id_niv_fra, 
	id_ref_fra, 
	id_typ_fra, 
	id_cpt_fra, 
	mt_fra, 
	id_para, 
	dur_min, 
	dur_max, 
	unt_del, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_niv_fra,
 id_ref_fra,
 id_typ_fra,
 id_cpt_fra,
 mt_fra,
 id_para,
 dur_min,
 dur_max,
 unt_del,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.franchise
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.plafond(id_prod, 
	id_rev, 
	id_gti, 
	id_niv_plaf, 
	id_ref_plaf, 
	id_typ_plaf, 
	id_cpt_plaf, 
	mt_plaf, 
	id_para, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_niv_plaf,
 id_ref_plaf,
 id_typ_plaf,
 id_cpt_plaf,
 mt_plaf,
 id_para,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.plafond
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )


INSERT INTO sysadm.delai(id_prod, 
	id_rev, 
	id_gti, 
	id_niv_del, 
	id_ref_del, 
	id_typ_del, 
	id_cpt_del, 
	dur_min, 
	dur_max, 
	unt_del, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 CASE id_rev
	When -1 Then -1
        Else @dcIdRevDest
 End,
 id_gti,
 id_niv_del,
 id_ref_del,
 id_typ_del,
 id_cpt_del,
 dur_min,
 dur_max,
 unt_del,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.delai
WHERE  	id_prod = @dcIdProdSource
AND 		id_rev  in (  @dcIdRevSource, -1 )

INSERT INTO sysadm.commande_type(id_prod, 
	id_gti, 
	id_code_frn, 
	id_code_art, 
	alt_code_def, 
	cree_le, maj_le, maj_par, 
	id_typ_code, 
	id_code)
SELECT
 @dcIdProdDest,
 id_gti,
 id_code_frn,
 id_code_art,
 alt_code_def,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme,
 id_typ_code,
 id_code
FROM	sysadm.commande_type
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.det_article(id_four, 
	id_ref_four, 
	id_prod, 
	id_typ_art, 
	id_article, 
	cree_le, maj_le, maj_par)
SELECT
 id_four,
 id_ref_four,
 @dcIdProdDest,
 id_typ_art,
 id_article,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM	sysadm.det_article
WHERE  	id_prod = @dcIdProdSource

INSERT INTO sysadm.det_pro(id_prod, 
	id_typ_code_dp, 
	id_code_dp, 
	id_typ_calc, 
	id_code_num, 
	id_code_car, 
	val_num, 
	val_car, 
	val_car2, 
	unt, 
	tri, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_typ_code_dp,
 id_code_dp,
 id_typ_calc,
 id_code_num,
 id_code_car,
 val_num,
 val_car,
 val_car2,
 unt,
 tri,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
FROM    sysadm.det_pro
WHERE   id_prod = @dcIdProdSource
AND     id_code_dp not in ( 94, 175, 142, 176, 306 ) -- JFF le 14/01/2008 + [PM02][PM72] + [DP306]

INSERT INTO sysadm.div_pro(id_prod, 
	nom_zone, 
	lib_label, 
	id_typ_liste, 
	alt_liste_codecar, 
	id_typ_zone, 
	alt_oblig, 
	cpt_tri, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 nom_zone,
 lib_label,
 id_typ_liste,
 alt_liste_codecar,
 id_typ_zone,
 alt_oblig,
 cpt_tri,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
 FROM	sysadm.div_pro
 WHERE	id_prod = @dcIdProdSource

INSERT INTO sysadm.autorisation(id_nat_oper, 
	id_oper, 
	id_prod, 
	cree_le, maj_le, maj_par)
SELECT
 id_nat_oper,
 id_oper,
 @dcIdProdDest,
 GetDate(),
 GetDate(),
 @sTrigramme
FROM	sysadm.autorisation
WHERE	id_prod = @dcIdProdSource

INSERT INTO sysadm.div_pdet(id_prod, 
	id_gti, 
	nom_zone, 
	lib_label, 
	id_typ_liste, 
	alt_liste_codecar, 
	id_typ_zone, 
	alt_oblig, 
	cpt_tri, 
	cree_le, maj_le, maj_par)
SELECT
 @dcIdProdDest,
 id_gti,
 nom_zone,
 lib_label,
 id_typ_liste,
 alt_liste_codecar,
 id_typ_zone,
 alt_oblig,
 cpt_tri,
 @dtGetDate,
 @dtGetDate,
 @sTrigramme
 FROM	sysadm.div_pdet
 WHERE	id_prod = @dcIdProdSource

IF @sAltCopieBoutique = 'O' 
BEGIN
	INSERT INTO sysadm.boutique(id_prod, 
		id_boutique, 
		region, adr_ville, 	adr_cp, 
		adr_tel, adr_fax, adr_mail, adr_mail_cc, 
		adr_nom, cod_mag, adr_1, adr_2, 
		responsable, adr_mail2, adr_mail_cc2, 
		rib_bq, rib_gui, rib_cpt, rib_cle, 
		cree_le, maj_le, maj_par, lib_police) -- #4 FPI 28/10/2009 [EXPANSION5_LIBPOLICE]
	SELECT 
	 @dcIdProdDest,
	 id_boutique,
	 region,
	 adr_ville,
	 adr_cp,
	 adr_tel,
	 adr_fax,
	 adr_mail,
	 adr_mail_cc,
	 adr_nom,
	 cod_mag, 
	 adr_1, 
	 adr_2,
	 responsable,
	 adr_mail2,
	 adr_mail_cc2,
	 rib_bq, 
	 rib_gui, 
	 rib_cpt, 
	 rib_cle, -- #2
	 @dtGetDate,
	 @dtGetDate,
	 @sTrigramme,
	 lib_police		-- #4 FPI 28/10/2009 [EXPANSION5_LIBPOLICE]
	FROM sysadm.boutique 
	WHERE id_prod = @dcIdProdSource
END

-- Ajout état 57 - FPI - 05/09/2016
INSERT INTO sysadm.traitement
(id_trt, id_etat, id_prod, 
	cod_arg1, alt_m, alt_t, alt_s, alt_a, 
	cod_edt, nb_exp, 
	nom_fic, cree_le, maj_le, maj_par)
select max(id_trt) + 1, 57, @dcIdProdDest,  
	@dcIdProdDest, 'O','N','N','N',
	2, 1, 
	'\\spb.lan\applis\spb\Simpa2\XLS\' + convert(varchar(10), @dcIdProdDest) + '\MENS\' + convert(varchar(10), @dcIdProdDest) + 'LR1.XLS',
	getdate(), getdate(), @sTrigramme
from sysadm.traitement
where not exists (select 1 from sysadm.traitement t
	where t.id_prod=@dcIdProdDest and (t.id_etat=57
		or upper(nom_fic) like '%' + convert(varchar(10), t.id_prod) + 'LR1.XLS') )

GO

grant execute on sysadm.PS_I01_RECOPIE_PRODUIT to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D01_DET_PRO
-- Auteur               :       FPI
-- Date                 :       11/12/2008
-- Libell‚              :       Suppression d'option d'un produit
-- Commentaires         :
-- R‚f‚rences           :       u_sp_gs_recopie_produit
--
-- Arguments            :       
--
-- Retourne             :       1 si OK
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_DET_PRO' AND type = 'P' )
            DROP procedure sysadm.PS_D01_DET_PRO
GO

CREATE PROC PS_D01_DET_PRO 
	@dcIdProd		Decimal (7),
	@iIdCodeDp		int
AS
Delete From sysadm.det_pro
Where id_prod = @dcIdProd
And id_code_dp = @iIdCodeDp

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D01_GARANTIE
-- Auteur               :       FPI
-- Date                 :       11/12/2008
-- Libell‚              :       Suppression d'une garantie d'un produit
-- Commentaires         :
-- R‚f‚rences           :       u_sp_gs_recopie_produit
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.PS_D01_GARANTIE
GO

CREATE PROC PS_D01_GARANTIE 
	@dcIdProd		Decimal (7),
	@dcIdGti		int
AS

Delete From sysadm.div_pdet
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.piece
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.motif
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.condition
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.franchise
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.plafond
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.delai
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.commande_type
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.affilier
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.garantie
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.code_garantie
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

Delete From sysadm.code_condition
Where id_prod = @dcIdProd
And   id_gti  = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_VERIF_COMPTE
-- Auteur               :       FPI
-- Date                 :       07/12/2010
-- Libell‚              :       Contrôle d'existence de compte dans GENVIR
-- Commentaires         :
-- R‚f‚rences           :      
--
-- Arguments            :       @dcIdProd      Decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       0 si le compte n'existe pas dans GENVIR, 1 sinon
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VERIF_COMPTE' AND type = 'P' )
            DROP procedure sysadm.PS_S01_VERIF_COMPTE
GO

CREATE PROCEDURE sysadm.PS_S01_VERIF_COMPTE
       @sIdappli char(4) ,
	@sRibBq char(5) ,
	@sRibGui char(5) ,
	@sRibCpt char(11) ,
	@sRibCle char(2) 
AS
  Declare @iRet integer

  Set @iRet = 1
  
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  Begin
    Select @iRet = count(*)
    from GENVIR_PRO.sysadm.fichier_compte 
    where id_appli =  @sIdappli
      and rib_bq_spb = @sRibBq
      and rib_gui_spb = @sRibGui
      and rib_cpt_spb = @sRibCpt
      and rib_cle_spb = @sRibCle
  End
  
  Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_CLOTURE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       07/12/2010
-- Libell‚              :       Cloture automatique de produit sur DP 153
-- Commentaires         :
-- R‚f‚rences           :      [PC582] - VDoc 2198
--
-- Arguments            :       
--
-- Retourne             :       
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_CLOTURE_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.PS_U01_CLOTURE_PRODUIT
GO

CREATE PROCEDURE sysadm.PS_U01_CLOTURE_PRODUIT
       
AS
  update sysadm.produit
  set id_corb=998, maj_le=getdate(),maj_par='AUTO'
  from sysadm.det_pro
  where det_pro.id_code_dp=153 
    and det_pro.id_prod = produit.id_prod
    and isnull(sysadm.FN_CLE_VAL('DTE_AFFECTATION_EN_CORBEILLE_998',det_pro.val_car,';'), '31/12/2100') < getdate() 
  
  delete from sysadm.det_pro where id_code_dp=153 
  
Go
--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I02_RECOPIE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       18/04/2013
-- Libell‚              :       Recopie de produit inter-base
-- Commentaires         :
-- R‚f‚rences           :       u_sp_gs_recopie_produit
--
-- Arguments            :       
--
-- Retourne             :       1 si OK
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_RECOPIE_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.PS_I02_RECOPIE_PRODUIT
GO

CREATE PROC sysadm.PS_I02_RECOPIE_PRODUIT 
	@dcIdProdSource		Decimal (7),
	@sBaseSource varchar(10),
	@sBaseDest varchar(10),
	@sMajPar varchar(10)
AS

DECLARE @sMessage    Varchar(8000),
    @sRetourErrMail VarChar(255), 
	@sSaut varchar(1),
	@sObjet varchar(255),
	@sDest varchar(1000)
Declare @sNomTable varchar(50),
	@sSql varchar(255)
	
Set @sSaut = Char (10)
  
-- Tables à recopier
Declare @tbTable TABLE (nom_table varchar(50), 
	tri int, 
	del_ok char(1) DEFAULT 'N', 
	insert_ok char(1) DEFAULT 'N')

Insert into @tbTable (nom_table, tri) values ('boutique',1),
	('div_pdet',2),
	('autorisation',3),
	('commande_type',4),
	('franchise',5),
	('plafond',6),
	('delai',7),
	('piece',8),
	('motif',9),
	('code_garantie',10),
	('affilier',11),
	('condition',12),
	('garantie',13),
	('para_prod',14),
	('cour_prod',15),
	('option_adh',16),
	('etablissement',17),
	('revision',18),
	('code_condition',19),
	('det_pro',20),
	('div_pro',21),
	('det_article',22),
	('produit',23)

-- Préfixe des bases
Declare @sPrefixeBaseSource varchar(200),
	@sPrefixeBaseDest varchar(200),
	@sIdProdSource varchar(7)

Select @sPrefixeBaseSource=Case @sBaseSource 
	When 'PROD' Then '[SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.'
	When 'SIM' Then '[SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.'
	When 'REC' Then '[SINSQL19REC\RECSINISTRES19].SIMPA2_TRT.sysadm.'
	Else '' End,
	@sPrefixeBaseDest=Case @sBaseDest
	When 'PROD' Then Case When @@SERVERNAME='SQL14SINISTRES\SINISTRES' Then 'SIMPA2_PRO.sysadm.' Else '[LS-SINISTRES].SIMPA2_PRO.sysadm.' End
	When 'SIM' Then '[SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.'
	When 'REC' Then '[SINSQL19REC\RECSINISTRES19].SIMPA2_TRT.sysadm.'
	Else '' End,
	@sIdProdSource=CONVERT(varchar(7),@dcIdProdSource)

If @sPrefixeBaseSource='' or @sPrefixeBaseDest='' Return -1

-- Cas particuliers de nouveaux cour_type
Set @sSql='insert into ' + @sPrefixeBaseDest + 'cour_type select * from ' + @sPrefixeBaseSource + 'cour_type c '
Set @sSql= @sSql + 'where not exists (select * from ' + @sPrefixeBaseDest + 'cour_type c2 where c2.id_cour=c.id_cour)'
exec(@sSql)
	
-- Suppr
While Exists ( Select * From @tbTable where del_ok = 'N' )
 Begin
	Select 	Top 1 @sNomTable=nom_table
	From @tbTable
	where del_ok = 'N'
	order by tri

	Set @sSql='delete from ' + @sPrefixeBaseDest + @sNomTable + ' where id_prod=' + @sIdProdSource
	exec(@sSql)
	
	Update @tbTable set del_ok='O' where nom_table=@sNomTable
End

-- Insert
While Exists ( Select * From @tbTable where insert_ok = 'N' )
 Begin
	Select 	Top 1 @sNomTable=nom_table
	From @tbTable
	where insert_ok = 'N'
	order by tri DESC

	Set @sSql='insert into ' + @sPrefixeBaseDest + @sNomTable + 
		' select * from ' + @sPrefixeBaseSource + @sNomTable + ' where id_prod=' + @sIdProdSource
	exec (@sSql)
	
	Update @tbTable set insert_ok='O' where nom_table=@sNomTable
End

-- Mail
Set @sMessage = 'Bonjour,' + @sSaut + @sSaut
Set @sMessage = @sMessage + 'Nous vous informons que '

Select @sMessage = @sMessage + rtrim(prenom) + ' ' + rtrim(nom)
From [SQL14BI\SINISTRESBI].SESAME_PRO.sysadm.operateur
where id_oper=@sMajPar


Set @sMessage = @sMessage + ' vient d''effectuer la recopie du produit ' + @sIdProdSource
Select @sMessage = @sMessage + ' - ' + rtrim(isnull(lib_long,'?'))
From sysadm.produit
where id_prod=@dcIdProdSource

Set @sMessage = @sMessage + ' de la base de '
Select @sMessage = @sMessage +Case @sBaseSource 
	When 'PROD' Then 'production'
	When 'SIM' Then 'simulation'
	When 'REC' Then 'recette (1 et 2)'
	Else '' End

Set @sMessage = @sMessage + ' vers la base de '
Select @sMessage = @sMessage + Case @sBaseDest
	When 'PROD' Then 'production.'
	When 'SIM' Then 'simulation.'
	When 'REC' Then 'recette (1 et 2).'
	Else '' End,
	@sObjet='Recopie du produit ' + @sIdProdSource + ' en base de ' +
		Case @sBaseDest
			When 'PROD' Then 'production'
			When 'SIM' Then 'simulation'
			When 'REC' Then 'recette (1 et 2)'
			Else '' End

Set @sMessage = @sMessage + @sSaut + @sSaut + 
	'Pour les recetteurs, merci d''attendre le Go de l''équipe ES pour reprendre la recette de ce produit.'
Set @sMessage = @sMessage + @sSaut + @sSaut + 'Cordialement'

Set @sDest='GG_DSI-DEI-ES_Coll@spb.fr'
Set @sDest = @sDest + ',cmathe@spb.eu,ntonnetot@spb.eu,flebarbay@spb.eu'
Set @sDest = @sDest + ',mlgasnier@spb.eu'
Set @sDest = @sDest + ',idezon@spb.eu, mcarpentier@spb.eu,vdevarieux@spb.eu'

EXEC master.dbo.SPB_PS_MAIL_OUTLOOK 
		@sRetourErrMail OUTPUT, 
		@sDest,
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		NULL, 
		NULL, 
		NULL, 
		NULL, 
		NULL
		
Return 1

GO

grant execute on sysadm.PS_I02_RECOPIE_PRODUIT to rolebddsinistres
Go
--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_V01_RECOPIE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       18/04/2013
-- Libell‚              :       Recopie de produit inter-base - contrôle
-- Commentaires         :
-- R‚f‚rences           :       u_sp_gs_recopie_produit
--
-- Arguments            :       
--
-- Retourne             :       1 si OK
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_V01_RECOPIE_PRODUIT' AND type = 'P' )
            DROP procedure sysadm.PS_V01_RECOPIE_PRODUIT
GO

CREATE PROC sysadm.PS_V01_RECOPIE_PRODUIT 
	@dcIdProdSource		Decimal (7),
	@sBaseSource varchar(10)
AS

-- Préfixe des bases
Declare @sPrefixeBaseSource varchar(200),
	@sIdProdSource varchar(7), 
	@iRet	integer

-- [PI056] changement noms de serveurs
Select @sPrefixeBaseSource=Case @sBaseSource 
	When 'PROD' Then '[SQL14BI\SINISTRESBI].SIMPA2_PRO.sysadm.'
	When 'SIM' Then '[SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.'
	When 'REC' Then '[SINSQL19REC\RECSINISTRES19].SIMPA2_TRT.sysadm.'
	Else '' End,
	@sIdProdSource=CONVERT(varchar(7),@dcIdProdSource)

If @sPrefixeBaseSource='' Return -1

Declare @tbResult TABLE(nb integer)
insert into @tbResult
exec('select count(*) from ' + @sPrefixeBaseSource + 'produit where id_prod=' + @sIdProdSource)

select @iRet=nb
from @tbResult

Return @iRet

GO

grant execute on sysadm.PS_V01_RECOPIE_PRODUIT to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_LISTE_DE_TOUS_LES_PRODUITS
-- Auteur               :       JFF
-- Date                 :       2020
-- Libell‚              :       Sort tous les produits spb
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       A lancer sur [LS-SINISTRES].SIMPA2_PRO absolument
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_LISTE_DE_TOUS_LES_PRODUITS' AND type = 'P' )
            DROP procedure sysadm.PS_S_LISTE_DE_TOUS_LES_PRODUITS
GO

CREATE procedure sysadm.PS_S_LISTE_DE_TOUS_LES_PRODUITS
AS

/* Auteur : FABRY JF
   Le     : 16/12/2019
   Info   : Lancer sur [LS-SINISTRES].SIMPA2_PRO
   Comment: Ramène tous les produits des applis SPB entre 1 et 99999.
		    A lancer en production sur LS-SINISTRE avec votre trigramme perso, le traitement est en lecture sale (Dirty Read), aucun risque de blocage
			S'il vous manque des droits d'accès à certaines bases, demandez à qqun qui a ces droits de lancer le programme.
   Temps  : Temps de traitement environ 5m30 minutes
   Présentation fichier excel : 
		- Fichier les volets en B2
		- Poser le filtre sur ligne d'entete
		- Mettre ligne d'entete en couleur violet et en taille police 12
		- nommer le fichier aaaammjjhhmm_Listes_de_tous_les_codes_produits_SPB.xlsx  (sauver en Excel 2016)
		- Mettre sur le 2ème onglet la liste de fournissuer -FR code_car et poser un filtre.
		- Mettre le fichier en lecture seule
		- le placer sur \\spb.lan\TRANSVERSE\Projets\Projets DPG-DSI\Referentiel\--- Listes de tous les codes produits SPB ---\Listes_de_tous_les_codes_produits_SPB.xlsx
*/

DECLARE @tbTousProduits TABLE 
	( id_ligne	integer identity,
	  etat_code_produit Varchar ( 20 ), 
	  existant_FFM  Varchar ( 10 ),
	  id_prod_ffm decimal (10 ),
	  lib_prod_court_ffm varchar ( 50 ),
	  lib_prod_long_ffm varchar ( 50 ),
	  nbre_adh_totale_ffm integer,
	  nbre_adh_active_ffm integer,
	  date_dernier_trt_mens Varchar ( 10 ),
	  existant_sherpa  Varchar ( 10 ),
	  id_prod_sherpa_adh decimal (10 ),
	  id_prod_sherpa_sinistre decimal (10 ),
	  lib_prod_court_sherpa varchar ( 50 ),
	  lib_prod_long_sherpa varchar ( 50 ),
	  type_produit_sherpa varchar ( 50 ),
	  appli_gestion_sherpa varchar ( 50 ),
	  existant_simpa2  Varchar ( 10 ),
	  id_prod_simpa2 decimal (10 ),
	  lib_prod_court_simpa2 varchar ( 50 ),
	  lib_prod_long_simpa2 varchar ( 50 ),
	  code_volcanes_simpa2 varchar ( 50 ), 
	  fournisseurs_lies_simpa2 varchar ( 50 ), 
	  existant_savane Varchar ( 10 ),
	  id_prod_savane decimal (10 ),
	  lib_prod_court_savane varchar ( 50 ),
	  lib_prod_long_savane varchar ( 50 ),
	  code_volcanes_savane varchar ( 50 ), 
	  existant_sindi Varchar ( 10 ),
	  id_prod_sindi decimal (10 ),
	  lib_prod_court_sindi varchar ( 50 ),
	  lib_prod_long_sindi varchar ( 50 ),
	  code_volcanes_sindi varchar ( 50 ), 
	  existant_pegase Varchar ( 10 ),
	  id_prod_pegase decimal (10 ),
	  lib_prod_court_pegase varchar ( 50 ),
	  lib_prod_long_pegase varchar ( 50 ),
	  code_volcanes_pegase varchar ( 50 ), 
	  existant_saga2 Varchar ( 10 ),
	  id_prod_saga2 decimal (10 ),
	  lib_prod_court_saga2 varchar ( 50 ),
	  lib_prod_long_saga2 varchar ( 50 ),
	  code_volcanes_saga2 varchar ( 50 ), 
	  nbre_adh_totale_saga2 integer,
	  nbre_adh_active_saga2 integer,
	  existant_volcanes Varchar ( 10 ),
	  id_prod_volcanes decimal (10 ),
	  lib_prod_court_volcanes varchar ( 50 ),
	  lib_prod_long_volcanes varchar ( 50 ),
	  fluxfi_volcanes_existant varchar ( 50 ),
	  date_dern_fluxfi_volcanes varchar ( 50 ),
	  etat_produit_volcanes varchar ( 50 ),
	  date_fermeture_prod_volcanes varchar ( 50 ),
	  reservation_R_spb varchar ( 50 ),
	  id_prod_R_spb decimal (10 ),
	  lib_prod_court_R_spb varchar ( 50 ),
	  lib_prod_long_R_spb varchar ( 50 ),
	  date_reservation_R_spb Varchar ( 10 )
	)

DECLARE @tbProduitsFFM TABLE (
		id_prod_ffm Decimal (10),
		lib_prod_ffm VarChar ( 50 )
		)

DECLARE @tbProduitsSherpa TABLE (
		id_cle_sherpa	integer identity,
		id_prod_Sherpa Decimal (10),
		id_prod_adh Decimal (10),
		lib_prod_Sherpa VarChar ( 50 ),
		type_prod_sherpa VarChar ( 50 ),
		appli_gestion_sherpa VarChar ( 50 ),
		marquage_trt integer
		)

DECLARE @tbAdhesionFFM TABLE (
		id_prod_ffm Decimal (10),
		nbre_adhesion_ffm integer
		)

DECLARE @tbAdhesionFFMactive TABLE (
		id_prod_ffm Decimal (10),
		nbre_adhesion_ffm_active integer
		)

DECLARE @tbAdhesionSaga2 TABLE (
		id_prod_saga2 Decimal (10),
		nbre_adhesion_saga2 integer
		)

DECLARE @tbAdhesionSaga2Active TABLE (
		id_prod_saga2 Decimal (10),
		nbre_adhesion_saga2_active integer
		)

DECLARE @tbExistenceFluxFiVolcanes TABLE (
		id_prod_ffm Decimal (10),
		existence_flux_fi_volcanes integer
)

DECLARE @tbDateDernFluxFiVolcanes TABLE (
		id_prod_ffm Decimal (10),
		date_dern_fluxfi_volcanes varchar (50)
)


DECLARE @tbEtatProduitVolcanes TABLE (
		id_prod_ffm Decimal (10),
		etat_produit_volcanes varchar (50)
)

DECLARE @tbDateFermProduitVolcanes TABLE (
		id_prod_ffm Decimal (10),
		date_ferm_prod_volcanes varchar (50)
)

Declare @TbCacheProduitATraiter TABLE (
		id_prod_a_traiter Decimal (10),
		marquage_trt integer
)

Declare @sEtatCodeProduit varchar ( 20 ),
		@sExistantFFM varchar ( 10 ),
		@dcIdProdFFM Decimal (10),
		@sLibProdCourtFFM  VarChar ( 50 ),
		@sLibProdLongFFM   VarChar ( 50 ),
		@iNbreAdhTotaleFFM integer,
	    @iNbreAdhActiveFFM integer,
	    @sDateDernierTrtMens Varchar ( 10 ),
		@sExistantSherpa varchar ( 10 ),
		@dcIdProdSherpaAdh decimal (10 ),
		@dcIdProdSherpaSinistre decimal (10 ),
	    @slibProdCourtSherpa varchar ( 50 ),
	    @slibProdLongSherpa varchar ( 50 ),
		@sTypeProduitSherpa  varchar ( 50 ),
		@sAppliGestionSherpa  varchar ( 50 ),
		@sExistantSimpa2 varchar ( 10 ),
		@dcIdProdSimpa2 Decimal (10),
		@sLibProdCourtSimpa2  VarChar ( 50 ),
		@sLibProdLongSimpa2   VarChar ( 50 ),
		@sCodeVolcanesSimpa2 varchar ( 50 ), 
		@sFournisseursLiesSimpa2 varchar ( 50 ), 
		@sExistantSavane varchar ( 10 ),
		@dcIdProdSavane  Decimal (10),
		@sLibProdCourtSavane   VarChar ( 50 ),
		@sLibProdLongSavane    VarChar ( 50 ),
		@sCodeVolcanesSavane varchar ( 50 ), 
		@sExistantSindi varchar ( 10 ),
		@dcIdProdSindi  Decimal (10),
		@sLibProdCourtSindi   VarChar ( 50 ),
		@sLibProdLongSindi    VarChar ( 50 ),
		@sCodeVolcanesSindi varchar ( 50 ), 
		@sExistantPegase varchar ( 10 ),
		@dcIdProdPegase  Decimal (10),
		@sLibProdCourtPegase   VarChar ( 50 ),
		@sLibProdLongPegase    VarChar ( 50 ),
		@sCodeVolcanesPegase varchar ( 50 ), 
		@sExistantSaga2 varchar ( 10 ),
		@dcIdProdSaga2  Decimal (10),
		@sLibProdCourtSaga2   VarChar ( 50 ),
		@sLibProdLongSaga2    VarChar ( 50 ),
		@sCodeVolcanesSaga2 varchar ( 50 ), 
		@iNbreAdhTotaleSaga2 integer,
	    @iNbreAdhActiveSaga2 integer,
		@sExistantVolcanes varchar ( 10 ),
		@dcIdProdVolcanes  Decimal (10),
		@sLibProdCourtVolcanes   VarChar ( 50 ),
		@sLibProdLongVolcanes    VarChar ( 50 ),
		@sFluxFiVolcanesExistant varchar ( 50 ),
	    @dtDateDernFluxFiVolcanes varchar ( 50 ),
	    @sEtatProduitVolcanes varchar ( 50 ),
	    @dtDateFermetureProdVolcanes varchar ( 50 ),
        @sReservation_R_Spb VarChar ( 50 ),
	    @dcIdProd_R_Spb Decimal (10),
		@slibProdCourt_R_Spb varchar ( 50 ),
	    @slibProdLong_R_Spb varchar ( 50 ),
		@sDateReservation_R_spb Varchar ( 10 )

Declare @IdentityTbTsProd_Deb numeric (38,0),
		@IdentityTbTsProd_Fin numeric (38,0),
		@iIdCleSherpa Integer,
		@iRowsEcritureTbTsProd Integer

Declare @dtGetDate DateTime

Set	@sEtatCodeProduit = null

-- Cache pour les produits adhésion distinct sans statut
Insert Into @tbProduitsFFM
Select Distinct
	produ_code_prod,
	produ_nom_prod 
from [ADHESIONDB_PRO].[dbo].[produ] with (nolock)
Where produ_maint <> 'D'
Union all
Select Distinct
	produ_code_prod,
	produ_nom_prod 
from [ADHESIONDB_PRO].[dbo].[chom_produ] with (nolock)
Where produ_maint <> 'D'
Order by 1

-- Cache nombre adhésions FFM
Insert Into @tbAdhesionFFM
Select dosad_code_prod id_prod_adh,
	   count(*) nbre_adh
From FUS_DOSAD_PRO.dbo.dosad with (nolock)
group by dosad_code_prod
union
Select dosad_code_prod,
	   count(*)
From FUS_DOSAD_PRO.dbo.chom_dosad with (nolock)
group by dosad_code_prod
Order by 1

-- Cache nombre adhésions FFM active
Insert Into @tbAdhesionFFMactive
Select dosad_code_prod,
	   count(*) 
From FUS_DOSAD_PRO.dbo.dosad with (nolock)
Where dosad_statut in ( 0,2,3,8 )
group by dosad_code_prod
union
Select dosad_code_prod,
	   count(*)
From FUS_DOSAD_PRO.dbo.chom_dosad with (nolock)
Where dosad_statut in ( 0,2,3,8 )
group by dosad_code_prod
Order by 1

-- Cache nombre adhésions Saga2
Insert into @tbAdhesionSaga2
select p.code,
	   count (*)
from [SQL14BI\SAGA2BI].[SAGA2_PVC].ref.product p with (nolock),
	 [SQL14BI\SAGA2BI].[SAGA2_PVC].oth_sub.subscription s with (nolock)
where s.id_product = p.id_product
Group By p.code
Order by 1

-- Cache nombre adhésions Saga2 active
Insert into @tbAdhesionSaga2Active
select p.code,
	   count (*)
from [SQL14BI\SAGA2BI].[SAGA2_PVC].ref.product p with (nolock),
	 [SQL14BI\SAGA2BI].[SAGA2_PVC].oth_sub.subscription s with (nolock),
	 [SQL14BI\SAGA2BI].[SAGA2_PVC].ref.ref_subscription_status ss with (nolock)
where s.id_product = p.id_product
And   ss.id_ref_subscription_status = s.id_ref_subscription_status
And   ss.code in ( 1, 8 ) 
Group By p.code

-- Cache existence Flux Fi Volcanes
Insert into @tbExistenceFluxFiVolcanes
select  evvol_cod_prod,
		Case When max(evvol_zdt_creat) > 0 Then '1'
			Else '0' 
		End
from [VOLCANESDB_PRO].[dbo].[evvol] with (nolock)
where evvol_existence = 1
group by evvol_cod_prod

-- Cache date dernier flux fi volcanes
Insert into @tbDateDernFluxFiVolcanes
select evvol_cod_prod, 
	   Case When max(evvol_zdt_creat) > 0 THEN convert(varchar(10),max(evvol_zdt_creat),10)
			else ''
	   End
from [VOLCANESDB_PRO].[dbo].[evvol] with (nolock)
where evvol_existence = 1
group by evvol_cod_prod

-- Cache état produit produit Volcanes
Insert into @tbEtatProduitVolcanes
Select [ctpro].ctpro_cod_prod,
	   Case When max([ctrat].ctrat_dt_fin_ct) > 0 THEN 'Fermé'
				Else 'Ouvert' 
	   End
FROM [VOLCANESDB_PRO].[dbo].[ctpro]  with (nolock) join [VOLCANESDB_PRO].[dbo].[ctrat]  with (nolock)
			on     [ctrat].ctrat_cod_tier_a = [ctpro].ctpro_cod_tier_a
			and [ctrat].ctrat_cod_stie_a = [ctpro].ctpro_cod_stie_a
			and [ctrat].ctrat_cod_contra = [ctpro].ctpro_cod_contra
where [ctpro].ctpro_existence <> 0
group by [ctpro].ctpro_cod_prod 

-- Cache date de fermeture des produits volcanes
Insert into @tbDateFermProduitVolcanes
Select [ctpro].ctpro_cod_prod,
		Case When max([ctrat].ctrat_dt_fin_ct) > 0 THEN convert(varchar(10),max([ctrat].ctrat_dt_fin_ct),10)
				Else '' 
		End
FROM [VOLCANESDB_PRO].[dbo].[ctpro] with (nolock) join [VOLCANESDB_PRO].[dbo].[ctrat] with (nolock)
			on     [ctrat].ctrat_cod_tier_a = [ctpro].ctpro_cod_tier_a
			and [ctrat].ctrat_cod_stie_a = [ctpro].ctpro_cod_stie_a
			and [ctrat].ctrat_cod_contra = [ctpro].ctpro_cod_contra
where [ctpro].ctpro_existence <> 0
group by [ctpro].ctpro_cod_prod 

-- Cache au de là de 1000
Set @dcIdProdFFM  = 1  -- On part du produit en adhésion 1
While @dcIdProdFFM < 1000 -- Fin 999 inclu
 Begin
	Insert into @TbCacheProduitATraiter Values( @dcIdProdFFM, 0 ) 
	Set @dcIdProdFFM = @dcIdProdFFM + 1  -- On part du produit en adhésion 1
 End 

Insert into @TbCacheProduitATraiter
Select distinct id_prod, 0
From 
  (
	Select p.id_prod
	from SIMPA2_PRO.sysadm.produit p with (nolock)
	Where p.id_prod >= 1000
	Union all
	Select p.id_prod
	from SAVANE_PRO.sysadm.produit p with (nolock)
	Where p.id_prod >= 1000
	Union all
	Select p.id_prod
	from SINDI_PRO.sysadm.produit p with (nolock)
	Where p.id_prod >= 1000
	Union all
	Select p.id_prod
	from PEGASE_PRO.sysadm.produit p with (nolock)
	Where p.id_prod >= 1000
	Union all
	-- Demandé par Agnès le 24/05/2022 pour avoir aussi les produits SAGA2 en Recette pas encore en production
	Select p.code
	From 
		( 
		Select p.code
		from [SQL14BI\SAGA2BI].[SAGA2_PVC].ref.product p with (nolock)
		Where p.code >= 1000
		Union
		Select p.code
		from [SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.v_produit_saga2_recette p with (nolock)
		Where p.code >= 1000
		) as p

 ) as TbTempo
 Order by id_prod
--Début Traitement

While Exists ( Select Top 1 1 From @TbCacheProduitATraiter where marquage_trt = 0 ) 
 Begin
	Select @dcIdProdFFM = min ( id_prod_a_traiter) From @TbCacheProduitATraiter where marquage_trt = 0

 	-- On insère la ligne dans la table destination
	Insert into @tbTousProduits Values ( @sEtatCodeProduit, @sExistantFFM, @dcIdProdFFM, @sLibProdCourtFFM, @sLibProdLongFFM, @iNbreAdhTotaleFFM, @iNbreAdhActiveFFM, @sDateDernierTrtMens, @sExistantSherpa, @dcIdProdSherpaAdh, @dcIdProdSherpaSinistre, @slibProdCourtSherpa, @slibProdLongSherpa, @sTypeProduitSherpa, @sAppliGestionSherpa, @sExistantSimpa2, @dcIdProdSimpa2, @sLibProdCourtSimpa2, @sLibProdLongSimpa2, @sCodeVolcanesSimpa2, @sFournisseursLiesSimpa2, @sExistantSavane, @dcIdProdSavane, @sLibProdCourtSavane, @sLibProdLongSavane, @sCodeVolcanesSavane, @sExistantSindi, @dcIdProdSindi, @sLibProdCourtSindi, @sLibProdLongSindi, @sCodeVolcanesSindi, @sExistantPegase, @dcIdProdPegase, @sLibProdCourtPegase, @sLibProdLongPegase, @sCodeVolcanesPegase, @sExistantSaga2, @dcIdProdSaga2, @sLibProdCourtSaga2, @sLibProdLongSaga2, @sCodeVolcanesSaga2, @iNbreAdhTotaleSaga2, @iNbreAdhActiveSaga2, @sExistantVolcanes, @dcIdProdVolcanes, @sLibProdCourtVolcanes, @sLibProdLongVolcanes, @sFluxFiVolcanesExistant, @dtDateDernFluxFiVolcanes, @sEtatProduitVolcanes, @dtDateFermetureProdVolcanes, @sReservation_R_Spb, @dcIdProd_R_Spb, @slibProdCourt_R_Spb, @slibProdLong_R_Spb, @sDateReservation_R_spb )

	-- Je récupère la référence de ma ligne 
	Set @IdentityTbTsProd_Deb = @@IDENTITY
	Set @IdentityTbTsProd_Fin = @IdentityTbTsProd_Deb 
	
	-------------------------------
	-- FFM                       --
	-------------------------------
	-- Le produit existe-t-il en adhésion (sur FFM) ?
	Set @sLibProdLongFFM = null
	SELECT Top 1 @sLibProdLongFFM = rtrim ( lTrim ( lib_prod_ffm ))
	FROM @tbProduitsFFM
	Where id_prod_ffm = @dcIdProdFFM

	If @sLibProdLongFFM is null Set @sLibProdLongFFM = ''
	Set @sLibProdCourtFFM = ''

	Set @sExistantFFM = 'Non'
	If @sLibProdLongFFM <> '' Set @sExistantFFM = 'Oui'
	
	-- Nbre adhésion total
	Select @iNbreAdhTotaleFFM = nbre_adhesion_ffm
	From   @tbAdhesionFFM 
	Where  id_prod_ffm = @dcIdProdFFM

	-- Nbre adhésion total
	Select @iNbreAdhActiveFFM = nbre_adhesion_ffm_active
	From   @tbAdhesionFFMactive 
	Where  id_prod_ffm = @dcIdProdFFM

	-- Date Dernier trt mens adhésion
	Select @sDateDernierTrtMens = ltrim ( rtrim ( Convert ( varchar (10), Max ( hidem_date_creat ) )))
	from [ADHESIONDB_PRO].[dbo].[hidem] h1 with (nolock)
	Where h1.hidem_prod = @dcIdProdFFM
	And h1.hidem_codx = 'TRT'
	And h1.hidem_period = 
			( Select max ( hidem_period )
			  from [ADHESIONDB_PRO].[dbo].[hidem] h2 with (nolock)
			  Where h1.hidem_prod = h2.hidem_prod
				And h1.hidem_codx = h2.hidem_codx )

	Select @sDateDernierTrtMens = Right ( @sDateDernierTrtMens, 2) + '/' + SUBSTRING ( @sDateDernierTrtMens, 5, 2) + '/' + Left ( @sDateDernierTrtMens, 4 ) 

	If @sDateDernierTrtMens is null Set @sDateDernierTrtMens = ''

	Update @tbTousProduits 
		Set existant_FFM= @sExistantFFM, 
			lib_prod_court_ffm = @sLibProdCourtFFM, 
			lib_prod_long_ffm = @sLibProdLongFFM,
			nbre_adh_totale_ffm = @iNbreAdhTotaleFFM,
			nbre_adh_active_ffm = @iNbreAdhActiveFFM, 
			date_dernier_trt_mens = @sDateDernierTrtMens
	Where id_ligne = @IdentityTbTsProd_Deb

	-------------------------------
	-- SHERPA                    --
	-------------------------------
	-- Le produit existe-t-il sur SHERPA ?
	Insert into @tbProduitsSherpa
	Select	vp.id_prod, 
			vp.id_prod_adh, 
			vp.lib_long, 
			Case vp.id_typ_fam 
				When 1 Then 'Produit Adhésion' 
				When 2 Then 'Produit sinistre'
				Else 'non défini'
			End,
			( Select Top 1 rtrim ( cd.lib_code )
			  From   SHERPA_PRO.sysadm.prod_app papp with (nolock),
					 SHERPA_PRO.sysadm.code cd with (nolock)
			  Where  papp.id_prod = vp.id_prod
			  And    cd.id_typ_code = '-AP'
			  And    cd.id_code = papp.id_appli 
			),
			0 
	From SHERPA_PRO.sysadm.v_produit vp with (nolock)
	Where vp.id_prod_adh = @dcIdProdFFM
	Order by id_prod

	Select @iIdCleSherpa = min ( id_cle_sherpa ) From @tbProduitsSherpa where marquage_trt = 0 
	Set @iRowsEcritureTbTsProd = 1
	Set @sExistantSherpa = 'Non'

	While Exists ( Select Top 1 1 From @tbProduitsSherpa where marquage_trt = 0 )
	 Begin
		Set @sExistantSherpa = 'Oui'

		Select 
			@dcIdProdSherpaSinistre = id_prod_Sherpa,
			@dcIdProdSherpaAdh = id_prod_adh,
			@slibProdCourtSherpa = '',
			@slibProdLongSherpa = lib_prod_Sherpa,
			@sTypeProduitSherpa = type_prod_sherpa,
			@sAppliGestionSherpa = appli_gestion_sherpa
		From @tbProduitsSherpa 
		Where id_cle_sherpa = @iIdCleSherpa

		IF @IdentityTbTsProd_Deb + @iRowsEcritureTbTsProd - 1  <= @IdentityTbTsProd_Fin 
		 Begin
			-- Les lignes existent déjà
			Update @tbTousProduits 
			Set		existant_sherpa			= @sExistantSherpa,
					id_prod_sherpa_adh      = @dcIdProdSherpaAdh,
					id_prod_sherpa_sinistre = @dcIdProdSherpaSinistre,
					lib_prod_court_sherpa   = @slibProdCourtSherpa,
					lib_prod_long_sherpa    = @slibProdLongSherpa,
					type_produit_sherpa     = @sTypeProduitSherpa,
					appli_gestion_sherpa    = @sAppliGestionSherpa
			Where id_ligne = @IdentityTbTsProd_Deb + @iRowsEcritureTbTsProd - 1
		 End 
		Else
		 Begin
			-- Il n'y a plus assez de lignes, j'en recréé
			Insert into @tbTousProduits Values ( @sEtatCodeProduit, @sExistantFFM, @dcIdProdFFM, @sLibProdCourtFFM, @sLibProdLongFFM, @iNbreAdhTotaleFFM, @iNbreAdhActiveFFM, @sDateDernierTrtMens, @sExistantSherpa, @dcIdProdSherpaAdh, @dcIdProdSherpaSinistre, @slibProdCourtSherpa, @slibProdLongSherpa, @sTypeProduitSherpa, @sAppliGestionSherpa, @sExistantSimpa2, @dcIdProdSimpa2, @sLibProdCourtSimpa2, @sLibProdLongSimpa2, @sCodeVolcanesSimpa2, @sFournisseursLiesSimpa2, @sExistantSavane, @dcIdProdSavane, @sLibProdCourtSavane, @sLibProdLongSavane, @sCodeVolcanesSavane, @sExistantSindi, @dcIdProdSindi, @sLibProdCourtSindi, @sLibProdLongSindi, @sCodeVolcanesSindi, @sExistantPegase, @dcIdProdPegase, @sLibProdCourtPegase, @sLibProdLongPegase, @sCodeVolcanesPegase, @sExistantSaga2, @dcIdProdSaga2, @sLibProdCourtSaga2, @sLibProdLongSaga2, @sCodeVolcanesSaga2, @iNbreAdhTotaleSaga2, @iNbreAdhActiveSaga2, @sExistantVolcanes, @dcIdProdVolcanes, @sLibProdCourtVolcanes, @sLibProdLongVolcanes, @sFluxFiVolcanesExistant, @dtDateDernFluxFiVolcanes, @sEtatProduitVolcanes, @dtDateFermetureProdVolcanes, @sReservation_R_Spb, @dcIdProd_R_Spb, @slibProdCourt_R_Spb, @slibProdLong_R_Spb, @sDateReservation_R_spb )
			-- Je récupère la référence de ma ligne 
			Set @IdentityTbTsProd_Fin = @@IDENTITY
		 End 

		Update @tbProduitsSherpa Set marquage_trt = 1 Where id_cle_sherpa = @iIdCleSherpa
		Set @iIdCleSherpa = @iIdCleSherpa + 1
		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	 End 
	
	IF @sExistantSherpa = 'Non'
	  Begin
		Update @tbTousProduits Set existant_sherpa = @sExistantSherpa Where id_ligne = @IdentityTbTsProd_Deb
	  End

	-------------------------------
	-- SIMPA                     --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantSimpa2      = null
		Set @dcIdProdSimpa2         = null
		Set @sLibProdCourtSimpa2  = null
		Set @sLibProdLongSimpa2   = null
		Set @sCodeVolcanesSimpa2 = null
		Set @sFournisseursLiesSimpa2 = null

		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd

		If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Select 
		    @sExistantSimpa2 = 'Oui', 
			@dcIdProdSimpa2    = pr.id_prod,
			@sLibProdCourtSimpa2  = rtrim ( ltrim ( pr.lib_court )),
			@sLibProdLongSimpa2   = rtrim ( ltrim ( pr.lib_long )),
			@sCodeVolcanesSimpa2 = pr.cod_prod_dms,
			@sFournisseursLiesSimpa2 = nullif ( ( SELECT Distinct '#' + CAST(rtrim ( id_code_frn ) AS VARCHAR(250)) FROM sysadm.commande_type with (nolock) Where id_prod = pr.id_prod For XML PATH ('') ) + '#', '##' )
		From SIMPA2_PRO.sysadm.produit pr with (nolock)
		Where id_prod = @dcIdProdSherpaSinistre

		If @sExistantSimpa2 is null Set @sExistantSimpa2 = 'Non'
			
		Update @tbTousProduits 
			Set		existant_simpa2			= @sExistantSimpa2,
					id_prod_simpa2	        = @dcIdProdSimpa2,
					lib_prod_court_simpa2   = @sLibProdCourtSimpa2,
					lib_prod_long_simpa2    = @sLibProdLongSimpa2,
					code_volcanes_simpa2    = @sCodeVolcanesSimpa2,
					fournisseurs_lies_simpa2 = @sFournisseursLiesSimpa2
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 

	-------------------------------
	-- SAVANE                     --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantSavane      = null
		Set @dcIdProdSavane        = null
		Set @sLibProdCourtSavane  = null
		Set @sLibProdLongSavane   = null
		Set @sCodeVolcanesSavane = null

		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd

		If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Select 
		    @sExistantSavane  = 'Oui', 
			@dcIdProdSavane    = pr.id_prod,
			@sLibProdCourtSavane  = rtrim ( ltrim ( pr.lib_court )),
			@sLibProdLongSavane   = rtrim ( ltrim ( pr.lib_long )),
			@sCodeVolcanesSavane = convert ( varchar (50), pr.id_prod/100 )
		From SAVANE_PRO.sysadm.produit pr with (nolock)
		Where id_prod = @dcIdProdSherpaSinistre

		If @sExistantSavane is null Set @sExistantSavane = 'Non'

		Update @tbTousProduits 
			Set		existant_savane			= @sExistantSavane,
					id_prod_savane	        = @dcIdProdSavane,
					lib_prod_court_savane   = @sLibProdCourtSavane,
					lib_prod_long_savane    = @sLibProdLongSavane,
					code_volcanes_savane    = @sCodeVolcanesSavane
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 

	-------------------------------
	-- SINDI                     --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantSindi      = null
		Set @dcIdProdSindi        = null
		Set @sLibProdCourtSindi  = null
		Set @sLibProdLongSindi   = null
		Set @sCodeVolcanesSindi = null
		
		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd

		If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Select 
		    @sExistantSindi  = 'Oui', 
			@dcIdProdSindi    = pr.id_prod,
			@sLibProdCourtSindi  = rtrim ( ltrim ( pr.lib_court )),
			@sLibProdLongSindi   = rtrim ( ltrim ( pr.lib_long )),
			@sCodeVolcanesSindi  = IsNull ( ( Select Top 1 convert ( Varchar ( 50), val_calc ) from SINDI_PRO.sysadm.det_pro with (nolock) where id_calc = 6 and id_prod = pr.id_prod ), '' )
		From SINDI_PRO.sysadm.produit pr with (nolock)
		Where id_prod = @dcIdProdSherpaSinistre

		If @sExistantSindi is null Set @sExistantSindi = 'Non'

		Update @tbTousProduits 
			Set		existant_sindi			= @sExistantSindi,
					id_prod_sindi	        = @dcIdProdSindi,
					lib_prod_court_sindi   = @sLibProdCourtSindi,
					lib_prod_long_sindi    = @sLibProdLongSindi,
					code_volcanes_sindi    = @sCodeVolcanesSindi
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 

	-------------------------------
	-- PEGASE                    --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantPegase      = null
		Set @dcIdProdPegase        = null
		Set @sLibProdCourtPegase  = null
		Set @sLibProdLongPegase   = null
		Set @sCodeVolcanesPegase  = null
		
		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd

		If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Select 
		    @sExistantPegase  = 'Oui', 
			@dcIdProdPegase    = pr.id_prod,
			@sLibProdCourtPegase  = rtrim ( ltrim ( pr.lib_court )),
			@sLibProdLongPegase   = rtrim ( ltrim ( pr.lib_long )),
			@sCodeVolcanesPegase = IsNull ( ( Select Top 1 convert ( Varchar ( 50), val_calc ) from PEGASE_PRO.sysadm.det_pro with (nolock) where id_calc = 6 and id_prod = pr.id_prod ), '' )
		From PEGASE_PRO.sysadm.produit pr with (nolock)
		Where id_prod = @dcIdProdSherpaSinistre

		If @sExistantPegase is null Set @sExistantPegase = 'Non'

		Update @tbTousProduits 
			Set		existant_pegase			= @sExistantPegase,
					id_prod_pegase	        = @dcIdProdPegase,
					lib_prod_court_pegase   = @sLibProdCourtPegase,
					lib_prod_long_pegase    = @sLibProdLongPegase
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 


	-------------------------------
	-- SAGA2                     --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantSaga2      = null
		Set @dcIdProdSaga2        = null
		Set @sLibProdCourtSaga2  = null
		Set @sLibProdLongSaga2   = null
		Set @sCodeVolcanesSaga2  = null
		
		/* Je coupe ce select car il sort des données erronées
		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd
		*/

		-- If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM
		Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Set @sExistantSaga2 = null

		Select 
		    @sExistantSaga2  = 'Oui', 
			@dcIdProdSaga2    = pr.code,
			@sLibProdCourtSaga2  = rtrim ( ltrim ( pr.short_label )),
			@sLibProdLongSaga2   = rtrim ( ltrim ( pr.long_label )),
			@sCodeVolcanesSaga2  = Convert ( varchar ( 50), pr.volcanes_code )
		From [SQL14BI\SAGA2BI].[SAGA2_PVC].ref.product pr with (nolock)
		Where code = @dcIdProdSherpaSinistre

		If @sExistantSaga2 is null
		  Begin
			Select 
		    @sExistantSaga2  = 'Oui', 
			@dcIdProdSaga2    = pr.code,
			@sLibProdCourtSaga2  = rtrim ( ltrim ( pr.short_label )),
			@sLibProdLongSaga2   = rtrim ( ltrim ( pr.long_label )),
			@sCodeVolcanesSaga2  = Convert ( varchar ( 50), pr.volcanes_code )
			From [SQL14DEV\SIMSINISTRES].SIMPA2_TRT.sysadm.v_produit_saga2_recette pr with (nolock)
			Where code = @dcIdProdSherpaSinistre
		  End 

		If @sExistantSaga2  is null Set @sExistantSaga2  = 'Non'

		-- Nbre adhésion total
		Select @iNbreAdhTotaleSaga2 = nbre_adhesion_saga2
		From   @tbAdhesionSaga2 
		Where  id_prod_saga2 = @dcIdProdSherpaSinistre

		-- Nbre adhésion total
		Select @iNbreAdhActiveSaga2 = nbre_adhesion_saga2_active
		From   @tbAdhesionSaga2Active 
		Where  id_prod_saga2 = @dcIdProdSherpaSinistre

		Update @tbTousProduits 
			Set		existant_saga2 			= @sExistantSaga2 ,
					id_prod_saga2	        = @dcIdProdSaga2 ,
					lib_prod_court_saga2    = @sLibProdCourtSaga2 ,
					lib_prod_long_saga2     = @sLibProdLongSaga2,
					nbre_adh_totale_saga2   = @iNbreAdhTotaleSaga2,
					nbre_adh_active_saga2   = @iNbreAdhActiveSaga2,
					code_volcanes_saga2     = @sCodeVolcanesSaga2
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 

	-------------------------------
	-- VOLCANES                  --
	-------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin
		Set @sExistantVolcanes      = null
		Set @dcIdProdVolcanes        = null
		Set @sLibProdCourtVolcanes  = null
		Set @sLibProdLongVolcanes   = null
		
		/* Je coupe ce select car il sort des données erronées
		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd
		*/

		-- If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM
		Set @dcIdProdSherpaSinistre = @dcIdProdFFM

		Select 
		    @sExistantVolcanes  = 'Oui', 
			@dcIdProdVolcanes    = pr.prodt_cod_prod,
			@sLibProdCourtVolcanes  = '',
			@sLibProdLongVolcanes   = rtrim ( ltrim ( pr.prodt_nom_prod ))
		From [VOLCANESDB_PRO].[dbo].[prodt] pr with (nolock)
		Where prodt_cod_prod = @dcIdProdSherpaSinistre

		If @sExistantVolcanes  is null Set @sExistantVolcanes  = 'Non'

		-- Y a-t-il Des flux financiers pour ce produit ?
		    select Top 1 @sFluxFiVolcanesExistant = existence_flux_fi_volcanes from @tbExistenceFluxFiVolcanes Where id_prod_ffm = @dcIdProdFFM

			If @sFluxFiVolcanesExistant is null Set @sFluxFiVolcanesExistant = 'Non'
			If @sFluxFiVolcanesExistant = '0' Set @sFluxFiVolcanesExistant = 'Non'
			If @sFluxFiVolcanesExistant = '1' Set @sFluxFiVolcanesExistant = 'Oui'

		-- Si Oui, quelle est la dernière date du flux fi ?
			If @sFluxFiVolcanesExistant = 'Oui'
			  Begin
			      Select @dtDateDernFluxFiVolcanes = date_dern_fluxfi_volcanes From @tbDateDernFluxFiVolcanes Where id_prod_ffm = @dcIdProdFFM

				  If @dtDateDernFluxFiVolcanes is null Set @dtDateDernFluxFiVolcanes = ''
				  If @dtDateDernFluxFiVolcanes <> ''
				    Begin
					  Select @dtDateDernFluxFiVolcanes = Right ( @dtDateDernFluxFiVolcanes, 2) + '/' + SUBSTRING ( @dtDateDernFluxFiVolcanes, 5, 2) + '/' + Left ( @dtDateDernFluxFiVolcanes, 4 ) 
					End 
			  End 

		-- Quel est l'état du produit OUVERT, FERME, PAS D'INFO (si la jointure ne ramène rien)
		    Select @sEtatProduitVolcanes = etat_produit_volcanes From @tbEtatProduitVolcanes Where id_prod_ffm = @dcIdProdFFM
			If @sEtatProduitVolcanes is null Set @sEtatProduitVolcanes = 'Pas d''info'

        -- Si Fermé, à quelle date
			IF @sEtatProduitVolcanes in ( 'Fermé' )
			  Begin
				Select @dtDateFermetureProdVolcanes = date_ferm_prod_volcanes From @tbDateFermProduitVolcanes Where id_prod_ffm = @dcIdProdFFM
				If @dtDateFermetureProdVolcanes is null Set @dtDateFermetureProdVolcanes = ''
			  End 

			If @dtDateFermetureProdVolcanes is null Set @dtDateFermetureProdVolcanes = ''
			If @dtDateFermetureProdVolcanes <> ''
			Begin
				Select @dtDateFermetureProdVolcanes = Right ( @dtDateFermetureProdVolcanes, 2) + '/' + SUBSTRING ( @dtDateFermetureProdVolcanes, 5, 2) + '/' + Left ( @dtDateFermetureProdVolcanes, 4 ) 
			End 

		Update @tbTousProduits 
			Set		existant_volcanes 		= @sExistantVolcanes ,
					id_prod_volcanes	    = @dcIdProdVolcanes ,
					lib_prod_court_volcanes = @sLibProdCourtVolcanes ,
					lib_prod_long_volcanes  = @sLibProdLongVolcanes,
					fluxfi_volcanes_existant = @sFluxFiVolcanesExistant,
					date_dern_fluxfi_volcanes = @dtDateDernFluxFiVolcanes,
					etat_produit_volcanes = @sEtatProduitVolcanes,
					date_fermeture_prod_volcanes = @dtDateFermetureProdVolcanes
					 
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 

	----------------------------------
	-- Réservation code produit SPB --
	----------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin

	  	Set @sReservation_R_Spb = null
	    Set @dcIdProd_R_Spb = null
		Set @slibProdCourt_R_Spb = null
	    Set @slibProdLong_R_Spb = null
		Set @sDateReservation_R_spb = null

		Select @dcIdProdSherpaSinistre = id_prod_sherpa_sinistre 
		From  @tbTousProduits
		Where id_ligne = @iRowsEcritureTbTsProd

		If @dcIdProdSherpaSinistre is null Set @dcIdProdSherpaSinistre = @dcIdProdFFM
		
		Select 
		    @sReservation_R_Spb  = 'Oui', 
			@dcIdProd_R_Spb   = id_code,
			@slibProdCourt_R_Spb  = '',
			@slibProdLong_R_Spb   = rtrim ( ltrim ( lib_code )),
			@sDateReservation_R_spb = convert ( varchar ( 10), cree_le, 103 )
		From SIMPA2_PRO.sysadm.code pr with (nolock)
		Where id_typ_code = '-W4'
		And   id_code > 0
		And   id_code = @dcIdProdSherpaSinistre

		If @sReservation_R_Spb  is null Set @sReservation_R_Spb  = 'Non'

		Update @tbTousProduits 
			Set		reservation_R_spb 		= @sReservation_R_Spb ,
					id_prod_R_spb	        = @dcIdProd_R_Spb ,
					lib_prod_court_R_spb   = @slibProdCourt_R_Spb ,
					lib_prod_long_R_spb    = @slibProdLong_R_Spb,
					date_reservation_R_spb = @sDateReservation_R_spb
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 


	---------------------------------
	-- Fin tour pour 1 produit FFM --
	---------------------------------

	----------------------------------------------------
	-- Mise à jour colonne EtatCodeProduit Libre/Pris --
	----------------------------------------------------
	Set @iRowsEcritureTbTsProd = @IdentityTbTsProd_Deb

	While @iRowsEcritureTbTsProd <= @IdentityTbTsProd_Fin
	  Begin

		Update @tbTousProduits 
			Set	etat_code_produit =	
						Case 
							When existant_FFM      = 'Oui' Then 'Pris'
							When existant_sherpa   = 'Oui' Then 'Pris'
							When existant_simpa2   = 'Oui' Then 'Pris'
							When existant_savane   = 'Oui' Then 'Pris'
							When existant_sindi    = 'Oui' Then 'Pris'
							When existant_pegase   = 'Oui' Then 'Pris'
							When existant_saga2    = 'Oui' Then 'Pris'
							When existant_volcanes = 'Oui' Then 'Pris'

							-- Mettre les réservation après les Pris
							When reservation_R_spb = 'Oui' Then 'Réservé'

							-- Libre
							Else 'Libre'
						End 
		Where id_ligne = @iRowsEcritureTbTsProd

		Set @iRowsEcritureTbTsProd = @iRowsEcritureTbTsProd + 1
	  End 


	-- On passe au produit FFM suivant et on RAZ les variables
	Delete @tbProduitsSherpa

	Set @sExistantFFM         = null
	Set @sLibProdCourtFFM     = null
	Set @sLibProdLongFFM      = null
	Set @iNbreAdhTotaleFFM    = null
	Set @iNbreAdhActiveFFM    = null
	Set @sDateDernierTrtMens  = null
	Set @sExistantSherpa      = null
	Set @dcIdProdSherpaAdh    = null
	Set @dcIdProdSherpaSinistre= null
	Set @slibProdCourtSherpa  = null
	Set @slibProdLongSherpa   = null
	Set @sTypeProduitSherpa   = null
	Set @sAppliGestionSherpa  = null
	Set @sExistantSimpa2      = null
	Set @dcIdProdSimpa2         = null
	Set @sLibProdCourtSimpa2  = null
	Set @sLibProdLongSimpa2   = null
	Set @sCodeVolcanesSimpa2 = null
	Set @sFournisseursLiesSimpa2 = null
	Set @sExistantSavane      = null
	Set @dcIdProdSavane        = null
	Set @sLibProdCourtSavane  = null
	Set @sLibProdLongSavane   = null
	Set @sCodeVolcanesSavane   = null
	Set @sExistantSindi       = null
	Set @dcIdProdSindi         = null
	Set @sLibProdCourtSindi   = null
	Set @sLibProdLongSindi    = null
	Set @sCodeVolcanesSindi   = null
	Set @sExistantPegase      = null
	Set @dcIdProdPegase        = null
	Set @sLibProdCourtPegase  = null
	Set @sLibProdLongPegase   = null
	Set @sCodeVolcanesPegase  = null
	Set @sExistantSaga2       = null
	Set @dcIdProdSaga2         = null
	Set @sLibProdCourtSaga2   = null
	Set @sLibProdLongSaga2   = null
	Set @sCodeVolcanesSaga2 = null
	Set @iNbreAdhTotaleSaga2 = null
	Set @iNbreAdhActiveSaga2 = null
	Set @sExistantVolcanes    = null
	Set @dcIdProdVolcanes      = null
	Set @sLibProdCourtVolcanes= null
	Set @sLibProdLongVolcanes = null
	Set @sFluxFiVolcanesExistant = null
	Set @dtDateDernFluxFiVolcanes = null
	Set @sEtatProduitVolcanes = null
	Set @dtDateFermetureProdVolcanes = null
	Set @sReservation_R_Spb = null
	Set @dcIdProd_R_Spb = null
	Set @slibProdCourt_R_Spb = null
	Set @slibProdLong_R_Spb = null
	Set @sDateReservation_R_spb = null

	Update @TbCacheProduitATraiter Set marquage_trt = 1 Where id_prod_a_traiter = @dcIdProdFFM
 End

Delete @tbTousProduits Where id_prod_ffm >= 1000 And etat_code_produit = 'Libre'

-- On mémorise les anciens réservé dans -W5 s'ils sont pris à présent.
If Exists ( 
		Select Top 1 1 
		From  @tbTousProduits t,
				SIMPA2_PRO.sysadm.code c with (nolock)
		where c.id_typ_code = '-W4' 
		And   t.id_prod_ffm = c.id_code
		And   t.etat_code_produit = 'Pris'
	) 
	Begin 
		Select t.*
		From  @tbTousProduits t,
				SIMPA2_PRO.sysadm.code c with (nolock)
		where c.id_typ_code = '-W4' 
		And   t.id_prod_ffm = c.id_code
		And   t.etat_code_produit = 'Pris'
	End 


If @@ROWCOUNT > 0 
  Begin 

	Select 1, '--------------------------------------------------------------------------------'
	Union
	Select 2, 'Les lignes ci-dessus sont en conflits avec les réservations de code produits (voir complètement au bout du tableau)' 
	Union
	Select 3, 'Lancer d''abord en production sur SIMPA2_PRO les commandes ci-dessous avant de relancer l''extraction et surtout PREVENEZ AGNES (EPG) de la situation. Ces commandes suppriment les réservations de -W4, mais les gardent pour mémoire sur -W5.' 
	Union
	Select 4, '--------------------------------------------------------------------------------'
	Order by 1

	Select Distinct
		   'Delete SIMPA2_PRO.sysadm.code Where id_typ_code = ''-W5'' and id_code = ' + Convert ( varchar ( 10), c.id_code ) + ' ; ' +
		   'Update SIMPA2_PRO.sysadm.code set id_typ_code = ''-W5'' Where id_typ_code = ''-W4'' and id_code = ' + Convert ( varchar ( 10), c.id_code )
	From  @tbTousProduits t,
		  SIMPA2_PRO.sysadm.code c with (nolock)
	where c.id_typ_code = '-W4' 
	And   t.id_prod_ffm = c.id_code
	And   t.etat_code_produit = 'Pris'

  End 
Else 
  Begin
	-------------------------------
	-- Select de sortie finale   --
	-------------------------------

	Set @dtGetDate  = Getdate()  

	Select
	@dtGetDate date_extract, 
	id_prod_ffm 'Code de 1 à 99999',
	'P' + Convert ( varchar (10), id_prod_ffm) 'Rech_Racine',
	IsNull (etat_code_produit, '' ) etat_code_produit,
	IsNull (existant_FFM, '' ) existant_FFM,
	Case existant_FFM
		WHen 'Non' Then ''
		Else IsNull (Convert ( varchar (30), id_prod_ffm), '' ) 
	End id_prod_ffm,
	IsNull (lib_prod_court_ffm, '' ) lib_prod_court_ffm,
	IsNull (lib_prod_long_ffm, '' ) lib_prod_long_ffm,
	IsNull ( Convert ( varchar (30), nbre_adh_totale_ffm ), '' ) nbre_adh_totale_ffm,
	IsNull ( Convert ( varchar (30), nbre_adh_active_ffm ), '' ) nbre_adh_active_ffm,
	IsNull ( date_dernier_trt_mens, '' ) date_dernier_trt_mens,
	IsNull (existant_sherpa, '' )existant_sherpa,
	IsNull (Convert ( varchar (30), id_prod_sherpa_adh), '' ) id_prod_sherpa_adh,
	IsNull (Convert ( varchar (30), id_prod_sherpa_sinistre), '' ) id_prod_sherpa_sinistre,
	IsNull (lib_prod_court_sherpa, '' ) lib_prod_court_sherpa,
	IsNull (lib_prod_long_sherpa, ''  ) lib_prod_long_sherpa,
	IsNull (type_produit_sherpa, '' ) type_produit_sherpa,
	IsNull (appli_gestion_sherpa, '' ) appli_gestion_sherpa,
	IsNull (existant_simpa2, '' ) existant_simpa2,
	IsNull (Convert ( varchar (30), id_prod_simpa2), '' ) id_prod_simpa2,
	IsNull (lib_prod_court_simpa2, '' ) lib_prod_court_simpa2,
	IsNull (lib_prod_long_simpa2, '' ) lib_prod_long_simpa2,
	IsNull (code_volcanes_simpa2, '' ) code_volcanes_simpa2,
	IsNull (fournisseurs_lies_simpa2, '') fournisseurs_lies_simpa2,
	IsNull (existant_savane, '' ) existant_savane,
	IsNull (Convert ( varchar (30), id_prod_savane), '' ) id_prod_savane,
	IsNull (lib_prod_court_savane, '' ) lib_prod_court_savane,
	IsNull (lib_prod_long_savane, '' ) lib_prod_long_savane,
	IsNull (code_volcanes_savane, '' ) code_volcanes_savane,
	IsNull (existant_sindi, '' ) existant_sindi,
	IsNull (Convert ( varchar (30), id_prod_sindi), '' ) id_prod_sindi,
	IsNull (lib_prod_court_sindi, '' ) lib_prod_court_sindi,
	IsNull (lib_prod_long_sindi, '' ) lib_prod_long_sindi,
	IsNull (code_volcanes_sindi, '' ) code_volcanes_sindi,
	IsNull (existant_pegase, '' ) existant_pegase,
	IsNull (Convert ( varchar (30), id_prod_pegase), '' ) id_prod_pegase,
	IsNull (lib_prod_court_pegase, '' ) lib_prod_court_pegase,
	IsNull (lib_prod_long_pegase, '' ) lib_prod_long_pegase,
	IsNull (code_volcanes_pegase, '' ) code_volcanes_pegase,
	IsNull (existant_saga2, '' ) existant_saga2,
	IsNull (Convert ( varchar (30), id_prod_saga2), '' ) id_prod_saga2,
	IsNull (lib_prod_court_saga2, '' ) lib_prod_court_saga2,
	IsNull (lib_prod_long_saga2, '' ) lib_prod_long_saga2,
	IsNull (code_volcanes_saga2, '' ) code_volcanes_saga2,
	IsNull (Convert ( varchar (30), nbre_adh_totale_saga2 ), '' ) nbre_adh_totale_saga2,
	IsNull (Convert ( varchar (30), nbre_adh_active_saga2 ), '' ) nbre_adh_active_saga2,
	IsNull (existant_volcanes, '' ) existant_volcanes,
	IsNull (Convert ( varchar (30), id_prod_volcanes), '' ) id_prod_volcanes,
	IsNull (lib_prod_court_volcanes, '' ) lib_prod_court_volcanes,
	IsNull (lib_prod_long_volcanes, '' ) lib_prod_long_volcanes,
	IsNull (fluxfi_volcanes_existant, '' ) fluxfi_volcanes_existant,
	IsNull (date_dern_fluxfi_volcanes, '' ) date_dern_fluxfi_volcanes,
	IsNull (etat_produit_volcanes, '' ) etat_produit_volcanes,
	IsNull (date_fermeture_prod_volcanes, '' ) date_fermeture_prod_volcanes,
	IsNull (reservation_R_spb, '' ) reservation_R_spb,
	IsNull (Convert ( varchar (30), id_prod_R_spb), '' ) id_prod_R_spb,
	IsNull (lib_prod_court_R_spb, '' ) lib_prod_court_R_spb,
	IsNull (lib_prod_long_R_spb, '' ) lib_prod_long_R_spb,
	IsNull (date_reservation_R_spb, '' ) date_reservation_R_spb
	From @tbTousProduits 
	order by 2
End 

Go
