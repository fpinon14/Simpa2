-------------------------------------------------------------------
--
-- Fichier              :       W_COUR_BLOB_ARCH.CP
-- Auteur               :       Fabry JF
-- Date                 :       30/03/2004
--
-- Commentaires         :       Gestion de la table W_COUR_BLOB_ARCH
--
-- Procédures           :       PS_I01_W_COUR_BLOB_ARCH
--				DW_S01_W_COUR_BLOB_ARCH_V01
--				DW_S02_W_COUR_BLOB_ARCH_V01
--				DW_S03_W_COUR_BLOB_ARCH_V01
--				DW_S04_W_COUR_BLOB_ARCH_V01
--				PS_D01_W_COUR_BLOB_ARCH
--                      :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_COUR_BLOB_ARCH
-- Auteur               :       Fabry JF
-- Date                 :       30/03/2004 
-- Libellé              :        
-- Commentaires         :       Sélect sur la table W_COUR_BLOB_ARCH
-- Références           :       
--                              
-- Arguments            :               @dcIdSin        Decimal (  7,0 ),
--			        	@dcIdI          Decimal (  7,0 ),
--        				@dcIdCpt        Decimal (  4,0 ),
--				        @iCptArch	Integer
--				        @sCodOper       Varchar (  4   ),
--        				@dtValideLe     DateTime
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	02/11/2006	[DNTMAIL1-2] On enregistre le media ( Id_Canal )
-- JFF      12/02/2016   [PI062]
-- JFF      15/07/2025   [CONVERT_PDF_STOCK]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_COUR_BLOB_ARCH
GO
  
CREATE procedure sysadm.PS_I01_W_COUR_BLOB_ARCH  
        @dcIdSin        Decimal (  10,0 ), -- [PI062]  
        @dcIdI          Decimal (  7,0 ),  
        @dcIdCpt        Decimal (  4,0 ),  
        @iCptArch Integer,  
        @sCodOper       Varchar (  4   ),  
        @dtValideLe     DateTime,  
		@sId_Canal Varchar(2) -- #1 PHG 02/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )  
          
AS  
  
-- #1  PHG 02/11/2006 [DNTMAIL1-2] On enregistre le media ( Id_Canal )  
-- Selon le point 5.2.3 des spécifications, on duplique l'insert pour spécifier id_lot, dte_edit et Alt_fn selon IdCanal  
IF @sId_Canal = 'MA'   
BEGIN  
 INSERT INTO sysadm.w_cour_blob_arch    
  (   
   w_cour_blob_arch.id_arch,     
  w_cour_blob_arch.id_sin,     
  w_cour_blob_arch.id_inter,     
  w_cour_blob_arch.id_seq,     
  w_cour_blob_arch.id_typ_blob,     
  w_cour_blob_arch.id_lot,  
  w_cour_blob_arch.id_typ_doc,  
  w_cour_blob_arch.txt_blob,     
  w_cour_blob_arch.alt_fn,  
  w_cour_blob_arch.dte_edit, -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3  
  w_cour_blob_arch.cree_le,     
  w_cour_blob_arch.maj_le,     
  w_cour_blob_arch.maj_par,  
  w_cour_blob_arch.valide_le,     
  w_cour_blob_arch.valide_par  
  )    
 SELECT  
  @iCptArch,     
  w_cour_blob.id_sin,     
  w_cour_blob.id_i,     
  w_cour_blob.id_cpt,     
  w_cour_blob.id_typ_blob,     
  -1 ,   -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3 : Id_lot = -1  
  w_cour_blob.id_typ_doc ,     
  w_cour_blob.txt_blob   ,     
  'N',   -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3 : Alt_fn = 'N'  
  GetDate(),  -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3 : Dte_edit = GetDate()  
  w_cour_blob.cree_le    ,     
  w_cour_blob.maj_le     ,     
  w_cour_blob.maj_par    ,  
  @dtValideLe  ,  
  @sCodOper  
  
 FROM     sysadm.w_cour_blob  
 WHERE   w_cour_blob.id_sin   = @dcIdSin      
 And  w_cour_blob.id_i        = @dcIdI  
 And     w_cour_blob.id_cpt      = @dcIdCpt      
 And     w_cour_blob.id_typ_blob = 'DO'  
END  
  
IF @sId_Canal = 'CO'  -- JFF Le 16/11/2006, j'enlève le ELSE  
BEGIN  
  
 INSERT INTO sysadm.w_cour_blob_arch    
  (   
   w_cour_blob_arch.id_arch,     
  w_cour_blob_arch.id_sin,     
  w_cour_blob_arch.id_inter,     
  w_cour_blob_arch.id_seq,     
  w_cour_blob_arch.id_typ_blob,     
  w_cour_blob_arch.id_lot,  
  w_cour_blob_arch.id_typ_doc,  
  w_cour_blob_arch.txt_blob,     
  w_cour_blob_arch.alt_fn,  
  w_cour_blob_arch.dte_edit, -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3  
  w_cour_blob_arch.cree_le,     
  w_cour_blob_arch.maj_le,     
  w_cour_blob_arch.maj_par,  
  w_cour_blob_arch.valide_le,     
  w_cour_blob_arch.valide_par  
  )    
 SELECT  
  @iCptArch,     
  w_cour_blob.id_sin,     
  w_cour_blob.id_i,     
  w_cour_blob.id_cpt,     
  w_cour_blob.id_typ_blob,     
  0 ,  
  w_cour_blob.id_typ_doc ,     
  w_cour_blob.txt_blob   ,     
  'N',  
  NULL, -- #1 PHG 02/11/2006 [DNTMAIL1-2] Point 5.2.3  
  w_cour_blob.cree_le    ,     
  w_cour_blob.maj_le     ,     
  w_cour_blob.maj_par    ,  
  @dtValideLe  ,  
  @sCodOper  
  
 FROM     sysadm.w_cour_blob  
 WHERE   w_cour_blob.id_sin   = @dcIdSin      
 And     w_cour_blob.id_i        = @dcIdI  
 And     w_cour_blob.id_cpt      = @dcIdCpt      
 And     w_cour_blob.id_typ_blob = 'DO'  
  
