-------------------------------------------------------------------
--
-- Fichier              :       PARAM_FRAIS.CP
-- Auteur               :       FPI
-- Date                 :       19/10/2009 14:20
--
-- Commentaires         :       Gestion des frais
--
-- Procédures           :       DW_S01_PARAM_FRAIS
--								DW_S02_PARAM_FRAIS
--								DW_I01_PARAM_FRAIS
--								DW_U01_PARAM_FRAIS
--								DW_D01_PARAM_FRAIS
-- 								PS_VERIF_PARAM_FRAIS
-- 								PS_VERIF_SIN_PARAM_FRAIS
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       19/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S01_PARAM_FRAIS
GO

CREATE PROCEDURE DW_S01_PARAM_FRAIS
	@iIdSeq	int
AS
  SELECT id_seq,
	id_prod,
	id_four,
	id_gti,
	id_process,
	cod_pec_spb,
	cod_pec_presta,
	cod_pec_assureur,
	mt_rbt,
	alt_prod,
	cree_le,
	maj_le,
	maj_par
  FROM sysadm.param_frais
  WHERE id_seq = @iIdSeq

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_FRAIS_V01
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_PARAM_FRAIS_V01
GO

CREATE PROCEDURE DW_S01_PARAM_FRAIS_V01
	@iIdSeq	int
AS
  SELECT id_seq,
	id_prod,
	id_four,
	id_gti,
	id_process,
	cod_pec_spb,
	cod_pec_presta,
	cod_pec_assureur,
	mt_rbt,
	alt_prod,
	typ_rbt,
	cree_le,
	maj_le,
	maj_par
  FROM sysadm.param_frais
  WHERE id_seq = @iIdSeq

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       19/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_S02_PARAM_FRAIS
GO

CREATE PROCEDURE DW_S02_PARAM_FRAIS
	@dcIdProd decimal(7,0),
	@sIdFour varchar(3),
	@dcIdGti decimal(7,0),
	@dtMajle datetime,
	@sMajPar varchar(4)
AS
  SELECT pf.id_seq,
	pf.id_prod,
	pr.lib_long,
	pf.id_four,
	sysadm.FN_CODE_CAR(pf.id_four, '-FR') as lib_four,
	pf.id_gti,
	sysadm.FN_CODE_NUM(pf.id_gti, '-GA') as lib_gti,
	pf.id_process,
	pf.cod_pec_spb,
	pf.cod_pec_presta,
	pf.cod_pec_assureur,
	pf.mt_rbt,
	pf.alt_prod,
	pf.cree_le,
	pf.maj_le,
	pf.maj_par
  FROM sysadm.param_frais pf
  INNER JOIN sysadm.produit pr on pr.id_prod = pf.id_prod
  WHERE (pf.id_prod = @dcIdProd or @dcIdProd is null) and
	(RTrim(pf.id_four) = @sIdFour or @sIdFour is null) and
	(pf.id_gti = @dcIdGti or @dcIdGti is null) and
	(pf.maj_le > @dtMajle or @dtMajle is null) and
	(RTrim(pf.maj_par) = @sMajPar or @sMajPar is null)
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARAM_FRAIS_V01
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S02_PARAM_FRAIS_V01
GO

CREATE PROCEDURE DW_S02_PARAM_FRAIS_V01
	@dcIdProd decimal(7,0),
	@sIdFour varchar(3),
	@dcIdGti decimal(7,0),
	@dtMajle datetime,
	@sMajPar varchar(4)
