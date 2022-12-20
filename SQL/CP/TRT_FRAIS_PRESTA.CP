-------------------------------------------------------------------
--
-- Fichier              :       TRT_FRAIS_PRESTA.CP
-- Auteur               :       Fabien PINON
-- Date                 :       04/10/2009
--
-- Commentaires         :       Gestion des tables trt_frais_presta & trace_trt_frais_presta
--
-- Procedures           :       PS_I01_TRACE_TRT_FRAIS_PRESTA
--				PS_I01_TRT_FRAIS_PRESTA
--				DW_S01_TRT_FRAIS_PRESTA
--				DW_S02_TRT_FRAIS_PRESTA
--				DW_S03_TRT_FRAIS_PRESTA
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_TRACE_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       05/11/2009
-- Libelle              :        
-- Commentaires         :       Insertion dans la table TRACE_TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	@dcIdSin		decimal(7,0)	(Val)
--								@iIdSeqCmd		int				(Val)
--								@dcIdProd		decimal(7,0)	(Val)
--								@sIdFour 		varchar(4)		(Val)
--								@dcIdGti 		decimal(7,0)	(Val)
--								@dcIdProcess 	decimal(7,0)	(Val)
--								@sAltProd 		char(1)			(Val)
--								@sResult 		char(1)			(Val)
--								@sTxtErr 		varchar(255)	(Val)
--								@sMajPar 		char(4)			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.PS_I01_TRACE_TRT_FRAIS_PRESTA
  @dcIdSin	decimal(10,0),  -- [PI062]
  @iIdSeqCmd	int,
  @dcIdProd	decimal(7,0),
  @sIdFour varchar(4),
  @dcIdGti decimal(7,0),
  @dcIdProcess decimal(7,0),
  @sAltProd char(1),
  @sResult char(1),
  @sTxtErr varchar(255),
  @dtMajLe datetime,
  @sMajPar char(4)
AS

Insert into trace_trt_frais_presta (
  id_sin,
  id_seq_cmd,
  id_prod,
  id_four,
  id_gti,
  id_process,
  alt_prod,
  flag_result,
  txt_err,
  id_oper,
  cree_le,
  maj_le)
Values (
  @dcIdSin,
  @iIdSeqCmd,
  @dcIdProd,
  @sIdFour,
  @dcIdGti,
  @dcIdProcess,
  @sAltProd,
  @sResult,
  @sTxtErr,
  @sMajPar,
  @dtMajLe,
  @dtMajLe
)

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I01_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       05/11/2009
-- Libelle              :        
-- Commentaires         :       Insertion dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	@dcIdSin		decimal(7,0)	(Val)
--								@iIdSeq			int				(Val)
--								@dcIdProd		decimal(7,0)	(Val)
--								@sIdFour 		varchar(4)		(Val)
--								@dcIdGti 		decimal(7,0)	(Val)
--								@dcIdProcess 	decimal(7,0)	(Val)
--								@sMajPar 		char(4)			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 05/08/2010 FPI [PM72] Ajout de la colonne typ_rbt
-- 22/12/2011 JFF [PM72][20111222] Gestion du lib_ag à null
-- 26/11/2012 JFF [PC877]
-- 10/06/2015 JFF [PM280-1][MANTIS15456]
-- JFF      12/02/2016   [PI062]
-- JFF		29/09/2017   au niveau rib, je transforme en null si vide (suite problème avec Volcanes ce jour 29/09/17)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.PS_I01_TRT_FRAIS_PRESTA
  @dcIdSin	decimal(10,0),  -- [PI062]
  @iIdSeq	int,
  @dcIdProd	decimal(7,0),
  @sIdFour varchar(4),
  @dcIdGti decimal(7,0),
  @dcIdProcess decimal(7,0),
  @sMajPar char(4)
As

Declare @sCodDept	varchar(35),
  @sIdAdh	varchar(19),
  @iIdProdAdh	int,
  @iIdEts	int,
  @iIdSdos	int,
  @sRibBq	char(5),
  @sRibAg char(5),
  @sRibCpt char(11),
  @sRibCle char(2),
  @sLibAg	varchar(24),
  @sLibReglt	varchar(31),
  @dcMontant	decimal(11,2),
  @sMoyenPaiement	char(1),
  @sCodCiv	char(1),
  @sNomAssure	varchar(71),
  @sAdr1	varchar(35),
  @sAdr2	varchar(35),
  @sAdrCp	varchar(5),
  @sAdrVille	varchar(35),
  @sOrdreChq	varchar(35),
  @iNoCie	int,
  @sNoContrat	varchar(20),
  @dcCodPecSpb	decimal(7,2),
  @dcCodPecPresta decimal(7,2),
  @dcCodPecAssureur decimal(7,2),
  @sResult char(1),
  @sTxtErr varchar(255), 
  @sAltProd char(1),
  @dtToday datetime,
  @dcIdRev decimal(7,0),
  @iTypeRbt	int, -- [PM72]
  @sARepGarantie VarChar ( 10 ) -- [PM280-1][MANTIS15456]