END  
  
If @@Error <> 0 Return @@Error  

-- [CONVERT_PDF_STOCK]
If sysadm.FN_CLE_NUMERIQUE ( 'CONVERT_PDF_STOCK_1') > 0 
 Begin
	Update pdf
	Set id_arch = @iCptArch
	FROM sysadm.w_cour_blob wcb,
		 sysadm.courrier_pdf pdf
	WHERE wcb.id_sin 	 = @dcIdSin    
	And	  wcb.id_i        = @dcIdI
	And   wcb.id_cpt      = @dcIdCpt    
	And   wcb.id_typ_blob = 'DO'
	And   pdf.id_seq = wcb.id_pdf
 End 
  
Return @@Error  

Go

-------------------------------------------------------------------
-- Procedure            :       DW_S01_W_COUR_BLOB_ARCH_V01
-- Auteur               :       Fabry JF (Reprise de PLJ)
-- Date                 :       07/04/2004
-- Libelle              :        
-- Commentaires         :       Recuperation des type DOC avec le nombre de courrier pour chacun
--                               
-- References           :       w_ae_sp_edition
--
-- Arguments            :       @sMajPar
--				@sIdSin         
--				@dtMajLe
--				@ilIdProd
--				@ilIdDept
--				
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/06/2014   [PI052]
-- JFF		12/02/2016	 [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_COUR_BLOB_ARCH_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_COUR_BLOB_ARCH_V01
Go

CREATE procedure sysadm.DW_S01_W_COUR_BLOB_ARCH_V01
        @sMajPar                Char    (    4 ),
        @iIdSin                 Integer         ,
        @dtMajLe                DateTime        ,
        @ilIdProd               Integer         ,
        @ilIdDept               Integer

/*------------------------------------------------------------------*/
/* Le 03/09/2006 22:45 - Mise en place du N° chrono.                */
/* Ajout de la zone ID_DOC_EDT dans la sélection.                   */
/*------------------------------------------------------------------*/

AS

DECLARE @dcIdSin        DECIMAL ( 10 ), -- [PI062]
        @dcIdProd       DECIMAL ( 7 ),
        @dcIdDept       DECIMAL ( 7 )

SET     @dcIdSin        = CONVERT ( DECIMAL ( 10 ), @iIdSin ) -- [PI062]
SET     @dcIdProd       = CONVERT ( DECIMAL ( 7 ), @ilIdProd )
SET     @dcIdDept       = CONVERT ( DECIMAL ( 7 ), @ilIdDept )

SELECT  @dtMajLe        = DATEADD ( DAY, 1, @dtMajLe )

-- [PI052]
If sysadm.FN_CLE_NUMERIQUE ( 'PI052') > 0 
 Begin
	SELECT  w_cour_blob_arch.id_typ_doc,
			code.lib_code,
			COUNT ( w_cour_blob_arch.id_typ_doc ),
			DATEADD ( minute, 1, MAX ( w_cour_blob_arch.maj_le     ) ),
			'N'              AS alt_select

	FROM    sysadm.code,
			sysadm.w_cour_blob_arch,
			sysadm.produit          AS p,
			sysadm.sinistre         AS s               

	WHERE   w_cour_blob_arch.id_typ_doc     = code.id_code                          AND
			w_cour_blob_arch.id_lot         = 0                                     AND
			w_cour_blob_arch.alt_fn         = 'N'                                   AND
			w_cour_blob_arch.dte_edit IS NULL                                       AND
			w_cour_blob_arch.id_doc_edt IS NULL                                     AND
			code.id_typ_code                = '-ND'                                 AND
			code.id_code                    >= 0                                    AND
			s.id_sin                        = w_cour_blob_arch.id_sin               AND
			s.id_prod                       = p.id_prod                             AND
			( w_cour_blob_arch.maj_par      = @sMajPar  OR @sMajPar  IS NULL )      AND
			( w_cour_blob_arch.maj_le       < @dtMajLe  OR @dtMajLe  IS NULL )      AND
			( w_cour_blob_arch.id_sin       = @dcIdSin  OR @dcIdSin  IS NULL )      AND
			( p.id_prod                     = @dcIdProd OR @dcIdProd IS NULL )      AND
			( p.id_depts                    = @dcIdDept OR @dcIdDept IS NULL )		AND
			-- [PI052]
			Not Exists ( 
				Select	1
				From	sysadm.w_cour_blob_arch_ksl wcbk
				Where	wcbk.id_arch = w_cour_blob_arch.id_arch
			)

	GROUP BY
			w_cour_blob_arch.id_typ_doc,
			code.lib_code
 End 
Else
 Begin 
	SELECT  w_cour_blob_arch.id_typ_doc,
			code.lib_code,
			COUNT ( w_cour_blob_arch.id_typ_doc ),
			DATEADD ( minute, 1, MAX ( w_cour_blob_arch.maj_le     ) ),
			'N'              AS alt_select

	FROM    sysadm.code,
			sysadm.w_cour_blob_arch,
			sysadm.produit          AS p,
			sysadm.sinistre         AS s               

	WHERE   w_cour_blob_arch.id_typ_doc     = code.id_code                          AND
			w_cour_blob_arch.id_lot         = 0                                     AND
			w_cour_blob_arch.alt_fn         = 'N'                                   AND
			w_cour_blob_arch.dte_edit IS NULL                                       AND
			w_cour_blob_arch.id_doc_edt IS NULL                                     AND
			code.id_typ_code                = '-ND'                                 AND
			code.id_code                    >= 0                                    AND
			s.id_sin                        = w_cour_blob_arch.id_sin               AND
			s.id_prod                       = p.id_prod                             AND
			( w_cour_blob_arch.maj_par      = @sMajPar  OR @sMajPar  IS NULL )      AND
			( w_cour_blob_arch.maj_le       < @dtMajLe  OR @dtMajLe  IS NULL )      AND
			( w_cour_blob_arch.id_sin       = @dcIdSin  OR @dcIdSin  IS NULL )      AND
			( p.id_prod                     = @dcIdProd OR @dcIdProd IS NULL )      AND
			( p.id_depts                    = @dcIdDept OR @dcIdDept IS NULL )

	GROUP BY
			w_cour_blob_arch.id_typ_doc,
			code.lib_code
 End

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_W_COUR_BLOB_ARCH_V01
-- Auteur               :       Fabry JF (Reprise de PLJ)
-- Date                 :       07/04/2004
-- Libelle              :                    :        
-- Commentaires         :       Sélection de la liste des courriers à éditer
--
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_COUR_BLOB_ARCH_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_COUR_BLOB_ARCH_V01
GO

CREATE PROCEDURE sysadm.DW_S02_W_COUR_BLOB_ARCH_V01
        @sMajPar                Char    (    4 ),
        @iIdSin                 Integer         ,
        @dtMaxMajLe             DateTime        ,
        @iIdTypDoc              Integer         ,
        @ilIdProd               Integer         ,
        @ilIdDept               Integer
AS

/*------------------------------------------------------------------*/
/* Le 03/09/2006 22:45 - Mise en place du N° chrono.                */
/* Ajout de la zone ID_DOC_EDT dans la sélection.                   */
/* Ajout de la colonne dans le SELECT. -> Changement de la DW       */
/*------------------------------------------------------------------*/

DECLARE @dcIdSin        DECIMAL ( 10 ), -- [PI062]
        @dcIdProd       DECIMAL ( 7 ),
        @dcIdDept       DECIMAL ( 7 )

SET     @dcIdSin        = CONVERT ( DECIMAL ( 10 ), @iIdSin ) -- [PI062]
SET     @dcIdProd       = CONVERT ( DECIMAL ( 7 ), @ilIdProd )
SET     @dcIdDept       = CONVERT ( DECIMAL ( 7 ), @ilIdDept )

SELECT  LTRIM ( RTRIM ( inter.nom ) ),
        w_cour_blob_arch.id_lot,
        w_cour_blob_arch.id_typ_doc,
        w_cour_blob_arch.id_arch,
        w_cour_blob_arch.id_sin,
        w_cour_blob_arch.id_inter,
        w_cour_blob_arch.id_seq,
        w_cour_blob_arch.dte_edit,
        w_cour_blob_arch.maj_le,
        w_cour_blob_arch.maj_par,
        produit.id_prod,
        produit.id_dept,
        w_cour_blob_arch.id_doc_edt
FROM    sysadm.w_cour_blob_arch,
        sysadm.inter,
        sysadm.sinistre,
        sysadm.produit
        
WHERE   sinistre.id_sin                 = w_cour_blob_arch.id_sin                       AND
        produit.id_prod                 = sinistre.id_prod                              AND
        w_cour_blob_arch.id_lot         = 0                                             AND
        w_cour_blob_arch.alt_fn         = 'N'                                           AND
        w_cour_blob_arch.dte_edit       IS NULL                                         AND
        w_cour_blob_arch.id_doc_edt     IS NULL                                         AND
        
        w_cour_blob_arch.id_typ_doc     = @iIdTypDoc                                    AND
        w_cour_blob_arch.maj_le         < @dtMaxMajLe                                   AND
        
        ( w_cour_blob_arch.id_sin       = @dcIdSin  OR @dcIdSin  IS NULL )              AND
        ( w_cour_blob_arch.maj_par      = @sMajPar  OR @sMajPar  IS NULL )              AND
        ( produit.id_prod               = @dcIdProd OR @dcIdProd IS NULL )              AND
        ( produit.id_depts              = @dcIdDept OR @dcIdDept IS NULL )              AND
        
        inter.id_sin                    = w_cour_blob_arch.id_sin                       AND
        inter.id_i                      = w_cour_blob_arch.id_inter

GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_S02_W_COUR_BLOB_ARCH_V02
-- Auteur               :		FPI
-- Date                 :       31/07/2014
-- Libelle              :      	[VDOC15000]   
-- Commentaires         :       Sélection de la liste des courriers à éditer
--
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_COUR_BLOB_ARCH_V02' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_COUR_BLOB_ARCH_V02
GO

CREATE procedure sysadm.DW_S02_W_COUR_BLOB_ARCH_V02
        @sMajPar                Char    (    4 ),
        @iIdSin                 Integer         ,
        @dtMaxMajLe             DateTime        ,
        @iIdTypDoc              Integer         ,
        @ilIdProd               Integer         ,
        @ilIdDept               Integer
AS

/*------------------------------------------------------------------*/
/* Le 03/09/2006 22:45 - Mise en place du N° chrono.                */
/* Ajout de la zone ID_DOC_EDT dans la sélection.                   */
/* Ajout de la colonne dans le SELECT. -> Changement de la DW       */
/*------------------------------------------------------------------*/

DECLARE @dcIdSin        DECIMAL ( 10 ), -- [PI062]
        @dcIdProd       DECIMAL ( 7 ),
        @dcIdDept       DECIMAL ( 7 )

SET     @dcIdSin        = CONVERT ( DECIMAL ( 10 ), @iIdSin ) -- [PI062]
SET     @dcIdProd       = CONVERT ( DECIMAL ( 7 ), @ilIdProd )
SET     @dcIdDept       = CONVERT ( DECIMAL ( 7 ), @ilIdDept )

SELECT  LTRIM ( RTRIM ( inter.nom ) ),
        w_cour_blob_arch.id_lot,
        w_cour_blob_arch.id_typ_doc,
        w_cour_blob_arch.id_arch,
        w_cour_blob_arch.id_sin,
        w_cour_blob_arch.id_inter,
        w_cour_blob_arch.id_seq,
        w_cour_blob_arch.dte_edit,
        w_cour_blob_arch.maj_le,
        w_cour_blob_arch.maj_par,
        produit.id_prod,
        produit.id_dept,
        w_cour_blob_arch.id_doc_edt,
        archive.id_cour,
        archive.id_cour_orig
        
FROM    sysadm.w_cour_blob_arch,
        sysadm.inter,
        sysadm.sinistre,
        sysadm.produit, 
        sysadm.archive
        
WHERE   sinistre.id_sin                 = w_cour_blob_arch.id_sin                       AND
        produit.id_prod                 = sinistre.id_prod                              AND
        w_cour_blob_arch.id_lot         = 0                                             AND
        w_cour_blob_arch.alt_fn         = 'N'                                           AND
        w_cour_blob_arch.dte_edit       IS NULL                                         AND
        w_cour_blob_arch.id_doc_edt     IS NULL                                         AND
        
        w_cour_blob_arch.id_typ_doc     = @iIdTypDoc                                    AND
        w_cour_blob_arch.maj_le         < @dtMaxMajLe                                   AND
        
        ( w_cour_blob_arch.id_sin       = @dcIdSin  OR @dcIdSin  IS NULL )              AND
        ( w_cour_blob_arch.maj_par      = @sMajPar  OR @sMajPar  IS NULL )              AND
        ( produit.id_prod               = @dcIdProd OR @dcIdProd IS NULL )              AND
        ( produit.id_depts              = @dcIdDept OR @dcIdDept IS NULL )              AND
        
        inter.id_sin                    = w_cour_blob_arch.id_sin                       AND
        inter.id_i                      = w_cour_blob_arch.id_inter						AND
		archive.id_arch					= w_cour_blob_arch.id_arch

GO

grant execute on sysadm.DW_S02_W_COUR_BLOB_ARCH_V02 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_S03_W_COUR_BLOB_ARCH_V01
-- Auteur               :       Fabry JF ( reprise de PLJ)
-- Date                 :       13/04/2004
-- Libelle              :        
-- Commentaires         :       Selection de la liste des courriers pour la reedition
--
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	03/11/2006	[DNTMAIL1-2] On exclu les éditions 'Mail' ( Point 6.1 )
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_W_COUR_BLOB_ARCH_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S03_W_COUR_BLOB_ARCH_V01
GO

CREATE procedure sysadm.DW_S03_W_COUR_BLOB_ARCH_V01
@iIdLot		Integer

AS


/*------------------------------------------------------------------*/
/* Le 03/09/2006 22:45 - Mise en place du N° chrono.                */
/* Ajout de la zone ID_DOC_EDT dans la sélection.                   */
/* Ajout de la zone ID_DEPT dans la sélection.                      */
/* Ajout des colonnes dans le SELECT. -> Changement de la DW        */
/*------------------------------------------------------------------*/
SELECT  inter.nom,
        w_cour_blob_arch.id_lot,
        w_cour_blob_arch.id_typ_doc,
        code.lib_code,
        w_cour_blob_arch.id_arch,
        w_cour_blob_arch.id_sin,
        w_cour_blob_arch.id_inter,
        w_cour_blob_arch.id_seq,
        w_cour_blob_arch.dte_edit,
        w_cour_blob_arch.maj_le,
        w_cour_blob_arch.maj_par,
        w_cour_blob_arch.id_doc_edt,
        produit.id_dept
FROM    sysadm.w_cour_blob_arch,
        sysadm.code,
        sysadm.inter,
        sysadm.sinistre,
        sysadm.produit
WHERE   w_cour_blob_arch.id_lot         = @iIdLot                               AND
        w_cour_blob_arch.id_sin         = inter.id_sin                          AND
        w_cour_blob_arch.id_inter       = inter.id_i                            AND
        w_cour_blob_arch.id_sin         = sinistre.id_sin                       AND
        sinistre.id_prod                = produit.id_prod                       AND
        code.id_typ_code                = '-ND'                                 AND
        w_cour_blob_arch.id_typ_doc     = CONVERT ( INTEGER, code.id_code )     AND
	w_cour_blob_arch.id_lot         > 0 -- #1 PHG 03/11/2006 [DNTMAIL1-2] On exclu les éditions 'Mail' ( Point 6.1 )

GO


--------------------------------------------------------------------
--
-- Procedure            :       DW_S04_W_COUR_BLOB_ARCH_V01
-- Auteur               :       Fabry JF ( reprise de PLJ)
-- Date                 :       13/04/2004
-- Libelle              :        
-- Commentaires         :       Selection de la liste des lots pour la reedition
--
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	03/11/2006	[DNTMAIL1-2] On exclu les éditions 'Mail' ( Point 6.1 )
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_W_COUR_BLOB_ARCH_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S04_W_COUR_BLOB_ARCH_V01
GO

CREATE procedure sysadm.DW_S04_W_COUR_BLOB_ARCH_V01
@sMajPar	Char(4),
@iIdSin		Integer,
@dtEditeLe 	DateTime,  
@iIdLot		Integer

AS

/*------------------------------------------------------------------*/
/* Le 03/09/2006 22:45 - Mise en place du N° chrono.                */
/* Ajout de la zone ID_TYP_DOC dans la sélection.                   */
/* Ajout de la zone LIB_CODE dans la sélection.                     */
/* Ajout de la colonne dans le SELECT. -> Changement de la DW       */
/*------------------------------------------------------------------*/
DECLARE @dcIdSin        DECIMAL ( 10 ) -- [PI062]
SET     @dcIdSin        = CONVERT ( DECIMAL ( 10 ), @iIdSin ) -- [PI062]

DECLARE @dtBorneSup     DATETIME
SET     @dtBorneSup     = DATEADD ( day, 1, @dtEditeLe )

SELECT  w_cour_blob_arch.id_lot,
        w_cour_blob_arch.id_typ_doc,
        c.lib_code,
        MIN ( w_cour_blob_arch.dte_edit ),
        MIN ( w_cour_blob_arch.maj_le   ),
        MAX ( w_cour_blob_arch.maj_le   ),
        COUNT (*),
        'N'             AS alt_select
FROM    sysadm.w_cour_blob_arch
LEFT OUTER JOIN 
        sysadm.code     AS c
ON      w_cour_blob_arch.id_typ_doc     = c.id_code     AND
        c.id_typ_code = '-ND'

WHERE   ( ( w_cour_blob_arch.dte_edit   > @dtEditeLe                                                    AND 
            w_cour_blob_arch.dte_edit   < @dtBorneSup  )                OR @dtEditeLe   IS NULL )       AND
        ( w_cour_blob_arch.id_sin       = @dcIdSin                      OR @dcIdSin     IS NULL )       AND     
        ( w_cour_blob_arch.maj_par      = @sMajPar                      OR @sMajPar     IS NULL )       AND
        ( w_cour_blob_arch.id_lot       = @iIdLot                       OR @iIdLot      IS NULL )       AND
	(w_cour_blob_arch.id_lot        > 0 ) -- #1 PHG 03/11/2006 [DNTMAIL1-2] On exclu les éditions 'Mail' ( Point 6.1 )

GROUP BY 
        w_cour_blob_arch.id_lot,
        w_cour_blob_arch.id_typ_doc,
        c.lib_code

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_D01_W_COUR_BLOB_ARCH
-- Auteur               :       Fabry JF
-- Date                 :       08/04/2004
-- Libelle              :        
-- Commentaires         :       Purge de la table w_cour_blob_arch
--
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	02/11/2006	[DNTMAIL1-2] On enregistre le media ( Id_Canal )
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.PS_D01_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.PS_D01_W_COUR_BLOB_ARCH
 @dDteMax	DateTime
AS

DELETE	sysadm.w_cour_blob_arch
WHERE 	alt_fn    = 'O'
AND	(id_lot> 0 OR id_lot =-1) -- #1 PHG 02/11/2006[DNTMAIL1-2] Point 5.2.4 : On supprime aussi les id_lot = -1
AND	dte_edit is not null
AND	dte_edit <= @dDteMax	

GO

--------------------------------------------------------------------
--
-- Procedure            :       PS_S01_W_COUR_BLOB_ARCH
-- Auteur               :       Fabry JF
-- Date                 :       08/04/2004
-- Libelle              :        
-- Commentaires         :       Ramene le nombre de courrier dont maj_le <= max de 
--				DW_S01_W_COUR_BLOB_ARCH
--				
-- References           :       
--
-- Arguments            :       
--                      :       
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.PS_S01_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.PS_S01_W_COUR_BLOB_ARCH
@sMajPar	Char(4),
@iIdSin		Integer,
@dDteMaxMaj	DateTime,
@iIdTypDoc	Integer,
@iNbreTrouve	Integer OUTPUT
AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]

 SELECT	@iNbreTrouve = Count (*)

   FROM	sysadm.w_cour_blob_arch
 	
  WHERE  id_lot     =  0                         AND
         alt_fn     =  'N'                       AND
         dte_edit   is null                      AND
         maj_le     <= @dDteMaxMaj               AND
         id_typ_doc =  @iIdTypDoc                AND

       ( id_sin = @dcIdSin Or @dcIdSin  = 0 ) AND	
       ( maj_par= @sMajPar Or @sMajPar is null ) 

