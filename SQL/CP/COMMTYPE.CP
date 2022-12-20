-------------------------------------------------------------------
--
-- Fichier              :       COMMANDE_TYPE.CP
-- Auteur               :       Fabry Jf
-- Date                 :       18/10/01
--
-- Commentaires         :       Gestion de la table COMMANDE_TYPE
--
-- Procédures           :       DW_S01_COMMANDE_TYPE
--				PS_S02_COMMANDE_TYPE // DCMP 040206
--				PS_S01_GESTION_ECHANGE_FLUX_V00 
--				DW_S02_COMMANDE_TYPE
--				DW_S03_COMMANDE_TYPE
--				DW_S04_COMMANDE_TYPE
--				DW_S05_COMMANDE_TYPE
--				DW_S06_COMMANDE_TYPE
--				DW_S06_COMMANDE_TYPE_V01
--				DW_S07_COMMANDE_TYPE
--				DW_S08_COMMANDE_TYPE
--				DW_S09_COMMANDE_TYPE
--				DW_S10_COMMANDE_TYPE
--				DW_S11_COMMANDE_TYPE
--				DW_S12_COMMANDE_TYPE
--				PS_D01_COMMANDE_TYPE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_COMMANDE_TYPE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des commandes
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-- JFF  22/03/2006  Ajout du Union.
-- JFF      02/03/2015   [PM289_CDP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S01_COMMANDE_TYPE
        @dcIdProd        Decimal (  7, 0 )
AS

Select
	id_prod,                        
	id_gti,                         
	id_code_frn,                    
	id_code_art,                    
	alt_code_def,                   
	0,
	'O',
	id_typ_code,
	id_code
From 	sysadm.commande_type
where 	id_prod = @dcIdProd
And		id_code_frn not in ( 'CDA' ) -- [PM289_CDP]
Union
Select
	id_prod,                        
	0,                         
	'TOUS FOURNISSEURS',                    
	'-1',                    
	'O',                   
	0,
	'N',
	'-XX',
	-1
From 	sysadm.commande_type
where 	id_prod = @dcIdProd
And		id_code_frn not in ( 'CDA' ) -- [PM289_CDP]

GO



--------------------------------------------------------------------
--
-- Procédure            :       PS_S02_COMMANDE_TYPE
-- Auteur               :       Fabry JF
-- Date                 :       07/09/01
-- Libellé              :        
-- Commentaires         :       Peut-on régler de façon automatique sur ce produit/gti/fourn/commande ?
-- Références           :       Pour choix des commandes
--
-- Arguments            :       @dcIdSin        Decimal (  7, 0 ),
--        			@lIdSeq         Integer ,
--			        @sIdFour        VarChar ( 3 ),
--        			@iRetour        Integer OUTPUT
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.PS_S02_COMMANDE_TYPE
GO

CREATE procedure sysadm.PS_S02_COMMANDE_TYPE
        @dcIdSin        Decimal (  10, 0 ), -- [PI062]
        @lIdSeq         Integer ,
        @sIdFour        VarChar ( 3 ),
        @iRetour        Integer OUTPUT
AS

Select  @iRetour = IsNull ( Count (*), 0 )

From 	sysadm.sinistre s
	INNER JOIN sysadm.commande cm	   On  cm.id_sin = s.id_sin 
					   And cm.id_seq = @lIdSeq
	INNER JOIN sysadm.commande_type ct On  ct.id_prod = s.id_prod 
					   And ct.id_gti  = cm.id_gti
					   And ct.id_code_art = cm.id_typ_art
					   
Where   s.id_sin = @dcIdSin
And	ct.id_code_frn = @sIdFour
And 	ct.id_typ_code = '-DP'
And 	ct.id_code = 23
And  	( 

	  (     cm.id_four      = 'ANV' 
	    and cm.info_spb_frn = 110  -- Le client envoi son mobile 
	  ) 
	  
	Or 
	
               
	  (     cm.id_four      = 'SBE' 
	    and cm.info_spb_frn = 210  -- Le client envoi son mobile 
	  )

	Or 
	
        --MADM 10/05/2006 Rempl du Frn AVM par COR[DCMP 060356]
        
	  (     cm.id_four      = 'COR' 
	    and cm.info_spb_frn = 310  -- Le client envoi son mobile 
	  )
	  
	)

-- Trt complèmentaire le 13/10/2005 JFF
If @iRetour = 0 
 Begin
  Select  @iRetour = IsNull ( Count (*), 0 )
  From    sysadm.commande cm
  Where   cm.id_sin = @dcIdSin
  And 	  cm.id_seq = @lIdSeq
  
  If @iRetour > 0 
    begin 
      Set @iRetour = 0 
    end 
  Else 
    begin 
      Set @iRetour = 1 
    end
 End

Go 


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_GESTION_ECHANGE_FLUX_V00
-- Auteur               :       JCA
-- Date                 :       06/02/2007
-- Libellé              :        
-- Commentaires         :       Select sur la table COMMANDE_TYPE
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       @iRet
-- 
-- #1  JFF   [SITE_CMDE] Jointure avec Det_pro sur les options 79, 80, 81
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GESTION_ECHANGE_FLUX_V00' And type = "P" )
DROP PROCEDURE sysadm.PS_S01_GESTION_ECHANGE_FLUX_V00
GO

CREATE PROCEDURE sysadm.PS_S01_GESTION_ECHANGE_FLUX_V00
	@dcIdProd decimal ( 7, 0 )
AS

DECLARE @iRet integer
SET 	@iRet = 0

SELECT	@iRet = count (*)
FROM	sysadm.commande_type ct,
	det_pro dp -- #1
WHERE	ct.id_prod = @dcIdProd
AND     ct.id_prod = dp.id_prod  -- #1
AND     dp.id_code_dp in ( 79, 80, 81 )  --#1

RETURN @iRet

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       20/10/2009
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_frais
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--       JFF    26/11/2012  [PC877]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S02_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S02_COMMANDE_TYPE
        @dcIdProd        Decimal (  7, 0 )
AS

	Select distinct
		ct.id_code_frn,
		c.lib_code as lib_four
	From 	sysadm.commande_type ct
	Inner join sysadm.code_car c on ct.id_code_frn = c.id_code and c.id_typ_code='-FR'
	where 	(ct.id_prod = @dcIdProd Or @dcIdProd = -1)
	and ct.id_code <> -1
	Order by ct.id_code_frn

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       20/10/2009
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_frais
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--								@sIdFour	 Char(3)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S03_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S03_COMMANDE_TYPE
        @dcIdProd        Decimal (  7, 0 ),
	@sIdFour	 Char(3)
AS

Select distinct
	ct.id_gti, 
	c.lib_code as lib_gti
From 	sysadm.commande_type ct
Inner join sysadm.code c on ct.id_gti = c.id_code and c.id_typ_code='-GA'
where 	(ct.id_prod = @dcIdProd Or @dcIdProd = -1)
and (ct.id_code_frn = @sIdFour or @sIdFour = '-1')
and ct.id_code <> -1
Order by ct.id_gti

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       20/10/2009
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_frais
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--								@sIdFour	 Char(3)
--
-- Retourne             :       Rien
--       JFF    26/11/2012  [PC877]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S04_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S04_COMMANDE_TYPE
    @dcIdProd        Decimal (  7, 0 ),
	@sIdFour	 Char(3),
	@dcIdGti        Decimal (  7, 0 )
AS

	Select distinct
		c.id_code as id_process, 
		c.lib_code as lib_process
	From 	sysadm.commande_type ct,
			sysadm.code c 
	where 	(ct.id_prod = @dcIdProd Or @dcIdProd = -1)
	and (ct.id_code_frn = @sIdFour or @sIdFour = '-1')
	and (ct.id_gti = @dcIdGti or @dcIdGti = -1)
	and convert(int,c.id_code) between (ct.id_code + 2) and (ct.id_code + 98)
	and c.id_typ_code='-IF'
	and ct.id_code <> -1
	Order by c.id_code
  
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       23/10/2009
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_frais
--
-- Arguments            :      
--
-- Retourne             :       Rien
--       JFF    26/11/2012  [PC877]
--		FPI		07/01/2014	[VDOC16435] - V01
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_COMMANDE_TYPE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S05_COMMANDE_TYPE_V01
GO

CREATE procedure sysadm.DW_S05_COMMANDE_TYPE_V01

AS

	Select distinct
		ct.id_prod,                        
		p.lib_long,
		CONVERT(varchar(7), ct.id_prod) + ' - ' + p.lib_long as lib_complet
	From 	sysadm.commande_type ct,
		sysadm.produit p 
	where 	ct.id_code_frn = 'O2M'
	and 	ct.id_prod = p.id_prod

GO

grant execute on sysadm.DW_S05_COMMANDE_TYPE_V01 to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :       [PM02]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--								@sIdFour	 Char(3)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S06_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S06_COMMANDE_TYPE
AS

Select distinct
	p.id_prod, 
	p.lib_long
From 	sysadm.commande_type ct
Inner join sysadm.produit p on ct.id_prod = p.id_prod
where 	ct.id_code_art in ('EDI','PRS')
	and ct.id_code > 0
Order by p.id_prod

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_COMMANDE_TYPE_V01
-- Auteur               :       Fabien PINON
-- Date                 :       29/06/2011
-- Libellé              :       [PM02]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--								@sIdFour	 Char(3)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_COMMANDE_TYPE_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S06_COMMANDE_TYPE_V01
GO

CREATE procedure sysadm.DW_S06_COMMANDE_TYPE_V01
AS

Select distinct
	p.id_prod, 
	p.lib_long,
	Case When d.id_prod is null Or (select count(*) from sysadm.param_ftu_brk pfb where pfb.id_prod=p.id_prod) = 0  Then 'NON' Else 'OUI' End as dp175
From 	sysadm.commande_type ct
Inner join sysadm.produit p on ct.id_prod = p.id_prod
left outer join sysadm.det_pro d on p.id_prod=d.id_prod and d.id_code_dp=175

where 	ct.id_code_art in ('EDI','PRS','AEF')
	and ct.id_code > 0
Order by p.id_prod

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :       [PM02]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--								@sIdFour	 Char(3)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S07_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S07_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 )
AS