Set @sResult = 'O'

-- [Corr_Doublon_PM72]
If Exists (select * from sysadm.trt_frais_presta where id_sin=@dcIdSin	and id_seq_cmd=@iIdSeq) Return

-- [PM280-1][MANTIS15456]
Select  @sARepGarantie = IsNull ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt), ';' ), '' )		
From	sysadm.commande c
Where	c.id_sin = @dcIdSin
And		c.id_seq = @iIdSeq

if @sARepGarantie is null Set @sARepGarantie = ''
If @sARepGarantie = 'OUI' Return

-- Récupération du paramétrage des frais

Select @dcCodPecSpb = cod_pec_spb,
  @dcCodPecPresta = cod_pec_presta,
  @dcCodPecAssureur = cod_pec_assureur,
  @dcMontant = mt_rbt,
  @sAltProd = alt_prod,
  @iTypeRbt = typ_rbt  -- [PM72]
From sysadm.param_frais
Where id_prod = @dcIdProd
  and id_four = @sIdFour
  and id_gti = @dcIdGti
  and id_process = @dcIdProcess


-- Si non-paramétré, on n'effectue pas d'autres select
if @@RowCount = 0 
Begin
  Set @sResult = 'N'
  Set @sTxtErr = 'Aucun paramétrage'
End 

-- [PM72][20111222]
If @dcCodPecSpb is null Set @dcCodPecSpb = 0
If @dcCodPecPresta is null Set @dcCodPecPresta = 0
If @dcCodPecAssureur is null Set @dcCodPecAssureur = 100


-- Si alt_prod='N', on n'effectue pas d'autres select
if @sAltProd = 'N' or @iTypeRbt=2 -- [PM72]
Begin
  Set @sResult = 'N'
  Set @sTxtErr = 'Paramétrage avec mise en prod à Non ou frais manuel'
End 

If @sResult = 'O'
Begin

  -- Récupération des données depuis 'sinistre'
  Select @sIdAdh = id_adh,
    @iIdEts = id_ets,
    @iIdSdos = id_sdos,
	@dcIdRev = id_rev
  From sysadm.sinistre
  Where id_sin = @dcIdSin

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Sinistre non trouvé'
  End
End

If @sResult = 'O'
Begin

  -- Récupération des données de l'inter assuré
  Select @sRibBq=rib_bq,
    @sRibAg = rib_gui,
    @sRibCpt = rib_cpt,
    @sRibCle = rib_cle,
    @sAdr1 = adr_1,
    @sAdr2 = adr_2,
    @sAdrCp = adr_cp,
    @sAdrVille = adr_ville,
    @sOrdreChq = Case When rib_gui is not null Then NULL Else nom End,
    @sNomAssure = nom, 
    @sCodCiv = cod_civ
  From sysadm.inter
  Where id_sin = @dcIdSin
  and cod_inter='A'

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Inter assuré non trouvé'
  End
End

-- JFF 29/09/2017
If rtrim ( @sRibBq ) = '' Set @sRibBq = null
If rtrim ( @sRibAg ) = '' Set @sRibAg = null
If rtrim ( @sRibCpt ) = '' Set @sRibCpt = null
If rtrim ( @sRibCle ) = '' Set @sRibCle = null

If @sResult = 'O'
Begin

  -- Récupération du produit adhésion et département de gestion
  Select @iIdProdAdh = cod_prod_dms,
    @sCodDept = lib_dept 
  From sysadm.produit
  Inner join sysadm.departement on produit.id_dept = departement.id_dept
  where id_prod = @dcIdProd

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Produit/département non trouvé'
  End
End

If @sResult = 'O'
Begin

  Select @iNoCie = pol.id_cie,
    @sNoContrat = pol.lib_police
  From sysadm.garantie gti
  Inner Join sysadm.police pol on gti.id_police = pol.id_police
  Where gti.id_gti = @dcIdGti
	And gti.id_prod = @dcIdProd
	And gti.id_rev = @dcIdRev
	
   if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Police / garantie non trouvé'
  End
End

Set @dtToday=getdate()

