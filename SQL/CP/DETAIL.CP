-------------------------------------------------------------------
--
-- Fichier              :       DETAIL.CP
-- Auteur               :       PLJ
-- Date                 :       27/07/1998
--
-- Commentaires         :       Gestion des d‚tails dans SIMPA2
--
-- Proc‚dures           :       DW_S01_DETAIL
--                              PS_I01_DETAIL_VAL
--                              PS_I02_DETAIL_VAL
--                              PS_U01_DETAIL_VAL
--				PS_U02_DETAIL_REDRESSEMENT_RN_FM_A
--				PS_U03_DETAIL_MAJ_FACTU  // Tout fournisseur JFF le 20/11/06
--				PS_U031_DETAIL_MAJ_FACTU // copie de PS_U03_DETAIL_MAJ_FACTU mais avec l'IdFour à règler en paramètre
--				PS_U032_DETAIL_MAJ_FACTU // Copie PS_U03_DETAIL_MAJ_FACTU mais avec une cas, car pas d'id_seq passé. Le "cas" permet de faire un bout de code personnalisé la recherche de l'id_seq.
--				PS_U04_DETAIL_MAJ_FACTU  // pour Darty JFF le 14/02/07
--				PS_U05_DETAIL_MAJ_FACTU  // Factu hors presta
--				PS_U06_DETAIL_MAJ_FACTU  // Facturation FNAC
--				PS_U07_DETAIL_MAJ_FACTU  // vdoc8602 - Facturation avec presta mais fourn fac <> fourn EDI (évol du Hors presta)
--				PS_U08_DETAIL_MAJ_FACTU  // vdoc9586 - Facturation hors presta avec maj déail si 1 seul détail
--				PS_U09_DETAIL_MAJ_FACTU  // [DT57_CMDE_IPHONE_SFR] - Facturation hors presta à O2M des iphones virtuel SFR
--				PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44 : Mise à jour automatique des données liées à la facturation pour tous les 
--													   fournisseurs, sans règler le fournisseur
--				PS_U_DETAIL_MAJ_FACTU_DIAG_O2M : Facturation des Diag O2M dans SIMPA2 avec redressement du détail 1083.
--				PS_U_DETAIL_MAJ_FACTU_BNP_SECU : Mise à jour automatique des données liées à la facturation pour AXA
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_DETAIL
-- Auteur               :       PLJ
-- Date                 :       27/07/1998
-- Libell‚              :        
-- Commentaires         :       S‚lect sur la table DETAIL
-- R‚f‚rences           :       Utilis‚ dans W_CM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DETAIL' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DETAIL
GO


CREATE procedure sysadm.DW_S01_DETAIL
        @dcIdSin        Decimal ( 10, 0 ) -- [PI062]
AS
 SELECT detail.id_sin,
        detail.id_gti,
        detail.id_detail,
        detail.id_evt,
        detail.id_reg,
        detail.id_i_reg,
		detail.lib_det,
        detail.dte_det,
        detail.heu_det,
        detail.num_carte,
        detail.mt_prej,
        detail.mt_fran,
        detail.mt_nplaf,
        detail.mt_plaf,
        detail.alt_plaf,
        detail.alt_reg,
        detail.alt_att,
        detail.alt_ssui,
        detail.cod_mot_ssui,
        detail.cod_dec_mac,
        detail.cod_dec_ope,
        detail.cod_etat,
		detail.id_carte,
        detail.id_type_carte,
        detail.cree_le,
        detail.maj_le,
        detail.maj_par,
        detail.valide_le,
        detail.valide_par,
		detail.dte_cmd,
		detail.dte_livr,
		detail.mt_val_achat,
		detail.mt_val_publique,
		detail.num_facture

  FROM  sysadm.detail
 WHERE  detail.id_sin = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_DETAIL_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table DETAIL (D‚claration)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_DETAIL_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_DETAIL_VAL
GO

CREATE procedure sysadm.PS_I01_DETAIL_VAL
        @dcIdSin        Decimal (  10,0 ),  -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
 INSERT INTO    sysadm.detail
        (       detail.id_sin,
                detail.id_gti,
                detail.id_detail,
                detail.id_evt,
                detail.id_reg,
                detail.id_i_reg,
	        detail.lib_det,
                detail.dte_det,
                detail.heu_det,
                detail.num_carte,
                detail.mt_prej,
                detail.mt_fran,
                detail.mt_nplaf,
                detail.mt_plaf,
                detail.alt_plaf,
                detail.alt_reg,
                detail.alt_att,
                detail.alt_ssui,
                detail.cod_mot_ssui,
                detail.cod_dec_mac,
                detail.cod_dec_ope,
                detail.cod_etat,
	        detail.id_carte,
                detail.id_type_carte,
                detail.cree_le,
                detail.maj_le,
                detail.maj_par,
                detail.valide_le,
                detail.valide_par,
                detail.dte_cmd,
                detail.dte_livr,
                detail.mt_val_achat,
                detail.mt_val_publique,
                detail.num_facture
                )
 SELECT         w_detail.id_sin,
                w_detail.id_gti,
                w_detail.id_detail,
                w_detail.id_evt,
                0,
                w_detail.id_i_reg,
	        w_detail.lib_det,
                w_detail.dte_det,
                w_detail.heu_det,
                w_detail.num_carte,
                w_detail.mt_prej,
                w_detail.mt_fran,
                w_detail.mt_nplaf,
                w_detail.mt_plaf,
                w_detail.alt_plaf,
                w_detail.alt_reg,
                w_detail.alt_att,
                w_detail.alt_ssui,
                w_detail.cod_mot_ssui,
                w_detail.cod_dec_mac,
                w_detail.cod_dec_ope,
                w_detail.cod_etat,
	        w_detail.id_carte,
                w_detail.id_type_carte,
                w_detail.cree_le,
                w_detail.maj_le,
                w_detail.maj_par,
                @dtValideLe,
                @sCodOper,
                w_detail.dte_cmd,
                w_detail.dte_livr,
                w_detail.mt_val_achat,
                w_detail.mt_val_publique,
                w_detail.num_facture
 FROM           sysadm.w_detail
 WHERE          w_detail.id_sin = @dcIdSin

