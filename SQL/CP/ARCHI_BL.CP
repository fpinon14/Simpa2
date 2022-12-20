-------------------------------------------------------------------
--
-- Fichier              :       ARCHI_BL.CP
-- Auteur               :       Erick John Stark
-- Date                 :       10/09/97 17:17:18
--
-- Commentaires         :       Gestion de la table ARCHIVE_BLOB
--
-- sysadm.PS_I01_ARCHIVE_BLOB_VAL
-- sysadm.PS_I02_ARCHIVE_BLOB_VAL
-- sysadm.PS_I03_ARCHIVE_BLOB_VAL
-- sysadm.PS_X_TRT_SIMPA2_ARCHIVE_BLOB
--
-- Procédures           :       PS_I01_ARCHIVE_BLOB_VAL
--				PS_I02_ARCHIVE_BLOB_VAL  // SVE DCMP 040020
--				PS_I03_ARCHIVE_BLOB_VAL  // [DNTMAIL1-2]
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_ARCHIVE_BLOB_VAL
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion dans la table ARCHIVE_BLOB
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdCpt        Decimal (  4,0 )        (Val)
--                      :       @dcIdDoc        Decimal (  7,0 )        (Val)
--                      :       @sCodOper       Varchar (  4   )        (Val)
--                      :       @dtValideLe     DateTime                (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_ARCHIVE_BLOB_VAL' AND type = 'P' )
        DROP procedure sysadm.PS_I01_ARCHIVE_BLOB_VAL
GO

CREATE procedure sysadm.PS_I01_ARCHIVE_BLOB_VAL
        @dcIdSin        Decimal (  10,0 ),   -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdDoc        Decimal (  7,0 ),
        @sCodOper       Varchar (  4   ),
        @dtValideLe     DateTime
AS

 INSERT INTO    sysadm.archive_blob
        (       archive_blob.id_sin,
                archive_blob.id_inter,
                archive_blob.id_doc,
                archive_blob.id_typ_blob,
                archive_blob.txt_blob,
                archive_blob.cree_le,
                archive_blob.maj_le,
                archive_blob.maj_par,
                archive_blob.valide_le,
                archive_blob.valide_par      )
 SELECT         w_inter_blob.id_sin,
                w_inter_blob.id_i,
                @dcIdDoc,
                w_inter_blob.id_typ_blob,
                w_inter_blob.txt_blob,
                w_inter_blob.cree_le,
                w_inter_blob.maj_le,
                w_inter_blob.maj_par,
                @dtValideLe,
                @sCodOper
 FROM           sysadm.w_inter_blob
 WHERE          w_inter_blob.id_sin     = @dcIdSin      AND
                w_inter_blob.id_i       = @dcIdI

 Return @@Error

GO

-------------------------------------------------------------------
-- Procedure            :       PS_I02_ARCHIVE_BLOB_VAL
-- Auteur               :       Fabry JF (Reprise de FS/PLJ)
-- Date                 :       07/04/2004
-- Libelle              :        
--                              Maj de la table archibe 
--                              transfert de w_cour_blob_arch --> Archive_Blob
--                               
-- References           :       Apres l'edition des courriers
--
-- Arguments            :       @iIdLot         Integer  ( Val )
--                              @sRet           Varchar(60 )
--
-- Retourne             :       Rien
--
------------------------------------------------------------------- 
-- #1 FS le 30/10/2002 : Mise en place d'une purge glissante sur 14 Jours
--    JFF 13/07/2011  [PM159]
------------------------------------------------------------------- 

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_ARCHIVE_BLOB_VAL' AND type = 'P' )
DROP procedure sysadm.PS_I02_ARCHIVE_BLOB_VAL

Go
 
CREATE procedure sysadm.PS_I02_ARCHIVE_BLOB_VAL
 @iIdLot  integer  ,
 @sRet    varchar(60) OUTPUT
As                        

Declare @dButtoir Datetime
Declare @iRet Integer
Declare @iNb  Integer

Select  @iRet = 0
Select  @sRet 'OK'

UPDATE sysadm.archive
SET    dte_edit = Case 
					When archive.dte_edit > '01/01/1900' Then archive.dte_edit -- [PM159]
					Else w.dte_edit
				  End,
       dte_echec_distrib_ksl = Case 
					When archive.dte_edit > '01/01/1900' Then w.dte_edit -- [PM159]
					Else archive.dte_echec_distrib_ksl 
				   End
FROM   sysadm.w_cour_blob_arch w
WHERE  w.id_arch = archive.id_arch
And    w.id_lot  = @iIdLot        

SELECT @iRet = @@Error
If @iRet <> 0
 Begin
   Select  @sRet = 'Err maj table archive lot ' + convert( varchar(10), @iIdLot )
   Return @iRet
 End

 INSERT INTO    sysadm.archive_blob
        (       archive_blob.id_sin,
                archive_blob.id_inter,
                archive_blob.id_doc,
                archive_blob.id_typ_blob,
                archive_blob.txt_blob,
                archive_blob.cree_le,
                archive_blob.maj_le,
                archive_blob.maj_par,
                archive_blob.valide_le,
                archive_blob.valide_par  )
 SELECT         wcb.id_sin,
                wcb.id_inter,
                a.id_doc,
                wcb.id_typ_blob,
                wcb.txt_blob,
                wcb.cree_le,
                wcb.maj_le,
                wcb.maj_par,
                wcb.valide_le,
                wcb.valide_par
 FROM           sysadm.w_cour_blob_arch wcb,
 		sysadm.archive a
 WHERE          wcb.id_lot = @iIdLot 
 And		wcb.alt_fn = 'N'
 And		wcb.id_arch = a.id_arch
 And		Not Exists ( 	Select * 
 				From sysadm.archive_blob 
 				Where id_sin   = a.id_sin
 				And   id_inter = a.id_inter
 				And   id_doc   = a.id_doc
 				And   id_typ_blob = 'DO' ) -- [PM159] gère le fait que le blob s'y trouve déjà pour les mail du PM159

SELECT @iRet = @@Error

If @iRet <> 0
 Begin
   Select  @sRet = 'Err insertion base blob lot ' + convert( varchar(10), @iIdLot )
   Return @iRet
 End

/*------------------------------------------------------------------*/
/* Mise à jour du flag d'archive dans w_cour_blob_arch              */
/*------------------------------------------------------------------*/

UPDATE sysadm.w_cour_blob_arch
   SET alt_fn = 'O'
 WHERE id_lot = @iIdLot And
       sysadm.w_cour_blob_arch.alt_fn = 'N'

SELECT @iRet = @@Error
If @iRet <> 0
 Begin
   Select  @sRet = 'Err maj flag table w_cour_blob_arch lot ' + convert( varchar(10), @iIdLot )
   Return @iRet
 End

Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_I03_ARCHIVE_BLOB_VAL
-- Auteur               :       PHG (Reprise de PS_I02_ARCHIVE_BLOB_VAL, by JFF/FS/PLJ)
-- Date                 :       03/11/2006
-- Libelle              :        On simule une edition pour la cas d'un mail.
--                              Maj de la table archive 
--                              transfert de w_cour_blob_arch --> Archive_Blob
--                               
-- References           :       Apres l'edition des courriers
--				[DNTMAIL1-2], Spécifications 5.2.6.1.
-- Arguments            :       @iIdLot         Integer  ( Val )
--                              @sRet           Varchar(60 )
--
-- Retourne             :       Rien
--   JFF  10/06/2011  [PM159]
--   JFF  21/12/2011  [MANTIS1932][PM159]
--   JFF  24/03/2015  [DT139]
--   JFF  05/06/2015  [VDOC17642]
--   JFF  11/06/2015  [VDOC16952]
--	 FPI  02/10/2015  [VDOC18795]
--   JFF  26/01/2016  [VDOC19724]
--	 FPI  09/02/2016  [VDOC18572]
--   JFF  24/03/2016  [VDOC20329]
--   JFF  12/02/2016  [PI062]
--   JFF  12/02/2018  [DT346]
--   JFF  26/12/2018  [PM421-2]
--   JFF  01/09/2020  [VDOC29600]
------------------------------------------------------------------- 
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I03_ARCHIVE_BLOB_VAL' AND type = 'P' )
DROP procedure sysadm.PS_I03_ARCHIVE_BLOB_VAL
Go
 
CREATE procedure sysadm.PS_I03_ARCHIVE_BLOB_VAL
 @iIdArch integer  ,
 @sRet    varchar(60) OUTPUT
As                        

Declare @dButtoir Datetime
Declare @iRet Integer
Declare @iNb  Integer

Declare @sIdCourOrig 	VarChar ( 6 )

Declare @asIdAppli	VarChar ( 10 )
Declare @dcIdSin	Decimal ( 10 ) -- [PI062]
Declare @dcIdI		Decimal ( 7 ) -- [PM421-2]
Declare @sCodInter  VarChar ( 1 ) -- [PM421-2]
Declare @iOptionDP	Integer
Declare @dcIdProd	Decimal ( 7 )
Declare @sLibProd	VarChar ( 70 )
Declare @dcIdEts	Decimal ( 7 )
Declare @sNumProd   	VarChar ( 20 )
Declare @sCiv	    	VarChar ( 35 )
Declare @sNom	    	VarChar ( 50 )
Declare @sMailFrom  	VarChar ( 128 )
Declare @sMailSend  	VarChar ( 128 )
Declare @sMailCc    	VarChar ( 128 )
Declare @sAltQuarant 	VarChar ( 1 )
Declare @sBoiteMail  	VarChar ( 128 )
Declare @sXMLVar     	VarChar ( 2000 )
Declare @iIdSin  	Integer
Declare @iIdProd 	Integer
Declare @iIdEts  	Integer
Declare @sMailObjet 	VarChar ( 255 )
Declare @sTypMail 	VarChar ( 10 )
Declare @iIdTypDoc	Integer -- [MANTIS1932][PM159]
Declare @sClientVip Varchar ( 10 ) -- [DT139]
Declare @sMailRefus 	VarChar ( 255 ) -- [VDOC18572]

Select  @iRet = 0
Select  @sRet 'OK'
Set     @sMailCc = ''  -- [VDOC16952]

UPDATE sysadm.archive
SET    dte_edit = w.dte_edit
FROM   sysadm.w_cour_blob_arch w
WHERE
       w.id_arch = archive.id_arch
And    w.id_arch  = @iIdArch        

SELECT @iRet = @@Error
If @iRet <> 0
 Begin
   Select  @sRet = 'Err maj table archive N°Arch ' + convert( varchar(10), @iIdArch )
   Return @iRet
 End

 INSERT INTO    sysadm.archive_blob
        (       archive_blob.id_sin,
                archive_blob.id_inter,
                archive_blob.id_doc,
                archive_blob.id_typ_blob,
                archive_blob.txt_blob,
                archive_blob.cree_le,
                archive_blob.maj_le,
                archive_blob.maj_par,
                archive_blob.valide_le,
                archive_blob.valide_par  )
 SELECT         wcb.id_sin,
                wcb.id_inter,
                a.id_doc,
                wcb.id_typ_blob,
                wcb.txt_blob,
                wcb.cree_le,
                wcb.maj_le,
                wcb.maj_par,
                wcb.valide_le,
                wcb.valide_par
 FROM           sysadm.w_cour_blob_arch wcb,
 		sysadm.archive a
 WHERE          wcb.id_arch = @iIdArch 
 And		wcb.alt_fn = 'N'
 And		wcb.id_arch = a.id_arch


SELECT @iRet = @@Error
If @iRet <> 0
 Begin
   Select @sRet = 'Err insertion base blob IdArch ' + convert( varchar(10), @iIdArch )
   Return @iRet
 End

/*------------------------------------------------------------------*/
/* Mise à jour du flag d'archive dans w_cour_blob_arch              */
/*------------------------------------------------------------------*/

UPDATE sysadm.w_cour_blob_arch
   SET alt_fn = 'O'
 WHERE id_arch = @iIdArch And
       sysadm.w_cour_blob_arch.alt_fn = 'N'

SELECT @iRet = @@Error
If @iRet <> 0
 Begin
   Select  @sRet = 'Err maj flag table w_cour_blob_arch IdArch ' + convert( varchar(10), @iIdArch )
   Return @iRet
 End

/*------------------------------------------------------------------*/
/* [PM159] Traitement TRACE_MAIL.mailpush                           */
/*------------------------------------------------------------------*/
Select 	@sIdCourOrig 	= a.id_cour_orig,
	    @dcIdSin	= a.id_sin,
		@dcIdI		= a.id_inter, -- [PM421-2]
		@sCodInter  = rtrim ( a.cod_inter ) -- [PM421-2]
From	sysadm.archive a
Where 	a.id_arch = @iIdArch

-- [PM421-2]
/*
Explication de cet armement de variables horrible :-)
J'ai besoin pour le PM421-2 d'avoir le l'inter sur la PS_S01_RECUP_DONNEES_MAIL_XML.
Cette PS ramenant le XML étant appelé à beaucoup d'endroit, je n'ai pas envie de modifier la signature de la PS et tous les appel.
De ce fait j'utilise la chaine de caractère @sMailCc pour transmettre la donnée en bcv.
*/
Set @sMailCc = sysadm.FN_CLE_VAL_E ( 'ID_I', Convert ( varchar, @dcIdI), rtrim ( IsNull ( @sMailCc, '')) , ';' )
Set @sMailCc = sysadm.FN_CLE_VAL_E ( 'COD_INTER', rtrim ( IsNull ( @sCodInter, '')) , rtrim ( IsNull ( @sMailCc, '')) , ';' )

-- [MANTIS1932][PM159]
Set @iIdTypDoc = 0
Select  @iIdTypDoc = wa.id_typ_doc
From	sysadm.w_cour_blob_arch wa
Where   wa.id_arch = @iIdArch


If @sIdCourOrig is null Set @sIdCourOrig = ''

Set  @asIdAppli = 'SIMPA2'
Set  @iOptionDP = 173   -- Si on arrive jusqu'ici, c'est qu'elle est présente sur le produit.
Set  @sTypMail 	= 'M16'

-- Récupération des données standard nécessaires à l'envoi du mail
Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
	@dcIdSin,
	@iOptionDP,
	@dcIdProd   OUTPUT,
	@sLibProd   OUTPUT,
	@dcIdEts    OUTPUT,
	@sNumProd   OUTPUT,
	@sCiv	    OUTPUT,
	@sNom	    OUTPUT,
	@sMailFrom  OUTPUT,
	@sMailSend  OUTPUT,
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT,
	@sXMLVar     OUTPUT

If @iRet < 0 
  Begin 
  	Set @sRet = 'Erreur dans PS_S01_RECUP_DONNEES_MAIL_XML sur appel PS_I03_ARCHIVE_BLOB_VAL'
  	Return @iRet 
  End 


-- Armement du corps du mail 
Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @dcIdSin ) + ' ' + @sLibProd

