-------------------------------------------------------------------
--
-- Fichier                      : contype.cp
-- Auteur                       : Fabry JF
-- Date                         : 24/04/01 
--
-- Commentaires                 : Liste des procédure de la table contact_type
--
-- Procédures                   :
-- Fonctions                    : DD_S01_CONTACT_TYPE
--				  DD_S02_CONTACT_TYPE
--
-------------------------------------------------------------------
-------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CONTACT_TYPE
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libellé              :       Chargement des Type de contacts 
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CONTACT_TYPE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CONTACT_TYPE
GO

CREATE PROC sysadm.DD_S01_CONTACT_TYPE
AS

select 	ct.id_canal, 
	ct.id_typ_msg, 
	tt.lib_code as lib_typ_msg, 
	'-1', 
	'', 
	ct.alt_mess, 
	ct.alt_cree_trv, 
	ct.alt_valide, 
	ct.alt_sc, 
	ct.alt_affecte

from   	sysadm.contact_type ct, 
	sysadm.code_car tt

where  	tt.id_typ_code = '-TT'
and    	tt.id_code     = ct.id_typ_msg
and    	ct.id_nat_msg = -1

GO


-------------------------------------------------------------------
--
-- Procédure            :       DD_S02_CONTACT_TYPE
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libellé              :       Chargement des natures de contacts 
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_CONTACT_TYPE' AND type = 'P' )
            DROP procedure sysadm.DD_S02_CONTACT_TYPE
GO

CREATE PROC sysadm.DD_S02_CONTACT_TYPE
AS

select 	ct.id_canal, 
	ct.id_typ_msg, 
	tt.lib_code as lib_typ_msg, 
	ct.id_nat_msg, 
	nt.lib_code as lib_nat_msg, 
	ct.alt_mess, 
	ct.alt_cree_trv, 
	ct.alt_valide, 
	ct.alt_sc, 
	ct.alt_affecte
from   	sysadm.contact_type ct, 
	sysadm.code nt, 
	sysadm.code_car tt
where  tt.id_typ_code = '-TT'
and    tt.id_code     = ct.id_typ_msg
and    nt.id_typ_code = '-NT'
and    nt.id_code     = Convert ( Decimal (7), ct.id_nat_msg )

GO





