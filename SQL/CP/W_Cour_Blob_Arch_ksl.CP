-------------------------------------------------------------------
--
-- Fichier              :       W_COUR_BLOB_ARCH_KSL.CP
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014
--								[PI052]
-- Commentaires         :       Gestion de la table W_COUR_BLOB_ARCH_KSL
--
-- Procédures           :       
--                      :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_WCBA_KSL_EDT
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       Edition
-- Commentaires         :       Sélect sur la table W_COUR_BLOB_ARCH_KSL + Commit à faire par le client !!!!
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_WCBA_KSL_EDT' AND type = 'P' )
        DROP procedure sysadm.PS_S_WCBA_KSL_EDT
GO

CREATE procedure sysadm.PS_S_WCBA_KSL_EDT
AS

Declare @iIdLot Integer
Declare @dcIdDocEdt Decimal ( 9, 0)  -- Decimal ( 7, 0)
Declare @sIdDocEdt varchar ( 30 )

SET NOCOUNT ON

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_arch	Integer,
	  marquage	integer null 
	)

Declare @iIdArch Integer
Declare @iIdSeq integer

-- Récup de d'un LOT
Begin Tran
	EXEC sysadm.PS_X_INCREMENTER 'ID_LOT_EDT', @iIdLot OUTPUT
Commit Tran
	
-- Marquage du LOT
Begin Tran
	Update	sysadm.w_cour_blob_arch
	Set		id_lot = @iIdLot,
			dte_edit = GetDate ()
	From	sysadm.w_cour_blob_arch wcba,
			sysadm.w_cour_blob_arch_ksl wcba_ksl
		
	Where	wcba.id_lot = 0 
	And     wcba_ksl.id_arch = wcba.id_arch
	And		wcba.alt_fn = 'N'
	And		wcba.dte_edit is null
	And		wcba.id_doc_edt is null
Commit Tran
	
-- Marquage id_doc_edt sur tout le Lot
Insert into @tb
select	wcba_ksl.id_arch,
		0 'marquage'
from	sysadm.w_cour_blob_arch wcba,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba.id_lot = @iIdLot 
And     wcba_ksl.id_arch = wcba.id_arch
And		wcba.alt_fn = 'N'
And		wcba.id_doc_edt is null

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@iIdArch = id_arch
	From	@tb
	Where	marquage = 0

	Begin Tran
		EXEC sysadm.PS_X_INCREMENTER 'ID_DOC_EDT', @dcIdDocEdt OUTPUT
	Commit Tran

	Set @sIdDocEdt = CONVERT ( VarChar ( 30 ), @dcIdDocEdt )

	Set @sIdDocEdt =  '0421' + REPLICATE ( '0', 7 - LEN ( @sIdDocEdt ) ) + CONVERT ( VARCHAR, @sIdDocEdt )

	Update	sysadm.w_cour_blob_arch
	Set		id_doc_edt = @sIdDocEdt 
	Where   id_arch = @iIdArch
		
	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

-- Archivage
Exec sysadm.PS_U_WCBA_KSL_ARCHIVAGE @iIdLot

-- Select Final
select	@iIdLot id_lot,
		wcba.id_arch,
		wcba.id_sin,
		wcba.id_inter,
		wcba_ksl.format_doc,
		wcba_ksl.id_ksl,
		wcba_ksl.type_courrier,
		wcba.id_typ_doc id_nat_doc,
		sysadm.FN_CODE_NUM ( wcba.id_typ_doc, '-ND' ) lib_nat_doc,
		wcba.id_doc_edt
from	sysadm.w_cour_blob_arch wcba,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba.id_lot = @iIdLot 
And     wcba_ksl.id_arch = wcba.id_arch
Order by wcba.id_sin,
		 wcba.id_inter

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_WCBA_KSL_REEDT
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       Réédition
-- Commentaires         :       Sélect sur la table W_COUR_BLOB_ARCH_KSL (pas de commit)
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_WCBA_KSL_REEDT' AND type = 'P' )
        DROP procedure sysadm.PS_S_WCBA_KSL_REEDT
GO

CREATE procedure sysadm.PS_S_WCBA_KSL_REEDT
	@iIdLot	Integer
AS

SET NOCOUNT ON

-- Select Final
select	wcba.id_lot,
		wcba.id_arch,
		wcba.id_sin,
		wcba.id_inter,
		wcba_ksl.format_doc,
		wcba_ksl.id_ksl,
		wcba_ksl.type_courrier,
		wcba.id_typ_doc id_nat_doc,
		sysadm.FN_CODE_NUM ( wcba.id_typ_doc, '-ND') lib_nat_doc,
		wcba.id_doc_edt