-- VDOC18795 / FPI
If @dcIdProd between 84000 and 84099
Begin
	Set @sMailObjet = 'ADVISE Sinistre numéro ' + Convert ( Varchar ( 10 ), @dcIdSin ) + ' ' + @sLibProd
End

-- Armement du corps du mail
Set @sXMLVar = @sXMLVar + '<courrier '
Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="' + @sIdCourOrig + '" '
Set @sXMLVar = @sXMLVar + 'id_arch_SIMPA2="' + Convert ( VarChar ( 15 ), @iIdArch ) + '" '
Set @sXMLVar = @sXMLVar + 'code_produit_SIMPA2="' + Convert ( VarChar ( 15 ), @dcIdProd  ) + '"'

-- [MANTIS1932][PM159]
Set @sXMLVar = @sXMLVar + ' nature_doc_SIMPA2="' + Convert ( VarChar ( 15 ), @iIdTypDoc  ) + '"'

-- [DT139]
-- [VDOC17642]
Select @sClientVip = rtrim ( ds.val_car )
From   sysadm.div_sin ds,
	   sysadm.sinistre s,
	   sysadm.det_pro dp 
Where  ds.id_sin = @dcIdSin
And	   ds.nom_zone = 'client_vip'
And	   s.id_sin = ds.id_sin 
And	   dp.id_prod = s.id_prod
And    dp.id_code_dp = 272