-- #1	JFF	05/09/2009  [20091105135857040].[BUG]
-- Il n'est pas normal que lors de la validation, il reste des état de détail en 500 alors qu'ils devraient tous passer en 600.
-- Ce code à cet endroit redresse un bug du code PB.
/*
 Update sysadm.detail
 Set    cod_etat = 600
 From   sysadm.w_detail
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        detail.id_sin           = w_detail.id_sin       AND
        detail.id_gti           = w_detail.id_gti       AND
        detail.id_detail        = w_detail.id_detail    AND
        w_detail.cpt_valide     = 0                     AND
        w_detail.cod_etat	= 500

 Update sysadm.w_detail
 Set    cod_etat = 600
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        w_detail.cpt_valide     = 0                     AND
        w_detail.cod_etat	= 500
-- :#1	JFF	05/09/2009  [20091105135857040].[BUG]
*/

 Return @@Error
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_DETAIL_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table DETAIL (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_DETAIL_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I02_DETAIL_VAL
GO

CREATE procedure sysadm.PS_I02_DETAIL_VAL
        @dcIdSin        Decimal ( 10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
 INSERT INTO    sysadm.detail
        (       detail.id_sin,
                detail.id_gti,
                detail.id_detail,
                detail.id_evt,
                detail.id_reg,
                detail.id_i_reg,
	        detail.lib_det,
                detail.dte_det,
                detail.heu_det,
                detail.num_carte,
                detail.mt_prej,
                detail.mt_fran,
                detail.mt_nplaf,
                detail.mt_plaf,
                detail.alt_plaf,
                detail.alt_reg,
                detail.alt_att,
                detail.alt_ssui,
                detail.cod_mot_ssui,
                detail.cod_dec_mac,
                detail.cod_dec_ope,
                detail.cod_etat,
	        detail.id_carte,
                detail.id_type_carte,
                detail.cree_le,
                detail.maj_le,
                detail.maj_par,
                detail.valide_le,
                detail.valide_par,
		detail.dte_cmd,
                detail.dte_livr,
                detail.mt_val_achat,
                detail.mt_val_publique,
                detail.num_facture
                )
 SELECT         w_detail.id_sin,
                w_detail.id_gti,
                w_detail.id_detail,
                w_detail.id_evt,
                0,
                w_detail.id_i_reg,
	        w_detail.lib_det,
                w_detail.dte_det,
                w_detail.heu_det,
                w_detail.num_carte,
                w_detail.mt_prej,
                w_detail.mt_fran,
                w_detail.mt_nplaf,
                w_detail.mt_plaf,
                w_detail.alt_plaf,
                w_detail.alt_reg,
                w_detail.alt_att,
                w_detail.alt_ssui,
                w_detail.cod_mot_ssui,
                w_detail.cod_dec_mac,
                w_detail.cod_dec_ope,
                w_detail.cod_etat,
	        w_detail.id_carte,
                w_detail.id_type_carte,
                w_detail.cree_le,
                w_detail.maj_le,
                w_detail.maj_par,
                @dtValideLe,
                @sCodOper,
		w_detail.dte_cmd,
                w_detail.dte_livr,
                w_detail.mt_val_achat,
                w_detail.mt_val_publique,
                w_detail.num_facture
             
 FROM           sysadm.w_detail
 WHERE          w_detail.id_sin         = @dcIdSin      AND
                w_detail.cpt_valide     = 0             AND
                w_detail.alt_valide =   'O'

-- #1	JFF	05/09/2009  [20091105135857040].[BUG]
-- Il n'est pas normal que lors de la validation, il reste des état de détail en 500 alors qu'ils devraient tous passer en 600.
-- Ce code à cet endroit redresse un bug du code PB.
/*
 Update sysadm.detail
 Set    cod_etat = 600
 From   sysadm.w_detail
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        detail.id_sin           = w_detail.id_sin       AND
        detail.id_gti           = w_detail.id_gti       AND
        detail.id_detail        = w_detail.id_detail    AND
        w_detail.cpt_valide     = 0                     AND
        w_detail.cod_etat	= 500

 Update sysadm.w_detail
 Set    cod_etat = 600
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        w_detail.cpt_valide     = 0                     AND
        w_detail.cod_etat	= 500
-- :#1	JFF	05/09/2009  [20091105135857040].[BUG]
*/

 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_DETAIL_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification dans la table DETAIL (Compl‚ment)
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_DETAIL_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_DETAIL_VAL
GO


CREATE procedure sysadm.PS_U01_DETAIL_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS
 UPDATE sysadm.detail
 SET    sysadm.detail.id_evt           = w_detail.id_evt               ,
        sysadm.detail.id_i_reg         = w_detail.id_i_reg             ,
        sysadm.detail.lib_det          = w_detail.lib_det              ,
        sysadm.detail.dte_det          = w_detail.dte_det              ,
        sysadm.detail.heu_det          = w_detail.heu_det              ,
        sysadm.detail.num_carte        = w_detail.num_carte            ,
        sysadm.detail.mt_prej          = w_detail.mt_prej              ,
        sysadm.detail.mt_fran          = w_detail.mt_fran              ,
        sysadm.detail.mt_nplaf         = w_detail.mt_nplaf             ,
        sysadm.detail.mt_plaf          = w_detail.mt_plaf              ,
        sysadm.detail.alt_plaf         = w_detail.alt_plaf             ,
        sysadm.detail.alt_reg          = w_detail.alt_reg              ,
        sysadm.detail.alt_att          = w_detail.alt_att              ,
        sysadm.detail.alt_ssui         = w_detail.alt_ssui             ,
        sysadm.detail.cod_mot_ssui     = w_detail.cod_mot_ssui         ,
        sysadm.detail.cod_dec_mac      = w_detail.cod_dec_mac          ,
        sysadm.detail.cod_dec_ope      = w_detail.cod_dec_ope          ,
        sysadm.detail.cod_etat         = w_detail.cod_etat             ,
        sysadm.detail.id_carte         = w_detail.id_carte             ,
        sysadm.detail.id_type_carte    = w_detail.id_type_carte        ,
        sysadm.detail.maj_le           = w_detail.maj_le               ,
        sysadm.detail.maj_par          = w_detail.maj_par              ,
        sysadm.detail.valide_le        = @dtValideLe                   ,
        sysadm.detail.valide_par       = @sCodOper                     ,
        sysadm.detail.dte_cmd          = w_detail.dte_cmd              ,
        sysadm.detail.dte_livr         = w_detail.dte_livr    	       ,
        sysadm.detail.mt_val_achat     = w_detail.mt_val_achat         ,
        sysadm.detail.mt_val_publique  = w_detail.mt_val_publique      ,	
        sysadm.detail.num_facture      = w_detail.num_facture
 FROM   sysadm.detail,
        sysadm.w_detail
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        detail.id_sin           = w_detail.id_sin       AND
        detail.id_gti           = w_detail.id_gti       AND
        detail.id_detail        = w_detail.id_detail    AND
        w_detail.cpt_valide     > 0                     AND
        w_detail.alt_valide     = 'O'

-- #1	JFF	05/09/2009  [20091105135857040].[BUG]
-- Il n'est pas normal que lors de la validation, il reste des état de détail en 500 alors qu'ils devraient tous passer en 600.
-- Ce code à cet endroit redresse un bug du code PB.
/*
 Update sysadm.detail
 Set    cod_etat = 600
 From   sysadm.w_detail
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        detail.id_sin           = w_detail.id_sin       AND
        detail.id_gti           = w_detail.id_gti       AND
        detail.id_detail        = w_detail.id_detail    AND
        w_detail.cpt_valide     > 0                     AND
        w_detail.cod_etat	= 500

 Update sysadm.w_detail
 Set    cod_etat = 600
 WHERE  w_detail.id_sin         = @dcIdSin              AND
        w_detail.cpt_valide     > 0                     AND
        w_detail.cod_etat	= 500
-- :#1	JFF	05/09/2009  [20091105135857040].[BUG]
*/
 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U02_DETAIL_REDRESSEMENT_RN_FM_A
-- Auteur               :       Fabry JF
-- Date                 :       02/08/2005
-- Libellé              :       Redressement des anciens règlements fournisseurs passés
--				en RN/FM/A, en RN/FM/F + ajout zone lié à la facturation
-- Commentaires         :       Modification dans la table DETAIL
-- Références           :       
--
-- Arguments            :       	@iIdSin  	decimal (7),
--					@iIdRegOrig  	decimal (2),
--					@sIdFour	VarChar (3),
--					@sDteFact	VarChar (10),
--					@sNumFact	VarChar (35),
--					@sMesRet	VarChar (100) OUTPUT
--
-- Retourne             :       VarChar Cas 1 : [OK]  // Dossier (détail) redressé
--					Cas 2 : [description de l'erreur] // Par conséquent si le retour <> 'OK' donc problème.
-- MAJ		
--
-- declare @sMesRet Varchar( 100 )
-- declare @iRet Integer
-- Set @sMesRet = Replicate ( 100, ' ' )
-- Exec @iRet = sysadm.PS_U02_DETAIL_REDRESSEMENT_RN_FM_A 868153, 1, 'DDF', '01/12/2004', '412000176', @sMesRet Output
-- Select @iRet
-- Select @sMesRet 
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_DETAIL_REDRESSEMENT_RN_FM_A' AND type = 'P' )
        DROP procedure sysadm.PS_U02_DETAIL_REDRESSEMENT_RN_FM_A
GO


CREATE procedure sysadm.PS_U02_DETAIL_REDRESSEMENT_RN_FM_A
	@iIdSin  	decimal (10), -- [PI062]
	@iIdRegOrig  	decimal (2),
	@sIdFour	VarChar (3),
	@sDteFact	VarChar (10),
	@sNumFact	VarChar (35),
	@sMesRet	VarChar (100) OUTPUT
AS

Declare @iNb		Integer

-- Contrôle du règlement, si le RN ne répond aux critères
-- de redressement, on sort.
Select 	@iNb = Count (*)
From 	sysadm.reglement r
Where	r.id_sin 	= @iIdSin
And	r.id_reg 	= @iIdRegOrig
And	r.cod_inter 	= 'A'
And	r.cod_mode_reg 	= 'FM'
And	r.cod_mot_reg	= 'RN'
And	r.mt_tot_reg	> 0

If @iNb <= 0 
 Begin
  Set @sMesRet = 'ERREUR : Le regl. d''Origine n''est pas du type RN/FM/A/Reg positif'
  Return -1
 End 

-- L'inter fournisseur a-t-il bien été créé par la gestion ?
Select 	@iNb = Count (*)
From   	sysadm.inter i
Where  	i.id_sin = @iIdSin
And	i.id_four = @sIdFour

If @iNb <= 0 
 Begin
  Set @sMesRet = 'ERREUR : L''interlocuteur fournisseur '+ @sIdFour + ' n''existe pas.'
  Return -1
 End 

-- La date de facture est-elle valide
If ( IsDate ( @sDteFact ) <= 0 Or @sDteFact is null Or sysadm.FN_TRIM ( @sDteFact ) = '' )
 Begin
  Set @sMesRet = 'ERREUR : La date de facturation '+ @sDteFact + ' n''est pas valide.'
  Return -1
 End 

-- Le n° de facture ne doit pas être vide
If ( @sNumFact is null Or sysadm.FN_TRIM ( @sNumFact ) = '' )
 Begin
  Set @sMesRet = 'ERREUR : Le numéro de facture ne doit pas être vide'
  Return -1
 End 

-- Le réglement doit être lié à un seul détail
Select 	@iNb = Count (*)
From   	sysadm.detail d
Where	d.id_sin = @iIdSin
And	d.id_reg = @iIdRegOrig

If @iNb <> 1 
 Begin
  Set @sMesRet = 'ERREUR : Le réglement doit être lié à un seul et unique détail'
  Return -1
 End 


-- FIN DES CONTROLES
-- DEBUT DES MISES A JOUR

-- Mise à jour de l'inter assuré
Update  sysadm.inter_encrypt
Set 	mt_reg = mt_reg - r.mt_tot_reg
From 	sysadm.reglement r
Where	r.id_sin = @iIdSin
And	r.id_reg = @iIdRegOrig
And	sysadm.inter_encrypt.id_sin = r.id_sin 
And 	sysadm.inter_encrypt.cod_inter = r.cod_inter

Update  sysadm.w_inter_encrypt
Set 	mt_reg = mt_reg - r.mt_tot_reg
From 	sysadm.reglement r
Where	r.id_sin = @iIdSin
And	r.id_reg = @iIdRegOrig
And	sysadm.w_inter_encrypt.id_sin = r.id_sin 
And 	sysadm.w_inter_encrypt.cod_inter = r.cod_inter

-- Mise à jour de l'inter fournisseur
Update  sysadm.inter_encrypt
Set 	mt_reg = mt_reg + r.mt_tot_reg
From 	sysadm.reglement r
Where	r.id_sin = @iIdSin
And	r.id_reg = @iIdRegOrig
And	sysadm.inter_encrypt.id_sin = r.id_sin 
And 	sysadm.inter_encrypt.cod_inter = 'F'
And 	sysadm.inter_encrypt.id_four   = @sIdFour

Update  sysadm.w_inter_encrypt
Set 	mt_reg = mt_reg + r.mt_tot_reg
From 	sysadm.reglement r
Where	r.id_sin = @iIdSin
And	r.id_reg = @iIdRegOrig
And	sysadm.w_inter_encrypt.id_sin = r.id_sin 
And 	sysadm.w_inter_encrypt.cod_inter = 'F'
And 	sysadm.w_inter_encrypt.id_four   = @sIdFour


-- Mise à jour du détail
Update 	sysadm.detail
Set	sysadm.detail.dte_livr = @sDteFact,
	sysadm.detail.num_facture = @sNumFact,
	sysadm.detail.id_i_reg = ( Select i.id_i from sysadm.inter i
				   Where i.id_sin = sysadm.detail.id_sin
				   And 	 i.id_four = @sIdFour )
Where	sysadm.detail.id_sin = @iIdSin
And	sysadm.detail.id_reg = @iIdRegOrig

Update 	sysadm.w_detail
Set	sysadm.w_detail.dte_livr = @sDteFact,
	sysadm.w_detail.num_facture = @sNumFact,
	sysadm.w_detail.id_i_reg = ( Select i.id_i from sysadm.inter i
				     Where i.id_sin = sysadm.w_detail.id_sin
				     And i.id_four = @sIdFour )
Where	sysadm.w_detail.id_sin = @iIdSin
And	sysadm.w_detail.id_detail = ( Select id_detail From sysadm.detail
				      Where  sysadm.detail.id_sin = @iIdSin
				      And    sysadm.detail.id_reg = @iIdRegOrig )

-- Mise à jour du Réglement
Update 	sysadm.reglement
Set	sysadm.reglement.cod_inter = 'F',
	sysadm.reglement.id_i = ( Select i.id_i from sysadm.inter i
				  Where i.id_sin = sysadm.reglement.id_sin
				  And i.id_four = @sIdFour )
Where	sysadm.reglement.id_sin = @iIdSin
And	sysadm.reglement.id_reg = @iIdRegOrig


-- Tout est Ok, dossier redressé
Set @sMesRet = 'OK : Dossier redressé'

print 'Vu détail'
Select 	d.id_sin,
	d.id_gti,
	d.id_detail,
	d.id_reg,
	d.id_i_reg,
	d.dte_livr,	
	d.num_facture    
From 	sysadm.detail d
Where	d.id_sin = @iIdSin
And	d.id_reg = @iIdRegOrig

print 'Vu inter'
Select 	i.id_sin,
	i.id_i,
	i.cod_inter,
	i.cod_mode_reg,
	i.mt_reg,
	i. id_four 
From 	sysadm.inter i
Where	i.id_sin = @iIdSin
And	i.cod_inter in ( 'A', 'F' )

print 'Vu Reglement'
Select 	r.id_sin,
	r.id_reg,
	r.mt_tot_reg,
	r.lib_reg,
	r.dte_reg,
	r.cod_inter,
	r.cod_mode_reg,
	r.cod_mot_reg,
	r.id_i,
	r.id_reg_base 
From 	sysadm.reglement r
Where	r.id_sin = @iIdSin
And	r.id_reg = @iIdRegOrig


Return 1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U03_DETAIL_MAJ_FACTU
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Mise à jour automatique des données liées à la facturation pour tous les fournisseurs
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@iIdSeq  Integer
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #1	03/09/2007	PHG	[DCMP070511] On permet
--				la MAJ des details sans suite
--				pour les trt d'integ. frn.
-- #2	17/03/2008	PHG	[DCMP080166] Ajout de la Catégorie 
--				de Facture dans le Message
--				du contact Sherpa
-- #3	17/03/2008	PHG	[DCMP070989]Prise en compte des détail refusé.
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      31/01/2014   [VDOC13070]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U03_DETAIL_MAJ_FACTU_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U03_DETAIL_MAJ_FACTU_V02
GO
  
CREATE procedure sysadm.PS_U03_DETAIL_MAJ_FACTU_V02  
 @dcIdSin Decimal (10), -- [PI062]  
 @iIdSeq  Integer,  
 @dtDteFact DateTime,  
 @sNumFact  VarChar ( 255 ),  
 @dcMtFact  Decimal (11,2),  
 @sCatFact  Varchar (35), -- #2 [DCMP080166] Catégorie de Facture  
 @adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_2 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_3 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_4 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_5 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_6 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_7 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_8 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_9 Decimal (11,2) , -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]  
 @adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]  
 @sChaine   VarChar ( 255 ), -- [PM336-1]  
 @sAltTraite Varchar(1) OUTPUT  
AS  
  
 Declare @sNomFourn  VarChar ( 255 )  
 Declare @sVal VarChar ( 500 )  
 Declare @AutoriseModif Integer  
 Declare @dcIdI Decimal( 7 )  
    Declare @dcIdGti Decimal (7)  
    Declare @dcIdDetail Decimal (7)  
    Declare @dcNewIdDetail Decimal (7)         
    Declare @sIdFour VarChar ( 3 )  
 Declare @iCas Integer  
 Declare @iRet Integer  
  
 Set @sAltTraite = 'O'  
  
 Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( c.id_four, '-FR' ), '(! Aucun fourn trouvé !)' ),  
     @sIdFour = c.id_four  
 From   commande c  
 Where  c.id_sin = @dcIdSin   
 and    c.id_seq = @iIdSeq  
  
 If @@Error <> 0 Return @@Error  
  
 If Exists (  
   Select *  
   From   sysadm.w_detail d with (nolock),   
          sysadm.w_commande c with (nolock)  
   Where  c.id_sin = @dcIdSin  
   And    c.id_seq = @iIdSeq  
   And    d.id_sin = c.id_sin   
   And    d.id_gti = c.id_gti   
   And    d.id_detail = c.id_detail )  
  Begin  
   Select @AutoriseModif = 1,  
       @iCas = d.cod_etat,  
       @dcIdGti = d.id_gti,  
       @dcIdDetail = d.id_detail  
   From   sysadm.w_detail d,   
          sysadm.w_commande c   
   Where  c.id_sin = @dcIdSin  
   And    c.id_seq = @iIdSeq  
   And    d.id_sin = c.id_sin   
   And    d.id_gti = c.id_gti   
   And    d.id_detail = c.id_detail   
   And    d.cod_etat not in ( 500,600 )  
   And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]  
     Or   
     Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]  
          )  
    
  End  
 Else  
  Begin  
   Select @AutoriseModif = 1,  
       @iCas = d.cod_etat,  
       @dcIdGti = d.id_gti,  
       @dcIdDetail = d.id_detail  
   From   sysadm.detail d with (nolock),   
          sysadm.commande c with (nolock)  
   Where  c.id_sin = @dcIdSin  
   And    c.id_seq = @iIdSeq  
   And    d.id_sin = c.id_sin   
   And    d.id_gti = c.id_gti   
   And    d.id_detail = c.id_detail   
   And    d.cod_etat not in ( 500,600 )          
   And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]  
     Or   
     Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' )-- [PI062]  
          )  
  End  
   
  
  
 If @@Error <> 0 Return @@Error  
  
 If @AutoriseModif = 1   
    Begin  
  Set @sVal = 'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) +   
    'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) +   
    'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) +  -- [PI062]  
    'Numéro Facture : ' + @sNumFact + Char (10) +  
    'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]  
  
  IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')  
      EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12  
  Else  
       EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12  