from	sysadm.w_cour_blob_arch wcba,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba.id_lot = @iIdLot 
And     wcba_ksl.id_arch = wcba.id_arch
Order by wcba.id_sin,
		 wcba.id_inter


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_WCBA_KSL_EDT_RELANCE
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       Edition
-- Commentaires         :       
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_WCBA_KSL_EDT_RELANCE' AND type = 'P' )
        DROP procedure sysadm.PS_S_WCBA_KSL_EDT_RELANCE
GO

CREATE procedure sysadm.PS_S_WCBA_KSL_EDT_RELANCE
AS

Declare @iIdLot Integer
Declare @dcIdDocEdt Decimal ( 9, 0)  -- Decimal ( 7, 0)
Declare @sIdDocEdt varchar ( 30 )

SET NOCOUNT ON

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_arch	Integer,
	  marquage	integer null 
	)

Declare @iIdArch Integer
Declare @iIdSeq integer

-- Récupération du lot de relance à éditer
Select  @iIdLot = MIN ( wcba_ksl.id_lot_rgt_rel ) 
From	sysadm.archive a,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba_ksl.id_arch = a.id_arch
And		( a.dte_edit is null or a.dte_edit = '01/01/1900' )
And		wcba_ksl.id_lot_rgt_rel is not null
And		wcba_ksl.type_courrier in ( 'RELANCE_ORIG', 'RELANCE_RELA' )

If 	@iIdLot is null 
  Begin
	return
  End 
	
-- Marquage id_doc_edt sur tout le Lot
Insert into @tb
select	wcba_ksl.id_arch,
		0 'marquage'
from	sysadm.archive a,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba_ksl.id_arch = a.id_arch
And		( a.dte_edit is null or a.dte_edit = '01/01/1900' )
And		wcba_ksl.id_lot_rgt_rel is not null
And		wcba_ksl.type_courrier in ( 'RELANCE_ORIG', 'RELANCE_RELA' )
And		wcba_ksl.id_lot_rgt_rel = @iIdLot

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@iIdArch = id_arch
	From	@tb
	Where	marquage = 0

	UPDATE sysadm.archive
	SET    dte_edit = GETDATE()
	Where  id_arch = @iIdArch
	
	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

-- Select Final
select	@iIdLot id_lot,
		a.id_arch,
		a.id_sin,
		a.id_inter,
		wcba_ksl.format_doc,
		wcba_ksl.id_ksl,
		wcba_ksl.type_courrier,
		null id_nat_doc,
		null lib_nat_doc,
		null id_doc_edt
from	sysadm.archive a,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba_ksl.id_arch = a.id_arch
And		wcba_ksl.id_lot_rgt_rel is not null
And		wcba_ksl.type_courrier in ( 'RELANCE_ORIG', 'RELANCE_RELA' )
And		wcba_ksl.id_lot_rgt_rel = @iIdLot
Order by a.id_sin,
		 a.id_inter,
		 wcba_ksl.type_courrier


Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_WCBA_KSL_REEDT_RELANCE
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       Réédition
-- Commentaires         :       Sélect sur la table W_COUR_BLOB_ARCH_KSL (pas de commit)
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_WCBA_KSL_REEDT_RELANCE' AND type = 'P' )
        DROP procedure sysadm.PS_S_WCBA_KSL_REEDT_RELANCE
GO

CREATE procedure sysadm.PS_S_WCBA_KSL_REEDT_RELANCE
	@iIdLotRgptRel	Integer 
AS

SET NOCOUNT ON

-- Select Final
select	@iIdLotRgptRel id_lot,
		a.id_arch,
		a.id_sin,
		a.id_inter,
		wcba_ksl.format_doc,
		wcba_ksl.id_ksl,
		wcba_ksl.type_courrier,
		null id_nat_doc,
		null lib_nat_doc,
		null id_doc_edt
from	sysadm.archive a,
		sysadm.w_cour_blob_arch_ksl wcba_ksl