If @sClientVip is null Set @sClientVip = ''

If @sClientVip In ( 'SEN', 'SEM' ) 
 Begin
	Set @sMailCc = 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]	 
 End 

If @sClientVip In ( 'ASN' ) 
 Begin
    -- [VDOC19724]
	Set @sMailCc = 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642]	 [VDOC20329]	 
 End 

 -- [DT346]
If @sClientVip In ( 'VIPPAR' ) 
	Begin
		-- le MailSend n'est pas une erreur, on n'envoie rien à l'assuré.
		Set @sMailSend = 'laura.naulot@orange.com,desk@parnasse.fr' -- [DT346]	 
	End 


-- [VDOC29600][PM421]
If Exists ( 
		Select  top 1 1
		From sysadm.inter_auto ia,
				sysadm.w_inter wi,
				sysadm.archive a
		Where ia.id_prod = @dcIdProd
		And   wi.id_sin = @dcIdSin
		And   wi.cod_inter = ia.cod_inter
		And   wi.nom = ia.nom
		And   wi.adr_1 = ia.adr_1
		And   isnull ( wi.adr_2, '')  = IsNull ( ia.adr_2, '' )
		And   wi.adr_cp = ia.adr_cp
		And   wi.adr_ville = ia.adr_ville
		And   CharIndex ( wi.adr_mail, ia.adr_mail ) > 0 
		And   a.id_arch = @iIdArch
		And   a.id_sin = wi.id_sin
		And   a.id_inter = wi.id_i
) 
Begin
	Set @sMailSend = ( Select Top 1 rtrim ( ltrim ( ia.adr_mail ))
						From sysadm.inter_auto ia,
								sysadm.w_inter wi,
								sysadm.archive a
						Where ia.id_prod = @dcIdProd
						And   wi.id_sin = @dcIdSin
						And   wi.cod_inter = ia.cod_inter
						And   wi.nom = ia.nom
						And   wi.adr_1 = ia.adr_1
						And   isnull ( wi.adr_2, '')  = IsNull ( ia.adr_2, '' )
						And   wi.adr_cp = ia.adr_cp
						And   wi.adr_ville = ia.adr_ville
						And   a.id_arch = @iIdArch
						And   a.id_sin = wi.id_sin
						And   a.id_inter = wi.id_i
					)