AS
  SELECT pf.id_seq,
	pf.id_prod,
	pr.lib_long,
	pf.id_four,
	sysadm.FN_CODE_CAR(pf.id_four, '-FR') as lib_four,
	pf.id_gti,
	sysadm.FN_CODE_NUM(pf.id_gti, '-GA') as lib_gti,
	pf.id_process,
	pf.cod_pec_spb,
	pf.cod_pec_presta,
	pf.cod_pec_assureur,
	pf.mt_rbt,
	pf.alt_prod,
	Case pf.typ_rbt When 1 Then 'Automatique' Else 'Manuel' End as typ_rbt,
	pf.cree_le,
	pf.maj_le,
	pf.maj_par
  FROM sysadm.param_frais pf
  INNER JOIN sysadm.produit pr on pr.id_prod = pf.id_prod
  WHERE (pf.id_prod = @dcIdProd or @dcIdProd is null) and
	(RTrim(pf.id_four) = @sIdFour or @sIdFour is null) and
	(pf.id_gti = @dcIdGti or @dcIdGti is null) and
	(pf.maj_le > @dtMajle or @dtMajle is null) and
	(RTrim(pf.maj_par) = @sMajPar or @sMajPar is null)
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       19/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_I01_PARAM_FRAIS
GO

CREATE PROCEDURE DW_I01_PARAM_FRAIS
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dcPecSpb decimal(7,2),
	@dcPecPresta decimal(7,2),
	@dcPecAssureur decimal(7,2),
	@dcMt decimal(11,2),
	@sMep char(1),
	@sMajPar char(4),
	@iIdSeq int OUTPUT
AS
  Insert into sysadm.param_frais(id_prod, id_four, id_gti, id_process, 
	cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
	mt_rbt, alt_prod, cree_le, maj_le, maj_par)
  Values (
	@dcIdProd,
	@sIdFour,
	@dcIdGti,
	@dcIdProcess,
	@dcPecSpb,
	@dcPecPresta,
	@dcPecAssureur,
	@dcMt,
	@sMep,
	getdate(),
	getdate(),
	@sMajPar)
	
	Set @iIdSeq=@@IDENTITY
	
	EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS @iIdSeq, @dcIdProd,	@sIdFour,	@dcIdGti,	@dcIdProcess,
		@dcPecSpb,	@dcPecPresta,	@dcPecAssureur,	
		@dcMt,	@sMep,	'C',  @sMajPar
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARAM_FRAIS_V01
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
--      18/10/2010      JFF     [PM72].[MAJ_DET_PRO_DP_95_76]
--      26/11/2012      JFF     [PC877]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_I01_PARAM_FRAIS_V01
GO

CREATE PROCEDURE DW_I01_PARAM_FRAIS_V01
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dcPecSpb decimal(7,2),
	@dcPecPresta decimal(7,2),
	@dcPecAssureur decimal(7,2),
	@dcMt decimal(11,2),
	@sMep char(1),
	@iTypRbt int,
	@sMajPar char(4),
	@iIdSeq int OUTPUT
AS

  Declare @LigMaj integer
  DECLARE @DBID INT     
  DECLARE @DBNAME NVARCHAR(128)


  Set @LigMaj = 0

  Insert into sysadm.param_frais(id_prod, id_four, id_gti, id_process, 
	cod_pec_spb, cod_pec_presta, cod_pec_assureur, 
	mt_rbt, alt_prod, typ_rbt, cree_le, maj_le, maj_par)
  Values (
	@dcIdProd,
	@sIdFour,
	@dcIdGti,
	@dcIdProcess,
	@dcPecSpb,
	@dcPecPresta,
	@dcPecAssureur,
	@dcMt,
	@sMep,
	@iTypRbt,
	getdate(),
	getdate(),
	@sMajPar)
	
	Set @iIdSeq=@@IDENTITY
	
	EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS_V01 @iIdSeq, @dcIdProd,	@sIdFour,	@dcIdGti,	@dcIdProcess,
		@dcPecSpb,	@dcPecPresta,	@dcPecAssureur,	
		@dcMt,	@sMep,	@iTypRbt, 'C',  @sMajPar
		
		
