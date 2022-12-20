-------------------------------------------------------------------
--
-- Fichier              :       PM452-1.CP
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
--
-- Commentaires         :       
--
-- Procedures           :       
-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_PERSONNE
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_PERSONNE' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_PERSONNE
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_PERSONNE
            ON sysadm.personne
    FOR INSERT
AS 

Update sysadm.personne
Set    cod_civ = 2 
From   sysadm.personne p,
	   inserted i
Where  i.id_ordre = p.id_ordre 
And    i.cod_civ = 3
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_W_INTER
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_W_INTER' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_W_INTER
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_W_INTER
            ON sysadm.w_inter
    FOR INSERT
AS 

Update sysadm.w_inter
Set    cod_civ = 2 
From   sysadm.w_inter wi,
	   inserted i
Where  i.id_sin = wi.id_sin
And    i.id_i   = wi.id_i
And    i.cod_civ = 3
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_INTER
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_INTER' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_INTER
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_INTER
            ON sysadm.inter
    FOR INSERT
AS 

Update sysadm.inter
Set    cod_civ = 2 
From   sysadm.inter wi,
	   inserted i
Where  i.id_sin = wi.id_sin
And    i.id_i   = wi.id_i
And    i.cod_civ = 3
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_TRT_FRAIS_PRESTA
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_TRT_FRAIS_PRESTA' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_TRT_FRAIS_PRESTA
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_TRT_FRAIS_PRESTA
            ON sysadm.trt_frais_presta
    FOR INSERT
AS 

Update sysadm.trt_frais_presta
Set    cod_civ = 2 
From   sysadm.trt_frais_presta trt,
	   inserted i
Where  i.id_seq = trt.id_seq
And    i.cod_civ = 3
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_W_SIN
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_W_SIN' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_W_SIN
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_W_SIN
            ON sysadm.w_sin
    FOR INSERT
AS 

Update sysadm.w_sin
Set    cod_civ = 2 
From   sysadm.w_sin ws,
	   inserted i
Where  i.id_sin = ws.id_sin
And    i.cod_civ = 3
	
Go


--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_W_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_W_COMMANDE' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_W_COMMANDE
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_W_COMMANDE
            ON sysadm.w_commande
    FOR INSERT
AS 

Update sysadm.w_commande
Set    adr_cod_civ = 2 
From   sysadm.w_commande wc,
	   inserted i
Where  i.id_sin = wc.id_sin
And    i.id_seq = wc.id_seq
And    i.adr_cod_civ = 3
	
Go

--------------------------------------------------------------------
--
-- Procedure            :       TR_I_PM452_MLLE_EN_MME_COMMANDE
-- Auteur               :       Fabry JF
-- Date                 :       15/11/2018
-- Libelle              :       [PM452-1]
--
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_PM452_MLLE_EN_MME_COMMANDE' AND type = 'TR' )
        DROP trigger sysadm.TR_I_PM452_MLLE_EN_MME_COMMANDE
GO

CREATE TRIGGER TR_I_PM452_MLLE_EN_MME_COMMANDE
            ON sysadm.commande
    FOR INSERT
AS 

Update sysadm.commande
Set    adr_cod_civ = 2 
From   sysadm.commande wc,
	   inserted i
Where  i.id_sin = wc.id_sin
And    i.id_seq = wc.id_seq
And    i.adr_cod_civ = 3
	
Go