End 

-- [VDOC16952]
-- [VDOC18572] - adresse mail dans l'option
Set @sMailRefus=NULL

Select Top 1 @sMailRefus=sysadm.FN_CLE_VAL('ADR_MAIL_REFUS',val_car,';')
	From   sysadm.sinistre s,
		   sysadm.det_pro dp 
	Where  s.id_sin = @dcIdSin
	And    s.cod_etat = 200 -- Si dossier refusé, c'est le critère, vu avec Christine Quertier.
	And	   dp.id_prod = s.id_prod
	And    dp.id_code_dp in (249,217)
	
if @sMailRefus is not null
 Begin
	If LEN ( @sMailCc  ) > 0 
	  Begin
		Set @sMailCc = @sMailCc + ','
	  End
	
	Set @sMailCc = @sMailCc + @sMailRefus -- [VDOC16952]	 
 End 
-- [VDOC16952]

Set @sXMLVar = @sXMLVar + '/>'

-- On convertit pour l'appel de la PS
Set @iIdSin  = Convert ( integer, @dcIdSin )
Set @iIdProd = Convert ( integer, @dcIdProd )
Set @iIdEts  = Convert ( integer, @dcIdEts )
Set @sAltQuarant = 'N'

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
 Begin
       Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V01 
		@asIdAppli,
		@iIdSin,
		@iIdProd,
		@sLibProd,
		@iIdEts,
		@sMailFrom,
		@sMailSend,
		@sMailCc,
		@sMailObjet,
		'Corps du mail construit par KSL',
		@sAltQuarant,
		@sBoiteMail,
		@sTypMail,
		2,
		'KSL',
		@iIdArch,
		@sXMLVar

   End    -- TRACE_MAIL_PRO : Fin écriture