Select distinct
	ct.id_prod, 
	ct.id_gti,
	cg.lib_gti
From 	sysadm.commande_type ct
inner join code_garantie cg on ct.id_prod=cg.id_prod and ct.id_gti=cg.id_gti
where 	ct.id_prod=@dcIdProd
	and ct.id_code_art in ('EDI','PRS')
	and ct.id_code > 0
Union
Select @dcIdProd, -1,'Toute garantie de ce produit'

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S08_COMMANDE_TYPE ---> Obsolète
-- Auteur               :       Fabien PINON
-- Date                 :       02/03/2011
-- Libellé              :       [PM02]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--				@dcIdGti        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S08_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S08_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S08_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 ),
	@dcIdGti        Decimal (  7, 0 )
AS

Select distinct
	ct.id_prod, 
	ct.id_gti,
	ct.id_code_frn,
	cc.lib_code
From 	sysadm.commande_type ct
Inner join code_car cc on cc.id_code=ct.id_code_frn
where 	cc.id_typ_code='-01'
  and ct.id_prod=@dcIdProd
  and (@dcIdGti = -1 or ct.id_gti=@dcIdGti) 
order by ct.id_code_frn
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S09_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       10/03/2011
-- Libellé              :       [PM02]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_ftu_brk
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--				@dcIdGti        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S09_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S09_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S09_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 ),
	@dcIdGti        Decimal (  7, 0 )