-- [PM72].[MAJ_DET_PRO_DP_95_76]
  -- [PC877]
  Update sysadm.det_pro
  Set val_car =
  Left ( sysadm.FN_CLE_VAL_E ( 'MT_FRAIS', Convert ( VarChar ( 15 ), @dcMt ), rtrim ( val_car ) + rtrim ( val_car2 ), ';')
	, 255 ),
  val_car2 =
  Substring(   	
	sysadm.FN_CLE_VAL_E ( 'MT_FRAIS', Convert ( VarChar ( 15 ), @dcMt ), rtrim ( val_car ) + rtrim ( val_car2 ), ';')
  , 256, 255 )
  
  Where id_prod = @dcIdProd
  And   id_code_dp in ( 95, 209 )
  And   rtrim ( val_car ) + rtrim ( val_car2 ) Like '%=' + Convert ( VarChar ( 10 ), @dcIdProcess ) + ';%'

  Set @LigMaj = @LigMaj + @@RowCount

  Update sysadm.det_pro 
  Set val_num = @dcMt 
  Where id_prod = @dcIdProd
  And   id_code_dp = 76
  And   id_code_num = @dcIdProcess
  
  Set @LigMaj = @LigMaj + @@RowCount
  
  If @LigMaj <= 0 
   Begin
     SET @DBID = DB_ID()
     SET @DBNAME = DB_NAME()
     RAISERROR (50001, 16, 1, @DBID, @DBNAME)
   End 
  
-- :[PM72].[MAJ_DET_PRO_DP_95_76] 		
		
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       19/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_U01_PARAM_FRAIS
GO

CREATE PROCEDURE DW_U01_PARAM_FRAIS
	@iIdSeq	int,
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dcPecSpb decimal(7,2),
	@dcPecPresta decimal(7,2),
	@dcPecAssureur decimal(7,2),
	@dcMt decimal(11,2),
	@sMep char(1),
	@sMajPar char(4)
AS
  Declare @dcIdProd Decimal (7)
  Declare @LigMaj integer
  DECLARE @DBID INT     
  DECLARE @DBNAME NVARCHAR(128)


  Set @LigMaj = 0
  Select @dcIdProd = pf.id_prod From sysadm.param_frais pf where pf.id_seq = @iIdSeq

  EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS @iIdSeq, NULL,	@sIdFour,	@dcIdGti,	@dcIdProcess,
		@dcPecSpb,	@dcPecPresta,	@dcPecAssureur,	
		@dcMt,	@sMep,	'M',  @sMajPar
		
  Update sysadm.param_frais
  Set id_four = @sIdFour, 
      id_gti = @dcIdGti, 
	  id_process = @dcIdProcess, 
	  cod_pec_spb = @dcPecSpb, 
	  cod_pec_presta = @dcPecPresta, 
	  cod_pec_assureur = @dcPecAssureur, 
	  mt_rbt = @dcMt, 
	  alt_prod= @sMep, 
	  maj_le=getdate(), 
	  maj_par= @sMajPar
  Where id_seq = @iIdSeq
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_PARAM_FRAIS_V01
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
--      18/10/2010      JFF     [PM72].[MAJ_DET_PRO_DP_95_76]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_U01_PARAM_FRAIS_V01
GO

CREATE PROCEDURE sysadm.DW_U01_PARAM_FRAIS_V01
	@iIdSeq	int,
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@dcPecSpb decimal(7,2),
	@dcPecPresta decimal(7,2),
	@dcPecAssureur decimal(7,2),
	@dcMt decimal(11,2),
	@sMep char(1),
	@iTypRbt int, -- [PM72]
	@sMajPar char(4)
AS
  Declare @dcIdProd Decimal (7)
  Declare @LigMaj integer
  DECLARE @DBID INT     
  DECLARE @DBNAME NVARCHAR(128)


  Set @LigMaj = 0
  Select @dcIdProd = pf.id_prod From sysadm.param_frais pf where pf.id_seq = @iIdSeq


  EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS_V01 @iIdSeq, NULL,	@sIdFour,	@dcIdGti,	@dcIdProcess,
		@dcPecSpb,	@dcPecPresta,	@dcPecAssureur,	
		@dcMt,	@sMep,	@iTypRbt, 'M',  @sMajPar
		
  Update sysadm.param_frais
  Set id_four = @sIdFour, 
      id_gti = @dcIdGti, 
	  id_process = @dcIdProcess, 
	  cod_pec_spb = @dcPecSpb, 
	  cod_pec_presta = @dcPecPresta, 
	  cod_pec_assureur = @dcPecAssureur, 
	  mt_rbt = @dcMt, 
	  alt_prod= @sMep, 
	  typ_rbt = @iTypRbt, -- [PM72]
	  maj_le=getdate(), 
	  maj_par= @sMajPar
  Where id_seq = @iIdSeq

