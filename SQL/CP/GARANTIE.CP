-------------------------------------------------------------------
--
-- Fichier              :  Garantie.cp
-- Auteur               :  V.Capelle
-- Date                 :  05/11/1997 10:59:52
--
-- Commentaires         :  Liste des procédures stokées afférant à la 
--                         table des garanties
--
-- Procédures           :  DW_S01_GARANTIE
--                         DW_S02_GARANTIE_SIN
--                         DW_I01_GARANTIE
--                         DW_D01_GARANTIE
--			   DW_S02_GARANTIE
--			   IM_S01_GARANTIE
--			   DW_S03_GARANTIE : CAG 15/07/2004 DCMP 030381
--			   DD_S01_PREFIXE : #1
--				DW_S04_GARANTIE : FPI - 28/10/2009 [EXPANSION5.LIB_POLICE]
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :   DD_S01_PREFIXE
-- Auteur               :   PHG, sur une idée originale de JCA :)
-- Date                 :   26/05/2008
-- Libellé              :   Sélection des préfixes
-- Commentaires         :	
-- Références           :   [DCMP070914], w_tm_sp_Garantie, dw_sp_garantie
--
-- Arguments            :   
-- Retourne             :   ResultSet
--				  
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_PREFIXE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_PREFIXE
GO

CREATE PROC sysadm.DD_S01_PREFIXE
AS

SELECT  NULL as id_code, 'Pas de Préfixe' as lib_code, convert(varchar(6), c.id_code) as id_cie
FROM	sysadm.code c
WHERE	c.id_typ_code  = '-AI' and c.id_code <> -1
UNION
SELECT 	cc.id_code,
	cc.lib_code,
	c.id_code as id_cie
FROM 	sysadm.code_car cc CROSS JOIN sysadm.code c
WHERE	cc.id_typ_code = '-PX'
and	( c.id_typ_code  = '-AI' and c.id_code <> -1 )
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S01_GARANTIE
-- Auteur               :   V.Capelle
-- Date                 :   05/11/1997 10:52:33
-- Libellé              :   Sélection d'une garantie
-- Commentaires         :	
-- Références           :   w_tm_sp_Garantie, dw_sp_garantie
--
-- Arguments            :   @dcIdProd     decimal ( 7, 0 )    Produit
--                          @dcIdRev      decimal ( 7, 0 )    Révision
--                          @dcIdGti      decimal ( 7, 0 )    Garantie
-- Retourne             :   ResultSet
--				  
-- #1	DCMP 70914	JCA	30/04/2008	Ajout d'un prefixe assureur pour les assureurs 6, 48, 75, 76
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_GARANTIE
GO

CREATE PROC sysadm.DW_S01_GARANTIE
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 )
AS

SELECT  sysadm.garantie.id_prod,
        sysadm.garantie.id_rev,
        sysadm.garantie.id_gti,
        sysadm.garantie.id_police,
        sysadm.garantie.cod_radical,
        sysadm.garantie.cod_typ_fra,
        sysadm.garantie.alt_plaf,
        sysadm.garantie.alt_del,
        sysadm.garantie.alt_fran,
        sysadm.garantie.cree_le,   
        sysadm.garantie.maj_le,   
        sysadm.garantie.maj_par,
	sysadm.garantie.id_prefixe -- #1
FROM    sysadm.garantie
WHERE   sysadm.garantie.id_prod = @dcIdProd and
        sysadm.garantie.id_rev  = @dcIdRev  and
        sysadm.garantie.id_gti  = @dcIdGti
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_GARANTIE_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table GARANTIE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                      :       @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_GARANTIE_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S02_GARANTIE_SIN
GO

CREATE procedure sysadm.DW_S02_GARANTIE_SIN
        @dcIdProd       decimal ( 7, 0 )       ,
        @dcIdRev        decimal ( 7, 0 )
AS
 SELECT garantie.id_prod,
        garantie.id_rev,
        garantie.id_gti,
        garantie.id_police,
        garantie.cod_typ_fra,
        garantie.alt_plaf,
        garantie.alt_del,
        garantie.alt_fran,
        garantie.cree_le,
        garantie.maj_le,
        garantie.maj_par
 FROM   sysadm.garantie
 WHERE  garantie.id_prod        = @dcIdProd     AND
        garantie.id_rev         = @dcIdRev