-- Définir les valeurs de paramètre  
  
        
    End  
  Else  
  Begin   
   Set @sAltTraite = 'N'   
   Return @@Error  
  End   
  
 If @@Error <> 0 Return @@Error  
   
 -- L'inter fournisseur Fourn existe-til ?  
 If Not Exists (   
  Select *  
  From w_inter wi with (nolock)  
  Where wi.id_sin = @dcIdSin  
  And   wi.id_four = @sIdFour  
  And   wi.cod_inter = 'F'  
        )  
    Begin  
     -- Sinon Création de l'interlocuteur  
  Set @dcIdI = ( Select max (id_i) + 1  
         From   sysadm.w_inter i  
         Where  i.id_sin = @dcIdSin )  
  
  -- [PMO89_RS4822]
  Insert into w_inter   
  Select   
   @dcIdSin,  
   @dcIdI,  
   'F',  
   5,  
   a.lib_ag,  
   a.adr_1,  
   a.adr_2,  
   a.adr_cp,  
   a.adr_ville,  
   null,  
   null,  
   null,  
   null,  
   'FM',  
   null,  
   null,  
   null,  
   null,  
   0,  
   0,  
   null,  
   null,  
   null,  
   null,  
   0,  
   0,  
   'N',  
   'N',  
   'N',  
   'N',  
   'N',  
   null,  
   null,  
   'N',  
   null,  
   null,  
   getdate(),  
   getdate(),  
   'ML',  
   null,  
   null,  
   @sIdFour ,  
   'N',  
   null,  
   null,  
   null,
   null, -- [PMO89_RS4822]
   null, -- [PMO89_RS4822]
   null, -- [PMO89_RS4822]
   0    -- [PMO89_RS4822]
  
  From    sysadm.agence a with (nolock)  
  Where  a.id_bq = @sIdFour   
  
  If @@Rowcount <> 1 Return @@Error  
  If @@Error <> 0 Return @@Error  
    
    End   
    Else  
    Begin  
  Select @dcIdI = wi.id_i  
  From w_inter wi with (nolock)  
  Where wi.id_sin = @dcIdSin  
  And   wi.id_four = @sIdFour   
  And   wi.cod_inter = 'F'  
    End   
  
 -- [PM251-2]  
 If @iCas not in ( 500, 600 )   
  Begin  
  Update sysadm.w_detail  
  Set    cod_dec_mac = 100,   
      cod_dec_ope = 100,  
      cod_etat = 100,  
      alt_att = 'N',  
      alt_ssui = 'N',  
      cod_mot_ssui = 0  
  From   sysadm.w_detail d  
  Where  d.id_sin = @dcIdSin  
  And    d.id_gti = @dcIdGti  
  And    d.id_detail = @dcIdDetail  
  End   
  
-- Le 17/03/2014, suite appel de Maryse, on revient en arrière sur la modification pour Auchan.  
 If @iCas not in ( 500, 600 )   
   Begin    
  Update sysadm.w_detail  
  Set    id_i_reg = @dcIdI  
  From   sysadm.w_detail d  
  Where  d.id_sin = @dcIdSin  
  And    d.id_gti = @dcIdGti   
  And    d.id_detail =  @dcIdDetail  
  And    d.cod_etat not in ( 500,600 )   
  And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]  
    Or   
    Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]  
         )  
  
  If @@Rowcount <> 1   
   Begin   
    Set @sAltTraite = 'N'   
    Return @@Error  
   End   
  
  If @@Error <> 0 Return @@Error  
  
  Update sysadm.w_detail   
  Set    dte_livr = @dtDteFact,   
    num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) ,   
    mt_prej = @dcMtFact,   
    alt_att = 'N',  
    alt_reg = Case -- [PM336-1]  
       When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'  
        Then 'O'  
       Else alt_reg  
        End   
  From   sysadm.w_detail d   
  Where  d.id_sin = @dcIdSin  
  And    d.id_gti = @dcIdGti   
  And    d.id_detail =  @dcIdDetail  
  And    d.cod_etat not in ( 500,600 )   
  And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]  
    Or   
    Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]  
    )  
  
  If @@Rowcount <> 1   
   Begin   
    Set @sAltTraite = 'N'   
    Return @@Error  
   End   
  
  -- [PM80_FA12_FRANEX]  
  If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0   
   Begin  
   Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01   
    @dcIdSin,  
    @dcIdI,  
    @dcIdGti,  
    @dcIdDetail,  
    @adcMtIndemPrinc_1,  
    @adcMtFraisAnex_2,  
    @adcMtFraisAnex_3,  
    @adcMtFraisAnex_4,  
    @adcMtFraisAnex_5,  
    @adcMtFraisAnex_6,  
    @adcMtFraisAnex_7,  
    @adcMtFraisAnex_8,  
    @adcMtFraisAnex_9,  
    @adcMtFraisAnex_10,  
    @adcMtFraisAnex_11,  
    'ML'  
  
   If @iRet <> 0 Return @iRet   
   End   
  
  If @@Error <> 0 Return @@Error  
   End  
  
 Return @@Error  
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U031_DETAIL_MAJ_FACTU
-- Auteur               :       FABRY JF
-- Date                 :       22/10/2010
-- Libelle              :       copie de PS_U03_DETAIL_MAJ_FACTU mais avec l'IdFour à règler en paramètre
-- Commentaires         :       [FACTU_VIP_CDS]
-- References           :       
--
-- Arguments            :       
--				@dcIdSin Decimal (7)
--				@iIdSeq  Integer
--				@sIdFour VarChar ( 3 ),
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #1	03/09/2007	PHG	[DCMP070511] On permet
--				la MAJ des details sans suite
--				pour les trt d'integ. frn.
-- #2	17/03/2008	PHG	[DCMP080166] Ajout de la Catégorie 
--				de Facture dans le Message
--				du contact Sherpa
-- #3	17/03/2008	PHG	[DCMP070989]Prise en compte des détail refusé.
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      31/01/2014   [VDOC13070]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U031_DETAIL_MAJ_FACTU_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U031_DETAIL_MAJ_FACTU_V02
GO

CREATE procedure sysadm.PS_U031_DETAIL_MAJ_FACTU_V02
	@dcIdSin Decimal (10), -- [PI062]
	@iIdSeq  Integer,
	@sIdFour VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), -- #2 [DCMP080166] Catégorie de Facture
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdI Decimal( 7 )
    Declare @dcIdGti Decimal (7)
    Declare @dcIdDetail Decimal (7)
    Declare @dcNewIdDetail Decimal (7)			    
	Declare @iCas Integer
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	-- [FACTU_VIP_CDS]
	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )
	
	If @@Error <> 0 Return @@Error

	If Exists (
			Select *
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail )
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And	   d.cod_etat not in ( 500,600 ) 				   
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin )  -- [PI062]
					 Or 
					 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		
		End
	Else
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.detail d with (nolock), 
			       sysadm.commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]

			       )
		End
	


	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) +  -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

		    
	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error
	
	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour ,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour 

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour 
		And   wi.cod_inter = 'F'
	   End 

	-- [PM251-2]
	If @iCas not in ( 500, 600 ) 
	 Begin
		Update sysadm.w_detail
		Set	   cod_dec_mac = 100, 
			   cod_dec_ope = 100,
			   cod_etat = 100,
			   alt_att = 'N',
			   alt_ssui = 'N',
			   cod_mot_ssui = 0
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti
		And    d.id_detail = @dcIdDetail

	 End 

-- Le 17/03/2014, suite appel de Maryse, on revient en arrière sur la modification pour Auchan.
	If @iCas not in ( 500, 600 ) 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin )  -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U032_DETAIL_MAJ_FACTU
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Copie PS_U03_DETAIL_MAJ_FACTU mais avec une cas, car pas d'id_seq passé. Le "cas" permet de faire un bout de code personnalisé la recherche de l'id_seq.
-- Commentaires         :       [VDOC14469]
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@iIdSeq  Integer
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U032_DETAIL_MAJ_FACTU_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U032_DETAIL_MAJ_FACTU_V02
GO

CREATE procedure sysadm.PS_U032_DETAIL_MAJ_FACTU_V02
	@dcIdSin Decimal (10), -- [PI062]
	@sCasIdSeq  VarChar ( 20 ),
	@sIdFour VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), -- #2 [DCMP080166] Catégorie de Facture
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sAltTraite Varchar(1) OUTPUT,
	@aiIdSeq Integer OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdI Decimal( 7 )
    Declare @dcIdGti Decimal (7)
    Declare @dcIdDetail Decimal (7)
    Declare @dcNewIdDetail Decimal (7)			    
	Declare @iCas Integer
	Declare @iIdSeq Integer
	Declare @iCasTrouve Integer	
	Declare @iRet Integer

	Set @sAltTraite = 'O'
	Set @iCasTrouve = 0

	If @sCasIdSeq = '999_SCR'
	  Begin
			  Select @iIdSeq = c.id_seq
			  From	 sysadm.commande c with (nolock),
					 sysadm.detail d with (nolock)
			  Where  c.id_sin = @dcIdSin
			  And	 c.id_four = 'SCR'
			  And    d.id_sin = c.id_sin
			  And	 d.id_gti = c.id_gti
			  And	 d.id_detail = c.id_detail
			  And	 d.cod_etat not in ( 500, 600 )

			  If @@ROWCOUNT <> 1 
			    Begin
				  Set @sAltTraite = 'N'	
				  Return @@Error
				End 
			 Set @iCasTrouve = 1
			 Set @aiIdSeq = @iIdSeq
	  End 


	If @iCasTrouve = 0 
	    Begin
		  Set @sAltTraite = 'N'	
		  Return @@Error
		End 
	

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )

	If @@Error <> 0 Return @@Error

	If Exists (
			Select *
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail )
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock) 
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
					 Or 
					 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		
		End
	Else
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.detail d with (nolock), 
			       sysadm.commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]

			       )
		End
	


	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

		    
	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error
	
	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour ,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour 

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour 
		And   wi.cod_inter = 'F'
	   End 

	-- [PM251-2]
	If @iCas not in ( 500, 600 )
	 Begin
		Update sysadm.w_detail
		Set	   cod_dec_mac = 100, 
			   cod_dec_ope = 100,
			   cod_etat = 100,
			   alt_att = 'N',
			   alt_ssui = 'N',
			   cod_mot_ssui = 0
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti
		And    d.id_detail = @dcIdDetail
	 End 

