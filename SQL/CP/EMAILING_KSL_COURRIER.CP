-------------------------------------------------------------------
--
-- Fichier              :       EMAILING_KSL_COURRIER.CP
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
--
-- Commentaires         :      
--
-- Procedures           :       
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       sysadm.TR_IU_EMAILING_KSL_COURRIER
-- Auteur               :       Fabry JF
-- Date                 :       02/01/2025
-- Libelle              :        
-- Commentaires         :       Trigger Insert/Update
-- References           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
If Exists ( Select Top 1 1 From sys.objects where name = 'TR_IU_EMAILING_KSL_COURRIER' and type = 'TR' ) Drop trigger sysadm.TR_IU_EMAILING_KSL_COURRIER
Go
Create Trigger sysadm.TR_IU_EMAILING_KSL_COURRIER
	on [sysadm].[emailing_ksl_courrier]
For Insert, Update
As

Declare @iProd Integer 
DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)

SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()
Set @iProd = 0

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @iProd = 1

Update em
Set em.cod_maq = rtrim ( ltrim ( Upper ( em.cod_maq ) )),
	em.categorie = rtrim ( ltrim ( Upper ( em.categorie ) )),
	em.regl = rtrim ( ltrim ( Upper ( em.regl ) )),
	em.piece = rtrim ( ltrim ( Upper ( em.piece ) )),
	em.refus = rtrim ( ltrim ( Upper ( em.refus ) ))
From inserted i,
	 sysadm.emailing_ksl_courrier em
Where i.cod_maq = em.cod_maq

If @iProd > 0
	Begin
		If Not Exists ( 
			Select Top 1 1 
			From inserted i,
				 TRACE_MAIL_PRO.sysadm.code_car cc
			Where cc.id_typ_code = '-TM'
			And   cc.id_code = i.typ_mail
		)
		Begin
			RAISERROR ('Déclarez d''abord les typ_mail sur TRACE_MAIL_PRO.sysadm.code_car, id_typ_code ''-TM''.', 16, 1, @DBID, @DBNAME)
			Rollback Tran
		End 
		
	End 
Else 
	Begin
		If Not Exists ( 
			Select Top 1 1 
			From inserted i,
				 TRACE_MAIL_TRT.sysadm.code_car cc
			Where cc.id_typ_code = '-TM'
			And   cc.id_code = i.typ_mail
		)
		Begin
			RAISERROR ('Déclarez d''abord les typ_mail sur TRACE_MAIL_TRT.sysadm.code_car, id_typ_code ''-TM''.', 16, 1, @DBID, @DBNAME)
			Rollback Tran
		End 
		
	End 

Go