Else
 Begin
	 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V01 
		@asIdAppli,
		@iIdSin,
		@iIdProd,
		@sLibProd,
		@iIdEts,
		@sMailFrom,
		@sMailSend,
		@sMailCc,
		@sMailObjet,
		'Corps du mail construit par KSL',
		@sAltQuarant,
		@sBoiteMail,
		@sTypMail,
		2,
		'KSL',
		@iIdArch,
		@sXMLVar
 End


-- :[PM159] 


Return @iRet

Go

grant execute on sysadm.PS_I03_ARCHIVE_BLOB_VAL to rolebddsinistres
go

---------------------------
-- JFF      12/02/2016   [PI062]
---------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_TRT_SIMPA2_ARCHIVE_BLOB' AND type = 'P' )
DROP procedure sysadm.PS_X_TRT_SIMPA2_ARCHIVE_BLOB
GO

CREATE PROCEDURE sysadm.PS_X_TRT_SIMPA2_ARCHIVE_BLOB
        @dtDebTrt		DateTime , 
        @adtFinTrt              DateTime        ,
        @aiNbrLig               Integer         ,
        @asRetour               VarChar (  500 ) OUTPUT 
AS


DECLARE @iRet           INTEGER         ,
        @iCptTrt        INTEGER         ,
        @iUpdateCpt     INTEGER         ,
        @sParam         CHAR(200)       ,
        @dtJourTrt      DATETIME        ,
        @dtVerifDate    DATETIME
        
