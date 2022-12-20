-------------------------------------------------------------------
--
-- Fichier              :       PARAM_FTU_BRK.CP
-- Auteur               :       Pinon Fabien
-- Date                 :       01/03/2011
--
-- Commentaires         :       Gestion de la table PARAM_FTU_BRK
--
-- Procédures           :       DW_S01_PARAM_FTU_BRK
--				DW_S02_PARAM_FTU_BRK
--				DW_S03_PARAM_FTU_BRK
--				DW_S04_PARAM_FTU_BRK
--				DW_S05_PARAM_FTU_BRK
--				DW_S06_PARAM_FTU_BRK
--				DW_S07_PARAM_FTU_BRK
--				DW_S07_PARAM_FTU_BRK_V01
--				DW_S07_PARAM_FTU_BRK_V02
--				DW_S07_PARAM_FTU_BRK_V03
--				DW_S08_PARAM_FTU_BRK
--				DW_S08_PARAM_FTU_BRK_V01
--				DW_I01_PARAM_FTU_BRK
--				DW_I01_PARAM_FTU_BRK_V01
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S01_PARAM_FTU_BRK

AS

Select distinct
	pfb.id_prod,                        
	p.lib_long
From 	sysadm.param_ftu_brk pfb,
        sysadm.produit p 
where 	pfb.id_prod = p.id_prod
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S02_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S02_PARAM_FTU_BRK

AS

Select distinct
	pfb.id_gti,                        
	cg.lib_gti
From 	sysadm.param_ftu_brk pfb
  inner join sysadm.code_garantie cg on  cg.id_prod=pfb.id_prod and cg.id_gti=pfb.id_gti
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S03_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S03_PARAM_FTU_BRK

AS

Select distinct
	pfb.id_brk,                        
	sysadm.FN_CODE_CAR(pfb.id_brk,'-01') as lib_long
From 	sysadm.param_ftu_brk pfb
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S04_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S04_PARAM_FTU_BRK

AS

Select distinct
	pfb.id_typ_art,                        
	Case When pfb.id_typ_art='-1' Then 'Pour tout appareil' 
	Else sysadm.FN_CODE_CAR(pfb.id_typ_art,'-AR') end as lib_long
From 	sysadm.param_ftu_brk pfb
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S05_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S05_PARAM_FTU_BRK

AS
Select distinct
	cie.id_cie,                        
	cie.lib_cie	
From 	sysadm.param_ftu_brk pfb
  inner join sysadm.garantie g on g.id_prod=pfb.id_prod 
  inner join sysadm.police po on g.id_police=po.id_police
  inner join sysadm.compagnie cie on cie.id_cie=po.id_cie  
 Where (pfb.id_rev=-1 or g.id_rev=pfb.id_rev)
	and (pfb.id_gti=-1 or g.id_gti=pfb.id_gti)
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre accueil des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S06_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S06_PARAM_FTU_BRK
  @iIdTarif	Int,
  @iIdProd	Decimal(7,0),
  @iIdGti	Decimal(7,0),
  @sIdBrk	Varchar(6),
  @sIdCodeArt	Varchar(6),
  @iIdCie	Decimal(7,0),
  @iIdPolice	Decimal(7,0)
  
AS
Select pfb.id_tarif, pfb.id_prod, pfb.alt_actif, pfb.id_gti, pfb.id_brk, pfb.id_typ_art, 
	dte_deb_eff,dte_fin_eff,typ_eff, typ_vetuste
From 	sysadm.param_ftu_brk pfb
Where 	(@iIdTarif is null or pfb.id_tarif=@iIdTarif)
  and  (@iIdProd is null or pfb.id_prod=@iIdProd)
  and  (@iIdGti is null or pfb.id_gti=@iIdGti)
  and  (@sIdBrk is null or pfb.id_brk=@sIdBrk)
  and  (@sIdCodeArt is null or pfb.id_typ_art=@sIdCodeArt)
  and (@iIdCie is null or 
    exists (select po.id_cie 
		from sysadm.garantie g 
		inner join sysadm.police po on g.id_police=po.id_police
		where g.id_prod=pfb.id_prod 
			and (g.id_rev=pfb.id_rev or pfb.id_rev=-1) 
			and (g.id_gti=pfb.id_gti or pfb.id_gti=-1)
			and po.id_cie=@iIdCie)
	)
  and (@iIdPolice is null or 
    exists (select g.id_police
		from sysadm.garantie g 
		where g.id_prod=pfb.id_prod 
			and (g.id_rev=pfb.id_rev or pfb.id_rev=-1) 
			and (g.id_gti=pfb.id_gti or pfb.id_gti=-1)
			and g.id_police=@iIdPolice)
	)
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S07_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S07_PARAM_FTU_BRK
	@iIdTarif int
