-------------------------------------------------------------------
--
-- Fichier              :       TRACE_CMDE.CP
-- Auteur               :       FABRY JF
-- Date                 :       19/08/2014
--
-- Commentaires         :       Gestion de la table TRACE_CMDE
--
-- Procédures           :       
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_TRACE_CMDE
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PM254_V1]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_CMDE' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_CMDE
GO

CREATE procedure sysadm.PS_I_TRACE_CMDE
        @adcIdSin     Decimal (  10,0 ), -- [PI062]
        @iIdSeq		  Integer,
        @alt_bcv	  varchar ( 1 ),	
        @sNomZone	  varchar ( 35 ),
        @sValCar	  varchar ( 255 ),
        @sIdTypListe  varchar ( 5 ),
        @sAltListeCodeCar varchar ( 1 ),
        @sNomFic	  VarChar ( 100 )
        
AS

Insert into sysadm.trace_cmde2 (  -- [PI062] trace_cmde2
					id_sin,
					id_seq,
					alt_bcv,
					nom_zone,
					val_car,
					id_typ_liste,
					alt_liste_codecar,
					nom_fic,
					cree_le,
					maj_le,
					maj_par
				)
			
		Values
				(
					@adcIdSin     ,
					@iIdSeq		  ,
					@alt_bcv	  ,
					@sNomZone	  ,
					@sValCar	  ,
					@sIdTypListe  ,
					@sAltListeCodeCar ,
					@sNomFic	  ,					
					GETDATE()	  ,
					GETDATE()	  ,
					'AUTO'
				)

Go

--------------------------------------------------------------------
--
-- Procédure            :       v_trace_cmde
-- Auteur               :       JFF
-- Date                 :       06/01/2017
-- Libellé              :        
-- Commentaires         :       [PI062]
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[sysadm].[v_trace_cmde]'))
DROP VIEW [sysadm].v_trace_cmde
GO
CREATE view [sysadm].v_trace_cmde
As

Select * From sysadm.trace_cmde
union all 
Select * From sysadm.trace_cmde2

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_TRACE_CMDE
-- Auteur               :       JFF	
-- Date                 :       28/08/2018
-- Libelle              :       
-- Commentaires         :       
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TRACE_CMDE' AND type = 'P' )
        DROP procedure sysadm.PS_S_TRACE_CMDE
GO

CREATE PROCEDURE sysadm.PS_S_TRACE_CMDE
	@dcIdSin	decimal(10,0),
	@iIdSeq int
As

Select	vt.id_cle,
		vt.id_sin,
		vt.id_seq,
		vt.alt_bcv,
		vt.nom_zone,
		isnull ( vt.val_car, '') val_car,
		Case
			When  vt.nom_zone = 'cod_etat' Then sysadm.FN_CODE_CAR ( vt.val_car, '-EC' )
			When  vt.nom_zone = 'status_gc' And IsNumeric ( vt.val_car ) = 1 Then sysadm.FN_CODE_NUM ( vt.val_car, '-GC' )
			Else ''
		End 'lib_val_car',
		isnull ( vt.id_typ_liste, '') id_typ_liste,
		vt.alt_liste_codecar,
		vt.nom_fic,
		sysadm.FN_CLE_VAL ( 'FLUX', rtrim ( c.info_spb_frn_cplt ) , ';' ) Flux_aller,
		vt.cree_le
from sysadm.v_trace_cmde vt,
	 sysadm.commande c
where vt.id_sin = @dcIdSin
And   vt.id_seq = @iIdSeq
And   c.id_sin = vt.id_sin
and   c.id_seq = vt.id_seq

order by id_cle

Go