DECLARE @iIdSin         DECIMAL(10,0)    , -- [PI062]
        @iIdInter       DECIMAL(7,0)    ,
        @iIdDoc         DECIMAL(7,0)    ,
        @iRefDocDt      DECIMAL(8,0)    ,
        @dtDteArchiv    DATETIME,
		@ExistDeja      Integer
        
DECLARE @iCptLigne      INTEGER        
        
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Explications paramètres                                                                                                      */
/* @adtFinTrt   = Date de fin de traitement demandée. (Cette date va être testée par la suite)                                  */
/* @alNbrLig    = Nbr de lignes à traiter.                                                                                      */
/* @asRetour    = Message de retour.                                                                                            */
/*------------------------------------------------------------------------------------------------------------------------------*/
/* Le but de cette procédure est de 'recopier' les blobs de la table ARCHIVE_BLOB (BASE:SIMPA2) dans la table ARCHIVE_BLOB      */
/* (Base:SIMPA2_BLOB), de supprimer le blob que l'on vient de recopier et de marquer la ligne de la table ARCHIVE.              */
/*------------------------------------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

/*------------------------------------------------------------------*/
/* Initialisation des variables                                     */
/*------------------------------------------------------------------*/
SET     @iRet   = 1 

/*------------------------------------------------------------------*/
/* La date minimum des blobs à traiter est le 22/06/2004, jour de la*/
/* mise en place de la SVE.                                         */
/*------------------------------------------------------------------*/
--SET     @dtDebTrt       = '22/06/2004 00:00'
--SET     @dtDebTrt       =  '29/03/2009 00:00'
SET     @dtJourTrt      = GETDATE()

/*------------------------------------------------------------------*/
/* On vérifie que les paramètres sont corrects.                     */
/*------------------------------------------------------------------*/
IF      @aiNbrLig IS NULL OR @aiNbrLig <= 0
        BEGIN
                SET @aiNbrLig = 100
        END
/*------------------------------------------------------------------*/
/* On doit garder au minimum 6 mois d'archive de BLOBs dans la base.*/
/* On va effectuer un calcul pour vérifier la date de fin de        */
/* traitement demandée.                                             */
/*------------------------------------------------------------------*/
SET     @dtVerifDate = DATEADD ( mm, -6, @dtJourTrt )
IF      @dtVerifDate < @adtFinTrt
        BEGIN
                SET     @adtFinTrt = @dtVerifDate
        END

/*------------------------------------------------------------------*/
/* On vérifie si la table TRACE_TRT_BLOB_ARCHIVE existe. Si ce      */
/* n'est pas le cas on arrête le traitement.                        */
/*------------------------------------------------------------------*/
IF NOT EXISTS ( SELECT * FROM sysobjects WHERE id = object_id( 'sysadm.trace_trt_blob_archive') AND OBJECTPROPERTY(id, 'IsUserTable') = 1)
        BEGIN
                SET @iRet = -1
SET @asRetour = 'La table TRACE_TRT_BLOB_ARCHIVE n''existe pas.'
        END