GO

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.DW_S01_W_COUR_BLOB_ARCH
@sMajPar	Char(4),
@iIdSin		Integer,
@dtMajLe	DateTime,
@ilIdProd	Integer,
@ilIdDept	Integer


AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @dcIdProd Decimal ( 7 )
Declare @dcIdDept Decimal ( 7 )

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]
Set @dcIdProd = Convert ( Decimal ( 7 ), @ilIdProd )
Set @dcIdDept = Convert ( Decimal ( 7 ), @ilIdDept )

Select @dtMajLe = DateAdd (day, 1, @dtMajLe )

SELECT w_cour_blob_arch.id_typ_doc,
       code.lib_code,
       count ( w_cour_blob_arch.id_typ_doc ),
       DateAdd ( ss, 1, max   ( w_cour_blob_arch.maj_le     ) ),
       'N'		as alt_select

  FROM sysadm.code,
       sysadm.w_cour_blob_arch,
       sysadm.produit p,
       sysadm.sinistre s	       
	
 WHERE  w_cour_blob_arch.id_typ_doc  = code.id_code 
 AND    w_cour_blob_arch.id_lot      = 0                                   
 AND    w_cour_blob_arch.alt_fn      = 'N'
 AND    w_cour_blob_arch.dte_edit is null 
 AND    code.id_typ_code             = '-ND'
 AND    code.id_code	>= 0
 AND  s.id_sin = w_cour_blob_arch.id_sin
 AND  s.id_prod = p.id_prod
 AND   ( w_cour_blob_arch.maj_par = @sMajPar OR @sMajPar is null )
 AND   ( w_cour_blob_arch.maj_le < @dtMajLe Or @dtMajLe is null  )
 AND   ( w_cour_blob_arch.id_sin = @dcIdSin Or @dcIdSin  is null  )
 AND   ( p.id_prod = @dcIdProd Or @dcIdProd is null  )
 AND   ( p.id_depts = @dcIdDept Or @dcIdDept is null  )
 
 

