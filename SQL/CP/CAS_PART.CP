-------------------------------------------------------------------
--
-- Fichier              :       CAS_PART.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des cas particuliers
--      
-- Procédures           :       DW_S01_W_SIN_CAS1
--                      :       DW_S02_W_SIN_CAS1
--                      :       PS_U01_W_SIN_CAS1
-- 		        :       DW_S01_W_SIN_CAS2 - DBI 28/03/2000
--                      :       DW_S02_W_SIN_CAS2 - DBI 28/03/2000
--                      :       DW_SACC_W_SIN_CAS2 - DBI 28/03/2000
--                      :       PS_U01_PERSONNE_CAS2 - DBI 28/03/2000
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_SIN_CAS1
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_SIN
-- Références           :       Utilis‚ dans W_TM_SP_CAS_ID_ADH
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- #1 JCA - 14/04/2006 - PB8 moins permissif, mise en cohérence avec la datawindow (suite migration Wyniwyg)
-- 
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_SIN_CAS1' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_SIN_CAS1
GO

CREATE procedure sysadm.DW_S01_W_SIN_CAS1
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS
 SELECT w_sin.id_sin,
        w_sin.id_prod,
        w_sin.id_rev,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.mt_a_reg,
        w_sin.mt_reg,
        w_sin.id_carte,
        w_sin.id_type_carte,
        w_sin.id_ordre,
        w_sin.cod_prov_pers,
        w_sin.cpt_valide,
        w_sin.cree_le,
        w_sin.maj_le,
        w_sin.maj_par,
	cast ( '' as varchar(19)),
	cast (0 as decimal(7,0)),
	cast ( '' as varchar(3)),
	cast (00 as decimal(7,0)),
	cast (0 as decimal(7,0))

 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin 	= @dcIdSin

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_W_SIN_CAS1
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_SIN
-- Références           :       Utilis‚ dans W_TM_SP_CAS_ID_ADH
--
-- Arguments            :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_SIN_CAS1' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_SIN_CAS1
GO

CREATE procedure sysadm.DW_S02_W_SIN_CAS1
        @dcIdOrdre      Decimal (  7,0 ),
        @dcIdSin        Decimal (  10,0 )  -- [PI062]

AS
 SELECT w_sin.id_sin,
        w_sin.id_ordre
 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin 	<> @dcIdSin     AND
        w_sin.id_ordre  =  @dcIdOrdre

 UNION

 SELECT sinistre.id_sin,
        sinistre.id_ordre
 FROM   sysadm.sinistre
 WHERE  sinistre.id_sin    <> @dcIdSin     AND
        sinistre.id_ordre  =  @dcIdOrdre

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_W_SIN_CAS1
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Update sur la table W_SIN
-- Références           :       Utilis‚ dans W_TM_SP_CAS_ID_ADH
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdEts        Decimal (  7,0 )        (Val)
--                      :       @sIdAdh         Varchar ( 16   )        (Val)
--                      :       @sIdTypeCarte   Varchar (  3   )        (Val)
--                      :       @dcIdCarte      Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_W_SIN_CAS1' AND type = 'P' )
        DROP procedure sysadm.PS_U01_W_SIN_CAS1
GO

CREATE procedure sysadm.PS_U01_W_SIN_CAS1
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdEts        Decimal (  7,0 ),
        @sIdAdh         Varchar ( 16   ),
        @sIdTypeCarte   Varchar (  3   ),
        @dcIdCarte      Decimal (  7,0 ),
        @dcIdOrdre      Decimal (  7,0 )