As
  Select id_tarif, id_prod, id_rev, 
    alt_actif, id_gti, id_four, id_methode,
    id_brk, id_typ_art, 
    dte_deb_eff, dte_fin_eff, typ_eff, 
    typ_mt_pivot, httc_pivot, mt_pivot, 
    typ_vetuste, per_cplt, per_cplt_ut, 
    typ_decote, mt_decote, httc_decote, tx_decote,
    mt_forfaitaire, httc_forfait, id_four_forfait,
    tx_tva, param_cplt, 
    cree_le, maj_le, maj_par,
    'N' as alt_reinit,
    'N' as alt_mode_creat
  From sysadm.param_ftu_brk
  Where id_tarif=@iIdTarif
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_PARAM_FTU_BRK_V01
-- Auteur               :       Fabien PINON
-- Date                 :       08/04/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_PARAM_FTU_BRK_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S07_PARAM_FTU_BRK_V01
GO

CREATE procedure sysadm.DW_S07_PARAM_FTU_BRK_V01
	@iIdTarif int
As
  Select id_tarif, id_prod, id_rev, 
    alt_actif, id_gti, id_four, id_methode,
    id_brk, id_typ_art, 
    dte_deb_eff, dte_fin_eff, typ_eff, 
    typ_mt_pivot, httc_pivot, mt_pivot, 
    typ_vetuste, per_cplt, per_cplt_ut, 
    typ_decote, mt_decote, httc_decote, tx_decote,
    mt_forfaitaire, httc_forfait, id_four_forfait,
    tx_tva, param_cplt, 
    cree_le, maj_le, maj_par,
    'N' as alt_reinit,
    'N' as alt_mode_creat,
    Case When dte_deb_eff='01/01/1980' and dte_fin_eff='01/01/3000' and typ_eff='DTESRV' Then 'O'
    Else 'N' End as alt_sans_vetuste
  From sysadm.param_ftu_brk
  Where id_tarif=@iIdTarif
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_PARAM_FTU_BRK_V02
-- Auteur               :       Fabien PINON
-- Date                 :       08/04/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_PARAM_FTU_BRK_V02' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S07_PARAM_FTU_BRK_V02
GO

CREATE procedure sysadm.DW_S07_PARAM_FTU_BRK_V02
	@iIdTarif int
As
  Select id_tarif, id_prod, id_rev, 
    alt_actif, id_gti, id_four, id_methode,
    id_brk, id_typ_art, 
    dte_deb_eff, dte_fin_eff, typ_eff, 
    typ_mt_pivot, httc_pivot, mt_pivot, 
    typ_vetuste, per_cplt, per_cplt_ut, 
    typ_decote, mt_decote, httc_decote, tx_decote,
    mt_forfaitaire, httc_forfait, id_four_forfait,
    tx_tva, param_cplt, 
    cree_le, maj_le, maj_par,
    'N' as alt_reinit,
    'N' as alt_mode_creat,
    Case When dte_deb_eff='01/01/1980' and dte_fin_eff='01/01/3000' and typ_eff='DTESRV' Then 'O'
    Else 'N' End as alt_sans_validite,
    Case When dte_fin_eff='01/01/3000' Then 'O'
    Else 'N' End as alt_sans_fin_valide
  From sysadm.param_ftu_brk
  Where id_tarif=@iIdTarif
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :        
-- Commentaires         :       Delete sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_D01_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_D01_PARAM_FTU_BRK
	@iIdTarif int
