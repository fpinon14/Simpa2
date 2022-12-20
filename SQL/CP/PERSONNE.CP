-------------------------------------------------------------------
--
-- Fichier              :       PERSONNE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Commandes pour la table PERSONNE
--
-- Procédures           :       PS_I01_PERSONNE_VAL
--                      :       PS_U01_PERSONNE_VAL
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_PERSONNE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table PERSONNE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdOrdre      Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_PERSONNE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_PERSONNE_VAL
GO

CREATE procedure sysadm.PS_I01_PERSONNE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdOrdre      Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.personne
        (       personne.id_ordre,
                personne.cod_civ,
                personne.nom,
                personne.prenom,
                personne.adr_1,
                personne.adr_2,
                personne.adr_cp,
                personne.adr_ville,
                personne.num_fax,
                personne.num_telb,
                personne.num_teld,
                personne.cree_le,
                personne.maj_le,
                personne.maj_par,        
                personne.valide_le,
                personne.valide_par     )
 SELECT         @dcIdOrdre,
                w_sin.cod_civ,
                w_sin.nom,
                w_sin.prenom,
                w_sin.adr_1,
                w_sin.adr_2,
                w_sin.adr_cp,
                w_sin.adr_ville,
                w_sin.num_fax,
                w_sin.num_telb,
                w_sin.num_teld,
                w_sin.cree_le,
                w_sin.maj_le,
                w_sin.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_sin
 WHERE          w_sin.id_sin = @dcIdSin

 Return @@RowCount
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_U01_PERSONNE_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Modification dans la table PERSONNE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_PERSONNE_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_U01_PERSONNE_VAL
GO

CREATE procedure sysadm.PS_U01_PERSONNE_VAL
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 UPDATE sysadm.personne
 SET    sysadm.personne.adr_1          = w_sin.adr_1           ,
        sysadm.personne.adr_2          = w_sin.adr_2           ,
        sysadm.personne.adr_cp         = w_sin.adr_cp          ,
        sysadm.personne.adr_ville      = w_sin.adr_ville       ,
        sysadm.personne.num_teld       = w_sin.num_teld        ,
        sysadm.personne.num_telb       = w_sin.num_telb        ,
        sysadm.personne.num_fax        = w_sin.num_fax         ,
        sysadm.personne.maj_par        = w_sin.maj_par         ,
        sysadm.personne.valide_le      = @dtValideLe           ,
        sysadm.personne.valide_par     = @sCodOper
 FROM   sysadm.personne,
        sysadm.w_sin
 WHERE  personne.id_ordre       = w_sin.id_ordre        AND
        w_sin.id_sin            = @dcIdSin

 Return @@RowCount

GO