GO

--------------------------------------------------------------------
--
-- Procédure     :   DW_I01_GARANTIE
-- Auteur        :   V.Capelle
-- Date          :   05/11/1997 10:54:10
-- Libellé       :   Insertion d'une garantie
-- Commentaires  :	
-- Références    :   w_td_sp_garantie, dw_1, SqlPreview
--
-- Arguments     :  @dcIdProd     decimal ( 7, 0 ),
--                  @dcIdRev      decimal ( 7, 0 ),
--                  @dcIdGti      decimal ( 7, 0 ),
--                  @dcIdPolice   decimal ( 7, 0 ),
--                  @dcCodTypFra  decimal ( 7, 0 ),
--		    @dcCodRadical decimal ( 7, 0 ),
--                  @sAltPlaf     Varchar(1),
--                  @sAltDel      Varchar(1),
--                  @sAltFran     Varchar(1),
--                  @dtCreeLe     DateTime,
--                  @dtMajLe      DateTime,
--                  @sMajPar      Varchar(4),
--		    @sIdPrefixe   Varchar(2)
--
-- Retourne      :  Rien
--				  
--------------------------------------------------------------------
-- MAJ	PAR	Le		Description
-- #1 	PHG	11/08/2008	Correction Bug Id_prefixe AIG

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_GARANTIE
GO

CREATE PROC sysadm.DW_I01_GARANTIE
       @dcIdProd     decimal ( 7, 0 ),
       @dcIdRev      decimal ( 7, 0 ),
       @dcIdGti      decimal ( 7, 0 ),
       @dcIdPolice   decimal ( 7, 0 ),
       @dcCodTypFra  decimal ( 7, 0 ),
       @dcCodRadical decimal ( 7, 0 ),
       @sAltPlaf     Varchar(1),
       @sAltDel      Varchar(1),
       @sAltFran     Varchar(1),
       @dtCreeLe     DateTime,
       @dtMajLe      DateTime,
       @sMajPar      Varchar(4),
       @sIdPrefixe   Varchar(2) -- #1 PHG le 11/08/2008, Correction Bug Id_prefixe AIG

AS

INSERT INTO sysadm.garantie 
       ( id_prod, id_rev, id_gti, id_police, 
         cod_typ_fra,  alt_plaf, alt_del, alt_fran, cod_radical, cree_le, maj_le ,  maj_par,
	 id_prefixe ) -- #1 PHG le 11/08/2008, Correction Bug Id_prefixe AIG
VALUES ( @dcIdProd, @dcIdRev, @dcIdGti, @dcIdPolice, @dcCodTypFra, @sAltPlaf,
         @sAltDel, @sAltFran, @dcCodRadical, @dtCreeLe, @dtMajLe, @sMajPar,
	 @sIdPrefixe ) -- #1 PHG le 11/08/2008, Correction Bug Id_prefixe AIG


GO

--------------------------------------------------------------------
--
-- Procédure     :   IM_S01_GARANTIE
-- Auteur        :   V.Capelle
-- Date          :   05/11/1997 14:45:15
-- Libellé       :   Vérifie que l'identifiant de la garantie qui
--									va être créée n'existe pas déjà
-- Commentaires  :	
-- Références    :   u_sp_gs_garantie, uf_ControlerGestion ()
--
-- Arguments     :   @dcIdProd    decimal ( 7, 0 ),
--                   @dcIdRev     decimal ( 7, 0 ),
--                   @dcIdGti     decimal ( 7, 0 )
--            
-- Retourne      :   @dcIdGtiRech decimal ( 7, 0 )   Valeur de l'identifiant de 
--                                          la garantie ou rien 				                    
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_GARANTIE' AND type = 'P' )
           DROP procedure sysadm.IM_S01_GARANTIE
GO

CREATE PROC sysadm.IM_S01_GARANTIE
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @dcIdGtiRech decimal ( 7, 0 ) OUTPUT
AS

SELECT @dcIdGtiRech            = sysadm.garantie.id_gti
FROM   sysadm.garantie
WHERE  sysadm.garantie.id_prod = @dcIdProd AND
       sysadm.garantie.id_rev  = @dcIdRev  AND
       sysadm.garantie.id_gti  = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Procédure     :   DW_D01_GARANTIE