As
  Delete From sysadm.param_ftu_brk_vts
  Where id_tarif=@iIdTarif
  
  Delete From sysadm.param_ftu_brk
  Where id_tarif=@iIdTarif
  
Go 

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :        
-- Commentaires         :       Update sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_U01_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_U01_PARAM_FTU_BRK
	@iIdTarif int,
	@sAltActif char(1),
	@sTypMtPivot varchar(6),
	@sHttcPivot varchar(6),
	@dcMtPivot decimal(11,2),
	@sTypetuste varchar(6),
	@iPeriodeCplt int,
	@sPeriodeCpltUnt char(1),
	@sTypeDecote varchar(6),
	@dcMtDecote decimal(11,2),
	@sHttcDecote varchar(6),
	@dcPctDecote decimal(11,2),
	@dcMtForfaitaire decimal(11,2),
	@sHttcForfait varchar(6),
	@sIdFourForfait varchar(3),
	@dcTva decimal(11,5),
	@sParamCplt varchar(255),
	@sMajPar char(4)
As

UPDATE sysadm.param_ftu_brk
   SET alt_actif = @sAltActif,
      typ_mt_pivot = @sTypMtPivot,
      httc_pivot = @sHttcPivot,
      mt_pivot = @dcMtPivot,
      typ_vetuste = @sTypetuste,
      per_cplt = @iPeriodeCplt,
      per_cplt_ut = @sPeriodeCpltUnt,
      typ_decote = @sTypeDecote,
      mt_decote = @dcMtDecote,
      httc_decote = @sHttcDecote, 
      tx_decote = @dcPctDecote,
      mt_forfaitaire = @dcMtForfaitaire,
      httc_forfait = @sHttcForfait,
      id_four_forfait = @sIdFourForfait,
      tx_tva = @dcTva,
      param_cplt = @sParamCplt,
      maj_le = getdate(),
      maj_par = @sMajPar
 WHERE id_tarif=@iIdTarif
Go


--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       15/03/2011
-- Libellé              :        
-- Commentaires         :       Insert sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_I01_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_I01_PARAM_FTU_BRK
	@iIdTarif int OUTPUT,
	@dcIdProd decimal(7,0),
	@dcIdRev decimal(7,0),
	@sAltActif char(1),
	@dcIdGti decimal(7,0),
	@sIdFour varchar(3),
	@iIdMethode int,
	@sIdBrk varchar(6),
	@sIdTypArt varchar(6),
	@dtDteDebEff datetime,
	@dtDteFinEff datetime,
	@sTypEff varchar(6),
	@sTypMtPivot varchar(6),
	@sHttcPivot varchar(6),
	@dcMtPivot decimal(11,2),
	@sTypetuste varchar(6),
	@iPeriodeCplt int,
	@sPeriodeCpltUnt char(1),
	@sTypeDecote varchar(6),
	@dcMtDecote decimal(11,2),
	@sHttcDecote varchar(6),
	@dcPctDecote decimal(11,2),
	@dcMtForfaitaire decimal(11,2),
	@sHttcForfait varchar(6),
	@sIdFourForfait varchar(3),
	@dcTva decimal(11,5),
	@sParamCplt varchar(255),
	@sMajPar char(4)
As
Declare @iRet int

INSERT INTO sysadm.param_ftu_brk
           (id_prod,id_rev,alt_actif,id_gti,
           id_four,id_methode,id_brk,id_typ_art,
           dte_deb_eff,dte_fin_eff,typ_eff,
           typ_mt_pivot,httc_pivot,mt_pivot,
           typ_vetuste,per_cplt,per_cplt_ut,
           typ_decote,mt_decote,httc_decote,tx_decote,
           mt_forfaitaire,httc_forfait,id_four_forfait,
           tx_tva,param_cplt,
           cree_le,maj_le,maj_par)
