-------------------------------------------------------------------
--
-- Fichier              :       TRACE_PARAM_FRAIS.CP
-- Auteur               :       Fabien Pinon
-- Date                 :       20/10/2009
--
-- Commentaires         :       Gestion de la table TRACE_PARAM_FRAIS
--
-- Procédures           :       PS_I01_TRACE_PARAM_FRAIS
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_PARAM_FRAIS
-- Auteur               :       Fabien PINON
-- Date                 :       20/10/2009
-- Libellé              :        
-- Commentaires         :       Insert dans la table TRACE_PARAM_FRAIS
-- Références           :       
--
-- Arguments            :      
--
-- Retourne             :       
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_PARAM_FRAIS
GO

CREATE PROCEDURE PS_I01_TRACE_PARAM_FRAIS 
	@iIdSeq int,
	@dcIdProd decimal(7, 0) ,
	@sIdFour char (3) ,
	@iIdGti decimal(7, 0) ,
	@dcIdProcess decimal(7, 0) ,
	@dcPecSpb decimal(7, 2) ,
	@dcPecPresta decimal(7, 2) ,
	@dcPecAssureur decimal(7, 2) ,
	@dcMtRbt decimal(7, 2) ,
	@sAltProd char (1) ,
	@sTypModif char (1),
	@sMajPar char (4)
AS

  Declare @sIdFour_actuel char (3) ,
	@iIdGti_actuel decimal(7, 0) ,
	@dcIdProcess_actuel decimal(7, 0) ,
	@dcPecSpb_actuel decimal(7, 2) ,
	@dcPecPresta_actuel decimal(7, 2) ,
	@dcPecAssureur_actuel decimal(7, 2) ,
	@dcMtRbt_actuel decimal(7, 2) ,
	@sAltProd_actuel char (1) ,
	@sTypModif_actuel char (1)

  
  if @sTypModif = 'M' or @sTypModif = 'S'
  Begin
    Select @dcIdProd = id_prod,
	@sIdFour_actuel = id_four,
	@iIdGti_actuel = id_gti,
	@dcIdProcess_actuel = id_process,
	@dcPecSpb_actuel = cod_pec_spb,
	@dcPecPresta_actuel = cod_pec_presta,
	@dcPecAssureur_actuel = cod_pec_assureur,
	@dcMtRbt_actuel = mt_rbt,
	@sAltProd_actuel = alt_prod
    From sysadm.param_frais
    Where id_seq = @iIdSeq
  End 
 
  
  if @sTypModif = 'C' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, typ_modif, 
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour, @iIdGti, @dcIdProcess,
	@dcPecSpb, @dcPecPresta, @dcPecAssureur,
	@dcMtRbt, @sAltProd , @sTypModif, 
	getdate(),getdate(),@sMajPar)
  End

 if @sTypModif = 'S' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, typ_modif, 
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour_actuel, @iIdGti_actuel, @dcIdProcess_actuel,
	@dcPecSpb_actuel, @dcPecPresta_actuel, @dcPecAssureur_actuel,
	@dcMtRbt_actuel, @sAltProd_actuel , @sTypModif, 
	getdate(),getdate(),@sMajPar)
  End

 if @sTypModif = 'M' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, id_four_apres, id_gti_apres, id_process_apres, 
     cod_pec_spb_apres, cod_pec_presta_apres, cod_pec_assureur_apres, 
     mt_rbt_apres, alt_prod_apres, typ_modif, 
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour_actuel, @iIdGti_actuel, @dcIdProcess_actuel,
	@dcPecSpb_actuel, @dcPecPresta_actuel, @dcPecAssureur_actuel,
	@dcMtRbt_actuel, @sAltProd_actuel, @sIdFour, @iIdGti, @dcIdProcess,
	@dcPecSpb, @dcPecPresta, @dcPecAssureur,
	@dcMtRbt, @sAltProd , @sTypModif, 
	getdate(),getdate(),@sMajPar)
  End

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_PARAM_FRAIS_V01
-- Auteur               :       Fabien PINON
-- Date                 :       27/07/2010
-- Libellé              :        [PM72]
-- Commentaires         :       Insert dans la table TRACE_PARAM_FRAIS
-- Références           :       
--
-- Arguments            :      
--
-- Retourne             :       
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_PARAM_FRAIS_V01
GO

CREATE PROCEDURE PS_I01_TRACE_PARAM_FRAIS_V01 
	@iIdSeq int,
	@dcIdProd decimal(7, 0) ,
	@sIdFour char (3) ,
	@iIdGti decimal(7, 0) ,
	@dcIdProcess decimal(7, 0) ,
	@dcPecSpb decimal(7, 2) ,
	@dcPecPresta decimal(7, 2) ,
	@dcPecAssureur decimal(7, 2) ,
	@dcMtRbt decimal(7, 2) ,
	@sAltProd char (1) ,
	@iTypRbt int,
	@sTypModif char (1),
	@sMajPar char (4)