/*------------------------------------------------------------------*/
/* Récupération du compteur de traitement.                          */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
                SELECT  @iCptTrt        = p.cpt_val
                FROM    sysadm.parametre        AS p
                WHERE   p.ref_cpt = 'ID_CPTBLOB'

                IF      @@ROWCOUNT <> 1 OR @iCptTrt <= 1 -- Il existe déjà un traitement 1
                        BEGIN
                                SET @iRet = -1
                                SET @asRetour = 'Pas de compteur valide ID_CPTBLOB dans la table PARAMETRE. (Le compteur doit être supérieur à 1)'
                        END

                IF      @iRet         = 1
                        BEGIN
                                SET     @iUpdateCpt = @iCptTrt
                                SET     @iCptTrt = @iCptTrt + 1
                /*------------------------------------------------------------------*/
                /* On va insérer une ligne dans la table TRACE_TRT_BLOB_ARCHIVE et  */
                /* incrémenter le compteur de 1 de la table PARAMETRE.              */
                /*------------------------------------------------------------------*/
                                BEGIN   TRAN

                                UPDATE  sysadm.parametre
                                SET     sysadm.parametre.cpt_val        = @iCptTrt
                                WHERE   sysadm.parametre.cpt_val        = @iUpdateCpt   AND
                                        sysadm.parametre.ref_cpt        = 'ID_CPTBLOB'

                                IF      @@ROWCOUNT <> 1
                                        BEGIN
                                                SET @iRet = -1
                                                SET @asRetour = 'Impossible de mettre la table PARAMETRE à jour.'
                                        END

                                ELSE
                                        BEGIN
                                                SET @sParam = CONVERT ( CHAR(10), @adtFinTrt, 103 ) + ' ' +  CONVERT ( CHAR(12), @adtFinTrt, 114 ) + ' - ' + CONVERT ( CHAR(20), @aiNbrLig )
                                                INSERT INTO sysadm.trace_trt_blob_archive VALUES ( @iCptTrt, @dtJourTrt, @sParam, NULL, NULL )
                                                IF      @@ROWCOUNT <> 1
                                                        BEGIN
                                                                SET @iRet = -1
                                                                SET @asRetour = 'Impossible de mettre la table TRACE_TRT_BLOB_ARCHIVE à jour.'
                                                        END
                                        END


                                IF      @iRet = 1
                                        BEGIN
                                                COMMIT TRAN
                                        END
                                ELSE
                                        BEGIN
                                                ROLLBACK TRAN
                                        END
                        END
        END

/*------------------------------------------------------------------*/
/* On déclare le curseur pour sélectionner les dossiers de la table */
/* ARCHIVE.                                                         */
/*------------------------------------------------------------------*/
IF      @iRet   = 1
        BEGIN
                DECLARE cCur CURSOR FOR
                SELECT	Top (@aiNbrLig)	
						a.id_sin,
                        a.id_inter,
                        a.id_doc,
                        a.ref_doc_dt,
                        a.dte_archiv
                FROM  sysadm.archive  AS a
                WHERE   a.dte_edit >= @dtDebTrt         AND
                        a.dte_edit <= @adtFinTrt        AND
                        a.dte_edit IS NOT NULL          AND
                        a.ref_doc_dt IS NULL            AND
                        a.dte_archiv IS NULL
                ORDER BY
                        a.dte_edit,
                        a.id_sin
                FOR UPDATE OF a.ref_doc_dt, a.dte_archiv
/*------------------------------------------------------------------*/
/* Ouverture du curseur et premier FETCH                            */
/*------------------------------------------------------------------*/
                OPEN cCur
                     
                FETCH NEXT FROM cCur
                INTO    @iIdSin,
                        @iIdInter,
                        @iIdDoc,
                        @iRefDocDt,
                        @dtDteArchiv
/*------------------------------------------------------------------*/                        
/* Boucle de traitement.                                            */
/*------------------------------------------------------------------*/
                SET @iCptLigne = 0
                WHILE @@FETCH_STATUS = 0
                BEGIN
                
/*------------------------------------------------------------------*/
/* Insertion du BLOB dans la BASE prévue à cet effet.               */
/*------------------------------------------------------------------*/

						Set @ExistDeja = 0

						If Exists ( 
							Select Top 1 1
							From   SIMPA2BLOB_PRO.sysadm.archive_blob2 ab
							Where  ab.id_sin       = @iIdSin       AND
                                   ab.id_inter     = @iIdInter     AND
                                   ab.id_doc       = @iIdDoc
							)
							Begin
								Set @ExistDeja = 1
							End 

                        BEGIN TRAN

						If @ExistDeja = 0 
							Begin 
								-- [PI062] archive_blob2
								INSERT INTO     SIMPA2BLOB_PRO.sysadm.archive_blob2
										(       SIMPA2BLOB_PRO.sysadm.archive_blob2.id_sin,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.id_inter,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.id_doc,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.id_typ_blob,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.txt_blob,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.valide_le,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.valide_par,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.cree_le,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.maj_le,
												SIMPA2BLOB_PRO.sysadm.archive_blob2.maj_par
										)
								SELECT          ab.id_sin,
												ab.id_inter,
												ab.id_doc,
												ab.id_typ_blob,
												ab.txt_blob,
												ab.valide_le,
												ab.valide_par,
												ab.cree_le,
												ab.maj_le,
												ab.maj_par
								FROM            sysadm.archive_blob     AS ab
								WHERE           ab.id_sin       = @iIdSin       AND
												ab.id_inter     = @iIdInter     AND
												ab.id_doc       = @iIdDoc
                                        
								IF      @@ROWCOUNT <= 0 
										BEGIN
												SET @iRet = -1
												SET @asRetour = 'Erreur sur le dossier ' + RTRIM ( CONVERT ( CHAR(10), @iIdSin ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdInter ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdDoc ) ) -- [PI062]

												SET @asRetour = @asRetour + ' - Insertion du BLOB sur SIMPA2BLOB.'
										END
							End 