VALUES (@dcIdProd, @dcIdRev, @sAltActif, @dcIdGti,
	@sIdFour, @iIdMethode, @sIdBrk, @sIdTypArt,
	@dtDteDebEff, @dtDteFinEff, @sTypEff,
	@sTypMtPivot, @sHttcPivot, @dcMtPivot,
	@sTypetuste, @iPeriodeCplt, @sPeriodeCpltUnt,
	@sTypeDecote, @dcMtDecote, @sHttcDecote, @dcPctDecote,
	@dcMtForfaitaire, @sHttcForfait, @sIdFourForfait,
	@dcTva, @sParamCplt,
	getdate(), getdate(),@sMajPar)

Select @iIdTarif = @@IDENTITY, @iRet=@@ERROR

If @iRet <> 0 Set @iIdTarif=NULL

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S08_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       01/04/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour l'export des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S08_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S08_PARAM_FTU_BRK
As
  select id_tarif, id_prod, id_rev, alt_actif, id_gti, 
	id_four, id_methode, id_brk, id_typ_art, 
	dte_deb_eff, dte_fin_eff, typ_eff, 
	typ_mt_pivot, httc_pivot, mt_pivot, 
	typ_vetuste, per_cplt, per_cplt_ut, 
	typ_decote, mt_decote, httc_decote, tx_decote, 
	mt_forfaitaire, httc_forfait, id_four_forfait, 
	tx_tva, param_cplt, cree_le, maj_le, maj_par
  from sysadm.param_ftu_brk
  order by id_tarif

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S09_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       11/04/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S09_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S09_PARAM_FTU_BRK

AS
Select distinct
	po.id_police,
	po.lib_police
From 	sysadm.param_ftu_brk pfb
  inner join sysadm.garantie g on g.id_prod=pfb.id_prod 
  inner join sysadm.police po on g.id_police=po.id_police
Where (pfb.id_rev=-1 or g.id_rev=pfb.id_rev)
	and (pfb.id_gti=-1 or g.id_gti=pfb.id_gti)
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_PARAM_FTU_BRK_V03
-- Auteur               :       Fabien PINON
-- Date                 :       08/06/2011
-- Libellé              :        ajout colonne marq+modele
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_PARAM_FTU_BRK_V03' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S07_PARAM_FTU_BRK_V03
GO

CREATE procedure sysadm.DW_S07_PARAM_FTU_BRK_V03
	@iIdTarif int
As
  Select id_tarif, id_prod, id_rev, 
    alt_actif, id_gti, id_four, id_methode,
    id_brk, id_typ_art,
    id_marq_art, id_modl_art, 
    dte_deb_eff, dte_fin_eff, typ_eff, 
    typ_mt_pivot, httc_pivot, mt_pivot, 
    typ_vetuste, per_cplt, per_cplt_ut, 
    typ_decote, mt_decote, httc_decote, tx_decote,
    mt_forfaitaire, httc_forfait, id_four_forfait,
    tx_tva, param_cplt, 
    cree_le, maj_le, maj_par,
    'N' as alt_reinit,
    'N' as alt_mode_creat,
    Case When dte_deb_eff='01/01/1980' and dte_fin_eff='01/01/3000' and typ_eff='DTESRV' Then 'O'
    Else 'N' End as alt_sans_validite,
    Case When dte_fin_eff='01/01/3000' Then 'O'
    Else 'N' End as alt_sans_fin_valide
  From sysadm.param_ftu_brk
  Where id_tarif=@iIdTarif
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S08_PARAM_FTU_BRK_V01
-- Auteur               :       Fabien PINON
-- Date                 :       08/06/2011
-- Libellé              :       Ajout de colonnes
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour l'export des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_PARAM_FTU_BRK_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S08_PARAM_FTU_BRK_V01
GO

CREATE procedure sysadm.DW_S08_PARAM_FTU_BRK_V01
As
  select id_tarif, id_prod, id_rev, alt_actif, id_gti, 
	id_four, id_methode, id_brk, id_typ_art, 
	id_marq_art, id_modl_art,
	dte_deb_eff, dte_fin_eff, typ_eff, 
	typ_mt_pivot, httc_pivot, mt_pivot, 
	typ_vetuste, per_cplt, per_cplt_ut, 
	typ_decote, mt_decote, httc_decote, tx_decote, 
	mt_forfaitaire, httc_forfait, id_four_forfait, 
	tx_tva, param_cplt, cree_le, maj_le, maj_par
  from sysadm.param_ftu_brk
  order by id_tarif

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S08_PARAM_FTU_BRK_V02
-- Auteur               :       Fabien PINON
-- Date                 :       25/09/2012
-- Libellé              :       Ajout de colonnes
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour l'export des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_PARAM_FTU_BRK_V02' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S08_PARAM_FTU_BRK_V02
GO

