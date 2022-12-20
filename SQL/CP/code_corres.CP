-------------------------------------------------------------------
--
-- Fichier              :       CODE_CORRES.CP
-- Auteur               :       Fabry Jf
-- Date                 :       16/05/2014
--
-- Commentaires         :       
--
-- Procedures           :       
--------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_CODE_CORRES
-- Auteur               :       Fabry JF
-- Date                 :       16/05/2014
-- Libelle              :        
-- Commentaires         :       
--
-- Retourne             :       Rien
-- JFF      19/05/2014   [VDOC14454] 
-- JFF      21/03/2016   [PM289-3] passage en V01
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_CODE_CORRES_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_CODE_CORRES_V01
GO

CREATE procedure sysadm.PS_S_CODE_CORRES_V01
        @sIdFour   VarChar ( 3 ),
        @sIdCtg3   VarChar ( 50 ),
        @sCodeSPB  VarChar ( 200 ) OUTPUT
AS	
 
 Set @sIdFour = RTRIM ( ltrim ( @sIdFour ))

 Select @sCodeSPB = 
		( '#' + (
			Select rtrim ( ltrim ( cc.code_spb )) + '#'
			From	sysadm.code_corres cc
			Where  cc.id_four = @sIdFour
			And    cc.id_ctg = @sIdCtg3
			for xml path('')
		 ))

 if  @sCodeSPB is null set @sCodeSPB = ''
 Set @sCodeSPB = lTrim ( rTrim ( @sCodeSPB ))
 
Go
