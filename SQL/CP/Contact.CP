-------------------------------------------------------------------
--
-- Fichier                      : contact.cp
-- Auteur                       : Fabry JF
-- Date                         : 24/04/01 
--
-- Commentaires                 : Liste des proc‚dures de la table contact
--
-- Proc‚dures                   :
-- Fonctions                    : DW_S01_CONTACT
--				  DW_I01_CONTACT
--				  PS_S01_CONTACT
--				  PS_S02_CONTACT
--				  DW_S02_CONTACT
--				  DW_S03_CONTACT
--				  PS_U01_CONTACT
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Chargement des contacts pour un sinistre
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CONTACT' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CONTACT
GO

CREATE PROC sysadm.DW_S01_CONTACT
   @dcIdSin  decimal ( 10, 0 )-- [PI062]
AS

Select
	id_sin,                         
	id_msg_seq,                     
	id_typ_msg,                     
	id_nat_msg,                     
	id_canal,                       
	cod_i_prov,                     
	txt_mess1,                      
	txt_mess2,                      
	alt_valide,                     
	cree_le,                        
	maj_le,                         
	maj_par
From	sysadm.contact
Where	id_sin = @dcIdSin

GO


-------------------------------------------------------------------
--
-- Proc‚dure            :       DW_I01_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Insertion d'un contact
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_CONTACT' AND type = 'P' )
            DROP procedure sysadm.DW_I01_CONTACT
GO
CREATE PROC sysadm.DW_I01_CONTACT
   @dcIdSin	decimal (10,0), -- [PI062]                       
   @dcIdMsgSeq 	decimal (3,0),                        
   @sIdTypMsg	char (2),                     
   @dcIdNatMsg	decimal (2,0),                     
   @sIdCanal	char ( 1 ),                       
   @sCodIProv	char ( 1 ),                       
   @sTxtMess1	char (254),                      
   @sTxtMess2	char (254),                      
   @sAltValide  char (1),                     
   @dtCreeLe    DateTime,                        
   @dtMajLe	DateTime,   
   @sMajPar	Char (4)                        
   
AS

Insert Into sysadm.contact
(
	id_sin,                         
	id_msg_seq,                     
	id_typ_msg,                     
	id_nat_msg,                     
	id_canal,                       
	cod_i_prov,                     
	txt_mess1,                      
	txt_mess2,                      
	alt_valide,                     
	cree_le,                        
	maj_le,                         
	maj_par
)
Values
(
   @dcIdSin,
   @dcIdMsgSeq,
   @sIdTypMsg,
   @dcIdNatMsg,
   @sIdCanal,
   @sCodIProv,
   @sTxtMess1,
   @sTxtMess2,
   @sAltValide,
   @dtCreeLe,
   @dtMajLe,
   @sMajPar
)

GO


-------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Maj de Alt_Valide sur table contact
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_CONTACT' AND type = 'P' )
            DROP procedure sysadm.PS_U01_CONTACT
GO

CREATE PROC sysadm.PS_U01_CONTACT
   @dcIdSin  decimal ( 10, 0 )
AS

UPDATE sysadm.contact
SET    alt_valide = 'N'
WHERE  id_sin     = @dcIdSin
AND    alt_valide = 'O'

GO

-------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Max du compteur s‚quentiel
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CONTACT' AND type = 'P' )
            DROP procedure sysadm.PS_S01_CONTACT
GO

CREATE PROC sysadm.PS_S01_CONTACT
   @dcIdSin  decimal ( 10, 0 ), -- [PI062]
   @iMaxSeq  Integer OUTPUT
   
AS

Select @iMaxSeq = CASE  max ( id_msg_seq )
			WHEN null THEN 0
			ELSE max ( id_msg_seq )
		  END
From   sysadm.contact
where  id_sin  = @dcIdSin

GO

-------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S02_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Y a-t-il une pr‚-instruction
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_CONTACT' AND type = 'P' )
            DROP procedure sysadm.PS_S02_CONTACT
GO

CREATE PROC sysadm.PS_S02_CONTACT
   @dcIdSin  decimal ( 10, 0 ), -- [PI062]
   @sTypMsg  Varchar ( 2 ),
   @iNbr     Integer OUTPUT
   
AS

Select @iNbr = Count ( * )
From   sysadm.contact
where  id_sin  = @dcIdSin
and    id_typ_msg = @sTypMsg

GO