-- Le 17/03/2014, suite appel de Maryse, on revient en arrière sur la modification pour Auchan.
	If @iCas not in ( 500, 600 ) 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d with (nolock)
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U04_DETAIL_MAJ_FACTU
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Mise à jour automatique des données liées à la facturation pour les centres DARTY
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@sIdFour VarChar ( 3 )
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  VarChar(35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #1	03/09/2007	PHG	[DCMP070511] On permet
--				la MAJ des details sans suite
--				pour les trt d'integ. frn.
-- #2	17/03/2008	PHG	[DCMP080166] Ajout de la Catégorie 
--				de Facture dans le Message
--				du contact Sherpa
-- #3	17/03/2008	PHG	[DCMP070989] Prise en compte des détail refusé.
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U04_DETAIL_MAJ_FACTU_V03' AND type = 'P' )
        DROP procedure sysadm.PS_U04_DETAIL_MAJ_FACTU_V03
GO


CREATE procedure sysadm.PS_U04_DETAIL_MAJ_FACTU_V03
	@dcIdSin Decimal (10), -- [PI062]
	@sIdFour VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  VarChar(35), -- #2 [DCMP080166] Catégorie de Facture
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT,
	@aiIdSeq Integer OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseSherpa Integer
	Declare @AutoriseDetail Integer
	Declare @NbreMaxPropo Integer
	Declare @iIdSeq Integer
	Declare @dcIdGti Decimal( 7 )
	Declare @dcIdDetail Decimal( 7 )
	Declare @dcIdI Decimal( 7 )
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )
	If @@Error <> 0 Return @@Error

	Select @NbreMaxPropo = IsNull ( count ( * ) , 0 )
	From   sysadm.commande c with (nolock)
	Where  c.id_sin = @dcIdSin 
	And    c.id_four = 'DTY'

	If @@Error <> 0 Return @@Error

	If @NbreMaxPropo <= 0 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @NbreMaxPropo between 1 and 3 
	 Begin 
		Select @iIdSeq = Min ( c.id_seq )
		From   sysadm.commande c with (nolock)
		Where  c.id_sin = @dcIdSin 
		And    c.id_four = 'DTY'

		-- [PM251-2]
		Set @aiIdSeq = @iIdSeq

		Select 	@dcIdGti = c.id_gti,
			@dcIdDetail = c.id_detail
		From   sysadm.commande c with (nolock)
		Where  c.id_sin = @dcIdSin 
		And    c.id_seq = @iIdSeq 

		If @@Error <> 0 Return @@Error	   


		If Exists ( 	Select 	* 
				from 	sysadm.w_detail d with (nolock)
				Where  d.id_sin = @dcIdSin
				And    d.id_gti = @dcIdGti 
				And    d.id_detail = @dcIdDetail 
			  )
			Begin 
				Select @AutoriseSherpa = IsNull ( count (*) , 0 )
				From   sysadm.w_detail d with (nolock)
				Where  d.id_sin = @dcIdSin
				And    d.id_gti = @dcIdGti 
				And    d.id_detail = @dcIdDetail 
				And    d.cod_etat not in ( 500,600 ) 
				And    ( Not exists ( select * from  w_queue wq  with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
					 Or 
					 Exists ( select * from w_queue wq  with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
				       )
			End
		Else			
			Begin
			
				Select @AutoriseSherpa = IsNull ( count (*) , 0 )
				From   sysadm.detail d  with (nolock)
				Where  d.id_sin = @dcIdSin
				And    d.id_gti = @dcIdGti 
				And    d.id_detail = @dcIdDetail 
				And    d.cod_etat not in ( 500,600 ) 
				And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
					 Or 
					 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
				       )
			End

		If @@Error <> 0 Return @@Error

		Set @AutoriseDetail = @AutoriseSherpa
	   
	 End 

	If @NbreMaxPropo > 3 
	 Begin 
		Set  @iIdSeq = 0
		
		Select @AutoriseSherpa = IsNull ( count (*) , 0 )
		Where  
 			( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = @dcIdSin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = @dcIdSin And wq.alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Error <> 0 Return @@Error
		
		Set @AutoriseDetail = 0
	   
	 End 

	If @@Error <> 0 Return @@Error

	If @AutoriseSherpa = 1 
	   Begin
		If @iIdSeq = 0 
		  Begin 
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ? '  + Char (10) +  -- [PI062]
					'Numéro Facture : ' + @sNumFact + Char(10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End
		Else
		  Begin
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
					'Numéro Facture : ' + @sNumFact	+ Char (10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End 

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre
	  

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error


	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
	   End 

	
	If @AutoriseDetail = 1 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U05_DETAIL_MAJ_FACTU
-- Auteur               :       PHG, d'après PS_U03_DETAIL_MAJ_FACTU
-- Date                 :       12/06/2008
-- Libelle              :       Mise à jour automatique des données 
--				liées à la facturation pour tous les 
--				fournisseurs, version pour facturation
--				hors prestation uniquement.
-- Commentaires         :       
-- References           :       [DCMP080461]
--
-- Arguments            :       @dcIdSin   Decimal  (7)
--				@sIdFour   varchar  (6), Identifiant 
--							 fournisseur
--							 selectionné.
--				@dtDteFact DateTime
--				@sNumFact  VarChar  ( 255 )
--				@dcMtFact  Decimal  (11,2)
--				@sCatFact  Varchar  (35)
--				@sAltTraite Varchar (1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U05_DETAIL_MAJ_FACTU_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U05_DETAIL_MAJ_FACTU_V01
GO


CREATE procedure sysadm.PS_U05_DETAIL_MAJ_FACTU_V01
	@dcIdSin	Decimal (10), -- [PI062]
	@sIdFour	VarChar (6)	,
	@dtDteFact	DateTime	,
	@sNumFact	VarChar ( 255 )	,
	@dcMtFact	Decimal (11,2)	,
	@sCatFact	Varchar (35)	,
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite	Varchar (1) OUTPUT
AS

	Declare @sNomFourn		VarChar ( 255 )
	Declare @sVal 			VarChar ( 500 )
	Declare @AutoriseModif 		Integer

	Set @sAltTraite = 'O'

	Set @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )

	Select	@AutoriseModif = count(*)
	from	sinistre s with (nolock)  -- sinistre sert juste de table 'support' pour la requête... Seule les clause sur w_queue sont utiles
	Where 	Convert ( decimal (10), s.id_sin ) = @dcIdSin -- [PI062]
	and	( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = @dcIdSin ) -- [PI062]
		  Or 
		  Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = @dcIdSin And alt_occupe = 'N' ) ) -- [PI062]

	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	Begin
		Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn  + Char (10) + 
				'FACTURE HORS PRESTATION. ' + Char (10) + 
				'Facture du : ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + Char (10) + -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

	End
	Else
	Begin 
		Set @sAltTraite = 'N'	
		Return @@Error
	End 

Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U06_DETAIL_MAJ_FACTU
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Mise à jour automatique des données liées à la facturation du fournisseur FNAC
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       Voir plus bas
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #4   06/11/2009      JFF      [DCMP090567]
-- 	09/03/2011	FPI	VDoc3187 - On ne tient pas compte de l'état à cause du soldage auto
--  11/01/2013  JFF VDoc9708
--  09/01/2014  JFF Vdoc13143
--  01/09/2014  JFF Vdoc15242
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U06_DETAIL_MAJ_FACTU_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U06_DETAIL_MAJ_FACTU_V02
GO

CREATE procedure sysadm.PS_U06_DETAIL_MAJ_FACTU_V02
	@dcIdSin Decimal (10), -- [PI062]
	@iIdSeq  Integer,
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), 
	@sSocCptable VarChar (4),
	@sMagRempl VarChar (4),
	@sHeuTicket VarChar (5),
	@sCaisse VarChar (4),
	@sHote VarChar (4),
	@sTicket VarChar (4),
	@dcMtTicket  Decimal (11,2),
	@sLstFacture VarChar ( 255 ),
	@sLstArticle1 VarChar ( 255 ),
	@sLstArticle2 VarChar ( 255 ),
	@sLstArticle3 VarChar ( 255 ),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sLstArticle VarChar ( 765 )
	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdGti Decimal (7)
	Declare @dcIdDetail Decimal (7)
	Declare @sZnVirt Varchar ( 35 )
	Declare @dcIdI Decimal ( 7 )
	Declare @sSocCptableOrig VarChar ( 4 )
	Declare @iRet Integer

	Set @sLstArticle = @sLstArticle1 + @sLstArticle2 + @sLstArticle3

	Select @sNumFact = sysadm.FN_TRIM ( @sNumFact )
	Select @sCatFact = sysadm.FN_TRIM ( @sCatFact )
	Select @sSocCptable = sysadm.FN_TRIM ( @sSocCptable )
	Select @sMagRempl = sysadm.FN_TRIM ( @sMagRempl )
	Select @sHeuTicket = sysadm.FN_TRIM ( @sHeuTicket )
	Select @sCaisse = sysadm.FN_TRIM ( @sCaisse )
	Select @sHote = sysadm.FN_TRIM ( @sHote )
	Select @sTicket = sysadm.FN_TRIM ( @sTicket )
	Select @sLstFacture = sysadm.FN_TRIM ( @sLstFacture )
	Select @sLstArticle = sysadm.FN_TRIM ( @sLstArticle )


	Set @sSocCptableOrig = @sSocCptable
	
	If @sSocCptable = 101 Set @sSocCptable = 142
	If @sSocCptable = 181 Set @sSocCptable = 180
	If @sSocCptable = 182 Set @sSocCptable = 140
	
	-- Vdoc15242
	If @sSocCptable in ( 186, 187, 188) Set @sSocCptable = 180

	-- VDOC13143
	If @sSocCptable = 189 
	  Begin
		  Set @sAltTraite = 'N'	
		  Return 0
	  End

	Set @sAltTraite = 'O'
	Set @AutoriseModif = 0

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( c.id_four, '-FR' ), '(! Aucun fourn trouvé !)' )
	From   commande c with (nolock) 
	Where  c.id_sin = @dcIdSin 
	and    c.id_seq = @iIdSeq

	If @@Error <> 0 Return @@Error

		-- VDoc9708 on regade les tables permanentes pour ce contrôle.
		Select @AutoriseModif = 1,
			   @dcIdGti = d.id_gti,
			   @dcIdDetail = d.id_detail
		From   sysadm.detail d with (nolock), 
			   sysadm.commande c with (nolock) 
		Where  c.id_sin = @dcIdSin
		And    c.id_seq = @iIdSeq
		And    d.id_sin = c.id_sin 
		And    d.id_gti = c.id_gti 
		And    d.id_detail = c.id_detail 
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			   )

		
	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.cod_inter = 'F'
		And   wi.id_four = @sSocCptable
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sSocCptable,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sSocCptable

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sSocCptable
		And   wi.cod_inter = 'F'
	   End 

	
	Update sysadm.w_detail
	Set    id_i_reg = @dcIdI
	From   sysadm.w_detail d
	Where  d.id_sin = @dcIdSin
	And    d.id_gti = @dcIdGti 
	And    d.id_detail =  @dcIdDetail
	And    d.cod_etat not in ( 500,600 ) 
	And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
		 Or 
		 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]
	       )

	If @@Rowcount <> 1 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error
	
	Update sysadm.w_detail 
	Set    dte_livr = @dtDteFact, 
	       num_facture = Substring ( @sNumFact, 1, 35 ) , 
	       mt_prej = @dcMtFact, 
	       alt_att = 'N',
		   alt_reg = Case -- [PM336-1]
						When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
							Then 'O'
						Else alt_reg
			 		 End  
	From   sysadm.w_detail d
	Where  d.id_sin = @dcIdSin
	And    d.id_gti = @dcIdGti 
	And    d.id_detail =  @dcIdDetail
	And    d.cod_etat not in ( 500,600 ) 
	And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
		 Or 
		 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		   )

	If @@Rowcount <> 1 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- Insertion/Mise à jour des zones virtuelles sur w_div_det
	Set @sZnVirt = 'fnc_mag'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sMagRempl Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sMagRempl,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws with (nolock) Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End


	Set @sZnVirt = 'fnc_soc_cptable'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sSocCptableOrig Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sSocCptableOrig,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

	Set @sZnVirt = 'fnc_dte_ticket'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_dte = @dtDteFact Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				@dtDteFact,
				null,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

	Set @sZnVirt = 'fnc_heu_ticket'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sHeuTicket Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sHeuTicket,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

	Set @sZnVirt = 'fnc_caisse'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sCaisse Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sCaisse,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

   	Set @sZnVirt = 'fnc_hote'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sHote Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sHote,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End
                      
   	Set @sZnVirt = 'fnc_ticket'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sTicket Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sTicket,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End
                      
   	Set @sZnVirt = 'fnc_mt_ticket'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_mt = @dcMtTicket Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				@dcMtTicket,
				null,
				null,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End
                    
   	Set @sZnVirt = 'fnc_num_fact'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = @sNumFact Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				@sNumFact,
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

   	Set @sZnVirt = 'fnc_marq_modl'
	If Exists ( Select * From sysadm.w_div_det dd with (nolock) Where  dd.id_sin = @dcIdSin And dd.id_gti = @dcIdGti And dd.id_detail = @dcIdDetail And dd.nom_zone = @sZnVirt )
		Begin
			Update sysadm.w_div_det Set val_car = IsNull ( Left ( @sLstArticle, 35 ), 'Aucun')  Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcIdDetail and nom_zone = @sZnVirt
		End 
	Else
		Begin	 
			
			Insert into sysadm.w_div_det 
			Select  @dcIdSin, @dcIdGti, @dcIdDetail, @sZnVirt, dpd.lib_label, dpd.id_typ_liste, dpd.alt_liste_codecar, dpd.id_typ_zone, dpd.alt_oblig, 'O', dpd.cpt_tri,

				null,
				null,
				null,
				IsNull ( Left ( @sLstArticle, 35 ), 'Aucun'),
				
				0, getdate(), getdate(), 'ML'
			From   	sysadm.div_pdet dpd, sysadm.w_sin ws Where   ws.id_sin = @dcIdSin And dpd.id_prod = ws.id_prod And dpd.id_gti = @dcIdGti And dpd.nom_zone = @sZnVirt
		End

	-- Cas du traitement de @sLstFacture et @sLstArticle
	If Exists ( Select * from sysadm.det_fact_fnac df with (nolock) where df.id_sin = @dcIdSin And df.id_seq = @iIdSeq )
		Begin
			-- Cas de l'update n'est sensé jamais arriver mais je préfère le traiter au cas où...
			Update sysadm.det_fact_fnac Set lst_fact = @sLstFacture, lst_article = @sLstArticle, maj_le = getdate (), maj_par = 'ML' Where id_sin = @dcIdSin And id_seq = @iIdSeq
		End 
	Else
		Begin	 	
			Insert into sysadm.det_fact_fnac Values ( @dcIdSin, @iIdSeq, @sLstFacture, @sLstArticle, getdate(), getdate (), 'ML')
		End

	-- [PM80_FA12_FRANEX]
	If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		End 

	Return @@Error
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U07_DETAIL_MAJ_FACTU (JAMAIS MIS EN PROD)
-- Auteur               :       FABRY JF
-- Date                 :       19/09/2012
-- Libelle              :       Mise à jour automatique des données liées à la facturation avec prestations, mais foun EDI <> fourn Fact.
--				Avec un lien sur entre le fournisseur de facturation et le fournisseur EDI réél
-- Commentaires         :       [vdoc8602] en cours de dév.
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@sIdFour VarChar ( 3 )
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  VarChar(35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- JFF      25/11/2014   [PM251-2]
-- JFF      12/02/2016   [PI062]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U07_DETAIL_MAJ_FACTU' AND type = 'P' )
        DROP procedure sysadm.PS_U07_DETAIL_MAJ_FACTU
GO


CREATE procedure sysadm.PS_U07_DETAIL_MAJ_FACTU
	@dcIdSin Decimal (10), -- [PI062]
	@iIdSeq  Integer,	
	@sIdFourFactu VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  VarChar(35), 
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFournEdi  VarChar ( 255 )
	Declare @sNomFournFactu  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseSherpa Integer
	Declare @AutoriseDetail Integer
	Declare @NbreMaxPropo Integer
	Declare @dcIdGti Decimal( 7 )
	Declare @dcIdDetail Decimal( 7 )
	Declare @dcIdI Decimal( 7 )
	Declare @sIdFourEdi VarChar ( 3 )
	Declare @AutoriseModif Integer
	
	Set @sAltTraite = 'O'

	Select @sNomFournEdi = IsNull ( sysadm.FN_CODE_CAR ( c.id_four, '-FR' ), '(! Aucun fourn trouvé !)' ),
	       @sIdFourEdi = c.id_four
	From   commande c with (nolock)
	Where  c.id_sin = @dcIdSin 
	and    c.id_seq = @iIdSeq


	Select @sNomFournFactu = IsNull ( sysadm.FN_CODE_CAR ( @sIdFourFactu, '-FR' ), '(! Aucun fourn trouvé !)' )
	If @@Error <> 0 Return @@Error


	If Exists (
			Select *
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock) 
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail )
		Begin
			Select @AutoriseModif = IsNull ( count (*) , 0 )
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c  with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		
		End
	Else
		Begin
			Select @AutoriseModif = IsNull ( count (*) , 0 )
			From   sysadm.detail d with (nolock), 
			       sysadm.commande c with (nolock) 
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]

			       )
		End
	



	If @@Error <> 0 Return @@Error

	If @AutoriseSherpa = 1 
	   Begin
		If @iIdSeq = 0 
		  Begin 
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFournFactu + '(nom fourn EDI : )' + @sNomFournEdi + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ? '  + Char (10) + -- [PI062]
					'Numéro Facture : ' + @sNumFact + Char(10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End
		Else
		  Begin
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFournFactu + '(nom fourn EDI : )' + @sNomFournEdi + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) +  -- [PI062]
					'Numéro Facture : ' + @sNumFact	+ Char (10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End 

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre
	  

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error


	Set @AutoriseDetail = @AutoriseSherpa

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFourFactu,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFourFactu

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
	   End 

	
	If @AutoriseDetail = 1 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq  with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin )  -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N' 
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin )  -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]

		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U08_DETAIL_MAJ_FACTU_V01 
