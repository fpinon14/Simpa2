-------------------------------------------------------------------
--
-- Fichier              :       TRACE_TS_COURRIER.CP
-- Auteur               :       FABRY JF
-- Date                 :       29/11/2019
--								
-- Commentaires         :       
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_I_TRACE_TS_COURRIER
-- Auteur               :       JFF
-- Date                 :       29/11/2019
-- Libelle              :       
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_TS_COURRIER' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_TS_COURRIER
GO

CREATE procedure sysadm.PS_I_TRACE_TS_COURRIER
	@adcIdSin Decimal (10),
	@asIdSql   VarChar (30),
	@asTypeTrt VarChar (10),
	@asIdCour  VarChar (10),
	@dcIdInter Decimal ( 7),
	@dcIdDoc   Decimal ( 7),
	@asCodIper VarChar (4),
	@aiRetour  Integer,
	@aiIdentity Integer OUTPUT
As

Insert into sysadm.trace_ts_courrier Values (
	@adcIdSin,
	@asIdSql,
	@asTypeTrt,
	@asIdCour,
	@dcIdInter,
	@dcIdDoc,
	@aiRetour,
	GetDate(),
	GetDate(),
	@asCodIper )

Set @aiIdentity = SCOPE_IDENTITY()

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_TRACE_TS_COURRIER
-- Auteur               :       JFF
-- Date                 :       29/11/2019
-- Libelle              :       
-- Commentaires         :       
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_TRACE_TS_COURRIER' AND type = 'P' )
        DROP procedure sysadm.PS_U_TRACE_TS_COURRIER
GO

CREATE procedure sysadm.PS_U_TRACE_TS_COURRIER
	@aiIdentity Integer,
	@aiRetour  Integer,
	@asIdCour  VarChar ( 6 )
As

Update sysadm.trace_ts_courrier
Set    retour = @aiRetour,
	   id_cour = @asIdCour	
Where  id_cle = @aiIdentity

Go