AS
Declare @dcIdOrdreAnc   Decimal ( 7,0 )
Declare @dcCptValide    Decimal ( 2,0 )


 SELECT @dcCptValide = w_sin.cpt_valide
 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin = @dcIdSin

 UPDATE sysadm.w_sin
 SET    sysadm.w_sin.id_ets            = @dcIdEts              ,
        sysadm.w_sin.id_adh            = @sIdAdh               ,
        sysadm.w_sin.id_type_carte     = @sIdTypeCarte         ,
        sysadm.w_sin.id_carte          = @dcIdCarte
 WHERE  w_sin.id_sin            = @dcIdSin

 IF     @dcCptValide > 0        
        Begin
                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.id_ets         = @dcIdEts      ,
                        sysadm.sinistre.id_adh         = @sIdAdh       ,
                        sysadm.sinistre.id_type_carte  = @sIdTypeCarte ,
                        sysadm.sinistre.id_carte       = @dcIdCarte
                WHERE   sinistre.id_sin         = @dcIdSin


                UPDATE  sysadm.archive
                SET     sysadm.archive.id_adh          = @sIdAdh
                WHERE   archive.id_sin          = @dcIdSin

        End

 IF     @dcIdOrdre is not NULL
        Begin

                SELECT  @dcIdOrdreAnc           = w_sin.id_ordre
                FROM    sysadm.w_sin
                WHERE   w_sin.id_sin            = @dcIdSin

                UPDATE  sysadm.w_sin
                SET     sysadm.w_sin.id_ordre          = @dcIdOrdre
                WHERE   w_sin.id_sin            = @dcIdSin

                UPDATE  sysadm.sinistre
                SET     sysadm.sinistre.id_ordre       = @dcIdOrdre
                WHERE   sinistre.id_sin         = @dcIdSin

                UPDATE  sysadm.archive
                SET     sysadm.archive.id_ordre        = @dcIdOrdre
                WHERE   archive.id_sin          = @dcIdSin

                IF      @dcIdOrdreAnc   is not NULL
                        Begin
                                DELETE FROM     sysadm.personne
                                WHERE           personne.id_ordre = @dcIdOrdreAnc
                        End
        End
GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_SACC_W_SIN_CAS2
-- Auteur               :       DBI
-- Date                 :       23/08/2000
-- Libellé              :       Retrieve fenˆtre accueil en fonction ROUTAGE.ALT_QUEUE
-- Commentaires         :       S‚lect sur la table W_SIN, SINISTRE, ROUTAGE...
-- Références           :       Utilis‚ dans W_A_SP_CAS_MAJ_NOM
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_SACC_W_SIN_CAS2' AND type = 'P' )
        DROP procedure sysadm.DW_SACC_W_SIN_CAS2
GO

CREATE procedure sysadm.DW_SACC_W_SIN_CAS2
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS

Declare	@sAltQueue	VarChar (  1   ) 

-- Lecture Routage.Alt_Queue

SELECT 		@sAltQueue = sysadm.routage.alt_queue
FROM		sysadm.routage
WHERE		sysadm.routage.id_sin = @dcIdSin

IF @sAltQueue = 'O' 
 BEGIN
	SELECT	sysadm.w_sin.id_sin,
		sysadm.w_sin.cod_civ,
		sysadm.code.lib_code,
		sysadm.w_sin.nom,
		sysadm.w_sin.prenom,
		sysadm.produit.lib_court,
		@sAltQueue
	FROM	sysadm.routage, sysadm.w_sin, sysadm.produit, sysadm.code
	WHERE	sysadm.w_sin.id_sin	=	@dcIdSin
	AND	sysadm.w_sin.id_sin	=	sysadm.routage.id_sin
	AND	sysadm.w_sin.id_prod	=	sysadm.produit.id_prod
	AND	Convert ( Decimal (7), sysadm.w_sin.cod_civ )	=	sysadm.code.id_code
	AND	sysadm.code.id_typ_code =	'-CI'

 END