-- [PM72].[MAJ_DET_PRO_DP_95_76]
  Update sysadm.det_pro
  Set val_car =
  Left ( sysadm.FN_CLE_VAL_E ( 'MT_FRAIS', Convert ( VarChar ( 15 ), @dcMt ), rtrim ( val_car ) + rtrim ( val_car2 ), ';')
    , 255 ),
  val_car2 =
  Substring(   	
  	sysadm.FN_CLE_VAL_E ( 'MT_FRAIS', Convert ( VarChar ( 15 ), @dcMt ), rtrim ( val_car ) + rtrim ( val_car2 ), ';')
  , 256, 255 )
  
  Where id_prod = @dcIdProd
  And   id_code_dp = 95
  And   rtrim ( val_car ) + rtrim ( val_car2 ) Like '%=' + Convert ( VarChar ( 10 ), @dcIdProcess ) + ';%'

  Set @LigMaj = @LigMaj + @@RowCount

  Update sysadm.det_pro 
  Set val_num = @dcMt 
  Where id_prod = @dcIdProd
  And   id_code_dp = 76
  And   id_code_num = @dcIdProcess
  
  Set @LigMaj = @LigMaj + @@RowCount
  
  If @LigMaj <= 0 
   Begin
     SET @DBID = DB_ID()
     SET @DBNAME = DB_NAME()
     RAISERROR (50001, 16, 1, @DBID, @DBNAME)
   End 
  
-- :[PM72].[MAJ_DET_PRO_DP_95_76]  
  
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       19/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.DW_D01_PARAM_FRAIS
GO

CREATE PROCEDURE DW_D01_PARAM_FRAIS
	@iIdSeq	int,
	@sMajPar char(4)
As 
  EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS @iIdSeq, NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,'S',  @sMajPar
  delete from sysadm.param_frais
  where id_seq = @iIdSeq
 Go

 --------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARAM_FRAIS_V01
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_FRAIS_V01' AND type = 'P' )
        DROP procedure sysadm.DW_D01_PARAM_FRAIS_V01
GO

CREATE PROCEDURE DW_D01_PARAM_FRAIS_V01
	@iIdSeq	int,
	@sMajPar char(4)
As 
  EXEC sysadm.PS_I01_TRACE_PARAM_FRAIS @iIdSeq, NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,'S',  @sMajPar
  delete from sysadm.param_frais
  where id_seq = @iIdSeq
 Go

 --------------------------------------------------------------------
--
-- Procédure            :       PS_VERIF_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       20/10/2009
-- Libellé              :       
-- Commentaires         :       
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VERIF_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.PS_VERIF_PARAM_FRAIS
GO

CREATE PROCEDURE PS_VERIF_PARAM_FRAIS
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@iIdSeq int	OUTPUT
As 
  SELECT @iIdSeq = pf.id_seq
  FROM sysadm.param_frais pf
  WHERE pf.id_prod = @dcIdProd and
	pf.id_four = @sIdFour and
	pf.id_gti = @dcIdGti and
	pf.id_process = @dcIdProcess
 Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_CTRL_FRAIS_PRESTA
