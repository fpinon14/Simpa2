-------------------------------------------------------------------
--
-- Fichier              :       FAMILLE.CP
-- Auteur               :       FABRY JF& GILLOT PH
-- Date                 :       09/11/2006
--
-- Commentaires         :       Procédures de Selection
--				sur les familles ( table famille & famille_car )
--				et sur les codes en fonction des familles
--
-- Procédures           :       DD_S01_CODE_PAR_FAMILLE
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_PAR_FAMILLE
-- Auteur               :       FABRY JF& GILLOT PH
-- Date                 :       09/11/2006
-- Libellé              :       Lecture des codes en fonction de la familles
-- Commentaires         :       
--
-- Arguments            : 	@sIdTypCode   Varchar ( 3 ) : Type de Code regroupé par famille
--				@iIdFam	  integer
--
-- Retourne                            :     Rien
--                                
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_PAR_FAMILLE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_PAR_FAMILLE
GO

CREATE PROC sysadm.DD_S01_CODE_PAR_FAMILLE
            @sIdTypCode   Varchar ( 3 ),
	    @iIdFam	  integer -- Code Famille
	    
AS

SELECT c.id_code,
       c.lib_code
FROM   sysadm.code c,
       sysadm.famille fam
WHERE  c.id_typ_code = @sIdTypCode
And    c.id_code    >=0
And    c.id_typ_code = fam.id_typ_code
And    c.id_code = fam.id_code
And    fam.id_fam = @iIdFam

GO

-------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_CAR_PAR_FAMILLE
-- Auteur               :       FABRY JF& GILLOT PH
-- Date                 :       09/11/2006
-- Libellé              :       Lecture des codes en fonction de la familles
-- Commentaires         :       
--
-- Arguments            : 	@sIdTypCode   Varchar ( 3 ) : Type de Code regroupé par famille
--				@iIdFam	  integer
--
-- Retourne                            :     Rien
--                                
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_CAR_PAR_FAMILLE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_CAR_PAR_FAMILLE
GO

CREATE PROC sysadm.DD_S01_CODE_CAR_PAR_FAMILLE
            @sIdTypCode   Varchar ( 3 ),
	    @iIdFam	  integer -- Code Famille
	    
AS

SELECT c.id_code,
       c.lib_code
FROM   sysadm.code c,
       sysadm.famille_car famc
WHERE  c.id_typ_code = @sIdTypCode
And    c.id_code    >=0
And    c.id_typ_code = famc.id_typ_code
And    c.id_code = famc.id_code
And    famc.id_fam = @iIdFam

GO