-- Auteur               :       FABRY JF
-- Date                 :       09/01/2013
-- Libelle              :       Mise à jour automatique des données liées à la facturation, hors prestation, et si 1 seul evènement
-- Commentaires         :       [vdoc9586] en cours de dév.
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@sIdFour VarChar ( 3 )
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  VarChar(35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- JFF      03/09/2014   [DT92_FACTU_CASTO]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U08_DETAIL_MAJ_FACTU_V03' AND type = 'P' )
        DROP procedure sysadm.PS_U08_DETAIL_MAJ_FACTU_V03
GO


CREATE procedure sysadm.PS_U08_DETAIL_MAJ_FACTU_V03
	@dcIdSin Decimal (10), -- [PI062]
	@sIdFourFactu VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  VarChar(35), 
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT,
	@sResult Varchar(255) OUTPUT -- [DT92_FACTU_CASTO]
AS

	Declare @sNomFournFactu  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseSherpa Integer
	Declare @AutoriseDetail Integer
	Declare @NbreMaxPropo Integer
	Declare @dcIdGti Decimal( 7 )
	Declare @dcIdDetail Decimal( 7 )
	Declare @dcIdI Decimal( 7 )
	Declare @sIdFourEdi VarChar ( 3 )
	Declare @AutoriseModif Integer
	Declare @sBonAReg VarChar ( 1 ) -- [DT92_FACTU_CASTO]
	Declare @sCauseAttente VarChar ( 10 )  -- [DT92_FACTU_CASTO]
	Declare @iCasto Integer
	Declare @dcMtValAchat Decimal ( 11, 2 ) -- [DT92_FACTU_CASTO]
	Declare @dcMtFactPct Decimal ( 11, 2 ) -- [DT92_FACTU_CASTO]
	Declare @iRet Integer -- [PM80_FA12_FRANEX]
	
	Set @sAltTraite = 'O'

	Select @sNomFournFactu = IsNull ( sysadm.FN_CODE_CAR ( @sIdFourFactu, '-FR' ), '(! Aucun fourn trouvé !)' )
	If @@Error <> 0 Return @@Error

	Set @sResult = '' -- [DT92_FACTU_CASTO]
	Set @iCasto = 0 -- [DT92_FACTU_CASTO]


	-- [DT92_FACTU_CASTO]

	Set @sResult = 'Info DSA => Bon à régler. ' -- [DT92_FACTU_CASTO]
		
	If Exists ( 
		Select  1
		From	sysadm.det_pro dp,
				sysadm.sinistre s with (nolock)
		Where   s.id_sin = @dcIdSin
		And     dp.id_prod = s.id_prod
		And		dp.id_code_dp = 43
		) 
		Begin
			Set @iCasto = 1
		End 

	If     (
			Select COUNT (*)
			From   sysadm.w_detail d with (nolock) 
			Where  d.id_sin = @dcIdSin 
			And    d.cod_etat not in ( 500,600 ) 
			) = 1
		Begin
			Select @AutoriseModif = IsNull ( count (*) , 0 )
			From   sysadm.w_detail d with (nolock) 
			Where  d.id_sin = @dcIdSin
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
			       
			Select 	@dcIdGti = d.id_gti,
				    @dcIdDetail = d.id_detail
			From   sysadm.w_detail d with (nolock)
			Where  d.id_sin = @dcIdSin 

			-- [DT92_FACTU_CASTO]
			Select @sBonAReg = dd.val_car	
			From   sysadm.w_detail d with (nolock),
					sysadm.w_div_det dd with (nolock)
			Where  d.id_sin = @dcIdSin 
			And	   d.id_gti = @dcIdGti
			And	   d.id_detail = @dcIdDetail
			And    dd.id_sin = d.id_sin
			And    dd.id_gti = d.id_gti
			And    dd.id_detail = d.id_detail
			And    dd.nom_zone = 'bon_a_regler'
				
			If @sBonAReg is null Set @sBonAReg = 'N'
				
			If @sBonAReg <> 'O' 
				Begin
					Select @sCauseAttente = dd.val_car	
					From   sysadm.w_detail d with (nolock),
							sysadm.w_div_det dd with (nolock)
					Where  d.id_sin = @dcIdSin 
					And	   d.id_gti = @dcIdGti
					And	   d.id_detail = @dcIdDetail
					And    dd.id_sin = d.id_sin
					And    dd.id_gti = d.id_gti
					And    dd.id_detail = d.id_detail
					And    dd.nom_zone = 'cause_attente'
					
					If @sCauseAttente is null Set @sCauseAttente = 'AUC'
					
					If @sCauseAttente <> 'AUC' 
						Begin
						Set @sResult = 'Info DSA => ' + rTrim ( sysadm.FN_CODE_CAR ( @sCauseAttente, '-W9' ) )
						Set @sAltTraite = 'N'	
						Return @@Error
						End
					Else
						Begin
						Set @sResult = 'Info DSA => Aucune info de la DSA'
						End 
					 
				End 

			-- [DT92_FACTU_CASTO]

			       
		End
	Else
		Begin				
			If     (
					Select COUNT (*)
					From   sysadm.detail d with (nolock) 
					Where  d.id_sin = @dcIdSin	
					And    d.cod_etat not in ( 500,600 ) 
					) = 1
				Begin
					Select @AutoriseModif = IsNull ( count (*) , 0 )
					From   sysadm.detail d  with (nolock)
					Where  d.id_sin = @dcIdSin
					And    d.cod_etat not in ( 500,600 ) 
					And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
						 Or 
						 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
						   )
						   
					Select 	@dcIdGti = d.id_gti,
							@dcIdDetail = d.id_detail
					From   sysadm.detail d with (nolock)
					Where  d.id_sin = @dcIdSin 
					
					-- [DT92_FACTU_CASTO]
					Select @sBonAReg = dd.val_car	
					From   sysadm.detail d with (nolock),
							sysadm.div_det dd with (nolock)
					Where  d.id_sin = @dcIdSin 
					And	   d.id_gti = @dcIdGti
					And	   d.id_detail = @dcIdDetail
					And    dd.id_sin = d.id_sin
					And    dd.id_gti = d.id_gti
					And    dd.id_detail = d.id_detail
					And    dd.nom_zone = 'bon_a_regler'
						
					If @sBonAReg is null Set @sBonAReg = 'N'
						
					If @sBonAReg <> 'O' 
						Begin
						Select @sCauseAttente = dd.val_car	
						From   sysadm.detail d with (nolock),
								sysadm.div_det dd with (nolock)
						Where  d.id_sin = @dcIdSin 
						And	   d.id_gti = @dcIdGti
						And	   d.id_detail = @dcIdDetail
						And    dd.id_sin = d.id_sin
						And    dd.id_gti = d.id_gti
						And    dd.id_detail = d.id_detail
						And    dd.nom_zone = 'cause_attente'
							
						If @sCauseAttente is null Set @sCauseAttente = 'AUC'
							
						If @sCauseAttente <> 'AUC' 
							Begin
							Set @sResult = 'Info DSA => ' + rTrim ( sysadm.FN_CODE_CAR ( @sCauseAttente, '-W9' ) )
							Set @sAltTraite = 'N'	
							Return @@Error
							End 
						Else
							Begin
							Set @sResult = 'Info DSA => Aucune info de la DSA'
							End 
							 
						End 

					-- [DT92_FACTU_CASTO]					
						   
				End
		    Else
				Begin
					Set @AutoriseModif = 0
				End 
		End
	

	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFournFactu + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ? '  + Char (10) +  -- [PI062]
					'Numéro Facture : ' + @sNumFact + Char(10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

			IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
			Else
 				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFourFactu,
			'N',
			null,
			null,
			null,
			null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFourFactu

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
	   End 

	
	If @AutoriseModif = 1 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		-- [DT92_FACTU_CASTO]
		If @iCasto = 1 
		 Begin
			Select	@dcMtValAchat = d.mt_val_achat
			From	sysadm.detail d with (nolock)
			Where   d.id_sin = @dcIdSin
			And		d.id_gti = @dcIdGti 
			And		d.id_detail = @dcIdDetail
			
			If @dcMtValAchat is null Set @dcMtValAchat = 0
			
			-- Si Mt_Casto = Mt_PEC_SIMPA2 Alors on prends MT_Casto
			-- En fait je ne traite pas ce cas, car ce sera le défaut si les deux autres cas ne répondent pas
			
			-- Si Mt_Casto < Mt_Pec_SIMPA2 Alors on prends MT_Casto
			-- Idem pour ce cas, je ne traite pas ce cas, car ce sera le défaut si l'autre cas ne répondent pas
			
			-- Si Mt_Casto > Mt_Pec_SIMPA2 Alors 
			If @dcMtFact > @dcMtValAchat
			  Begin
			    Set @dcMtFactPct = @dcMtFact * 0.8  --   A=Mt_casto – 20%
			    
			    -- Si A <= Mt_SIMPA2, Ok on garde A
			    If @dcMtFactPct <= @dcMtValAchat
			      Begin
					Set @dcMtFact = @dcMtFactPct
			      End 

				-- Si A > Mt_SIMPA2, Alors on ajuste au Mt_Pec_SIMPA2			      
			    If @dcMtFactPct > @dcMtValAchat
			      Begin
					Set @dcMtFact = @dcMtValAchat
			      End 
			      
			  End 
			  
			 Set @sResult = rtrim ( @sResult )+ ' (' + convert ( VarChar (20), @dcMtFact ) + '€).'			  
		 End 
		-- [DT92_FACTU_CASTO]


		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U09_DETAIL_MAJ_FACTU  
-- Auteur               :       FABRY JF
-- Date                 :       09/01/2013
-- Libelle              :       Mise à jour automatique des données liées à la facturation, hors prestation des cmde CEG avec Id_ref_four = 'IPHONE_VIRTUEL'
-- Commentaires         :       [DT57_CMDE_IPHONE_SFR] - Facturation hors presta à O2M des iphones virtuel SFR.
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@sIdFour VarChar ( 3 )
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  VarChar(35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U09_DETAIL_MAJ_FACTU_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U09_DETAIL_MAJ_FACTU_V02
GO


CREATE procedure sysadm.PS_U09_DETAIL_MAJ_FACTU_V02
	@dcIdSin Decimal (10), -- [PI062]
	@sIdFourFactu VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  VarChar(35),
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]	 
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFournFactu  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseSherpa Integer
	Declare @AutoriseDetail Integer
	Declare @NbreMaxPropo Integer
	Declare @dcIdGti Decimal( 7 )
	Declare @dcIdDetail Decimal( 7 )
	Declare @dcIdI Decimal( 7 )
	Declare @sIdFourEdi VarChar ( 3 )
	Declare @AutoriseModif Integer
	Declare @iRet integer

	Set @sAltTraite = 'O'

	Select @sNomFournFactu = IsNull ( sysadm.FN_CODE_CAR ( @sIdFourFactu, '-FR' ), '(! Aucun fourn trouvé !)' )
	If @@Error <> 0 Return @@Error

	If     (
			Select COUNT (*)
			From   sysadm.w_detail d with (nolock),
				   sysadm.w_commande wc  with (nolock)
			Where  d.id_sin = @dcIdSin 
			And    wc.id_sin = d.id_sin
			And    wc.id_detail = d.id_detail			
			And	   wc.id_four = 'CEG'
			And    CharIndex ('IPHONE', wc.id_modl_art ) > 0
			And    wc.cod_etat = 'RPC'
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]
			       )			
			) = 1
		Begin
			Select @AutoriseModif = 1
			
			Select 	@dcIdGti = d.id_gti,
					@dcIdDetail = d.id_detail
			
			From   sysadm.w_detail d with (nolock),
				   sysadm.w_commande wc with (nolock)
			Where  d.id_sin = @dcIdSin 
			And    wc.id_sin = d.id_sin
			And    wc.id_detail = d.id_detail			
			And	   wc.id_four = 'CEG'
			And    CharIndex ('IPHONE', wc.id_modl_art  ) > 0
			And    wc.cod_etat = 'RPC'
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		End
	Else
		Begin				
			If     (
					Select COUNT (*)
					From   sysadm.detail d with (nolock),
						   sysadm.commande wc with (nolock)
					Where  d.id_sin = @dcIdSin 
					And    wc.id_sin = d.id_sin
					And    wc.id_detail = d.id_detail			
					And	   wc.id_four = 'CEG'
					And    CharIndex ('IPHONE', wc.id_modl_art  ) > 0
					And    wc.cod_etat = 'RPC'
					And    d.cod_etat not in ( 500,600 ) 
					And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
							 Or 
						     Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]
						   )					
					) = 1
				Begin
					Select @AutoriseModif = 1

					Select 	@dcIdGti = d.id_gti,
							@dcIdDetail = d.id_detail
					From   sysadm.detail d with (nolock),
						   sysadm.commande wc with (nolock)
					Where  d.id_sin = @dcIdSin 
					And    wc.id_sin = d.id_sin
					And    wc.id_detail = d.id_detail			
					And	   wc.id_four = 'CEG'
					And    CharIndex ('IPHONE', wc.id_modl_art  ) > 0
					And    wc.cod_etat = 'RPC'
					And    d.cod_etat not in ( 500,600 ) 
					And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
						 Or 
						 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' )-- [PI062]
						   )
				End
		    Else
				Begin
					Set @AutoriseModif = 0
				End 
		End
	
	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFournFactu + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ? '  + Char (10) + -- [PI062]
					'Numéro Facture : ' + @sNumFact + Char(10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

			IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
				EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
			Else
 				EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFourFactu,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFourFactu

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFourFactu
		And   wi.cod_inter = 'F'
	   End 

	If @AutoriseModif = 1 
	  Begin	 
	  
	  Select @dcIdSin, @dcIdGti, @dcIdDetail
	  
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 )
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44
-- Auteur               :       FABRY JF
-- Date                 :       21/11/2006
-- Libelle              :       Mise à jour automatique des données liées à la facturation pour tous les fournisseurs, sans règler le fournisseur, 
--								Mais en demandant l'argent à l'assureur, donc juste marquer d'un SR sur volcanes, pour dire Sans Rapprochement par rapport à un règlement quotidien.
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@iIdSeq  Integer
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #1	03/09/2007	PHG	[DCMP070511] On permet
--				la MAJ des details sans suite
--				pour les trt d'integ. frn.
-- #2	17/03/2008	PHG	[DCMP080166] Ajout de la Catégorie 
--				de Facture dans le Message
--				du contact Sherpa
-- #3	17/03/2008	PHG	[DCMP070989]Prise en compte des détail refusé.
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      07/05/2013   [PC938_ORANGE_V3]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02
GO