If @sResult = 'O'
Begin

  -- Affectation du moyen de paiement et du libellé d'agence
  If @sRibAg is null or rtrim(@sRibAg) = '' 
  Begin
    Set @sMoyenPaiement = 'C'
    Set @sLibAg=NULL
  End
  Else
  Begin
    Set @sMoyenPaiement = 'T'

    Select @sLibAg = lib_ag
    From sysadm.agence
    Where id_bq = @sRibBq and id_ag = @sRibAg
    
    -- [PM72][20111222]
    If @sLibAg is null Set @sLibAg = 'AUCUN'
    
  End

  Set @sLibReglt= 'SPB FRAIS ' + convert(varchar(10), @dcIdSin)  -- [PI062]

  -- Insertion dans la table de traitement
  INSERT INTO sysadm.trt_frais_presta(
    id_sin, 
    id_seq_cmd, 
    cod_dept, 
    id_adh, 
    id_prod_adh, 
    id_ets, 
    id_sdos, 
    rib_bq, 
    rib_ag, 
    rib_cpt, 
    rib_cle, 
    lib_ag, 
    lib_reglement, 
    montant, 
    monnaie, 
    moyen_paiement, 
    cod_civ, 
    cod_inter, nom_assure, 
    adr_1, 
    adr_2, 
    adr_cp, 
    adr_ville, 
    ordre_chq, 
    top_valide, 
    top_info, 
    no_cie, 
    no_contrat, 
    id_prod, 
    cod_pec_spb, 
    cod_pec_presta, 
    cod_pec_assureur, 
    cod_presta, 
    cod_pos, 
    cree_le, maj_le, maj_par)
  VALUES(@dcIdSin,  
    @iIdSeq,  
    @sCodDept,  
    @sIdAdh,  
    @iIdProdAdh,  
    @iIdEts,  
    @iIdSdos,  
    @sRibBq,  
    @sRibAg,  
    @sRibCpt,  
    @sRibCle,  
    @sLibAg,  
    @sLibReglt,  
    @dcMontant,  
    'EUR',  
    @sMoyenPaiement,  
    @sCodCiv,  
    'A',  
    @sNomAssure,  
    @sAdr1,  
    @sAdr2,  
    @sAdrCp,  
    @sAdrVille,  
    @sOrdreChq,  
    1,  
    0,  
    @iNoCie,  
    @sNoContrat,  
    @dcIdProd,  
    @dcCodPecSpb, 
    @dcCodPecPresta,
    @dcCodPecAssureur,
    @sIdFour,  
    0,  
    @dtToday, @dtToday, @sMajPar)

     
  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr=@@error
  End
End

-- Insertion de la trace
EXEC sysadm.PS_I01_TRACE_TRT_FRAIS_PRESTA @dcIdSin, 
    @iIdSeq, 
    @dcIdProd, 
    @sIdFour,  
    @dcIdGti,   
    @dcIdProcess,   
    @sAltProd,   
    @sResult,   
    @sTxtErr,
    @dtToday,
    @sMajPar

Go

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRT_FRAIS_PRESTA_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRT_FRAIS_PRESTA_V01
GO

CREATE PROCEDURE sysadm.PS_I01_TRT_FRAIS_PRESTA_V01
  @dcIdSin	decimal(10,0),  -- [PI062]
  @iIdSeq	int,
  @dcIdProd	decimal(7,0),
  @sIdFour varchar(4),
  @dcIdGti decimal(7,0),
  @dcIdProcess decimal(7,0),
  @sMajPar char(4),
  @sInfoFrnSpbCplt varchar (800), --[PC877]
  @sInfoFrnSpbCpltActuel varchar (800) --[PC877]

As

Declare @sCodDept	varchar(35),
  @sIdAdh	varchar(19),
  @iIdProdAdh	int,
  @iIdEts	int,
  @iIdSdos	int,
  @sRibBq	char(5),
  @sRibAg char(5),
  @sRibCpt char(11),
  @sRibCle char(2),
  @sLibAg	varchar(24),
  @sLibReglt	varchar(31),
  @dcMontant	decimal(11,2),
  @sMoyenPaiement	char(1),
  @sCodCiv	char(1),
  @sNomAssure	varchar(71),
  @sAdr1	varchar(35),
  @sAdr2	varchar(35),
  @sAdrCp	varchar(5),
  @sAdrVille	varchar(35),
  @sOrdreChq	varchar(35),
  @iNoCie	int,
  @sNoContrat	varchar(20),
  @dcCodPecSpb	decimal(7,2),
  @dcCodPecPresta decimal(7,2),
  @dcCodPecAssureur decimal(7,2),
  @sResult char(1),
  @sTxtErr varchar(255), 
  @sAltProd char(1),
  @dtToday datetime,
  @dcIdRev decimal(7,0),
  @iTypeRbt	int -- [PM72]

