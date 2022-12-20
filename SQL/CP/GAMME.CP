-------------------------------------------------------------------
--
-- Fichier              :       GAMME.CP
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
--
-- Commentaires         :       Gestion de la table GAMME
--
-- Procédures           :       DW_S01_GAMME
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_GAMME
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
-- Libellé              :       Select sur la table GAMME 
-- Commentaires         :       Les 2 zones "N" sont utilis‚es pour l'affichage des couleurs
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_GAMME' AND type = 'P' )
        DROP procedure sysadm.DW_S01_GAMME
GO

CREATE procedure sysadm.DW_S01_GAMME
AS

 SELECT gamme.id_four,
 	gamme.id_orian_marque,
 	gamme.id_orian_modele,
 	gamme.id_ref_four,
 	gamme.marq_port,
 	gamme.modl_port,
 	gamme.id_gamme,
	convert ( decimal(11,2), convert (decimal(11,2), right( c.lib_code, (len(c.lib_code)-patindex('%/%', c.lib_code)) ))
		* ( 1 + convert(decimal(11,2), right( c2.lib_code, (len(c2.lib_code)-patindex('%/%', c2.lib_code)) )) / 100 )),
	"N",
	"N",
 	gamme.cree_le,
 	gamme.maj_le,
 	gamme.maj_par
 FROM   sysadm.gamme,
	sysadm.code c,
	sysadm.code c2
 WHERE (gamme.id_gamme + 100)	= c.id_code
   and c.id_typ_code		= '-GM'
   and c2.id_typ_code		= '-GM'
   and c2.id_code		= 201

GO

