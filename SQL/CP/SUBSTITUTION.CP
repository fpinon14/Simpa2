-------------------------------------------------------------------
--
-- Fic hier              :       SUBSTITUTION.CP
-- Auteur               :       FABRY JF
-- Date                 :       23/03/2012
--
-- Commentaires         :       PS affèrant à la table SUBSTITUTION
--
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SUBSTITUTION
-- Auteur               :       FABRY JF
-- Date                 :       03/01/2012
-- Libellé              :        
-- Commentaires         :       [PM95]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SUBSTITUTION' AND type = 'P' )
        DROP procedure sysadm.PS_S_SUBSTITUTION
GO

CREATE procedure sysadm.PS_S_SUBSTITUTION
	@dcIdprod		Decimal ( 7 ),
	@sMarqAppOrig	VarChar ( 35 ),
	@sModlAppOrig	VarChar ( 35 ),
	@iCptSubs		integer,	
	@sMarqAppSubs	VarChar ( 35 ) OUTPUT,
	@sModlAppSubs	VarChar ( 35 ) OUTPUT,
	@iNbreSubst		Integer OUTPUT
AS

Select	@sMarqAppSubs = RTRIM ( s.marq_app_subs ),
		@sModlAppSubs = RTRIM ( s.modl_app_subs )
From	sysadm.substitution s
Where   ( s.id_prod = @dcIdprod Or ( s.id_prod = -1 And 
									 Not Exists ( Select * From sysadm.substitution s1
												  Where s1.id_prod = @dcIdprod ) 
									) 
  	    )
And		s.marq_app_orig = @sMarqAppOrig
And		s.modl_app_orig = @sModlAppOrig
And		s.cpt_subs = @iCptSubs
And		s.alt_actif = 'O'

Set @iNbreSubst = @@RowCount

Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_SUBSTITUTION
-- Auteur               :       FPI
-- Date                 :       08/10/2015
-- Libellé              :        
-- Commentaires         :       [VDoc18645]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_SUBSTITUTION' AND type = 'P' )
        DROP procedure sysadm.DW_S01_SUBSTITUTION
GO

CREATE procedure sysadm.DW_S01_SUBSTITUTION
AS
	select id_seq, id_prod, 
		cpt_subs, 
		marq_app_orig, modl_app_orig, 
		marq_app_subs, modl_app_subs, 
		alt_actif, 
		cree_le, cree_par, 
		maj_le, maj_par
	from sysadm.substitution 
	order by marq_app_orig, modl_app_orig, cpt_subs
Go

grant execute on sysadm.DW_S01_SUBSTITUTION to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_SUBSTITUTION
-- Auteur               :       FPI
-- Date                 :       08/10/2015
-- Libellé              :        
-- Commentaires         :       [VDoc18645]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_SUBSTITUTION' AND type = 'P' )
        DROP procedure sysadm.DW_I01_SUBSTITUTION
GO

CREATE procedure sysadm.DW_I01_SUBSTITUTION
	@iIdProd decimal(7, 0),
	@iCptSubs int,
	@sMarqAppOrig varchar(35),
	@sModlAppOrig varchar(35),
	@sMarqAppSubs varchar(35),
	@sModlAppSubs varchar(35),
	@sAltActif varchar(1),
	@sCreePar varchar(4) 
AS
	insert into sysadm.substitution
	(id_prod, cpt_subs, 
		marq_app_orig, modl_app_orig, 
		marq_app_subs, modl_app_subs, 
		alt_actif, 
		cree_le, cree_par, 
		maj_le, maj_par)
	values (@iIdProd, @iCptSubs,
	@sMarqAppOrig, @sModlAppOrig,
	@sMarqAppSubs, @sModlAppSubs,
	@sAltActif,
	getdate(),@sCreePar,
	getdate(),@sCreePar)
Go

grant execute on sysadm.DW_I01_SUBSTITUTION to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_U01_SUBSTITUTION
-- Auteur               :       FPI
-- Date                 :       08/10/2015
-- Libellé              :        
-- Commentaires         :       [VDoc18645]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_SUBSTITUTION' AND type = 'P' )
        DROP procedure sysadm.DW_U01_SUBSTITUTION
GO

CREATE procedure sysadm.DW_U01_SUBSTITUTION
	@iIdSeq int,
	@iIdProd decimal(7, 0),
	@iCptSubs int,
	@sMarqAppOrig varchar(35),
	@sModlAppOrig varchar(35),
	@sMarqAppSubs varchar(35),
	@sModlAppSubs varchar(35),
	@sAltActif varchar(1),
	@sMajPar varchar(4) 
AS
	update sysadm.substitution
	set id_prod=@iIdProd, 
		cpt_subs=@iCptSubs,
		marq_app_orig=@sMarqAppOrig, 
		modl_app_orig=@sModlAppOrig,
		marq_app_subs=@sMarqAppSubs, 
		modl_app_subs=@sModlAppSubs,
		alt_actif=@sAltActif,
		maj_le=getdate(),
		maj_par=@sMajPar
	Where id_seq=@iIdSeq
Go

grant execute on sysadm.DW_U01_SUBSTITUTION to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_SUBSTITUTION
-- Auteur               :       FPI
-- Date                 :       08/10/2015
-- Libellé              :        
-- Commentaires         :       [VDoc18645]
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_SUBSTITUTION' AND type = 'P' )
        DROP procedure sysadm.DW_D01_SUBSTITUTION
GO

CREATE procedure sysadm.DW_D01_SUBSTITUTION
	@iIdSeq int
As
	delete from sysadm.substitution 
	where id_seq=@iIdSeq
Go

grant execute on sysadm.DW_D01_SUBSTITUTION to rolebddsinistres
Go