ELSE
 BEGIN
	SELECT	sysadm.sinistre.id_sin,
		sysadm.personne.cod_civ,
		sysadm.code.lib_code,
		sysadm.personne.nom,
		sysadm.personne.prenom,
		sysadm.produit.lib_court,
		@sAltQueue
	FROM	sysadm.routage, sysadm.sinistre, sysadm.produit, sysadm.personne, sysadm.code
	WHERE	sysadm.sinistre.id_sin	=	@dcIdSin
	AND	sysadm.sinistre.id_sin	=	sysadm.routage.id_sin
	AND	sysadm.sinistre.id_prod	=	sysadm.produit.id_prod
	AND	sysadm.sinistre.id_ordre=	sysadm.personne.id_ordre
	AND	Convert ( Decimal (7), sysadm.personne.cod_civ )	=	sysadm.code.id_code
	AND	sysadm.code.id_typ_code =	'-CI'
 END

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_SIN_CAS2
-- Auteur               :       DBI
-- Date                 :       23/08/2000
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_SIN
-- Références           :       Utilis‚ dans W_TM_SP_CAS_MAJ_NOM
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- #1 JCA - 14/04/2006 - PB8 moins permissif, mise en cohérence avec la datawindow (Migration Wyniwyg)
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_SIN_CAS2' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_SIN_CAS2
GO

CREATE procedure sysadm.DW_S01_W_SIN_CAS2
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
	@sAltQueue	Varchar (  1   )
AS

--Select sur les tables de travail sur alt_queue = Oui car les informations sont les plus fraiches.

IF @sAltQueue = 'O' 
 BEGIN

 SELECT w_sin.id_sin,
        w_sin.id_prod,
        w_sin.id_rev,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.mt_reg,
        w_sin.id_carte,
        w_sin.id_type_carte,
        w_sin.id_ordre,
        w_sin.cree_le,
        w_sin.maj_le,
        w_sin.maj_par,
	cast ( '' as varchar(1)),
	cast ( '' as varchar(35)),
	cast ( '' as varchar(35))

 FROM   sysadm.w_sin
 WHERE  w_sin.id_sin 	= @dcIdSin

 END

ELSE
 BEGIN

 SELECT sinistre.id_sin,
        sinistre.id_prod,
        sinistre.id_rev,
        sinistre.id_ets,
        sinistre.id_adh,
        sinistre.id_sdos,
        personne.cod_civ,
        personne.nom,
        personne.prenom,
        personne.adr_1,
        personne.adr_2,
        personne.adr_cp,
        personne.adr_ville,
        sinistre.mt_reg,
        sinistre.id_carte,
        sinistre.id_type_carte,
        sinistre.id_ordre,
        sinistre.cree_le,
        sinistre.maj_le,
        sinistre.maj_par,
	cast ( '' as varchar(1)),
	cast ( '' as varchar(35)),
	cast ( '' as varchar(35))

 FROM   sysadm.sinistre, sysadm.personne
 WHERE  sinistre.id_sin 	= @dcIdSin
 AND    sinistre.id_ordre	= personne.id_ordre

 END

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_W_SIN_CAS2
-- Auteur               :       DBI
-- Date                 :       23/08/2000
-- Libellé              :        
-- Commentaires         :       S‚lect sur la table W_SIN, SINISTRE ( Recherche homonymes )
-- Références           :       Utilis‚ dans W_TM_SP_CAS_MAJ_NOM
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--				@sNom		VarChar ( 35   )	(Val)
--				@sPrenom	VarChar ( 35   )	(Val)
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_W_SIN_CAS2' AND type = 'P' )
        DROP procedure sysadm.DW_S02_W_SIN_CAS2
GO

CREATE procedure sysadm.DW_S02_W_SIN_CAS2
    @dcIdSin    Decimal (  10,0 ), -- [PI062]
	@sNom		Varchar (  35  ),
	@sPrenom	Varchar (  35  )
AS

Declare @dcIdOrdre	Decimal (  7,0 )
Declare @sCodTravail	VarChar (  3   )

SELECT @sCodTravail 	= routage.cod_travail
FROM   sysadm.routage
WHERE  routage.id_sin	= @dcIdSin

-- Recherche de l'id_ordre pour ne pas ramener plusieurs fois 
-- la personne concern‚e par le sinistre en cours