GROUP BY
	w_cour_blob_arch.id_typ_doc,
	code.lib_code

GO

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.DW_S02_W_COUR_BLOB_ARCH
@sMajPar	Char(4),
@iIdSin		Integer,
@dtMaxMajLe	DateTime,  
@iIdTypDoc	Integer,
@ilIdProd	Integer,
@ilIdDept	Integer


AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]
Declare @dcIdProd Decimal ( 7 )
Declare @dcIdDept Decimal ( 7 )

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]
Set @dcIdProd = Convert ( Decimal ( 7 ), @ilIdProd )
Set @dcIdDept = Convert ( Decimal ( 7 ), @ilIdDept )

SELECT 	lTrim ( rTrim ( inter.nom ) ) ,
	w_cour_blob_arch.id_lot,
	w_cour_blob_arch.id_typ_doc,
	w_cour_blob_arch.id_arch,
	w_cour_blob_arch.id_sin,
	w_cour_blob_arch.id_inter,
	w_cour_blob_arch.id_seq,
	w_cour_blob_arch.dte_edit,
	w_cour_blob_arch.maj_le,
	w_cour_blob_arch.maj_par,
	produit.id_prod,
	produit.id_dept
	

  FROM 	sysadm.w_cour_blob_arch,
	sysadm.inter,
	sysadm.sinistre,
	sysadm.produit
	
 WHERE	sinistre.id_sin = w_cour_blob_arch.id_sin				AND
 	produit.id_prod = sinistre.id_prod					AND
 	w_cour_blob_arch.id_lot 	= 0 		   			AND
	w_cour_blob_arch.alt_fn 	= 'N'		   			AND
	w_cour_blob_arch.dte_edit 	is null		   			AND
	
	w_cour_blob_arch.id_typ_doc 	= @iIdTypDoc	   			AND
	w_cour_blob_arch.maj_le 	< @dtMaxMajLe 				AND
	
	( w_cour_blob_arch.id_sin = @dcIdSin Or @dcIdSin  is null )		AND	
	( w_cour_blob_arch.maj_par= @sMajPar Or @sMajPar is null )		AND
	( produit.id_prod = @dcIdProd Or @dcIdProd is null )			AND
	( produit.id_depts = @dcIdDept Or @dcIdDept is null )			AND
 
	
	inter.id_sin		= w_cour_blob_arch.id_sin			AND
	inter.id_i  		= w_cour_blob_arch.id_inter


GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.DW_S03_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.DW_S03_W_COUR_BLOB_ARCH
@iIdLot		Integer

AS


SELECT 	inter.nom,
	w_cour_blob_arch.id_lot,
	w_cour_blob_arch.id_typ_doc,
	code.lib_code,
	w_cour_blob_arch.id_arch,
	w_cour_blob_arch.id_sin,
	w_cour_blob_arch.id_inter,
	w_cour_blob_arch.id_seq,
	w_cour_blob_arch.dte_edit,
	w_cour_blob_arch.maj_le,
	w_cour_blob_arch.maj_par
	

  FROM 	sysadm.w_cour_blob_arch,
	sysadm.code,
	sysadm.inter
	
 WHERE	w_cour_blob_arch.id_lot 	= @iIdLot	   			AND
	
	inter.id_sin	= w_cour_blob_arch.id_sin		AND
	inter.id_i  	= w_cour_blob_arch.id_inter		AND

	code.id_typ_code 		= '-ND'					AND
	convert (integer, code.id_code)	= w_cour_blob_arch.id_typ_doc

GO

--  JFF		12/02/2016		[PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.DW_S04_W_COUR_BLOB_ARCH
GO

CREATE procedure sysadm.DW_S04_W_COUR_BLOB_ARCH
@sMajPar	Char(4),
@iIdSin		Integer,
@dtEditeLe 	DateTime,  
@iIdLot		Integer

AS

Declare @dcIdSin Decimal ( 10 ) -- [PI062]

Set @dcIdSin = Convert ( Decimal ( 10 ), @iIdSin ) -- [PI062]


DECLARE @dtBorneSup DateTime
SELECT  @dtBorneSup = DateAdd ( day, 1, @dtEditeLe )


SELECT	w_cour_blob_arch.id_lot,
	min ( w_cour_blob_arch.dte_edit ),
	min ( w_cour_blob_arch.maj_le   ),
	max ( w_cour_blob_arch.maj_le   ),
	count (*),
	'N'		AS alt_select

  FROM	sysadm.w_cour_blob_arch

 WHERE 	( ( w_cour_blob_arch.dte_edit > @dtEditeLe AND w_cour_blob_arch.dte_edit < @dtBorneSup  ) Or @dtEditeLe is null ) AND
	( w_cour_blob_arch.id_sin = @dcIdSin Or @dcIdSin is null  )	AND	
	( w_cour_blob_arch.maj_par  = @sMajPar Or @sMajPar   is null  )	AND
	( w_cour_blob_arch.id_lot   = @iIdLot Or @iIdLot    is null   )	AND

	w_cour_blob_arch.id_lot	<>  0

GROUP BY w_cour_blob_arch.id_lot

GO

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_W_COUR_BLOB_ARCH' AND type = 'P' )
        DROP procedure sysadm.PS_I02_W_COUR_BLOB_ARCH
GO

CREATE PROCEDURE sysadm.PS_I02_W_COUR_BLOB_ARCH
  @dcIdSin	decimal (10, 0),  -- [PI062]
  @dcIdInter	decimal (7, 0),
  @dcIdDoc	decimal (7, 0),
  @sTypBlob	varchar (2),
  @iIdTypDoc	integer,
  @sMajPar	varchar (4)

AS

DECLARE @dtDate datetime

SET @dtDate = getdate()

INSERT w_cour_blob_arch

SELECT	a.id_arch, 
	a.id_sin, 
	a.id_inter, 
	a.id_doc,	-- id_seq
	@sTypBlob,	-- id_typ_blob
	0, 			-- id_lot
	@iIdTypDoc,	-- id_typ_doc
	' ',		-- txt_blob
	'N',
	null, 		-- dte_edit
	@dtDate,
	@dtDate,
	@sMajPar,
	@dtDate,
	@sMajPar,
	null

FROM	archive a

WHERE	a.id_sin 	= @dcIdSin
AND 	a.id_inter 	= @dcIdInter
AND 	a.id_doc	= @dcIdDoc

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_RECUP_BLOB_KSL
-- Auteur               :       JFF
-- Date                 :       30/05/2011
-- Libellé              :        
-- Commentaires         :       [PM159]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF    30/03/2023   Changement de méthode de lecture et recherche sur SIMPA2BLOB_PRO
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECUP_BLOB_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECUP_BLOB_KSL
GO

CREATE procedure sysadm.PS_S01_RECUP_BLOB_KSL
	@iIdArch	integer
AS

Select  wb.txt_blob  
From sysadm.w_cour_blob_arch wb  with (nolock)  
Where wb.id_arch = @iIdArch  

If @@RowCount = 1 Return @@Error
  
Select  ab.txt_blob  
From sysadm.archive a  with (nolock),  
	 sysadm.archive_blob ab  with (nolock)  
Where a.id_arch = @iIdArch  
And     ab.id_sin = a.id_sin  
And     ab.id_inter = a.id_inter  
And     ab.id_doc = a.id_doc  
	
If @@RowCount = 1 Return @@Error

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
  Begin
	Select  ab.txt_blob  
	From sysadm.archive a  with (nolock),  
	 	 SIMPA2BLOB_PRO.sysadm.archive_blob2 ab  with (nolock)  
	Where a.id_arch = @iIdArch  
	And     ab.id_sin = a.id_sin  
	And     ab.id_inter = a.id_inter  
	And     ab.id_doc = a.id_doc  
  End   

If @@RowCount = 1 Return @@Error

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
  Begin
	Select  ab.txt_blob  
	From sysadm.archive a  with (nolock),  
	 	 SIMPA2BLOB_PRO.sysadm.archive_blob ab  with (nolock)  
	Where a.id_arch = @iIdArch  
	And     ab.id_sin = a.id_sin  
	And     ab.id_inter = a.id_inter  
	And     ab.id_doc = a.id_doc  
  End   

Return @@Error  

Go

/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECUP_BLOB_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECUP_BLOB_KSL
GO

CREATE procedure sysadm.PS_S01_RECUP_BLOB_KSL
	@iIdArch	integer
AS
If Exists ( 
		Select Top 1 1 
		From	sysadm.w_cour_blob_arch wb
		Where	wb.id_arch = @iIdArch
		)
	Begin 
	Select  wb.txt_blob
	From	sysadm.w_cour_blob_arch wb
	Where	wb.id_arch = @iIdArch
	End 

Else
	Begin
	Select  ab.txt_blob
	From	sysadm.archive a,
			sysadm.archive_blob ab
	Where	a.id_arch = @iIdArch
	And     ab.id_sin = a.id_sin
	And     ab.id_inter = a.id_inter
	And     ab.id_doc = a.id_doc
	End 

Return @@Error

Go
*/
--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_PM240_NBRE_COURRIER_1
-- Auteur               :       JFF
-- Date                 :       06/12/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [PM240]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM240_NBRE_COURRIER_1' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM240_NBRE_COURRIER_1
GO

CREATE procedure sysadm.PS_S_PM240_NBRE_COURRIER_1
AS

	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr', 
			'SIMPA2' 'Application',
			p.id_prod 'Code_produit_sinitre',
			p.lib_long 'Lib_produit_sinistre',
			p.cod_prod_dms 'Code_produit_adhésion',
			g.lib_grp 'Lib_Contractant',
			count(*) 'Nbre de courriers'
		 
	from	SIMPA2_PRO.sysadm.w_cour_blob_arch wcb,
			SIMPA2_PRO.sysadm.produit p,
			SIMPA2_PRO.sysadm.sinistre s,
			SIMPA2_PRO.sysadm.groupe g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_grp = p.id_grp
	Group by 
			p.id_prod,
			p.lib_long,
			p.cod_prod_dms,
			g.lib_grp
	Union All
	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr', 
			'PEGASE' 'Application',
			p.id_prod 'Code_produit_sinitre',
			p.lib_long 'Lib_produit_sinistre',
			Convert ( Decimal (7), Left ( Convert ( VarChar (20), p.id_prod ), 2))  'Cod_produit_adhésion',
			g.lib_grp 'Lib_Contractant',
			count(*)
		 
	from	PEGASE_PRO.sysadm.w_cour_blob_arch wcb,
			PEGASE_PRO.sysadm.produit p,
			PEGASE_PRO.sysadm.sinistre s,
			PEGASE_PRO.sysadm.groupe g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_grp = p.id_grp
	Group by 
			p.id_prod,
			p.lib_long,
			Convert ( Integer, Left ( Convert ( VarChar (20), p.id_prod ), 2)),
			g.lib_grp
	Union All
	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr', 
			'SAVANE' 'Application',
			p.id_prod 'Code_produit_sinitre',
			p.lib_long 'Lib_produit_sinistre',
			Convert ( Decimal (7), Left ( Convert ( VarChar (20), p.id_prod ), 2))  'Cod_produit_adhésion',
			g.lib_ets 'Lib_Contractant',
			count(*)
		 
	from	SAVANE_PRO.sysadm.w_cour_blob_arch wcb,
			SAVANE_PRO.sysadm.produit p,
			SAVANE_PRO.sysadm.sinistre s,
			SAVANE_PRO.sysadm.etablissement g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_ets = p.id_ets
	Group by 
			p.id_prod,
			p.lib_long,
			Convert ( Integer, Left ( Convert ( VarChar (20), p.id_prod ), 2)),
			g.lib_ets
	order by 2, p.cod_prod_dms, p.id_prod

Go

grant execute on sysadm.PS_S_PM240_NBRE_COURRIER_1 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_PM240_NBRE_COURRIER_2
-- Auteur               :       JFF
-- Date                 :       06/12/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [PM240]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM240_NBRE_COURRIER_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM240_NBRE_COURRIER_2
GO

CREATE procedure sysadm.PS_S_PM240_NBRE_COURRIER_2
AS
	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr',
			'SIMPA2' 'Application',
			g.lib_grp 'Lib_Contractant',
			count(*) 'Nbre de courriers'
		 
	from	SIMPA2_PRO.sysadm.w_cour_blob_arch wcb,
			SIMPA2_PRO.sysadm.produit p,
			SIMPA2_PRO.sysadm.sinistre s,
			SIMPA2_PRO.sysadm.groupe g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_grp = p.id_grp
	Group by 
			g.lib_grp
	Union all		
	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr',
			'PEGASE',
			g.lib_grp 'Lib_Contractant',
			count(*)
		 
	from	PEGASE_PRO.sysadm.w_cour_blob_arch wcb,
			PEGASE_PRO.sysadm.produit p,
			PEGASE_PRO.sysadm.sinistre s,
			PEGASE_PRO.sysadm.groupe g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_grp = p.id_grp
	Group by 
			g.lib_grp
	Union all		
	Select  'Le ' + convert ( varchar(10), getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) 'Date_Extr',
			'SAVANE',
			g.lib_ets 'Lib_Contractant',
			count(*)
		 
	from	SAVANE_PRO.sysadm.w_cour_blob_arch wcb,
			SAVANE_PRO.sysadm.produit p,
			SAVANE_PRO.sysadm.sinistre s,
			SAVANE_PRO.sysadm.etablissement g
	where	wcb.id_lot = 0
	And		s.id_sin = wcb.id_sin
	and		p.id_prod = s.id_prod
	and		g.id_ets = p.id_ets
	Group by 
			g.lib_ets		
	Order by 2, g.lib_grp		

Go

grant execute on sysadm.PS_S_PM240_NBRE_COURRIER_2 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_PM240_NBRE_COURRIER_MAIL_1
-- Auteur               :       JFF
-- Date                 :       06/12/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [PM240]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-- JFF		10/09/2024   [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM240_NBRE_COURRIER_MAIL_1' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_1
GO

CREATE procedure sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_1
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
-- [20240910162546267]
-- Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_PM240_Nbre_Courrier\'
Set @sPath 	= sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Extraction_PM240_Nbre_Courrier\'

Set @sFileName	= 'PM240_NBRE_COURRIER_' + Replace ( convert ( varchar(10), GETDATE(), 112 ) + CONVERT (varchar(8), GETDATE(), 108), ':', '' )
Set @sFileExt	= 'xls'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_PM240_NBRE_COURRIER_1 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_PM240_NBRE_COURRIER_1 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Go

grant execute on sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_1 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            : 	PS_S_PM240_NBRE_COURRIER_MAIL_2
-- Auteur               :       JFF
-- Date                 :       06/12/2013
-- Libellé              :       Stats
-- Commentaires         :       
-- Références           :       [PM240]
--
-- Arguments            :       
--				
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- MAJ	LE		    PAR		 Description
-- JFF		10/09/2024   [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM240_NBRE_COURRIER_MAIL_2' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_2
GO

CREATE procedure sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_2
AS

DECLARE @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
		@sRetourErrMail VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int	

-- chemin d'enregistrement du Result Set
-- [20240910162546267]
-- Set @sPath 	= '\\spb.lan\applis\spb\SIMPA2\XLS\Autres\Extraction_PM240_Nbre_Courrier\'
Set @sPath 	= sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\Autres\Extraction_PM240_Nbre_Courrier\'

Set @sFileName	= 'PM240_NBRE_COURRIER_2'
Set @sFileExt	= 'xls'


SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

SET @sNomServeur = @@servername
-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode

Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_PRO.sysadm.PS_S_PM240_NBRE_COURRIER_2 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
Else
   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
			'SIMPA2_TRT.sysadm.PS_S_PM240_NBRE_COURRIER_2 ' + 
			'" /o' + @sFicOut + ' -w5000' + @sOsqlOption
EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output


Go

grant execute on sysadm.PS_S_PM240_NBRE_COURRIER_MAIL_2 to rolebddsinistres
Go