/*------------------------------------------------------------------*/
/* Suppression du BLOB de la table ARCHIVE_BLOB.                    */
/*------------------------------------------------------------------*/
                        IF      @iRet = 1
                                BEGIN
                                        DELETE
                                        FROM    sysadm.archive_blob
                                        WHERE   sysadm.archive_blob.id_sin       = @iIdSin       AND
                                                sysadm.archive_blob.id_inter     = @iIdInter     AND
                                                sysadm.archive_blob.id_doc       = @iIdDoc       -- AND
                                                -- sysadm.archive_blob.id_typ_blob  = 'DO'  
                                                
                                         IF      @@ROWCOUNT <= 0  
                                                 BEGIN
                                                         SET @iRet = -1
                                                         SET @asRetour = 'Erreur sur le dossier ' + RTRIM ( CONVERT ( CHAR(10), @iIdSin ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdInter ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdDoc ) ) -- [PI062]

                                                         SET @asRetour = @asRetour + ' - Suppression de ARCHIVE_BLOB.'
                                                 END
                                END
/*------------------------------------------------------------------*/
/* Mise à jour de la table ARCHIVE pour indiquer l'archivage du     */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
                        IF      @iRet = 1
                                BEGIN
                                        UPDATE  sysadm.archive
                                        SET     dte_archiv      = @dtJourTrt,
                                                ref_doc_dt      = @iCptTrt
                                        WHERE   sysadm.archive.id_sin          = @iIdSin                 AND
                                                sysadm.archive.id_inter        = @iIdInter               AND
                                                sysadm.archive.id_doc          = @iIdDoc
                                
                                         IF      @@ROWCOUNT <= 0 
                                                 BEGIN
                                                         SET @iRet = -1
                                                         SET @asRetour = 'Erreur sur le dossier ' + RTRIM ( CONVERT ( CHAR(10), @iIdSin ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdInter ) ) + '/' + RTRIM ( CONVERT ( CHAR(7), @iIdDoc ) ) -- [PI062]

                                                         SET @asRetour = @asRetour + ' - Mise à jour de la table ARCHIVE.'
                                                 END
                                END
                                
/*------------------------------------------------------------------*/
/* On s'occupe de COMMITER ou ROLLBACKER la transaction.            */
/*------------------------------------------------------------------*/
                        IF      @iRet = 1
                                BEGIN
                                        COMMIT TRAN
                                END
                        ELSE
                                BEGIN
                                        ROLLBACK TRAN
                                        BREAK
                                END
                
                
                        FETCH NEXT FROM cCur
                        INTO    @iIdSin,
                                @iIdInter,
                                @iIdDoc,
                                @iRefDocDt,
                                @dtDteArchiv

/*------------------------------------------------------------------*/                                
/* A t-on traité le nombre de lignes maximum fixé par le demandeur. */
/*------------------------------------------------------------------*/
                        SET @iCptLigne = @iCptLigne + 1
                        IF      @iCptLigne >= @aiNbrLig
                                BEGIN
                                        BREAK
                                END
                END   
/*------------------------------------------------------------------*/
/* Fermeture et désallocation du curseur                            */
/*------------------------------------------------------------------*/
                CLOSE           cCur
                DEALLOCATE      cCur
        END

/*------------------------------------------------------------------*/
/* On s'occupe de mettre la table TRACE_TRT_BLOB_ARCHIVE à jour.    */
/*------------------------------------------------------------------*/
IF      @iRet = 1
        BEGIN
                UPDATE  sysadm.trace_trt_blob_archive
                SET     nbr_lig_traite  = @iCptLigne,
                        dte_fin_trt     = GETDATE()
                WHERE   id_trt = @iCptTrt
        END

RETURN ( @iRet )

GO