AS

Select distinct
	ct.id_prod, 
	c.id_code,
	c.lib_code
From 	sysadm.commande_type ct
inner join code_garantie cg on ct.id_prod=cg.id_prod and ct.id_gti=cg.id_gti
inner join code_car c on ct.id_code_frn=c.id_code
where 	ct.id_prod=@dcIdProd
	and (@dcIdGti = -1 or ct.id_gti=@dcIdGti)
	and ct.id_code_art in ('EDI','PRS')
	and ct.id_code > 0
	and c.id_typ_code='-FR'
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S10_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :       [PM95]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_alerte_frn
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S10_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S10_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S10_COMMANDE_TYPE
AS

Select distinct
	p.id_prod, 
	p.lib_long
From 	sysadm.commande_type ct
Inner join sysadm.produit p on ct.id_prod = p.id_prod
Inner join sysadm.code_car c on c.id_code=ct.id_code_frn
where 	c.id_typ_code='-10'
Order by p.id_prod

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S11_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :       [PM95]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_alerte_frn
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S11_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S11_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S11_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 )
AS

Select distinct
	ct.id_prod, 
	ct.id_gti,
	cg.lib_gti
From 	sysadm.commande_type ct
inner join code_garantie cg on ct.id_prod=cg.id_prod and ct.id_gti=cg.id_gti
Inner join sysadm.code_car c on c.id_code=ct.id_code_frn
where 	ct.id_prod=@dcIdProd
	and c.id_typ_code='-10'
Union
Select @dcIdProd, -1,'Toute garantie de ce produit'

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S12_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :       [PM95]
-- Commentaires         :       S‚lect sur la table COMMANDE_TYPE
-- Références           :       Pour choix des param_alerte_frn
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S12_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.DW_S12_COMMANDE_TYPE
GO

CREATE procedure sysadm.DW_S12_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 ),
	@dcIdGti         Decimal (  7, 0 )
AS

Select distinct
	ct.id_prod, 
	Case When @dcIdGti = -1 Then -1 Else ct.id_gti End as id_gti,
	ct.id_code_frn,
	cc.lib_code
From 	sysadm.commande_type ct
Inner join code_car cc on cc.id_code=ct.id_code_frn
where 	cc.id_typ_code='-10'
  and ct.id_prod=@dcIdProd
  and (@dcIdGti = -1 or ct.id_gti=@dcIdGti) 
Union
Select @dcIdProd, -1,'-1','Tous fournisseurs'
order by ct.id_code_frn

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_COMMANDE_TYPE
-- Auteur               :       Fabien PINON
-- Date                 :       28/12/2012
-- Libellé              :       [VDoc9112]
-- Commentaires         :       Suppression dans la table COMMANDE_TYPE
-- Références           :       Pour la fenêtre de recopie de produits
--
-- Arguments            :       @dcIdProd        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_COMMANDE_TYPE' AND type = 'P' )
        DROP procedure sysadm.PS_D01_COMMANDE_TYPE
GO

CREATE procedure sysadm.PS_D01_COMMANDE_TYPE
	@dcIdProd        Decimal (  7, 0 )
AS

Delete from sysadm.commande_type
Where id_prod=@dcIdProd

GO