Set @sResult = 'O'

-- [Corr_Doublon_PM72]
If Exists (select * from sysadm.trt_frais_presta where id_sin=@dcIdSin	and id_seq_cmd=@iIdSeq) Return

-- Récupération du paramétrage des frais

Select @dcCodPecSpb = cod_pec_spb,
  @dcCodPecPresta = cod_pec_presta,
  @dcCodPecAssureur = cod_pec_assureur,
  @dcMontant = mt_rbt,
  @sAltProd = alt_prod,
  @iTypeRbt = typ_rbt  -- [PM72]
From sysadm.param_frais
Where id_prod = @dcIdProd
  and id_four = @sIdFour
  and id_gti = @dcIdGti
  and id_process = @dcIdProcess


-- Si non-paramétré, on n'effectue pas d'autres select
if @@RowCount = 0 
Begin
  Set @sResult = 'N'
  Set @sTxtErr = 'Aucun paramétrage'
End 

-- [PM72][20111222]
If @dcCodPecSpb is null Set @dcCodPecSpb = 0
If @dcCodPecPresta is null Set @dcCodPecPresta = 0
If @dcCodPecAssureur is null Set @dcCodPecAssureur = 100


-- Si alt_prod='N', on n'effectue pas d'autres select
if @sAltProd = 'N' or @iTypeRbt=2 -- [PM72]
Begin
  Set @sResult = 'N'
  Set @sTxtErr = 'Paramétrage avec mise en prod à Non ou frais manuel'
End 

If @sResult = 'O'
Begin

  -- Récupération des données depuis 'sinistre'
  Select @sIdAdh = id_adh,
    @iIdEts = id_ets,
    @iIdSdos = id_sdos,
	@dcIdRev = id_rev
  From sysadm.sinistre
  Where id_sin = @dcIdSin

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Sinistre non trouvé'
  End
End

If @sResult = 'O'
Begin

  -- Récupération des données de l'inter assuré
  Select @sRibBq=rib_bq,
    @sRibAg = rib_gui,
    @sRibCpt = rib_cpt,
    @sRibCle = rib_cle,
    @sAdr1 = adr_1,
    @sAdr2 = adr_2,
    @sAdrCp = adr_cp,
    @sAdrVille = adr_ville,
    @sOrdreChq = Case When rib_gui is not null Then NULL Else nom End,
    @sNomAssure = nom, 
    @sCodCiv = cod_civ
  From sysadm.inter
  Where id_sin = @dcIdSin
  and cod_inter='A'

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Inter assuré non trouvé'
  End
End

If @sResult = 'O'
Begin

  -- Récupération du produit adhésion et département de gestion
  Select @iIdProdAdh = cod_prod_dms,
    @sCodDept = lib_dept 
  From sysadm.produit
  Inner join sysadm.departement on produit.id_dept = departement.id_dept
  where id_prod = @dcIdProd

  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Produit/département non trouvé'
  End
End

If @sResult = 'O'
Begin

  Select @iNoCie = pol.id_cie,
    @sNoContrat = pol.lib_police
  From sysadm.garantie gti
Inner Join sysadm.police pol on gti.id_police = pol.id_police
  Where gti.id_gti = @dcIdGti
	And gti.id_prod = @dcIdProd
	And gti.id_rev = @dcIdRev
	
   if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr='Police / garantie non trouvé'
  End
End

Set @dtToday=getdate()