CREATE procedure sysadm.DW_S08_PARAM_FTU_BRK_V02
As
  select id_tarif, id_prod, sysadm.FN_LIB_PROD ( id_prod ) as lib_prod, id_rev, alt_actif, id_gti, 
	id_four, id_methode, id_brk, id_typ_art, 
	id_marq_art, id_modl_art,
	dte_deb_eff, dte_fin_eff, typ_eff, 
	typ_mt_pivot, httc_pivot, mt_pivot, 
	typ_vetuste, per_cplt, per_cplt_ut, 
	typ_decote, mt_decote, httc_decote, tx_decote, 
	mt_forfaitaire, httc_forfait, id_four_forfait, 
	tx_tva, param_cplt, cree_le, maj_le, maj_par
  from sysadm.param_ftu_brk
  order by id_tarif

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_FTU_BRK_V01
-- Auteur               :       Fabien PINON
-- Date                 :       08/06/2011
-- Libellé              :       Ajout des colonnes marque/modele
-- Commentaires         :       Insert sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre traitement des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_FTU_BRK_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_I01_PARAM_FTU_BRK_V01
GO

CREATE procedure sysadm.DW_I01_PARAM_FTU_BRK_V01
	@iIdTarif int OUTPUT,
	@dcIdProd decimal(7,0),
	@dcIdRev decimal(7,0),
	@sAltActif char(1),
	@dcIdGti decimal(7,0),
	@sIdFour varchar(3),
	@iIdMethode int,
	@sIdBrk varchar(6),
	@sIdTypArt varchar(6),
	@sIdMarqArt varchar(35),
	@sIdModlArt varchar(35),
	@dtDteDebEff datetime,
	@dtDteFinEff datetime,
	@sTypEff varchar(6),
	@sTypMtPivot varchar(6),
	@sHttcPivot varchar(6),
	@dcMtPivot decimal(11,2),
	@sTypetuste varchar(6),
	@iPeriodeCplt int,
	@sPeriodeCpltUnt char(1),
	@sTypeDecote varchar(6),
	@dcMtDecote decimal(11,2),
	@sHttcDecote varchar(6),
	@dcPctDecote decimal(11,2),
	@dcMtForfaitaire decimal(11,2),
	@sHttcForfait varchar(6),
	@sIdFourForfait varchar(3),
	@dcTva decimal(11,5),
	@sParamCplt varchar(255),
	@sMajPar char(4)
As
Declare @iRet int

INSERT INTO sysadm.param_ftu_brk
           (id_prod,id_rev,alt_actif,id_gti,
           id_four,id_methode,id_brk,id_typ_art,
	   id_marq_art, id_modl_art,
           dte_deb_eff,dte_fin_eff,typ_eff,
           typ_mt_pivot,httc_pivot,mt_pivot,
           typ_vetuste,per_cplt,per_cplt_ut,
           typ_decote,mt_decote,httc_decote,tx_decote,
           mt_forfaitaire,httc_forfait,id_four_forfait,
           tx_tva,param_cplt,
           cree_le,maj_le,maj_par)
VALUES (@dcIdProd, @dcIdRev, @sAltActif, @dcIdGti,
	@sIdFour, @iIdMethode, @sIdBrk, @sIdTypArt,
	@sIdMarqArt,@sIdModlArt,
	@dtDteDebEff, @dtDteFinEff, @sTypEff,
	@sTypMtPivot, @sHttcPivot, @dcMtPivot,
	@sTypetuste, @iPeriodeCplt, @sPeriodeCpltUnt,
	@sTypeDecote, @dcMtDecote, @sHttcDecote, @dcPctDecote,
	@dcMtForfaitaire, @sHttcForfait, @sIdFourForfait,
	@dcTva, @sParamCplt,
	getdate(), getdate(),@sMajPar)