-- Auteur        :   V.Capelle
-- Date          :   05/11/1997 10:56:08
-- Libellé       :   Suppression d'une garantie
-- Commentaires  :   W_tm_sp_garantie, dw_1, SQLPREVIEW
-- Références    :	
-- Arguments     :  @dcIdProd	decimal ( 7, 0 ),
--                  @dcIdRev    decimal ( 7, 0 ),
--                  @dcIdGti    decimal ( 7, 0 )
--
-- Retourne      :  Rien
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_D01_GARANTIE
GO

CREATE PROC sysadm.DW_D01_GARANTIE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 ),
            @dcIdGti   decimal ( 7, 0 )
AS

  /* Suppression des lignes dans la table AFFILIER */
  EXECUTE sysadm.IM_D01_AFFILIER @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table PIECE */
  EXECUTE sysadm.IM_D02_PIECE @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table MOTIF */
  EXECUTE sysadm.IM_D02_MOTIF @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table FRANCHISE */
  EXECUTE sysadm.IM_D03_FRANCHISE @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table PLAFOND */
  EXECUTE sysadm.IM_D03_PLAFOND @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table DELAI */
  EXECUTE sysadm.IM_D03_DELAI @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table CONDITION */
  EXECUTE sysadm.IM_D03_CONDITION @dcIdProd, @dcIdRev, @dcIdGti

  IF @@ERROR <> 0
    BEGIN
     RETURN
    END


  /* Suppression des lignes dans la table GARANTIE */
  DELETE FROM  sysadm.garantie
         WHERE sysadm.garantie.id_prod = @dcIdProd   AND
               sysadm.garantie.id_rev  = @dcIdRev    AND
               sysadm.garantie.id_gti  = @dcIdGti

GO



--------------------------------------------------------------------
--
-- Procédure     :   DW_S02_GARANTIE
-- Auteur        :   Fabry JF
-- Date          :   11/06/1999 10:56:08
-- Libellé       :   Select 
-- Commentaires  :   Le group by sur cette requˆte est extrˆment important
--		     Ne jamais le supprimer.
-- Références    :  W_RL_SP_REL1_AUTO	
-- Arguments     :  @dcIdProd	decimal ( 7, 0 ),
--
-- Retourne      :  Rien
--				  
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_GARANTIE' AND type = 'P' )
           DROP procedure sysadm.DW_S02_GARANTIE
GO

CREATE PROC sysadm.DW_S02_GARANTIE
        @dcIdProd    Decimal ( 7,0 )
AS

select	gar.id_prod, 
       	gar.id_rev,
	pol.lib_police,
	cie.lib_cie

from 	sysadm.garantie   gar,
	sysadm.police	  pol,
     	sysadm.compagnie  cie

Where 	id_prod 	= @dcIdProd
and   	pol.id_police 	= gar.id_police
and	cie.id_cie	= pol.id_cie

Group by gar.id_prod, gar.id_rev, pol.lib_police, cie.lib_cie

GO

--------------------------------------------------------------------
--
-- Procédure     :   DW_S03_GARANTIE
-- Auteur        :   Abdmeziem Catherine
-- Date          :   15/07/2004
-- Libellé       :   DCMP 030381
-- Commentaires  :   
-- Références    :  D_SP_SIN_POL_ASS
-- Arguments     :  @dcIdProd	decimal ( 7, 0 ),
--		    @dcIdRev	decimal ( 7, 0 )
--
-- Retourne      :  Rien
--				  
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_GARANTIE' AND type = 'P' )
           DROP procedure sysadm.DW_S03_GARANTIE
GO

CREATE PROC sysadm.DW_S03_GARANTIE
        @dcIdProd    Decimal ( 7, 0 ),
        @dcIdRev     Decimal ( 7, 0 )
AS

select	gar.id_prod,
	gar.id_rev,
	gar.id_gti,
	cg.lib_code,
       	gar.id_police,
	pol.lib_police,
	pol.id_cie,
	cie.lib_cie
from 	sysadm.garantie   gar,
	sysadm.police	  pol,
     	sysadm.compagnie  cie,
     	sysadm.code	  cg

