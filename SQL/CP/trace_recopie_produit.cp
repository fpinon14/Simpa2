-------------------------------------------------------------------
--
-- Fichier              :       TRACE_RECOPIE_PRODUIT.CP
-- Auteur               :       FPI	
-- Date                 :       17/12/2008
--
-- Commentaires         :       Recopies de produits
-------------------------------------------------------------------
-- PS_I01_TRACE_RECOPIE_PRODUIT
-- PS_U01_TRACE_RECOPIE_PRODUIT
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_I01_TRACE_RECOPIE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       17/12/2008 
-- Libelle              :        
-- Commentaires         :       Insertion dans la table de trace_recopie_produit
--                               
-- References           :       
--
-- Arguments            :      		@dcIdProdSource			decimal(7,0) 
--									@dcIdRevSource			decimal(7,0),  
--									@dcIdProdDest			decimal(7,0), 
--									@dcIdRevDest			decimal(7,0), 
--									@sLibLong			varchar(65), -- [DCMP080728]
--									@sLibCourt			varchar(20), 
--									@sEffRevDest			varchar(10), 
--									@sLibRevDest			varchar(35), 
--									@dteEffRev			datetime, 
--									@sMajPar			varchar(4),
--									@sAltCopieBoutique		varchar(1), 
--									@sSuppOption			varchar(50),
--									@sSuppGti			varchar(50), 
--									@sResultat			varchar(50), 
--									@iIdCle				int	OUTPUT

--
-- Retourne             :                        
--
-------------------------------------------------------------------
-- FPI - 21/01/2009 - [DCMP080728] - Agrandissement colonne lib_long (35->65)
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_RECOPIE_PRODUIT' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_I01_TRACE_RECOPIE_PRODUIT
GO

CREATE PROCEDURE sysadm.PS_I01_TRACE_RECOPIE_PRODUIT
		@dcIdProdSource			decimal(7,0),  
		@dcIdRevSource			decimal(7,0),  
		@dcIdProdDest			decimal(7,0), 
		@dcIdRevDest			decimal(7,0), 
		@sLibLong			varchar(65),  -- [DCMP080728]
		@sLibCourt			varchar(20), 
		@sEffRevDest			varchar(10), 
		@sLibRevDest			varchar(35), 
		@dteEffRev			datetime, 
		@sMajPar			varchar(4),
		@sAltCopieBoutique		varchar(1), 
		@sSuppOption			varchar(50),
		@sSuppGti			varchar(50), 
		@sResultat			varchar(50), 
		@iIdCle				int	OUTPUT
AS
	INSERT INTO sysadm.trace_recopie_produit( 
		id_oper, 
		id_prod_src, id_rev_src, 
		id_prod_dest, 
		lib_court_dest, 
		lib_long_dest, 
		id_rev_dest, 
		lib_rev_dest, 
		eff_rev_dest, 
		dte_eff_rev, 
		alt_copie_boutique, 
		supp_option, 
		supp_gti, 
		resultat, 
		cree_le, 
		maj_le, 
		maj_par)
	VALUES(
		@sMajPar, 
		@dcIdProdSource, 
		@dcIdRevSource, 
		@dcIdProdDest,
		@sLibCourt, 
		@sLibLong,
		@dcIdRevDest, 
		@sLibRevDest, 
		@sEffRevDest, 
		@dteEffRev, 
		@sAltCopieBoutique, 
		@sSuppOption, 
		@sSuppGti, 
		@sResultat, 
		getdate(), 
		getdate(), 
		@sMajPar)

	If @@ROWCOUNT < 1 
	BEGIN
		SET @iIdCle=-1
		RETURN @@ERROR
	END

	Select @iIdCle=max(id_cle) From sysadm.trace_recopie_produit
	
		
GO

-------------------------------------------------------------------
-- Procedure            :       PS_U01_TRACE_RECOPIE_PRODUIT
-- Auteur               :       FPI
-- Date                 :       17/12/2008 
-- Libelle              :        
-- Commentaires         :       Update dans la table de trace_recopie_produit
--                               
-- References           :       
--
-- Arguments            :       @iIdCle				int
--								@sResultat			varchar(50)
--								@sIdOper			varchar(4)
--
-- Retourne             :                        
--
-------------------------------------------------------------------
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_TRACE_RECOPIE_PRODUIT' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_U01_TRACE_RECOPIE_PRODUIT
GO

CREATE PROCEDURE sysadm.PS_U01_TRACE_RECOPIE_PRODUIT
		@iIdCle				int,
		@sResultat			varchar(50), 
		@sIdOper			varchar(4)
AS
	UPDATE sysadm.trace_recopie_produit
	SET resultat=@sResultat, maj_le = getdate(), maj_par=@sIdOper
	WHERE id_cle = @iIdCle 
	
GO