If @sResult = 'O'
Begin

  -- Affectation du moyen de paiement et du libellé d'agence
  If @sRibAg is null or rtrim(@sRibAg) = '' 
  Begin
    Set @sMoyenPaiement = 'C'
    Set @sLibAg=NULL
  End
  Else
  Begin
    Set @sMoyenPaiement = 'T'

    Select @sLibAg = lib_ag
    From sysadm.agence
    Where id_bq = @sRibBq and id_ag = @sRibAg
    
    -- [PM72][20111222]
    If @sLibAg is null Set @sLibAg = 'AUCUN'
    
  End

  Set @sLibReglt= 'SPB FRAIS ' + convert(varchar(10), @dcIdSin) -- [PI062]

  -- Insertion dans la table de traitement
  INSERT INTO sysadm.trt_frais_presta(
    id_sin, 
    id_seq_cmd, 
    cod_dept, 
    id_adh, 
    id_prod_adh, 
    id_ets, 
    id_sdos, 
    rib_bq, 
    rib_ag, 
    rib_cpt, 
    rib_cle, 
    lib_ag, 
    lib_reglement, 
    montant, 
    monnaie, 
    moyen_paiement, 
    cod_civ, 
    cod_inter, nom_assure, 
    adr_1, 
    adr_2, 
    adr_cp, 
    adr_ville, 
    ordre_chq, 
    top_valide, 
    top_info, 
    no_cie, 
    no_contrat, 
    id_prod, 
    cod_pec_spb, 
    cod_pec_presta, 
    cod_pec_assureur, 
    cod_presta, 
    cod_pos, 
    cree_le, maj_le, maj_par)
  VALUES(@dcIdSin,  
    @iIdSeq,  
    @sCodDept,  
    @sIdAdh,  
    @iIdProdAdh,  
    @iIdEts,  
    @iIdSdos,  
    @sRibBq,  
    @sRibAg,  
    @sRibCpt,  
    @sRibCle,  
    @sLibAg,  
    @sLibReglt,  
    @dcMontant,  
    'EUR',  
    @sMoyenPaiement,  
    @sCodCiv,  
    'A',  
    @sNomAssure,  
    @sAdr1,  
    @sAdr2,  
    @sAdrCp,  
    @sAdrVille,  
    @sOrdreChq,  
    1,  
    0,  
    @iNoCie,  
    @sNoContrat,  
    @dcIdProd,  
    @dcCodPecSpb, 
    @dcCodPecPresta,
    @dcCodPecAssureur,
    @sIdFour,  
    0,  
    @dtToday, @dtToday, @sMajPar)

     
  if @@RowCount = 0 
  Begin
    Set @sResult='N'
    Set @sTxtErr=@@error
  End
End

-- Insertion de la trace
EXEC sysadm.PS_I01_TRACE_TRT_FRAIS_PRESTA @dcIdSin, 
    @iIdSeq, 
    @dcIdProd, 
    @sIdFour,  
    @dcIdGti,   
    @dcIdProcess,   
    @sAltProd,   
    @sResult,   
    @sTxtErr,
    @dtToday,
    @sMajPar


Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       25/11/2009
-- Libelle              :        
-- Commentaires         :       Select dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.DW_S01_TRT_FRAIS_PRESTA
As 
  Select id_sin, 
    id_seq_cmd, 
    cod_dept, 
    id_adh, 
    id_prod_adh, 
    id_ets, 
    id_sdos, 
    rib_bq, 
    rib_ag, 
    rib_cpt, 
    rib_cle, 
    lib_ag, 
    lib_reglement, 
    montant, 
    monnaie, 
    moyen_paiement, 
    cod_civ, 
    cod_inter, nom_assure, 
    adr_1, 
    adr_2, 
    adr_cp, 
    adr_ville, 
    ordre_chq, 
    top_valide, 
    top_info, 
    no_cie, 
    no_contrat, 
    id_prod, 
    cod_pec_spb, 
    cod_pec_presta, 
    cod_pec_assureur, 
    cod_presta, 
    cod_pos, cree_le,maj_le, maj_par
  From sysadm.trt_frais_presta
  Where cod_pos = 1
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_TRT_FRAIS_PRESTA_V01
-- Auteur               :       F. Pinon
-- Date                 :       24/05/2012
-- Libelle              :        
-- Commentaires         :       Select dans la table TRT_FRAIS_PRESTA 
-- References           :       [VDOC7806]
--
-- Arguments            :      	Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TRT_FRAIS_PRESTA_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TRT_FRAIS_PRESTA_V01
GO

CREATE PROCEDURE sysadm.DW_S01_TRT_FRAIS_PRESTA_V01
As 
  Select id_sin, 
    id_seq_cmd, 
    cod_dept, 
    id_adh, 
    id_prod_adh, 
    id_ets, 
    id_sdos, 
    rib_bq, 
    rib_ag, 
    rib_cpt, 
    rib_cle, 
    lib_ag, 
    lib_reglement, 
    montant, 
    monnaie, 
    moyen_paiement, 
    cod_civ, 
    cod_inter, nom_assure, 
    adr_1, 
    adr_2, 
    adr_cp, 
    adr_ville, 
    ordre_chq, 
    top_valide, 
    top_info, 
    no_cie, 
    no_contrat, 
    id_prod, 
    cod_pec_spb, 
    cod_pec_presta, 
    cod_pec_assureur, 
    cod_presta, 
    cod_pos, cree_le,maj_le, maj_par,
	(select count(*) from sysadm.det_pro d where d.id_prod=t.id_prod and id_code_dp=213) dp_213_presente,
	NULL as id_iban_dest,
	NULL as id_bic_dest
  From sysadm.trt_frais_presta t
  Where cod_pos = 1
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U01_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       25/11/2009
-- Libelle              :        
-- Commentaires         :       Update du cod_pos dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_U01_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.PS_U01_TRT_FRAIS_PRESTA
  @iCodPos	int,
  @iCodPosNew	int,
  @sMajPar	varchar(4)