-------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S02_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       24/04/01 
-- Libell‚              :       Stat sur les contacts DCMP 010361
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_CONTACT' AND type = 'P' )
            DROP procedure sysadm.DW_S02_CONTACT
GO

CREATE PROC sysadm.DW_S02_CONTACT
   @dtDteDeb	DateTime,
   @dtDteFin	DateTime,  
   @dcIdProd  	decimal ( 7, 0 )
   
AS

select  Count (*) Nbre,
	CodeTT.lib_code Type_Tache,
	CodeNT.lib_code Nature_Tache,
	CodeCR.lib_code Media,
	CodeIN.lib_code Provenance,
	s.id_prod,
	p.lib_court Produit,
	Convert ( Varchar ( 4), DatePart ( year, c.cree_le ) ) + 
	Convert ( Varchar ( 2), DatePart ( month, c.cree_le ) ) Contact_Cree_Le

from    sysadm.contact c,
	sysadm.code CodeNT,
	sysadm.code_car CodeTT,
	sysadm.code_car CodeIN,
	sysadm.code_car CodeCR,
	sysadm.sinistre s,
	sysadm.produit p

Where 	s.id_prod = @dcIdProd
And	p.id_prod = s.id_prod
And	s.id_sin = c.id_sin
And	c.cree_le between @dtDteDeb And @dtDteFin
And 	CodeTT.id_typ_code = '-TT'
And 	CodeTT.id_code = c.id_typ_msg 
And	CodeNT.id_typ_code = '-NT'
And 	CodeNT.id_code = c.id_nat_msg 
And 	CodeIN.id_typ_code = '-IN'
And 	CodeIN.id_code = c.cod_i_prov
And 	CodeCR.id_typ_code = '-CR'
And 	CodeCR.id_code = c.id_canal

Group By CodeTT.lib_code,
	 CodeNT.lib_code,
	 CodeCR.lib_code,
	 CodeIN.lib_code,
	 s.id_prod,
	 p.lib_court,
	 Convert ( Varchar ( 4), DatePart ( year, c.cree_le ) ) + 
	 Convert ( Varchar ( 2), DatePart ( month, c.cree_le ) ) 

Order by Convert ( Varchar ( 4), DatePart ( year, c.cree_le ) ) + 
	 Convert ( Varchar ( 2), DatePart ( month, c.cree_le ) ),
	 CodeCR.lib_code,
	 CodeTT.lib_code,
	 CodeNT.lib_code,
	 CodeIN.lib_code
Go


-------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S03_CONTACT
-- Auteur               :       FABRY JF
-- Date                 :       05/03/02 
-- Libell‚              :       Stat sur les contacts DEEI 2246
-- Commentaires         :
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_CONTACT' And type = "P" )
DROP PROCEDURE sysadm.DW_S03_CONTACT
 
GO

CREATE PROC sysadm.DW_S03_CONTACT 
   @dtDteDeb	DateTime,
   @dtDteFin	DateTime  
  
AS

SELECT s.id_prod            , 
       c.id_sin             , 
       c.id_msg_seq         , 
       c.id_typ_msg         , 
       CodeTT.lib_code    ,
       c.id_nat_msg         ,
       CodeNT.lib_code    ,
       c.id_canal as canal  , 
       CodeCR.lib_code    ,
       c.cod_i_prov         , 
       CodeIN.lib_code    , 
       c.txt_mess1 as Texte1, 
       c.txt_mess2 as Texte2, 
       c.alt_valide         , 
       c.cree_le            , 
       c.maj_le             , 
       c.maj_par

FROM	sysadm.contact c    ,
	sysadm.sinistre s   ,
	sysadm.code CodeNT,
	sysadm.code_car CodeTT,
	sysadm.code_car CodeIN,
	sysadm.code_car CodeCR

WHERE 	s.id_sin  = c.id_sin
	and   c.maj_le between @dtDteDeb and @dtDteFin
	and   c.id_typ_msg         = 'R'
	And CodeTT.id_typ_code = '-TT'
	And CodeTT.id_code = c.id_typ_msg 
	And CodeNT.id_typ_code = '-NT'
	And CodeNT.id_code = c.id_nat_msg 
	And CodeIN.id_typ_code = '-IN'
	And CodeIN.id_code = c.cod_i_prov
	And CodeCR.id_typ_code = '-CR'
	And CodeCR.id_code = c.id_canal

GO
