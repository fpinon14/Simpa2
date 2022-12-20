-------------------------------------------------------------------
--
-- Fichier              :       TRACE_TOUT_MOBILE.CP
-- Auteur               :       FABRY JF
-- Date                 :       29/11/2005
--
-- Commentaires         :       
--
-- Procédures           :       PS_I01_TRACE_TOUT_MOBILE 	// Donnée liée au client+ticket CastoWeb
--				PS_U01_TRACE_TOUT_MOBILE	//  xxx
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_TRACE_TOUT_MOBILE
-- Auteur               :       MEBROUK MADANI
-- Date                 :       29/11/2005
-- Libellé              :       Insertion dans trace_tout_mobile
-- Commentaires         :       
--
--- Arguments                           :    @dcIdSin          decimal ( 7, 0 )          Sinistre
--                                           @dcIdProd          decimal ( 7, 0 )         Produit
--                                           @dcIdGti           decimal ( 7, 0 )         Garantie
--                                           @sMarqPortSin      Varchar ( 35 )           Marque du Portable sinistré       
--                                           @sModlPortSin      Varchar ( 35 )           Modele du Portable sinistré
--                                           @dcMtValPbcSin     decimal ( 11,2 )         Montant Valeur Publique Sinistré
--                                           @sMarqPortCmd      Varchar ( 35 )           Marque du Portable commandé   
--                                           @sModlPortCmd      Varchar ( 35 )           Modele du Portable commandé
--                                           @dcMtValPbcCmd     decimal ( 11,2 )         Montant Valeur Publique Commandé
--                                           @dcMtValFrnttc     decimal ( 11,2 )         Montant Valeur Fournisseur TTC
--                                           @sTypArt           Varchar (3)              Type Article          
--                                           @sNomGest          Varchar ( 35 )           Nom du Gestionnaire
--                                           @sPrenGest         Varchar ( 35 )           Prénom du Gestionnaire  
--                                           @sMajPar           VarChar ( 4 )            MAJ_PAR
--
-- Retourne                            :     Rien
--     
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_TOUT_MOBILE' AND type = 'P' )
        DROP procedure sysadm.PS_I01_TRACE_TOUT_MOBILE
GO

CREATE procedure sysadm.PS_I01_TRACE_TOUT_MOBILE 
        @dcIdSin           decimal ( 10, 0 )   , -- [PI062]
        @dcIdProd          decimal ( 7, 0 )   ,      
        @dcIdGti           decimal ( 7, 0 )   ,      
        @sMarqPortSin      Varchar ( 35 ) ,
        @sModlPortSin      Varchar ( 35 ) ,
        @dcMtValPbcSin     decimal ( 11,2 ) ,
        @sMarqPortCmd      Varchar ( 35 ) ,
        @sModlPortCmd      Varchar ( 35 ) ,
        @dcMtValPbcCmd     decimal ( 11,2 ) ,
        @dcMtValFrnttc     decimal ( 11,2 )  ,
        @sTypArt           Varchar (3) ,
        @sNomGest          Varchar ( 35 ) ,        
        @sPrenGest         Varchar ( 35 ) ,
        @sMajPar           VarChar ( 4 ) 
AS
	Insert into sysadm.trace_tout_mobile
		(id_sin,
		 id_prod,
		 id_gti,
		 marq_port_sin,
		 modl_port_sin,
		 mt_val_publique_sin,
		 marq_port_cmd,
		 modl_port_cmd,
		 mt_val_publique_cmd ,
		 mt_val_frn_ttc ,
		 id_typ_art ,
		 nom_gest,
		 prenom_gest,
		 alt_valide ,
		 cree_le,
		 maj_le,
		 maj_par )

	Values 
		(@dcIdSin,
		 @dcIdProd,
		 @dcIdGti,
		 @sMarqPortSin,
		 @sModlPortSin,
		 @dcMtValPbcSin ,
		 @sMarqPortCmd ,
		 @sModlPortCmd ,
		 @dcMtValPbcCmd ,
		 @dcMtValFrnttc ,
		 @sTypArt ,
		 @sNomGest,
		 @sPrenGest,
		 'N' ,
		 GetDate (),
		 GetDate (),
		 @sMajPar )
                 
--Avant insertion dans w_div_sin on cherche la clé du tout mobile pour le sinistre et si trouvé on la delete

	Delete From sysadm.w_div_sin
	Where  id_sin = @dcIdSin
	And    nom_zone = 'id_cle_ttmob'

        Delete From sysadm.div_sin
        Where  id_sin = @dcIdSin
        And    nom_zone = 'id_cle_ttmob'


	INSERT INTO sysadm.w_div_sin 
	(       w_div_sin.id_sin,
		w_div_sin.nom_zone,
		w_div_sin.lib_label,
		w_div_sin.id_typ_liste,
		w_div_sin.alt_liste_codecar,
		w_div_sin.id_typ_zone,
		w_div_sin.alt_oblig,
		w_div_sin.alt_prot,
		w_div_sin.cpt_tri,
		w_div_sin.val_nbre,
		w_div_sin.val_mt,
		w_div_sin.val_dte,
		w_div_sin.val_car,
		w_div_sin.cpt_valide,
		w_div_sin.cree_le,      
		w_div_sin.maj_le,               
		w_div_sin.maj_par       
		)

	VALUES
	(
		@dcIdSin,
		'id_cle_ttmob',
		'clé trace tout mobile',
		'-1',
		'N',
		'N',
		'N',
		'O',
		99,
		@@identity,
		null,
		null,
		null,
		0,
		GetDate (),
		GetDate (),               
		@sMajPar
		)

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_TRACE_TOUT_MOBILE
-- Auteur               :       MEBROUK MADANI
-- Date                 :       16/12/2005
-- Libellé              :       Maj (Update) dans trace_tout_mobile
-- Commentaires         :       
--
-- Arguments           :        
--
-- Retourne             :     Rien
--         
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_TRACE_TOUT_MOBILE' AND type = 'P' )
        DROP procedure sysadm.PS_U01_TRACE_TOUT_MOBILE
GO

CREATE procedure sysadm.PS_U01_TRACE_TOUT_MOBILE
	@dcIdSin           decimal ( 10, 0 ) -- [PI062]
AS

   if ( select  count (*)
        from    sysadm.w_div_sin wds
        where   wds.id_sin = @dcIdSin
        and     wds.nom_zone = 'id_cle_ttmob' ) > 0
  Begin
        Update trace_tout_mobile
        set     alt_valide = 'O'
        where   id_cle = ( select  wds.val_nbre
                           from    sysadm.w_div_sin wds
                           where   wds.id_sin = @dcIdSin
                           and     wds.nom_zone = 'id_cle_ttmob' )

  End

  Delete from w_div_sin
  where  id_sin = @dcIdSin
  And    nom_zone = 'id_cle_ttmob'

  Delete from div_sin
  where  id_sin = @dcIdSin
  And    nom_zone = 'id_cle_ttmob'

Go