As 
  Declare @dteMaj datetime
  
  Set @dteMaj =getdate()
  
  If @iCodPosNew=2
  Begin
   Update sysadm.trt_frais_presta
   Set dte_trt=@dteMaj
   Where cod_pos = @iCodPos
  End
  
  Update sysadm.trt_frais_presta
  Set cod_pos = @iCodPosNew, maj_le=@dteMaj, maj_par = @sMajPar
  Where cod_pos = @iCodPos
Go
  
--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       04/01/2010
-- Libelle              :        
-- Commentaires         :       Select dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.DW_S02_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.DW_S02_TRT_FRAIS_PRESTA
	@sIdSin	Decimal(10,0) -- [PI062]
As 
  Select t.id_sin, 
    t.id_seq_cmd, 
	t.id_seq,
	t.lib_reglement, 
    t.montant, 
    CASE t.moyen_paiement WHEN 'C' THEN 'Chèque'
	ELSE 'Virement' END as moyen_paiement,
    t.cod_presta,   t.cod_pos, t.cree_le,t.maj_le, t.maj_par
  From sysadm.trt_frais_presta t
  Where t.id_sin = -1
  order by t.maj_le desc
  
GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S03_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       04/04/2011 - VDoc 3603
-- Libelle              :        
-- Commentaires         :       Select dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_TRT_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.DW_S03_TRT_FRAIS_PRESTA
GO

CREATE PROCEDURE sysadm.DW_S03_TRT_FRAIS_PRESTA
As 
  Select t.id_sin, 
    t.id_seq_cmd, 
    t.cod_dept, 
    t.id_adh, 
    t.id_prod_adh, 
    t.id_ets, 
    t.id_sdos, 
    t.rib_bq, 
    t.rib_ag, 
    t.rib_cpt, 
    t.rib_cle, 
    t.lib_ag, 
    t.lib_reglement, 
    t.montant, 
    t.monnaie, 
    t.moyen_paiement, 
    t.cod_civ, 
    t.cod_inter, t.nom_assure, 
    t.adr_1, 
    t.adr_2, 
    t.adr_cp, 
    t.adr_ville, 
    t.ordre_chq, 
    t.top_valide, 
    t.top_info, 
    t.no_cie, 
    t.no_contrat, 
    t.id_prod, 
    t.cod_pec_spb, 
    t.cod_pec_presta, 
    t.cod_pec_assureur, 
    t.cod_presta, 
    t.cod_pos, t.cree_le, t.maj_le, t.maj_par,
    sysadm.FN_CODE_CAR(d.val_car,'-AR') as type_appareil,
    c.info_spb_frn as code_process,
    sysadm.FN_CODE_NUM(c.info_spb_frn,'-IF') as lib_process
  From sysadm.trt_frais_presta t
  inner join commande c on t.id_sin = c.id_sin and c.id_seq=t.id_seq_cmd
  left outer join div_sin d on d.id_sin=t.id_sin and d.nom_zone='type_app'
  Where t.cod_pos = 1
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_I02_TRT_FRAIS_PRESTA
-- Auteur               :       F. Pinon
-- Date                 :       18/08/2011
-- Libelle              :        
-- Commentaires         :       Insertion dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	@dcIdSin		decimal(7,0)	(Val)
--				@sMajPar 		char(4)			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 05/08/2010 FPI [PM72] Ajout de la colonne typ_rbt
-- 15/12/2010 FPI [ITSM94758] Le libellé de l'agence n'est pas forcément dans la table agence
-- 28/12/2011 FPI [ITSM96269] Suppression de la condition sur DP 176 (car pec à 0)
-- 07/06/2012 FPI [PM103] - V01 - ajout critère mode_reprise
-- 17/04/2014 FPI [DT141] - frais presta
-- 02/03/2015 FPI [ITSM367095] - Correction mode de règlement à chèque/défaut - remis à T si RIB renseigné
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_TRT_FRAIS_PRESTA_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I02_TRT_FRAIS_PRESTA_V01
GO

CREATE PROCEDURE sysadm.PS_I02_TRT_FRAIS_PRESTA_V01
  @dcIdSin	decimal(10,0), -- [PI062]
  @dcMtReg	decimal(11,2),
  @sMajPar char(4),
  @sModeReprise char(1)

As