Where 	id_prod 	= @dcIdProd
  And	id_rev		= @dcIdRev
  And   pol.id_police 	= gar.id_police
  And	cie.id_cie	= pol.id_cie
  And	cg.id_typ_code  = "-GA"
  And	cg.id_code	= gar.id_gti

GO

--------------------------------------------------------------------
--
-- Procédure     :   DW_S04_GARANTIE
-- Auteur        :   FPI
-- Date          :   28/10/2009
-- Libellé       :   [EXPANSION5.LIB_POLICE]
-- Commentaires  :   
-- Références    :  
-- Arguments     :  @dcIdProd	decimal ( 7, 0 ),
--		    @dcIdRev	decimal ( 7, 0 )
--			@sCodBoutique	Varchar(20)
--
-- Retourne      : 
--				  
--------------------------------------------------------------------
-- 		FPI	   01/08/2012  [VDoc7726]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_GARANTIE' AND type = 'P' )
           DROP procedure sysadm.DW_S04_GARANTIE
GO

CREATE PROC sysadm.DW_S04_GARANTIE
        @dcIdProd    Decimal ( 7, 0 ),
        @dcIdRev     Decimal ( 7, 0 ),
	@sCodBoutique	Varchar(20)
AS
DECLARE @sValCar varchar(255),
	@sConcat varchar(1),
	@sLibPolice varchar(35)

Set @sValCar=NULL
Set @sLibPolice=''

select @sValCar=RTrim(d.val_car)
from   sysadm.det_pro d
where  d.id_prod = @dcIdProd
and    d.id_code_dp=124

If @sValCar is Not Null
Begin
  -- Récupération du libellé depuis l'id_boutique
  Select @sConcat   = sysadm.FN_CLE_VAL('ALT_CONCAT',@sValCar,';'),
	 @sLibPolice = RTrim(boutique.lib_police)
  From sysadm.boutique
  Where id_prod = @dcIdProd
  and   cod_mag = @sCodBoutique
  And sysadm.FN_CLE_VAL( 'FRN',region,  ';') <> 'PSM' -- [VDOC7726]
  
  If @@RowCount = 0 Set @sConcat=NULL
  If @sLibPolice is null Set @sLibPolice=''
End 

select	gar.id_prod,
	gar.id_rev,
	gar.id_gti,
	cg.lib_code,
       	gar.id_police,
	case @sConcat 
	  When 'O' Then RTrim(pol.lib_police) + @sLibPolice
	  When 'N' Then @sLibPolice
	  Else pol.lib_police End as lib_police,
	pol.id_cie,
	cie.lib_cie
from 	sysadm.garantie   gar,
	sysadm.police	  pol,
     	sysadm.compagnie  cie,
     	sysadm.code	  cg

Where 	gar.id_prod 	= @dcIdProd
  And	gar.id_rev	= @dcIdRev
  And   pol.id_police 	= gar.id_police
  And	cie.id_cie	= pol.id_cie
  And	cg.id_typ_code  = '-GA'
  And	cg.id_code	= gar.id_gti

GO

--------------------------------------------------------------------
--
-- Procédure     :   PS_S_GTI_COUVERTE_SUR_REV
-- Auteur        :   JFF
-- Date          :   28/08/2022
-- Libellé       :   
-- Commentaires  :   [RS3552]
-- Références    :  
-- Arguments     :  
--
-- Retourne      : 
--				  
--------------------------------------------------------------------
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_GTI_COUVERTE_SUR_REV' AND type = 'P' )
           DROP procedure sysadm.PS_S_GTI_COUVERTE_SUR_REV
GO

CREATE PROC sysadm.PS_S_GTI_COUVERTE_SUR_REV
        @dcIdProd    Decimal ( 7, 0 ),
        @dcIdRev     Decimal ( 7, 0 ),
		@dcIdGti	 Decimal ( 7, 0 )
AS

If Exists ( 
	Select Top 1 1 
	From sysadm.garantie g
	Where g.id_prod = @dcIdProd
	and   g.id_rev = @dcIdRev
	And   g.id_gti = @dcIdGti
  )
  Begin 
	Return 1 -- Le bione id_prod/id_rev couvre la gti
  End

Return 0 -- Le bione id_prod/id_rev ne couvre pas la gti par défaut

Go