Where	wcba_ksl.id_arch = a.id_arch
And		wcba_ksl.id_lot_rgt_rel is not null
And		wcba_ksl.type_courrier in ( 'RELANCE_ORIG', 'RELANCE_RELA' )
And		wcba_ksl.id_lot_rgt_rel = @iIdLotRgptRel
And		a.dte_edit is not null
And		a.dte_edit <> '01/01/1900'
Order by a.id_sin,
		 a.id_inter,
		 wcba_ksl.type_courrier

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_WCBA_KSL_ARCHIVAGE
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       Archivage
-- Commentaires         :       + commit
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_WCBA_KSL_ARCHIVAGE' AND type = 'P' )
        DROP procedure sysadm.PS_U_WCBA_KSL_ARCHIVAGE
GO

CREATE procedure sysadm.PS_U_WCBA_KSL_ARCHIVAGE
	@iIdLot	Integer
AS

Declare @sMess VarChar ( 60 )
Set @sMess = SPACE ( 60 ) 

SET NOCOUNT ON

Exec sysadm.PS_I02_ARCHIVE_BLOB_VAL @iIdLot, @sMess OUTPUT

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_WCBA_KSL_FORMAT
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_WCBA_KSL_FORMAT' AND type = 'P' )
        DROP procedure sysadm.PS_S_WCBA_KSL_FORMAT
GO

CREATE procedure sysadm.PS_S_WCBA_KSL_FORMAT
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@dcIdInter  Decimal ( 7 ),
	@dcIdDoc    Decimal ( 7 ),
	@sformatDoc	Varchar ( 10 ) OUTPUT
AS

Select @sformatDoc	= wcba_ksl.format_doc
from   sysadm.archive a,
	   sysadm.w_cour_blob_arch_ksl wcba_ksl
Where  a.id_sin = @dcIdSin
And	   a.id_inter = @dcIdInter
And    a.id_doc = @dcIdDoc
And	   wcba_ksl.id_arch = a.id_arch  -- Indique si la jointure se fait que du KSL (PDF)

If ( @sformatDoc is null ) Or ( lTrim ( @sformatDoc ) ) = '' Set @sformatDoc = 'ANCIEN_DOC'

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_WCBA_KSL_COUR_RELANCE
-- Auteur               :       Fabry JF
-- Date                 :       26/08/2014 
-- Libellé              :       
-- Commentaires         :       Insertion simple, rien à voir avec PS_I01_ARCHIVE_VAL_SVE où c'est une autre insertion
-- Références           :       Uniquement pour traiter le courrier original lié à une relance
--                              
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_WCBA_KSL_COUR_RELANCE' AND type = 'P' )
        DROP procedure sysadm.PS_I_WCBA_KSL_COUR_RELANCE
GO

CREATE procedure sysadm.PS_I_WCBA_KSL_COUR_RELANCE
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@dcIdInter  Decimal ( 7 ),
	@dcIdDoc    Decimal ( 7 ),
	@sFormatDoc Varchar ( 20 ),
	@sCleKSL	varchar ( 60 ),
	@sTypeCourrier varchar ( 20 ),
	@idLotRgtRel	Integer
	
AS

	Insert into sysadm.w_cour_blob_arch_ksl
	Select a.id_arch,
		   a.id_sin,
		   a.id_inter,
		   @sFormatDoc,
		   @sCleKSL,
		   @sTypeCourrier,
		   @idLotRgtRel,
		   getdate(),
		   getdate(),
		   'AUTO',
		   getdate(),
		   'AUTO'
	From sysadm.archive a
	Where	a.id_sin = @dcIdSin
	And		a.id_inter = @dcIdInter
	And		a.id_doc = @dcIdDoc

Go




--------------------------------------------------------------------
--
-- Procedure            :       PS_S_TYPE_DOC_PI052
-- Auteur               :       JFF
-- Date                 :       27/11/2014
-- Libelle              :       
-- Commentaires         :       [PI052]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TYPE_DOC_PI052' AND type = 'P' )
        DROP procedure sysadm.PS_S_TYPE_DOC_PI052
GO

CREATE procedure sysadm.PS_S_TYPE_DOC_PI052
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@dcIdInter  Decimal ( 7 ),
	@dcIdDoc    Decimal ( 7 ),
	@sTypFormat VarChar ( 10 ) OutPut
AS

	Select @sTypFormat = wcksl.format_doc
	From sysadm.archive a,
		 sysadm.w_cour_blob_arch_ksl wcksl
	Where	a.id_sin = @dcIdSin
	And		a.id_inter = @dcIdInter
	And		a.id_doc = @dcIdDoc
	And		wcksl.id_arch = a.id_arch
	
	If @sTypFormat is null Set @sTypFormat = ''
	If @sTypFormat = '' Set @sTypFormat = 'DOC'

Go