CREATE procedure sysadm.PS_U_DETAIL_MAJ_FACTU_SANS_REGL_DT44_V02
	@dcIdSin Decimal (10), -- [PI062]
	@iIdSeq  Integer,
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), -- #2 [DCMP080166] Catégorie de Facture
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdI Decimal( 7 )
    Declare @dcIdGti Decimal (7)
    Declare @dcIdDetail Decimal (7)
    Declare @dcNewIdDetail Decimal (7)			    
    Declare @sIdFour VarChar ( 3 )
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( c.id_four, '-FR' ), '(! Aucun fourn trouvé !)' ),
		   @sIdFour = c.id_four
	From   commande c with (nolock)
	Where  c.id_sin = @dcIdSin 
	and    c.id_seq = @iIdSeq

	If @@Error <> 0 Return @@Error

	If Exists (
			Select *
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail )
		Begin
			Select @AutoriseModif = IsNull ( count (*) , 0 )
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c with (nolock) 
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		
		End
	Else
		Begin
			Select @AutoriseModif = IsNull ( count (*) , 0 )
			From   sysadm.detail d with (nolock), 
			       sysadm.commande c  with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' )-- [PI062]
			       )
		End
	


	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

		    
	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour ,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour 

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour 
		And   wi.cod_inter = 'F'
	   End 

	
	Update sysadm.w_detail 
	Set    id_i_reg = i.id_i 
	From   sysadm.w_detail d, 
	       sysadm.w_commande c, 
	       sysadm.w_inter i 
	Where  c.id_sin = @dcIdSin
	And    c.id_seq = @iIdSeq
	And    d.id_sin = c.id_sin 
	And    d.id_gti = c.id_gti 
	And    d.id_detail =  c.id_detail
	And    d.cod_etat not in ( 500,600 )
	And    i.id_sin = c.id_sin 
	And    i.cod_inter = 'F' 
	And    i.id_four = c.id_four 
	And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
		 Or 
		 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
	       )
	
	       

	If @@Rowcount <> 1 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	
	Update sysadm.w_detail 
	Set    dte_livr = @dtDteFact, 
	       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
	       mt_prej = @dcMtFact, 
	       alt_att = 'N',
		   alt_reg = Case -- [PM336-1]
						When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
							Then 'O'
						Else alt_reg
					 End  
	From   sysadm.w_detail d, 
	       sysadm.w_commande c 
	Where  c.id_sin = @dcIdSin
	And    c.id_seq = @iIdSeq
	And    d.id_sin = c.id_sin 
	And    d.id_gti = c.id_gti 
	And    d.cod_etat not in ( 500,600 ) 
	And    d.id_detail = c.id_detail 	
	And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
		 Or 
		 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
	       )

	If @@Rowcount <> 1 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error
	

	-- [DT044-1_V5]
	If Not Exists ( 
		Select Top 1 1
		From sysadm.w_div_det dd with (nolock),
		     sysadm.w_detail d with (nolock), 
	         sysadm.w_commande c  with (nolock)
		Where  c.id_sin = @dcIdSin
		And    c.id_seq = @iIdSeq
		And    d.id_sin = c.id_sin 
		And    d.id_gti = c.id_gti 
		And    d.id_detail = c.id_detail
		And    dd.id_sin = d.id_sin
		And	   dd.id_gti = d.id_gti
		And	   dd.id_detail = d.id_detail
		And    dd.nom_zone = 'pas_de_rglt_fourn' )
		
		Begin
	
			Insert into sysadm.w_div_det 
			select d.id_sin,
				   d.id_gti,
				   d.id_detail,
				   'pas_de_rglt_fourn', 
				   'Pas de rglt fournisseur', 
				   '-1',
				   'N',
				   'X', 
				   'N', 
				   'N',
				   500,
				   null,
				   null,
				   null,
				   'O',
				   0,
				   getdate(), 
				   getdate(), 
				   'JFF'
			From   sysadm.w_detail d with (nolock), 
				   sysadm.w_commande c  with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.cod_etat not in ( 500,600 ) 
			And    d.id_detail = c.id_detail 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
				   )

			If @@Rowcount <> 1 
			 Begin 
			  Set @sAltTraite = 'N'	
			  Return @@Error
			 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		End
	
	If @@Error <> 0 Return @@Error


	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DETAIL_MAJ_FACTU_DIAG_O2M