-- Auteur               :       FPI
-- Date                 :       04/01/2010
-- Libellé              :       
-- Commentaires         :       Contrôle la concordance entre la table "param_frais" et l'option det_pro 95
-- Références           :       [DCMP090440]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CTRL_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_CTRL_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.PS_CTRL_FRAIS_PRESTA
as
  -- Table #tmp_frais contient les enreg -DP 95 qui nous interessent
  drop table #tmp_frais

  select distinct d.id_prod,
	sysadm.FN_CLE_VAL('MT_FRAIS',rtrim(d.val_car) + rtrim(d.val_car2),';') as montant_dp,
	sysadm.FN_CLE_VAL('PROCESS',rtrim(d.val_car) + rtrim(d.val_car2),';') as id_process,
	sysadm.FN_CLE_VAL('FRN',rtrim(d.val_car) + rtrim(d.val_car2),';') as id_four
  into #tmp_frais
  From sysadm.det_pro d
  where d.id_code_dp = 95
	and rtrim(d.val_car) + rtrim(d.val_car2) like '%MT_FRAIS%'
	and not (d.id_prod Between 35800 and 35899 or d.id_prod between 38100 and 38199) -- Temporaire 

  -- Suppression des montants à 0 dans #tmp_frais
  delete from #tmp_frais where convert(decimal(11,2),montant_dp)=0

  -- Select final
  select distinct p.id_seq, p.id_prod, p.id_four, p.id_gti, p.id_process,
	p.mt_rbt as montant_param, 
    t.montant_dp
  From sysadm.param_frais p
    left outer join #tmp_frais t on t.id_prod = p.id_prod
    and convert(varchar(7),p.id_process) = t.id_process
    and p.id_four = t.id_four
  where not (p.id_prod Between 35800 and 35899 or p.id_prod between 38100 and 38199) -- Temporaire 
    and (t.id_prod is null or
	p.mt_rbt <> convert(decimal(11,2),t.montant_dp))
  UNION
  select distinct NULL as id_seq, t.id_prod, 
	t.id_four,
	NULL as id_gti,
	convert(decimal(7,0),t.id_process),
	NULL as montant_param,
	convert(decimal(11,2),t.montant_dp)
  From #tmp_frais t
  where not exists (
    select id_seq
    from sysadm.param_frais p
    where p.id_prod = t.id_prod
      and convert(varchar(7),p.id_process) = t.id_process
      and p.id_four = t.id_four
	)
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_GET_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       27/07/2010
-- Libellé              :       
-- Commentaires         :       Récup d'info de la table "param_frais" 
-- Références           :       [PM72]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_GET_PARAM_FRAIS' AND type = 'P' )
        DROP procedure sysadm.PS_GET_PARAM_FRAIS
GO

CREATE PROCEDURE sysadm.PS_GET_PARAM_FRAIS
	@dcIdProd decimal(7,0),
	@sIdFour char(3),
	@dcIdGti decimal(7,0),
	@dcIdProcess decimal(7,0),
	@iIdSeq int	OUTPUT,
	@dcMontant decimal(11,2) OUTPUT,
	@iTypRbt int OUTPUT
As
  SELECT @iIdSeq = pf.id_seq,
	@dcMontant = mt_rbt,
	@iTypRbt = typ_rbt
  FROM sysadm.param_frais pf
  WHERE pf.id_prod = @dcIdProd and
	pf.id_four = @sIdFour and
	pf.id_gti = @dcIdGti and
	pf.id_process = @dcIdProcess and 
	pf.alt_prod='O'
	
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_VERIF_SIN_PARAM_FRAIS
-- Auteur               :       FPI
-- Date                 :       17/08/2011
-- Libellé              :       Vérifie l'éligbilité d'un dossier au règlement manuel PM72
-- Commentaires         :       
-- Références           :       [PM72.2]
--
-- Arguments            :       
--				
-- Retourne             :       -1 un frais vers O2M déjà passé
--				-2 pas de commande de diag O2M non annulée
--				-3 DP "142 - PM72:frais manuels interdits si O2M" présente
--				-4 param absent, pas normal
--				-5 un frais d'envoi vers l'assuré existe déjà
--				-6 frais interdit sur DOM-COM pour ce process
--				0 éligible - param absent, mais normal
--				1 éligible - param présent
-------------------------------------------------------------------
-- MAJ	LE		PAR	Description
-- 	26/12/2011	FPI	[VDoc6404] Ajout du -6
--  17/04/2014 FPI [DT141] - frais presta
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_VERIF_SIN_PARAM_FRAIS]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_VERIF_SIN_PARAM_FRAIS]
GO