Select @iIdTarif = @@IDENTITY, @iRet=@@ERROR

If @iRet <> 0 Set @iIdTarif=NULL

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S10_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       10/06/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S10_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S10_PARAM_FTU_BRK

AS
Select distinct
	Case When pfb.id_marq_art	='-1' Then 1 
	Else 2 End as tri,
	Case When pfb.id_marq_art	='-1' Then '-1'
	Else pfb.id_marq_art End as id_marq_art,
	Case When pfb.id_marq_art	='-1' Then 'Pour toute marque'
	Else pfb.id_marq_art End as lib_marq_art
From 	sysadm.param_ftu_brk pfb
Union Select 1,'-1','Pour toute marque'
order by tri
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S11_PARAM_FTU_BRK
-- Auteur               :       Fabien PINON
-- Date                 :       10/06/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_PARAM_FTU_BRK' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S11_PARAM_FTU_BRK
GO

CREATE procedure sysadm.DW_S11_PARAM_FTU_BRK

AS
Select distinct
	Case When pfb.id_modl_art	='-1' Then 1 
	Else 2 End as tri,
	Case When pfb.id_modl_art	='-1' Then '-1'
	Else pfb.id_modl_art End as id_modl_art,
	Case When pfb.id_modl_art	='-1' Then 'Pour tout modèle'
	Else pfb.id_modl_art End as lib_modl_art
From 	sysadm.param_ftu_brk pfb
Union Select 1,'-1','Pour tout modèle'
order by tri

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_PARAM_FTU_BRK_V01
-- Auteur               :       Fabien PINON
-- Date                 :       10/06/2011
-- Libellé              :       Ajout des arg marq & modele 
-- Commentaires         :       Select sur la table PARAM_FTU_BRK
-- Références           :       Pour la fenêtre accueil des param_ftu_brk
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_PARAM_FTU_BRK_V01' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S06_PARAM_FTU_BRK_V01
GO

CREATE procedure sysadm.DW_S06_PARAM_FTU_BRK_V01
  @iIdTarif	Int,
  @iIdProd	Decimal(7,0),
  @iIdGti	Decimal(7,0),
  @sIdBrk	Varchar(6),
  @sIdCodeArt	Varchar(6),
  @sIdMarqArt	Varchar(35),
  @sIdModlArt	Varchar(35),
  @iIdCie	Decimal(7,0),
  @iIdPolice	Decimal(7,0)
  
AS
Select pfb.id_tarif, pfb.id_prod, pfb.alt_actif, pfb.id_gti, pfb.id_brk, pfb.id_typ_art, 
	dte_deb_eff,dte_fin_eff,typ_eff, typ_vetuste
From 	sysadm.param_ftu_brk pfb
Where 	(@iIdTarif is null or pfb.id_tarif=@iIdTarif)
  and  (@iIdProd is null or pfb.id_prod=@iIdProd)
  and  (@iIdGti is null or pfb.id_gti=@iIdGti)
  and  (@sIdBrk is null or pfb.id_brk=@sIdBrk)
  and  (@sIdCodeArt is null or pfb.id_typ_art=@sIdCodeArt)
  and  (@sIdMarqArt is null or pfb.id_marq_art=@sIdMarqArt)
  and  (@sIdModlArt is null or pfb.id_modl_art=@sIdModlArt)
  and (@iIdCie is null or 
    exists (select po.id_cie 
		from sysadm.garantie g 
		inner join sysadm.police po on g.id_police=po.id_police
		where g.id_prod=pfb.id_prod 
			and (g.id_rev=pfb.id_rev or pfb.id_rev=-1) 
			and (g.id_gti=pfb.id_gti or pfb.id_gti=-1)
			and po.id_cie=@iIdCie)
	)
  and (@iIdPolice is null or 
    exists (select g.id_police
		from sysadm.garantie g 
		where g.id_prod=pfb.id_prod 
			and (g.id_rev=pfb.id_rev or pfb.id_rev=-1) 
			and (g.id_gti=pfb.id_gti or pfb.id_gti=-1)
			and g.id_police=@iIdPolice)
	)
Go