-- Auteur               :       FABRY JF
-- Date                 :       05/11/2013
-- Libelle              :       Facturation des Diag O2M dans SIMPA2 avec redressement du détail 1083.
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@iIdSeq  Integer
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02' AND type = 'P' )
        DROP procedure sysadm.PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02
GO


CREATE procedure sysadm.PS_U_DETAIL_MAJ_FACTU_DIAG_O2M_V02
	@dcIdSin Decimal (10), -- [PI062]
	@iIdSeq  Integer,
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), -- #2 [DCMP080166] Catégorie de Facture
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdI Decimal( 7 )
    Declare @dcIdGti Decimal (7)
    Declare @dcIdDetail Decimal (7)
    Declare @dcNewIdDetail Decimal (7)			    
    Declare @sIdFour VarChar ( 3 )
	Declare @iCas Integer
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( c.id_four, '-FR' ), '(! Aucun fourn trouvé !)' ),
		   @sIdFour = c.id_four
	From   commande c
	Where  c.id_sin = @dcIdSin 
	and    c.id_seq = @iIdSeq

	If @@Error <> 0 Return @@Error

	If Exists (
			Select *
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c  with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail )
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.w_detail d with (nolock), 
			       sysadm.w_commande c  with (nolock)
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		
		End
	Else
		Begin
			Select @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.detail d, 
			       sysadm.commande c 
			Where  c.id_sin = @dcIdSin
			And    c.id_seq = @iIdSeq
			And    d.id_sin = c.id_sin 
			And    d.id_gti = c.id_gti 
			And    d.id_detail = c.id_detail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = c.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = c.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		End
	


	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

		    
	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error

	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour ,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour 

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour 
		And   wi.cod_inter = 'F'
	   End 

	-- [PM251-2]
	If @iCas not in ( 500, 600 )
	 Begin
		Update sysadm.w_detail
		Set	   cod_dec_mac = 100, 
			   cod_dec_ope = 100,
			   cod_etat = 100,
			   alt_att = 'N',
			   alt_ssui = 'N',
			   cod_mot_ssui = 0
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti
		And    d.id_detail = @dcIdDetail

	 End 
		
	If @iCas in ( 500, 600 ) -- On créé un autre détail.
	 Begin
		
		Select	@dcNewIdDetail = max ( id_detail ) 
		From	sysadm.w_detail with (nolock)
		where   id_sin = @dcIdSin
		and     id_gti = @dcIdGti 

		If @dcNewIdDetail is null Set @dcNewIdDetail = 0
		Set @dcNewIdDetail = @dcNewIdDetail + 1

		Insert into sysadm.w_detail 
--		Select id_sin,   id_gti,   @dcNewIdDetail,   id_evt,   lib_det,   dte_det,   heu_det, num_carte,   0,   0,   0,   0,   null, 'N', 'N', 'N',   'N',   'O', alt_valide,  0,  'N',   0,   100,   100,   100,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   null,   null,   mt_val_achat,   mt_val_publique,   null
		Select id_sin,   id_gti,   @dcNewIdDetail,   id_evt,   lib_det,   dte_det,   heu_det, num_carte,   0,   0,   0,   0,   null, 'N', 'N', 'N',   'N',   'O', 'O'       ,  0,  'N',   0,   100,   100,   100,   id_carte,   id_type_carte, getdate(),   getdate(),   'AUTO',   null,   null,   mt_val_achat,   mt_val_publique,   null
		From sysadm.w_detail d with (nolock)
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail

		Insert into sysadm.w_div_det 
		Select id_sin,   id_gti, @dcNewIdDetail, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot , cpt_tri, val_nbre, val_mt, val_dte, val_car, 0, getdate(),   getdate(), 'AUTO'
		From sysadm.w_div_det d with (nolock)
		Where d.id_sin = @dcIdSin
		And   d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetail			  

		Set @dcIdDetail = @dcNewIdDetail

	 End 

	
	Update sysadm.w_detail 
	Set    id_i_reg = i.id_i, 
		   dte_livr = @dtDteFact, 
	       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
	       mt_prej = @dcMtFact, 
	       alt_att = 'N',
		   alt_reg = Case -- [PM336-1]
						When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
							Then 'O'
						Else alt_reg
			 		 End  
	From   sysadm.w_detail d, 
	       sysadm.w_inter i 
	Where  d.id_sin = @dcIdSin
	And    d.id_gti = @dcIdGti
	And    d.id_detail = @dcIdDetail
	And    i.id_sin = d.id_sin 
	And    i.cod_inter = 'F' 
	And    i.id_four = @sIdFour 

	If @@Rowcount <> 1 
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	-- [PM80_FA12_FRANEX]
	If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
	  Begin
		Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
			@dcIdSin,
			@dcIdI,
			@dcIdGti,
			@dcIdDetail,
			@adcMtIndemPrinc_1,
			@adcMtFraisAnex_2,
			@adcMtFraisAnex_3,
			@adcMtFraisAnex_4,
			@adcMtFraisAnex_5,
			@adcMtFraisAnex_6,
			@adcMtFraisAnex_7,
			@adcMtFraisAnex_8,
			@adcMtFraisAnex_9,
			@adcMtFraisAnex_10,
			@adcMtFraisAnex_11,
			'ML'

			If @iRet <> 0 Return @iRet 
	  End 

	If @@Error <> 0 Return @@Error

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V02
-- Auteur               :       FPI
-- Date                 :       29/10/2014
-- Libelle              :       Mise à jour automatique des données liées à la facturation pour AXA
-- Commentaires         :       
-- References           :       [PC13174]
--
-- Arguments            :       @dcIdProd Decimal (7)
--				@dcIdEts Decimal (7)
--				@sIdAdh	varchar(29)
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  Varchar (35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03' AND type = 'P' )
        DROP procedure sysadm.PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03
GO


CREATE procedure sysadm.PS_U_DETAIL_MAJ_FACTU_BNP_SECU_V03
	@dcIdProd Decimal (7),
	@dcIdEts Decimal (7),
	@sIdAdh	varchar(29),
	@sIdFour VarChar ( 10),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  Varchar (35), 
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @dcIdSin Decimal(10) -- [PI062]
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseModif Integer
	Declare @dcIdI Decimal( 7 )
    Declare @dcIdGti Decimal (7)
    Declare @dcIdDetail Decimal (7)
    Declare @dcNewIdDetail Decimal (7)			    
	Declare @iCas Integer
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )

	If @@Error <> 0 Return @@Error

	If Exists (
			Select *
			From   sysadm.w_sin s with (nolock),
				   sysadm.w_detail d with (nolock)
			Where  s.id_prod=@dcIdProd
			And	   s.id_ets=@dcIdEts
			And	   s.id_adh=@sIdAdh
			And    d.id_sin = s.id_sin 
			And    d.id_evt = 1419  )
		Begin
			Select Top 1
				   @AutoriseModif = 1,
				   @dcIdSin=s.id_sin,
				   @iCas = d.cod_etat,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.w_sin s with (nolock),
				   sysadm.w_detail d with (nolock)
			Where  s.id_prod=@dcIdProd
			And	   s.id_ets=@dcIdEts
			And	   s.id_adh=@sIdAdh
			And    d.id_sin = s.id_sin 
			And    d.id_evt = 1419 
			And    d.cod_etat not in ( 500,600 )
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = s.id_sin ) -- [PI062]
					 Or 
					Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = s.id_sin And alt_occupe = 'N' )-- [PI062]
			       )
		
		End
	Else
		Begin
			Select Top 1
				   @AutoriseModif = 1,
				   @iCas = d.cod_etat,
				   @dcIdSin=s.id_sin,
				   @dcIdGti = d.id_gti,
				   @dcIdDetail = d.id_detail
			From   sysadm.sinistre s with (nolock),
				   sysadm.detail d with (nolock)
			Where  s.id_prod=@dcIdProd
			And	   s.id_ets=@dcIdEts
			And	   s.id_adh=@sIdAdh
			And    d.id_sin = s.id_sin 
			And    d.id_evt = 1419 
			And    d.cod_etat not in ( 500,600 )
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = s.id_sin ) -- [PI062]
				 Or 
				 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = s.id_sin And alt_occupe = 'N' ) -- [PI062]
			       )
		End
	


	If @@Error <> 0 Return @@Error

	If @AutoriseModif = 1 
	   Begin
		Set @sVal = 'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
				'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
				'Detail : ' + Convert ( Varchar (10), @dcIdSin ) + ' Detail ' + Convert ( Varchar (2), @dcIdDetail ) + Char (10) +  -- [PI062]
				'Numéro Facture : ' + @sNumFact + Char (10) +
				'Catégorie de Facture : ' + @sCatFact 

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre

		    
	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error
	
	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )
		
		-- [PMO89_RS4822]
		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour ,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour 

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour 
		And   wi.cod_inter = 'F'
	   End 

	-- [PM251-2]
	If @iCas not in ( 500, 600 )
	 Begin
		Update sysadm.w_detail
		Set	   cod_dec_mac = 100, 
			   cod_dec_ope = 100,
			   cod_etat = 100,
			   alt_att = 'N',
			   alt_ssui = 'N',
			   cod_mot_ssui = 0
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti
		And    d.id_detail = @dcIdDetail

	 End 

	If @iCas not in ( 500, 600 ) 
	  Begin	 
		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = Case When mt_prej=0 Then @dcMtFact else mt_prej End, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
				 Or 
			     Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

		If @@Error <> 0 Return @@Error
	  End

	Return @@Error
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_LST_DETAILS
-- Auteur               :       FPI	
-- Date                 :       15/07/2014
-- Libellé              :        
-- Commentaires         :       Liste des détails d'un sinistre
-- Références           :       [PC395-2] - pour Atlas
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_LST_DETAILS' AND type = 'P' )
        DROP procedure sysadm.PS_S01_LST_DETAILS
GO

CREATE procedure sysadm.PS_S01_LST_DETAILS
        @dcIdSin        Decimal ( 10,0 ) -- [PI062]
AS

	Select g.id_gti, cg.lib_gti,
		d.id_detail, 
		d.id_evt, sysadm.FN_CODE_NUM(d.id_evt,'+EV') as lib_evt,
		d.cod_etat, sysadm.FN_CODE_NUM(d.cod_etat,'-ET') as lib_code_etat,
		d.valide_le,
		r.mt_reg,
		rt.dte_reg,
		d.mt_plaf,
		re.id_motif as id_refus,
		sysadm.FN_CODE_NUM(re.id_motif,'+RE') as lib_refus
	From sysadm.sinistre s
		inner join sysadm.gar_sin g on s.id_sin=g.id_sin
		inner join sysadm.code_garantie cg on cg.id_prod=s.id_prod and cg.id_gti=g.id_gti
		inner join sysadm.detail d on s.id_sin=d.id_sin and d.id_gti=g.id_gti
		left outer join sysadm.reglement rt on rt.id_sin=s.id_sin 
			and (rt.id_reg=d.id_reg or rt.id_reg_base=d.id_reg)
		left outer join sysadm.reg_gti r on r.id_sin=s.id_sin and r.id_gti=g.id_gti 
			and r.id_reg=rt.id_reg
		left outer join sysadm.refus re on re.id_sin=s.id_sin and re.id_gti=g.id_gti
			and (re.id_detail=-1 or re.id_detail=d.id_detail)
	Where s.id_sin=@dcIdSin
		
Go