AS

  Declare @sIdFour_actuel char (3) ,
	@iIdGti_actuel decimal(7, 0) ,
	@dcIdProcess_actuel decimal(7, 0) ,
	@dcPecSpb_actuel decimal(7, 2) ,
	@dcPecPresta_actuel decimal(7, 2) ,
	@dcPecAssureur_actuel decimal(7, 2) ,
	@dcMtRbt_actuel decimal(7, 2) ,
	@sAltProd_actuel char (1) ,
	@sTypModif_actuel char (1),
	@iTypRbt_actuel int
	
  
  if @sTypModif = 'M' or @sTypModif = 'S'
  Begin
    Select @dcIdProd = id_prod,
	@sIdFour_actuel = id_four,
	@iIdGti_actuel = id_gti,
	@dcIdProcess_actuel = id_process,
	@dcPecSpb_actuel = cod_pec_spb,
	@dcPecPresta_actuel = cod_pec_presta,
	@dcPecAssureur_actuel = cod_pec_assureur,
	@dcMtRbt_actuel = mt_rbt,
	@sAltProd_actuel = alt_prod,
	@iTypRbt_actuel= typ_rbt
    From sysadm.param_frais
    Where id_seq = @iIdSeq
  End 
 
  
  if @sTypModif = 'C' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, typ_modif, typ_rbt,
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour, @iIdGti, @dcIdProcess,
	@dcPecSpb, @dcPecPresta, @dcPecAssureur,
	@dcMtRbt, @sAltProd ,  @sTypModif, @iTypRbt,
	getdate(),getdate(),@sMajPar)
  End

 if @sTypModif = 'S' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, typ_rbt, typ_modif, 
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour_actuel, @iIdGti_actuel, @dcIdProcess_actuel,
	@dcPecSpb_actuel, @dcPecPresta_actuel, @dcPecAssureur_actuel,
	@dcMtRbt_actuel, @sAltProd_actuel , @iTypRbt,@sTypModif, 
	getdate(),getdate(),@sMajPar)
  End

 if @sTypModif = 'M' 
  Begin
   INSERT INTO sysadm.trace_param_frais(
     id_seq, id_prod, id_four, id_gti, id_process, 
     cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
     mt_rbt, alt_prod, typ_rbt, id_four_apres, id_gti_apres, id_process_apres, 
     cod_pec_spb_apres, cod_pec_presta_apres, cod_pec_assureur_apres, 
     mt_rbt_apres, alt_prod_apres, typ_rbt_apres, typ_modif, 
     cree_le, maj_le, maj_par
   )
   VALUES(@iIdSeq, @dcIdProd, @sIdFour_actuel, @iIdGti_actuel, @dcIdProcess_actuel,
	@dcPecSpb_actuel, @dcPecPresta_actuel, @dcPecAssureur_actuel,
	@dcMtRbt_actuel, @sAltProd_actuel, @iTypRbt_actuel, @sIdFour, @iIdGti, @dcIdProcess,
	@dcPecSpb, @dcPecPresta, @dcPecAssureur,
	@dcMtRbt, @sAltProd , @iTypRbt, @sTypModif, 
	getdate(),getdate(),@sMajPar)
  End

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_FORMAT_TRACE_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       02/11/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [O2M_FRAIS].FPI
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_FORMAT_TRACE_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS
GO

CREATE PROCEDURE sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS
AS

-- Pour l'ajout & suppr
update #result
set descript='Produit ' + convert(varchar(10),id_prod)
	+ ' - Fournisseur ' + id_four
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'Garantie ' + sysadm.FN_CODE_NUM(id_gti,'-GA')
	+ ' - Process ' + convert(varchar(10),id_process)
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'PEC SPB : ' + convert(varchar(3),convert(int, cod_pec_spb))
	+ ' - PEC Presta : ' + convert(varchar(3),convert(int, cod_pec_presta))
	+ ' - PEC Assureur : ' + convert(varchar(3),convert(int, cod_pec_assureur))
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'Montant : ' + convert(varchar(20), mt_rbt)
	+ Char(13) + 'Mise en production : ' 
	+ Case alt_prod
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End
Where typ_modif in ('C','S')

-- Pour la màj
update #result
set descript=Rtrim(descript) + 'Fournisseur : ' + id_four + ' -> ' + id_four_apres + Char(13)
Where typ_modif ='M' and id_four <> id_four_apres