CREATE PROCEDURE sysadm.PS_VERIF_SIN_PARAM_FRAIS
	@dcIdSin decimal(10,0), -- [PI062]
	@iTypRbt int OUTPUT,
	@dcMtRbt decimal(11,2)	OUTPUT
As 
  Declare @iIdSeq 	int,
	@iInfoSpbFrn 	int,
	@dcIdProd  	decimal(7,0),
	@dcIdGti  	decimal(7,0),
	@nbFraisAssure int,
	@iCaisse int,
	@sIdFour varchar(3)
  
  Select @iInfoSpbFrn=NULL, @dcMtRbt=NULL, @iTypRbt=NULL
  
  -- Ctrl 1 : un seul frais d'envoi possible vers O2M
  If exists (SELECT id_seq FROM sysadm.trt_frais_presta WHERE id_sin = @dcIdSin) Return -1
  
  -- Ctrl 2 : Présence d'une commande de diag 02M non annulée
  Select @iInfoSpbFrn = c.info_spb_frn,
	@iIdSeq = c.id_seq,
	@dcIdGti = c.id_gti,
	@dcIdProd = s.id_prod,
	@sIdFour=c.id_four -- [DT141]
  From sysadm.commande c
    inner join sysadm.sinistre s on s.id_sin=c.id_sin
  Where c.id_sin = @dcIdSin
    And c.id_four in ('SBE','O2M')
    And c.id_ref_four='A_DIAGNOSTIQUER' 
    And c.cod_etat<>'ANN'
    
  If @iInfoSpbFrn Is Null Return -2
  
  -- Ctrl 3 : Absence de la DP 142
  If exists (select * from sysadm.det_pro where id_prod=@dcIdProd and id_code_dp=142) Return -3
  
  -- Ctrl 4 : récupération du paramétrage (OK si DP 176 présente et param absent)
  Select @dcMtRbt=mt_rbt,
	@iTypRbt=typ_rbt
  From sysadm.param_frais
  Where id_prod = @dcIdProd
    And id_four =@sIdFour -- [DT141]
    And id_gti = @dcIdGti
    And id_process = @iInfoSpbFrn
  
   If @dcMtRbt is null
   Begin
	Return -4
   End
   
    -- Ctrl 5 : Un frais d'envoi vers l'assuré existe déjà
   Select @nbFraisAssure=count(*)
   From sysadm.frais f
   Inner join sysadm.inter i on f.id_sin=i.id_sin and f.id_i=i.id_i
   Where f.id_sin=@dcIdSin And id_typ_frais=1 And i.cod_inter='A'
   
   If @nbFraisAssure > 0 Return -5
   
   Select @nbFraisAssure=count(*)
   From sysadm.w_frais f
   Inner join sysadm.inter i on f.id_sin=i.id_sin and f.id_i=i.id_i
   Where f.id_sin=@dcIdSin And id_typ_frais=1 And i.cod_inter='A'
   
   If @nbFraisAssure > 0 Return -5
   
   -- Ctrl 6 : pour les caisses 900,902,903 (DOM COM), autorisation uniquement pour le code process 910
   Set @iCaisse=NULL
   
   Select @iCaisse=val_nbre 
   from sysadm.div_sin 
   where id_sin=@dcIdSin and Upper (nom_zone) = 'ID_CLI_BQ'
   
   If @iCaisse is Not NULL 
   Begin
	If @iCaisse in (900,902,903) and @iInfoSpbFrn <> 910 Return -6
   End
   
   Return 1
 Go
 
grant execute on sysadm.PS_VERIF_SIN_PARAM_FRAIS to rolebddsinistres
Go