Declare @sCodDept	varchar(35),
  @sIdAdh	varchar(19),
  @iIdProdAdh	int,
  @iIdEts	int,
  @iIdSdos	int,
  @sRibBq	char(5),
  @sRibAg char(5),
  @sRibCpt char(11),
  @sRibCle char(2),
  @sLibAg	varchar(24),
  @sLibReglt	varchar(31),
  @sMoyenPaiement	char(1),
  @sCodCiv	char(1),
  @sNomAssure	varchar(71),
  @sAdr1	varchar(35),
  @sAdr2	varchar(35),
  @sAdrCp	varchar(5),
  @sAdrVille	varchar(35),
  @sOrdreChq	varchar(35),
  @iNoCie	int,
  @sNoContrat	varchar(20),
  @sResult char(1),
  @sTxtErr varchar(255), 
  @sAltProd char(1),
  @dtToday datetime,
  @dcIdRev decimal(7,0),
  @dcIdProd decimal(7,0),
  @dcIdGti decimal(7,0),
  @iIdSeq int,
  @iIdProcess int,
  @dcCodPecSpb	decimal(7,2),
  @dcCodPecPresta decimal(7,2),
  @dcCodPecAssureur decimal(7,2),
  @sMess	VarChar ( 255 ),
  @iIdCt	Integer ,
  @iCodPos Integer,
  @sIdFour varchar(3)
    
Set @sResult = 'O'
Set @iCodPos=0

If @sModeReprise='O' Set @iCodPos=2

-- Récupération des données depuis 'sinistre'
Select top 1 @sIdAdh = s.id_adh,
    @iIdEts = s.id_ets,
    @iIdSdos = s.id_sdos,
    @dcIdRev = s.id_rev,
    @dcIdProd = s.id_prod, 
    @iIdSeq = c.id_seq,
    @iIdProcess = c.info_spb_frn,
    @dcIdGti = c.id_gti,
    @sIdFour = c.id_four -- [DT141] 
From sysadm.sinistre s
	inner join sysadm.commande c on c.id_sin=s.id_sin
Where s.id_sin = @dcIdSin
	And c.id_four in ('O2M','SBE') -- [DT141] ajout de SBE
    And c.id_ref_four='A_DIAGNOSTIQUER' 
    And c.cod_etat<>'ANN'

if @@RowCount = 0 
Begin
  select @sResult='N',
    @sTxtErr='No dossier incorrect/commande introuvable'
End

If @sResult='O'
Begin
  Select @dcCodPecSpb = cod_pec_spb,
    @dcCodPecPresta = cod_pec_presta,
    @dcCodPecAssureur = cod_pec_assureur,
    @sAltProd = alt_prod 
  From sysadm.param_frais
  Where id_prod = @dcIdProd
    and id_four = @sIdFour -- [DT141] 
    and id_gti = @dcIdGti
    and id_process = @iIdProcess

  if @@RowCount = 0 
  Begin
	-- If not exists (select * from sysadm.det_pro where id_prod=@dcIdProd and id_code_dp=176)
	-- Begin
        select @sResult='N',
        @sTxtErr='Paramétrage absent'
      --End
  End
  
 
End

If @sResult='O' 
Begin 
  -- Récupération des données de l'inter assuré
  Select @sRibBq=rib_bq,
    @sRibAg = rib_gui,
    @sRibCpt = rib_cpt,
    @sRibCle = rib_cle,
    @sAdr1 = adr_1,
    @sAdr2 = adr_2,
    @sAdrCp = adr_cp,
    @sAdrVille = adr_ville,
    @sOrdreChq = Case When rib_gui is not null Then NULL Else nom End,
    @sNomAssure = nom, 
    @sCodCiv = cod_civ
  From sysadm.inter
  Where id_sin = @dcIdSin
    and cod_inter='A'

  if @@RowCount = 0 
  Begin
    select @sResult='N',
      @sTxtErr='Inter assuré non trouvé'
  End
End

-- Récupération du produit adhésion et département de gestion
If @sResult='O'
Begin
  Select @iIdProdAdh = p.cod_prod_dms,
    @sCodDept = d.lib_dept,
    @iNoCie = pol.id_cie,
    @sNoContrat = pol.lib_police
  From sysadm.produit p
    Inner join sysadm.departement d on p.id_dept = d.id_dept
    Inner join sysadm.garantie gti on gti.id_prod=p.id_prod
    Inner Join sysadm.police pol on gti.id_police = pol.id_police
  where p.id_prod = @dcIdProd
    And gti.id_gti = @dcIdGti
    And gti.id_rev = @dcIdRev
    
  if @@RowCount = 0 
  Begin
    select @sResult='N',
      @sTxtErr='Produit/département/police/garantie non trouvé'
  End
End 
  
 Set @dtToday=getdate()