update #result
set descript=Rtrim(descript) + 'Garantie : ' + sysadm.FN_CODE_NUM(id_gti,'-GA') + Char(13)
	+ ' -> ' +  sysadm.FN_CODE_NUM(id_gti_apres,'-GA')
Where typ_modif ='M' and id_gti <> id_gti_apres

update #result
set descript=Rtrim(descript) + 'Process : ' + convert(varchar(10),id_process) +  
	' -> ' + convert(varchar(10),id_process_apres) + Char(13)
Where typ_modif ='M' and id_process <> id_process_apres

update #result
set descript=Rtrim(descript) + 'PEC SPB : ' + convert(varchar(3),convert(int, cod_pec_spb)) + 
	' -> ' +convert(varchar(3),convert(int, cod_pec_spb_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_spb <> cod_pec_spb_apres

update #result
set descript=Rtrim(descript) + 'PEC Presta : ' + convert(varchar(3),convert(int, cod_pec_presta)) + 
	' -> ' + convert(varchar(3),convert(int, cod_pec_presta_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_presta <> cod_pec_presta_apres

update #result
set descript=Rtrim(descript) + 'PEC Assureur : ' + convert(varchar(3),convert(int, cod_pec_assureur)) + 
	' -> ' + convert(varchar(3),convert(int, cod_pec_assureur_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_assureur <> cod_pec_assureur_apres

update #result
set descript=Rtrim(descript) + 'Montant : ' + convert(varchar(20), mt_rbt) + 
	' -> ' + convert(varchar(20), mt_rbt_apres) + Char(13)
Where typ_modif ='M' and mt_rbt <> mt_rbt_apres

update #result
set descript=Rtrim(descript) + 'Mise en production : ' 
	+  Case alt_prod
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End  + ' -> ' 
	+ Case alt_prod_apres
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End
Where typ_modif ='M' and alt_prod <> alt_prod_apres


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01
-- Auteur               :       FPI
-- Date                 :       27/07/2010
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PM72]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01
GO

CREATE PROCEDURE sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01
AS

-- Pour l'ajout & suppr
update #result
set descript='Produit ' + convert(varchar(10),id_prod)
	+ ' - Fournisseur ' + id_four
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'Garantie ' + sysadm.FN_CODE_NUM(id_gti,'-GA')
	+ ' - Process ' + convert(varchar(10),id_process)
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'PEC SPB : ' + convert(varchar(3),convert(int, cod_pec_spb))
	+ ' - PEC Presta : ' + convert(varchar(3),convert(int, cod_pec_presta))
	+ ' - PEC Assureur : ' + convert(varchar(3),convert(int, cod_pec_assureur))
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'Montant : ' + convert(varchar(20), mt_rbt)
	+ Char(13) + 'Mise en production : ' 
	+ Case alt_prod
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End
Where typ_modif in ('C','S')

update #result
set descript=Rtrim(descript) + Char(13) + 'Montant : ' + convert(varchar(20), mt_rbt)
	+ Char(13) + 'Type de remboursement : ' 
	+ Case typ_rbt
		When 1 Then 'Automatique'
		When 2 Then 'Manuel'
		Else '?'
	  End
Where typ_modif in ('C','S')

-- Pour la màj
update #result
set descript=Rtrim(descript) + 'Fournisseur : ' + id_four + ' -> ' + id_four_apres + Char(13)
Where typ_modif ='M' and id_four <> id_four_apres

update #result
set descript=Rtrim(descript) + 'Garantie : ' + sysadm.FN_CODE_NUM(id_gti,'-GA') + Char(13)
	+ ' -> ' +  sysadm.FN_CODE_NUM(id_gti_apres,'-GA')
Where typ_modif ='M' and id_gti <> id_gti_apres

update #result
set descript=Rtrim(descript) + 'Process : ' + convert(varchar(10),id_process) +  
	' -> ' + convert(varchar(10),id_process_apres) + Char(13)
Where typ_modif ='M' and id_process <> id_process_apres

update #result
set descript=Rtrim(descript) + 'PEC SPB : ' + convert(varchar(3),convert(int, cod_pec_spb)) + 
	' -> ' +convert(varchar(3),convert(int, cod_pec_spb_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_spb <> cod_pec_spb_apres

update #result
set descript=Rtrim(descript) + 'PEC Presta : ' + convert(varchar(3),convert(int, cod_pec_presta)) + 
	' -> ' + convert(varchar(3),convert(int, cod_pec_presta_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_presta <> cod_pec_presta_apres

update #result
set descript=Rtrim(descript) + 'PEC Assureur : ' + convert(varchar(3),convert(int, cod_pec_assureur)) + 
	' -> ' + convert(varchar(3),convert(int, cod_pec_assureur_apres)) + Char(13)
Where typ_modif ='M' and cod_pec_assureur <> cod_pec_assureur_apres

update #result
set descript=Rtrim(descript) + 'Montant : ' + convert(varchar(20), mt_rbt) + 
	' -> ' + convert(varchar(20), mt_rbt_apres) + Char(13)
Where typ_modif ='M' and mt_rbt <> mt_rbt_apres

update #result
set descript=Rtrim(descript) + 'Mise en production : ' 
	+  Case alt_prod
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End  + ' -> ' 
	+ Case alt_prod_apres
		When 'O' Then 'Oui'
		When 'N' Then 'Non'
		Else '?'
	  End
Where typ_modif ='M' and alt_prod <> alt_prod_apres

update #result
set descript=Rtrim(descript) + Char(13) + 'Montant : ' + convert(varchar(20), mt_rbt)
	+ Char(13) + 'Type de remboursement : ' 
	+ Case typ_rbt
		When 1 Then 'Automatique'
		When 2 Then 'Manuel'
		Else '?'
	  End + ' -> '
	  + Case typ_rbt_apres
		When 1 Then 'Automatique'
		When 2 Then 'Manuel'
		Else '?'
	  End
Where typ_modif ='M' and typ_rbt <> typ_rbt_apres

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_TRACE_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       02/11/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [O2M_FRAIS].FPI
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TRACE_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TRACE_PARAM_FRAIS
GO

CREATE PROCEDURE sysadm.DW_S01_TRACE_PARAM_FRAIS
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dtMajle datetime,
	@sMajPar char(4)
AS

Set @sIdFour = RTrim(@sIdFour)
Set @sMajPar = RTrim(@sMajPar)

SELECT *,REPLICATE(' ',255) as descript
INTO #result
FROM sysadm.trace_param_frais 
WHERE (id_prod = @dcIdProd or @dcIdProd is null) and
	(RTrim(id_four) = @sIdFour or @sIdFour is null) and
	(id_gti = @dcIdGti or @dcIdGti is null) and
	(id_process = @dcIdProcess or @dcIdProcess is null) and
	(maj_le > @dtMajle or @dtMajle is null) and
	(Rtrim(maj_par) = @sMajPar or @sMajPar is null)

exec sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS

Select maj_le, id_prod, typ_modif, id_seq, descript From #result

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_TRACE_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       02/11/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [O2M_FRAIS].FPI
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_TRACE_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S02_TRACE_PARAM_FRAIS
GO

CREATE PROCEDURE sysadm.DW_S02_TRACE_PARAM_FRAIS
	@idSeq int
AS

SELECT *,REPLICATE(' ',255) as descript
INTO #result
FROM sysadm.trace_param_frais 
WHERE id_seq = @idSeq

exec sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS

Select maj_le, id_prod, typ_modif, id_seq, descript From #result

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_TRACE_PARAM_FRAIS_V01
-- Auteur               :       FPI
-- Date                 :       27/07/2010
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PM72]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TRACE_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TRACE_PARAM_FRAIS_V01
GO

CREATE PROCEDURE sysadm.DW_S01_TRACE_PARAM_FRAIS_V01
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dtMajle datetime,
	@sMajPar char(4)
AS

Set @sIdFour = RTrim(@sIdFour)
Set @sMajPar = RTrim(@sMajPar)

SELECT *,REPLICATE(' ',255) as descript
INTO #result
FROM sysadm.trace_param_frais 
WHERE (id_prod = @dcIdProd or @dcIdProd is null) and
	(RTrim(id_four) = @sIdFour or @sIdFour is null) and
	(id_gti = @dcIdGti or @dcIdGti is null) and
	(id_process = @dcIdProcess or @dcIdProcess is null) and
	(maj_le > @dtMajle or @dtMajle is null) and
	(Rtrim(maj_par) = @sMajPar or @sMajPar is null)

exec sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01

Select maj_le, id_prod, typ_modif, id_seq, descript From #result

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_TRACE_PARAM_FRAIS_V01
-- Auteur               :       FPI
-- Date                 :       27/07/2010
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [PM72]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_TRACE_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S02_TRACE_PARAM_FRAIS_V01
GO

CREATE PROCEDURE sysadm.DW_S02_TRACE_PARAM_FRAIS_V01
	@idSeq int
AS

SELECT *,REPLICATE(' ',255) as descript
INTO #result
FROM sysadm.trace_param_frais 
WHERE id_seq = @idSeq

exec sysadm.PS_S01_FORMAT_TRACE_PARAM_FRAIS_V01

Select maj_le, id_prod, typ_modif, id_seq, descript From #result

Go