grant execute on sysadm.PS_S01_LST_DETAILS to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U10_DETAIL_MAJ_FACTU_ADVISE
-- Auteur               :       FABRY JF
-- Date                 :       30/05/2017
-- Libelle              :       Mise à jour automatique des données liées à la facturation pour ADVISE (PC151259-2)
-- Commentaires         :       [PC151259-2]
-- References           :       
--
-- Arguments            :       @dcIdSin Decimal (7)
--				@sIdFour VarChar ( 3 )
--				@dtDteFact DateTime
--				@sNumFact  VarChar ( 255 )
--				@dcMtFact  Decimal (11,2)
--				@sCatFact  VarChar(35)
--				@sAltTraite Varchar(1) OUTPUT
--
-- Retourne             :       @@Error
--
-------------------------------------------------------------------
-- MAJ	Le 		Par	Description
-- #1	03/09/2007	PHG	[DCMP070511] On permet
--				la MAJ des details sans suite
--				pour les trt d'integ. frn.
-- #2	17/03/2008	PHG	[DCMP080166] Ajout de la Catégorie 
--				de Facture dans le Message
--				du contact Sherpa
-- #3	17/03/2008	PHG	[DCMP070989] Prise en compte des détail refusé.
-- #4   06/11/2009      JFF      [DCMP090567]
-- JFF      25/11/2014   [PM251-2]
-- JFF      11/04/2016   [PM336-1]
-- JFF      12/02/2016   [PI062]
-- JFF      09/09/2022   [PM80_FA12_FRANEX]
-- JFF      30/05/2023   [PMO89_RS4822]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01' AND type = 'P' )
        DROP procedure sysadm.PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01
GO


CREATE procedure sysadm.PS_U10_DETAIL_MAJ_FACTU_ADVISE_V01
	@dcIdSin Decimal (10), -- [PI062]
	@sIdFour VarChar ( 3 ),
	@dtDteFact DateTime,
	@sNumFact  VarChar ( 255 ),
	@dcMtFact  Decimal (11,2),
	@sCatFact  VarChar(35), -- #2 [DCMP080166] Catégorie de Facture
	@adcMtIndemPrinc_1 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_2 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_3 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_4 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_5 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_6 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_7 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_8 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_9 Decimal (11,2)	, -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_10 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@adcMtFraisAnex_11 Decimal (11,2), -- [PM80_FA12_FRANEX]
	@sChaine   VarChar ( 255 ), -- [PM336-1]
	@sAltTraite Varchar(1) OUTPUT,
	@aiIdSeq Integer OUTPUT
AS

	Declare @sNomFourn  VarChar ( 255 )
	Declare @sVal VarChar ( 500 )
	Declare @AutoriseSherpa Integer
	Declare @AutoriseDetail Integer
	Declare @NbreMaxPropo Integer
	Declare @iIdSeq Integer
	Declare @dcIdGti Decimal( 7 )
	Declare @dcIdDetail Decimal( 7 )
	Declare @dcIdI Decimal( 7 )
	Declare @iRet Integer

	Set @sAltTraite = 'O'

	Select @sNomFourn = IsNull ( sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ), '(! Aucun fourn trouvé !)' )
	If @@Error <> 0 Return @@Error

	-- fourn ADV saisi
	If @sIdFour <> 'ADV' 
	 Begin
		Set @sAltTraite = 'N'
		Return
     End

	-- Les produits Advises uniquement...	 
	If Not Exists ( 
		Select Top 1 1 
		From   sysadm.det_pro dp with (nolock),
			   sysadm.sinistre s with (nolock)
		Where  s.id_sin = @dcIdSin
		And    dp.id_prod = s.id_prod
		And    dp.id_code_dp = 252
	)
	 Begin
		Set @sAltTraite = 'N'
		Return
	 End 

	-- La logique est de dire ici que le seul fournisseur réél des ces produits ne peut être que PSM
	-- Donc tout autre fournisseur présent passe par une facturation ADVISE, et donc j'en cherche un (qui n'est pas réglé).
	Select @iIdSeq = Min ( c.id_seq )
	From   sysadm.commande c with (nolock),
		   sysadm.detail d with (nolock)
	Where  c.id_sin = @dcIdSin 
	And    c.id_four <> 'PSM'
	And	   c.cod_etat in ( 'RPC', 'RFO' )
	And    d.id_sin = c.id_sin
	And    d.id_gti = c.id_gti
	And    d.id_detail = c.id_detail
	And    d.cod_etat not in ( 500, 600 )

	If @iIdSeq is null Or @iIdSeq <= 0 
	 Begin
		Set @sAltTraite = 'N'
		Return
	 End 

	-- [PM251-2]
	Set @aiIdSeq = @iIdSeq

	Select 	@dcIdGti = c.id_gti,
		    @dcIdDetail = c.id_detail
	From   sysadm.commande c with (nolock)
	Where  c.id_sin = @dcIdSin 
	And    c.id_seq = @iIdSeq 

	If @@Error <> 0 Return @@Error	   


	If Exists ( 	Select 	* 
			from 	sysadm.w_detail d with (nolock)
			Where  d.id_sin = @dcIdSin
			And    d.id_gti = @dcIdGti 
			And    d.id_detail = @dcIdDetail 
			)
		Begin 
			Select @AutoriseSherpa = IsNull ( count (*) , 0 )
			From   sysadm.w_detail d  with (nolock)
			Where  d.id_sin = @dcIdSin
			And    d.id_gti = @dcIdGti 
			And    d.id_detail = @dcIdDetail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
					Or 
					Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
				    )
		End
	Else			
		Begin
			
			Select @AutoriseSherpa = IsNull ( count (*) , 0 )
			From   sysadm.detail d  with (nolock)
			Where  d.id_sin = @dcIdSin
			And    d.id_gti = @dcIdGti 
			And    d.id_detail = @dcIdDetail 
			And    d.cod_etat not in ( 500,600 ) 
			And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
					Or 
					Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
				    )
		End

	If @@Error <> 0 Return @@Error

	Set @AutoriseDetail = @AutoriseSherpa
	   

	If @NbreMaxPropo > 3 
	 Begin 
		Set  @iIdSeq = 0
		
		Select @AutoriseSherpa = IsNull ( count (*) , 0 )
		Where  
 			( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = @dcIdSin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = @dcIdSin And wq.alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Error <> 0 Return @@Error
		
		Set @AutoriseDetail = 0
	   
	 End 

	If @@Error <> 0 Return @@Error

	If @AutoriseSherpa = 1 
	   Begin
		If @iIdSeq = 0 
		  Begin 
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ? '  + Char (10) +  -- [PI062]
					'Numéro Facture : ' + @sNumFact + Char(10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End
		Else
		  Begin
			Set @sVal = 	'FACTURATION MENSUELLE ' + @sNomFourn + Char (10) + 
					'Facture du ' + Convert ( VarChar ( 10 ) , @dtDteFact, 103 ) + Char (10) + 
					'Commande : ' + Convert ( Varchar (10), @dcIdSin ) + ' Tiret ' + Convert ( Varchar (2), @iIdSeq ) + Char (10) + -- [PI062]
					'Numéro Facture : ' + @sNumFact	+ Char (10) +
					'Catégorie de Facture : ' + @sCatFact -- #2 [DCMP080166]
		  End 

		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
-- #4 [DCMP090567]
--		    Exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal, 'ML', 'X', 0
		    EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
		Else
-- #4 [DCMP090567]		
--		    Exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin,2, @sVal ,'ML', 'X', 0
 		    EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V02 @dcIdSin, 2, @sVal, 'ML', 'X' , 0 , null, 'C', null, 12
-- Définir les valeurs de paramètre
	  

	   End
	 Else
	 Begin 
	  Set @sAltTraite = 'N'	
	  Return @@Error
	 End 

	If @@Error <> 0 Return @@Error


	-- L'inter fournisseur Fourn existe-til ?
	If Not Exists ( 
		Select *
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
		      )
	   Begin
	   	-- Sinon Création de l'interlocuteur
		Set @dcIdI = ( Select max (id_i) + 1
			      From   sysadm.w_inter i with (nolock)
			      Where  i.id_sin = @dcIdSin )

		Insert into w_inter 
		Select	
			@dcIdSin,
			@dcIdI,
			'F',
			5,
			a.lib_ag,
			a.adr_1,
			a.adr_2,
			a.adr_cp,
			a.adr_ville,
			null,
			null,
			null,
			null,
			'FM',
			null,
			null,
			null,
			null,
			0,
			0,
			null,
			null,
			null,
			null,
			0,
			0,
			'N',
			'N',
			'N',
			'N',
			'N',
			null,
			null,
			'N',
			null,
			null,
			getdate(),
			getdate(),
			'ML',
			null,
			null,
			@sIdFour,
			'N',
			null,
			null,
			null,
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    null, -- [PMO89_RS4822]
		    0    -- [PMO89_RS4822]

		From   	sysadm.agence a with (nolock)
		Where 	a.id_bq = @sIdFour

		If @@Rowcount <> 1 Return @@Error
		If @@Error <> 0 Return @@Error
		
	   End 
	   Else
	   Begin
		Select @dcIdI = wi.id_i
		From w_inter wi with (nolock)
		Where wi.id_sin = @dcIdSin
		And   wi.id_four = @sIdFour
		And   wi.cod_inter = 'F'
	   End 

	
	If @AutoriseDetail = 1 
	  Begin	 

		Update sysadm.w_detail
		Set    id_i_reg = @dcIdI
		From   sysadm.w_detail d
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq with (nolock) where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq with (nolock) where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		Update sysadm.w_detail 
		Set    dte_livr = @dtDteFact, 
		       num_facture = Substring ( sysadm.FN_TRIM ( @sNumFact ), 1, 35 ) , 
		       mt_prej = @dcMtFact, 
		       alt_att = 'N',
			   alt_reg = Case -- [PM336-1]
							When sysadm.FN_CLE_VAL ( 'A_FORCER', @sChaine, ';' ) = 'OUI'
								Then 'O'
							Else alt_reg
						 End  
		From   sysadm.w_detail d 
		Where  d.id_sin = @dcIdSin
		And    d.id_gti = @dcIdGti 
		And    d.id_detail =  @dcIdDetail
		And    d.cod_etat not in ( 500,600 ) 
		And    ( Not exists ( select * from  w_queue wq where Convert ( decimal (10), wq.id_sin ) = d.id_sin ) -- [PI062]
			 Or 
			 Exists ( select * from w_queue wq where Convert ( decimal (10),  wq.id_sin ) = d.id_sin And alt_occupe = 'N' ) -- [PI062]
		       )

		If @@Rowcount <> 1 
		 Begin 
		  Set @sAltTraite = 'N'	
		  Return @@Error
		 End 

		If @@Error <> 0 Return @@Error

		-- On mets les autres détails des autres presta (hors PSM), sans suite.
		Update sysadm.w_detail 
		Set    cod_etat = 900,
			   alt_ssui = 'O',
			   cod_mot_ssui = 3,
			   alt_att = 'N',
			   alt_bloc = 'N',
			   mt_prej = 0,
			   alt_reg = 'N',
			   alt_valide = 'O'

		From   sysadm.w_detail wdt,
			   sysadm.w_commande wcm
		Where  wdt.id_sin = @dcIdSin
		And    wdt.id_gti = @dcIdGti 
		And    wdt.id_detail <> @dcIdDetail
		And	   wdt.cod_etat in ( 1, 100 )
		And    wcm.id_sin = wdt.id_sin
		And    wcm.id_gti = wdt.id_gti
		And    wcm.id_detail = wdt.id_detail
		And    wcm.id_four <> 'PSM'
		And    wcm.cod_etat in ( 'RPC', 'RFO' )
		
		If @@Error <> 0 Return @@Error

		-- [PM80_FA12_FRANEX]
		If sysadm.FN_CLE_NUMERIQUE ( 'PM80_FA12_FRANEX') > 0 
		 Begin
			Exec @iRet = sysadm.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 
				@dcIdSin,
				@dcIdI,
				@dcIdGti,
				@dcIdDetail,
				@adcMtIndemPrinc_1,
				@adcMtFraisAnex_2,
				@adcMtFraisAnex_3,
				@adcMtFraisAnex_4,
				@adcMtFraisAnex_5,
				@adcMtFraisAnex_6,
				@adcMtFraisAnex_7,
				@adcMtFraisAnex_8,
				@adcMtFraisAnex_9,
				@adcMtFraisAnex_10,
				@adcMtFraisAnex_11,
				'ML'

			If @iRet <> 0 Return @iRet 
		 End 

	  End

	Return @@Error
Go