IF ( @sCodTravail = 'CAS' )
 BEGIN

  SELECT @dcIdOrdre = sinistre.id_ordre
  FROM   sysadm.sinistre
  WHERE  sysadm.sinistre.id_sin = @dcIdSin
 END
ELSE
 BEGIN

  SELECT @dcIdOrdre = IsNull ( w_sin.id_ordre, -1 )
  FROM   sysadm.w_sin
  WHERE  sysadm.w_sin.id_sin = @dcIdSin
 END


--
-- Routage.COD_TRAVAIL = CAS si dossier clos ( n'existe pas sur les tables w_xxx )
-- Si l'id_ordre du sinistre n'est pas renseign‚ on n'en tient pas compte dans la recherche
-- Sinon on exclue les sinistres avec le mˆme id_ordre qui seront automatiquement mis … jour 
-- lors de la validation

IF @dcIdOrdre > 0
BEGIN

 SELECT w_sin.id_sin,
        w_sin.id_prod,
	produit.lib_long,
	w_sin.dte_surv,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.mt_reg,
        w_sin.id_ordre,
        w_sin.maj_le,
        w_sin.maj_par
 FROM   sysadm.w_sin, sysadm.produit, sysadm.routage
 WHERE  w_sin.id_sin 	<> @dcIdSin
 AND    w_sin.id_ordre  <> @dcIdOrdre
 AND	w_sin.id_prod   = produit.id_prod
 AND    w_sin.nom    like Substring ( @sNom,    1,5 ) + '%'
 AND    w_sin.prenom like Substring ( @sPrenom, 1,5 ) + '%'
 AND	routage.id_sin  = w_sin.id_sin
 AND    routage.cod_travail <> 'CAS'
 UNION
 SELECT sinistre.id_sin,
        sinistre.id_prod,
	produit.lib_long,
	sinistre.dte_surv,
        sinistre.id_ets,
        sinistre.id_adh,
        sinistre.id_sdos,
        personne.cod_civ,
        personne.nom,
        personne.prenom,
        personne.adr_1,
        personne.adr_2,
        personne.adr_cp,
        personne.adr_ville,
        sinistre.mt_reg,
        sinistre.id_ordre,
        sinistre.maj_le,
        sinistre.maj_par
 FROM   sysadm.sinistre, sysadm.produit, sysadm.routage, sysadm.personne
 WHERE  sinistre.id_sin 	<> @dcIdSin
 AND	sinistre.id_prod   = produit.id_prod
 AND	sinistre.id_ordre  = personne.id_ordre
 AND    sinistre.id_ordre  <> @dcIdOrdre
 AND    personne.nom    like Substring ( @sNom,    1,5 ) + '%'
 AND    personne.prenom like Substring ( @sPrenom, 1,5 ) + '%'
 AND	routage.id_sin  = sinistre.id_sin
 AND    routage.cod_travail = 'CAS'
END
ELSE
BEGIN
 SELECT w_sin.id_sin,
        w_sin.id_prod,
	produit.lib_long,
	w_sin.dte_surv,
        w_sin.id_ets,
        w_sin.id_adh,
        w_sin.id_sdos,
        w_sin.cod_civ,
        w_sin.nom,
        w_sin.prenom,
        w_sin.adr_1,
        w_sin.adr_2,
        w_sin.adr_cp,
        w_sin.adr_ville,
        w_sin.mt_reg,
        w_sin.id_ordre,
        w_sin.maj_le,
        w_sin.maj_par
 FROM   sysadm.w_sin, sysadm.produit, sysadm.routage
 WHERE  w_sin.id_sin 	<> @dcIdSin
 AND	w_sin.id_prod   = produit.id_prod
 AND    w_sin.nom    like Substring ( @sNom,    1,5 ) + '%'
 AND    w_sin.prenom like Substring ( @sPrenom, 1,5 ) + '%'
 AND	routage.id_sin  = w_sin.id_sin
 AND    routage.cod_travail <> 'CAS'
 UNION
 SELECT sinistre.id_sin,
        sinistre.id_prod,
	produit.lib_long,
	sinistre.dte_surv,
        sinistre.id_ets,
        sinistre.id_adh,
        sinistre.id_sdos,
        personne.cod_civ,
        personne.nom,
        personne.prenom,
        personne.adr_1,
        personne.adr_2,
        personne.adr_cp,
        personne.adr_ville,
        sinistre.mt_reg,
        sinistre.id_ordre,
        sinistre.maj_le,
        sinistre.maj_par
 FROM   sysadm.sinistre, sysadm.produit, sysadm.routage, sysadm.personne
 WHERE  sinistre.id_sin 	<> @dcIdSin
 AND	sinistre.id_prod   = produit.id_prod
 AND	sinistre.id_ordre  = personne.id_ordre
 AND    personne.nom    like Substring ( @sNom,    1,5 ) + '%'
 AND    personne.prenom like Substring ( @sPrenom, 1,5 ) + '%'
 AND	routage.id_sin  = sinistre.id_sin
 AND    routage.cod_travail = 'CAS'
END

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_PERSONNE_CAS2
-- Auteur               :       DBI
-- Date                 :       28/03/2000
-- Libellé              :        
-- Commentaires         :       Update sur la table PERSONNE, W_SIN
-- Références           :       Utilis‚ dans W_TM_SP_CAS_MAJ_NOM
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodCiv        Varchar ( 1    )        (Val)
--                      :       @sNom	        Varchar ( 35   )        (Val)
--                      :       @sPrenom	Varchar ( 35   )        (Val)
--
-- Retourne             :       Rien
-- #1 JCA - 14/04/2006 - Passage du convert de id_sin de 6 à 7
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_PERSONNE_CAS2' AND type = 'P' )
        DROP procedure sysadm.PS_U01_PERSONNE_CAS2
GO


CREATE procedure sysadm.PS_U01_PERSONNE_CAS2
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodCiv        Varchar ( 1    ),
        @sNom	        Varchar ( 35   ),
        @sPrenom	Varchar ( 35   )
AS

Declare @dcIdOrdre	Decimal (  7,0 )
Declare @sCodTravail	VarChar (  3   )
Declare @sAltQueue	VarChar (  1   )

SELECT @sCodTravail 	= routage.cod_travail,
       @sAltQueue	= routage.alt_queue	
FROM   sysadm.routage
WHERE  routage.id_sin	= @dcIdSin

--****************************************************
-- Recherche de l'id_ordre pour mettre … jour sinistres li‚s
--****************************************************

IF ( @sCodTravail = 'CAS' )
 BEGIN

  SELECT @dcIdOrdre = sinistre.id_ordre
  FROM   sysadm.sinistre
  WHERE  sysadm.sinistre.id_sin = @dcIdSin
 END
ELSE
 BEGIN

  SELECT @dcIdOrdre = IsNull ( w_sin.id_ordre, -1 )
  FROM   sysadm.w_sin
  WHERE  sysadm.w_sin.id_sin = @dcIdSin
 END


--****************************************************
-- Mis … jour sur w_queue si le dossier n'est pas pris
--****************************************************

 IF @sAltQueue = 'O'
 BEGIN

	UPDATE 	sysadm.w_queue
        SET     sysadm.w_queue.nom = @sNom + ' ' + @sPrenom
	WHERE   id_sin = Convert ( VarChar (10), @dcIdSin ) -- [PI062]
	AND     alt_occupe = 'N'

	IF @@ROWCOUNT = 0 RETURN 
	
 END	
	
--****************************************************
-- Mis … jour sur w_sin pour le sinistre en cours
--****************************************************
	UPDATE 	sysadm.w_sin
        SET     sysadm.w_sin.cod_civ  = @sCodCiv,
                sysadm.w_sin.nom      = @sNom,
                sysadm.w_sin.prenom   = @sPrenom
	WHERE 	id_sin 	 = @dcIdSin

	IF @@ERROR <> 0 RETURN 

--****************************************************
-- Mis … jour sur w_inter
--****************************************************

	UPDATE 	sysadm.w_inter
        SET     sysadm.w_inter.cod_civ  = @sCodCiv,
                sysadm.w_inter.nom      = @sPrenom + ' ' + @sNom
	WHERE   id_sin   = @dcIdSin
	AND     id_i     = 0

	IF @@ERROR <> 0 RETURN 

--***********************************************************************
-- Je ne mets pas … jour la table archive pour les Anciens courriers
-- des dossiers qui possŠdent le mˆme id_ordre
-- On conserve ainsi le nom du destinataire auxquels ils ont ‚t‚ adress‚s
-- Le nom de l'assur‚ est de toute fa‡on mis … jour sur personne
--***********************************************************************

	UPDATE  sysadm.archive
        SET     sysadm.archive.nom        = @sPrenom + ' ' + @sNom
	WHERE   id_sin   = @dcIdSin
	AND     id_inter = 0

	IF @@ERROR <> 0 RETURN 

--****************************************************
-- Mis … jour sur inter
--****************************************************

	UPDATE 	sysadm.inter
        SET     sysadm.inter.cod_civ  = @sCodCiv,
                sysadm.inter.nom      = @sPrenom + ' ' + @sNom
	WHERE   id_sin   = @dcIdSin
	AND     id_i     = 0

	IF @@ERROR <> 0 RETURN 

--****************************************************
-- Mis … jour sur personne
--****************************************************

	UPDATE  sysadm.personne
        SET     sysadm.personne.cod_civ  = @sCodCiv,
                sysadm.personne.nom      = @sNom,
                sysadm.personne.prenom   = @sPrenom
	FROM    sysadm.sinistre, sysadm.personne
	WHERE   sinistre.id_sin   = @dcIdSin
	AND     sinistre.id_ordre = personne.id_ordre

	IF @@ERROR <> 0 RETURN 

IF @dcIdOrdre <> -1
BEGIN

--****************************************************
-- Mis … jour sur w_sin pour les sinistres diff‚rents avec mˆme id_ordre
--****************************************************

	UPDATE 	sysadm.w_sin
        SET     sysadm.w_sin.cod_civ  = @sCodCiv,
                sysadm.w_sin.nom      = @sNom,
                sysadm.w_sin.prenom   = @sPrenom
	WHERE 	id_ordre = @dcIdOrdre
	AND     id_sin   <>@dcIdSin

	IF @@ERROR <> 0 RETURN 

--****************************************************
-- Mis … jour sur w_inter pour les sinistres diff‚rents avec mˆme id_ordre
--****************************************************

	UPDATE 	sysadm.w_inter
        SET     sysadm.w_inter.cod_civ  = @sCodCiv,
                sysadm.w_inter.nom      = @sPrenom + ' ' + @sNom
	FROM    sysadm.w_inter, sysadm.w_sin
	WHERE   w_sin.id_sin <> @dcIdSin
	AND	w_sin.id_sin   = w_inter.id_sin
	AND     w_inter.id_i   = 0
	AND	w_sin.id_ordre = @dcIdOrdre

	IF @@ERROR <> 0 RETURN 

--****************************************************
-- Mis … jour sur inter pour les sinistres diff‚rents avec mˆme id_ordre
--****************************************************

	UPDATE 	sysadm.inter
        SET     sysadm.inter.cod_civ  = @sCodCiv,
                sysadm.inter.nom         = @sPrenom + ' ' + @sNom
	FROM    sysadm.inter, sysadm.sinistre
	WHERE   sinistre.id_sin  <> @dcIdSin
	AND	sinistre.id_sin   = inter.id_sin
	AND     inter.id_i   	  = 0
	AND	sinistre.id_ordre = @dcIdOrdre

	IF @@ERROR <> 0 RETURN 

END

GO