-- Affectation du moyen de paiement et du libellé d'agence
If @sRibAg is null 
Begin
  Select @sMoyenPaiement = 'C', @sLibAg=NULL
End
Else
Begin
  Select @sLibAg = lib_ag
  From sysadm.agence
  Where id_bq = @sRibBq and id_ag = @sRibAg
  
  Set @sMoyenPaiement = 'T' -- [ITSM94758] -- [ITSM367095]
End

Set @sLibReglt= 'SPB FRAIS ' + convert(varchar(10), @dcIdSin)  -- [PI062]
If @sModeReprise='O' Set @sLibReglt= '[RBM] '+ @sLibReglt

-- Insertion dans la table de traitement
If @sResult='O'
Begin
  INSERT INTO sysadm.trt_frais_presta(
    id_sin, id_seq_cmd, cod_dept, 
    id_adh, id_prod_adh, id_ets, id_sdos, 
    rib_bq, rib_ag, rib_cpt, rib_cle, 
    lib_ag, lib_reglement, montant, 
    monnaie, moyen_paiement, 
    cod_civ, cod_inter, nom_assure, 
    adr_1, adr_2, adr_cp, adr_ville, 
    ordre_chq, top_valide, top_info, 
    no_cie, no_contrat, id_prod, 
    cod_pec_spb, cod_pec_presta, cod_pec_assureur, cod_presta, 
    cod_pos, cree_le, maj_le, maj_par)
VALUES(@dcIdSin,  @iIdSeq,  @sCodDept,  
    @sIdAdh,  @iIdProdAdh,  @iIdEts,  @iIdSdos,  
    @sRibBq,  @sRibAg,  @sRibCpt,  @sRibCle,  
    @sLibAg,  @sLibReglt,  @dcMtReg,  
    'EUR',  @sMoyenPaiement,  
    @sCodCiv,  'A',  @sNomAssure,  
    @sAdr1,  @sAdr2,  @sAdrCp,  @sAdrVille,  
    @sOrdreChq,  1,  0,  
    @iNoCie,  @sNoContrat,  @dcIdProd,  
    @dcCodPecSpb, @dcCodPecPresta, @dcCodPecAssureur, @sIdFour,  
    @iCodPos,  @dtToday, @dtToday, @sMajPar)

  if @@RowCount = 0 
  Begin
    select @sResult='N',
      @sTxtErr='Erreur insertion dans trt_frais_presta'
  End
End 

-- Insertion de la trace
EXEC sysadm.PS_I01_TRACE_TRT_FRAIS_PRESTA @dcIdSin, @iIdSeq, 
    @dcIdProd, @sIdFour,  @dcIdGti,   @iIdProcess, @sAltProd,   
    @sResult, @sTxtErr, @dtToday, @sMajPar

-- Insertion d'un contact
Set @sMess = 'Règlement direct vers Volcanes d''un frais d''envoi lié à une prestation ' + @sIdFour + ' d''un montant de ' + rTrim ( Convert ( VarChar ( 10), @dcMtReg ) ) + ' €.'

If @sModeReprise='O' Set @sMess = '[Déjà réglé en base manuelle] '+ @sMess

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1,	/* Le Client est trouvé automatiquement par la proc */
						2,		/* Famille : Sinistre */
						4,		/* Type de Contact : Information */
						'C',		/* Canal : Courrier */
						@dcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,		/* Le message du Contact */
						@sMajPar,		/* Trig. Virtuel O2M */
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
						2,		/* Famille : Sinistre */
						4,		/* Type de Contact : Information */
						'C',		/* Canal : Courrier */
						@dcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,		/* Le message du Contact */
						@sMajPar,		/* Trig. Virtuel O2M */
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */

END

Go

grant execute on sysadm.PS_I02_TRT_FRAIS_PRESTA_V01 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CTRLE_EXISTS_RGLT
-- Auteur               :       JFF
-- Date                 :       26/08/2020
-- Libelle              :        
-- Commentaires         :       Insertion dans la table TRT_FRAIS_PRESTA 
-- References           :       
--
-- Arguments            :      	@dcIdSin		decimal(7,0)	(Val)
--				@sMajPar 		char(4)			(Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CTRLE_EXISTS_RGLT' AND type = 'P' )
        DROP procedure sysadm.PS_S_CTRLE_EXISTS_RGLT
GO

CREATE PROCEDURE sysadm.PS_S_CTRLE_EXISTS_RGLT
  @dcIdSin	decimal(10,0) -- [PI062]
As

If Exists (select * from sysadm.trt_frais_presta where id_sin=@dcIdSin ) Return 1 

Return 0 

Go
