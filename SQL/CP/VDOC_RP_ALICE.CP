-------------------------------------------------------------------
--
-- Fichier              :       VDOC_RP_ALICE.CP
-- Auteur               :       FPI
-- Date                 :       01/02/2016
--
-- Commentaires         :       Gestion de la VDoc Mensuelle des RP Alice Dumesnil
--
-- Procédures           :       PS_VDOC_RP_ALICE
--								PS_VDOC_RP_ALICE_TRAITEMENT
--								PS_VDOC_RP_ALICE_EXTRACT
--								PS_VDOC_RP_ALICE_EXTRACT_FICHIER
--------------------------------------------------------------------

/***********************
Pour les VDoc d'ajout de RP en masse,
Modifier PS_VDOC_RP_ALICE pour ajouter les infos de la VDoc, 
le mettre dans un sql pour un ITSM à PI, exemple :

Titre : 
[SQL][PROD][SQLSINISTRES\SINISTRES][SIMPA2_PRO] : PS à jouer aujourd'hui + Job à activer !!

Description :
Jouer le SQL lundi matin 25/01 en base.
+
Lundi matin 25/01
Reprendre le Job existant "SIMPA2_PRO : Traitement unique vDoc RP ALICE pour le DCP"
Activer le Job pour un lancement unique : Mardi 26/01/2016 à 00h05  (Donc dans la nuit de Lundi à mardi)

***********************/
--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC_RP_ALICE 
-- Auteur               :       FPI
-- Date                 :       02/02/2016
-- Libellé              :        
-- Commentaires         :       Insertion de RP en masse
-- Références           :       
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC_RP_ALICE' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC_RP_ALICE
GO

CREATE procedure sysadm.PS_VDOC_RP_ALICE

As

	Declare @sVdoc VarChar ( 20 )
	Declare @sDteVdoc VarChar ( 20 )

	delete from sysadm.vDocRPAlice -- (facultatif)
	
	-- 1. Lignes à insérer
	-- ="Insert into sysadm.vDocRPAlice values (" & A2  & "," & B2 & ",'" & GAUCHE(SUPPRESPACE(E2);35) & "', 0 )"
	Insert into sysadm.vDocRPAlice values (4652616,6.89,'FA CPLT ORANGE FC013055 VRT MANUEL', 0 )
	-- ...

	-- 2. Infos de la VDoc
	Set @sVdoc= '19767'  -- renseigner le numéro de vDoc
	Set @sDteVdoc= '27/01/2015' -- renseigner la date de la VDoc

	exec sysadm.PS_VDOC_RP_ALICE_TRAITEMENT @sVdoc, @sDteVdoc
Go

grant execute on sysadm.PS_VDOC_RP_ALICE to rolebddsinistres
go
		


--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC_RP_ALICE_TRAITEMENT
-- Auteur               :       FPI
-- Date                 :       01/02/2016
-- Libellé              :        
-- Commentaires         :       Insertion de RP en masse
-- Références           :       [VDOC15707]
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- marquage = 0 : non traité, 1 : traité - OK , 3 : non traité - pas de règlement PSM/O2M, 4 : traité - pas de règlement PSM/O2M
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC_RP_ALICE_TRAITEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC_RP_ALICE_TRAITEMENT
GO

CREATE procedure sysadm.PS_VDOC_RP_ALICE_TRAITEMENT
	@sVdoc VarChar ( 20 ),
	@sDteVdoc VarChar ( 20 )
As


DECLARE @sMessage    Varchar(1000),
	    @sObjet      VarChar(255),
	    @sRetourErrMail VarChar(255),
		@sFicOut varchar(255),
	    @iRPok integer,
	    @iRPko integer

Update sysadm.vDocRPAlice
Set marquage = 3
from sysadm.vDocRPAlice vd
where not exists ( 
		Select 1
		From sysadm.reglement r,
			  sysadm.inter i
		Where r.id_sin = vd.id_sin
		And   r.cod_mode_reg = 'FM'
		And   i.id_sin = r.id_sin
		And   i.id_i = r.id_i
		And   i.id_four in ( 'O2M', 'PSM' )
	 )
	and marquage=0

Select @iRPok = COUNT(*)
From   sysadm.vDocRPAlice
Where  marquage = 0

Select @iRPko = COUNT(*)
From   sysadm.vDocRPAlice
Where  marquage = 3

If @iRPok is null set @iRPok = 0
If @iRPko is null set @iRPko = 0


Declare 
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@aiIdSeq		Integer,
	@asIdFour		VarChar ( 3 ),
	@adcMtAvoir		Decimal (11, 2 ),
	@asLibRM		VarChar ( 35 ),
	@asResult		Varchar ( 255 ) 

Declare @dcIdInterRP Decimal (7)
Declare @dcIdRegBase Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )

Declare @iNbre  Integer
Declare @iIdSeq integer
Declare @iCpt integer


While Exists ( Select * From sysadm.vDocRPAlice where marquage = 0 ) 
 Begin
 
	Select 	Top 1 
		@iIdSeq = id_seq,
		@adcIdSin = id_sin,
		@adcMtAvoir = mt,
		@asLibRM = lib
	From	sysadm.vDocRPAlice
	Where	marquage = 0

	Select  Top 1
			@dcIdRegBase = r.id_reg,
			@sCodInter = r.cod_inter,
			@dcIdInterRP = r.id_i,
			@sCodModeReg = r.cod_mode_reg,
			@dcIdGtiBase = d.id_gti,
			@dcMtTotReg = r.mt_tot_reg,
			@sIdFourCtrle = i.id_four
			
	From	sysadm.reglement r,
			sysadm.inter i,
			sysadm.detail d
			
	Where   r.id_sin = @adcIdSin
	And     r.cod_mode_reg = 'FM'
	And     r.cod_mot_reg = 'RN'
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		i.id_sin = r.id_sin
	And     i.id_i = r.id_i

	And		( 
				i.id_four = 'O2M'
			 Or
			    ( i.id_four = 'PSM'
				  And		
				  Not Exists ( 
						Select 1
						From	sysadm.reglement r1,
								sysadm.inter i1
						Where   r1.id_sin = r.id_sin
						And     r1.cod_mode_reg = r.cod_mode_reg
						And     r1.cod_mot_reg = r.cod_mot_reg
						And		i1.id_sin = r1.id_sin
						And     i1.id_i = r1.id_i
						And		i1.id_four = 'O2M'
						)		  
			    
			    )
			 )	


	Update sysadm.sinistre 
	Set    cpt_reg = cpt_reg + 1
	where  id_sin = @adcIdSin

	Select @dcIdReg = cpt_reg 
	From sysadm.sinistre 
	where id_sin = @adcIdSin

	Insert Into sysadm.reglement values ( 
	@adcIdSin,
	@dcIdReg,
	@adcMtAvoir,
	@asLibRM,
	Convert ( Varchar ( 20 ), Getdate(), 103 ),
	null, 
	null,
	null,
	null,
	@sCodInter,
	'C', 
	'RP',
	@dcIdInterRP,
	@dcIdRegBase,
	Getdate(),
	'ML',
	Getdate(),
	Getdate(),
	'ML',
	null
	)
	  
	Insert Into sysadm.reg_gti values ( 
	@adcIdSin,
	@dcIdReg,
	@dcIdGtiBase,
	@dcIdGtiBase,
	@dcIdInterRP,
	@adcMtAvoir,
	@adcMtAvoir,
	Getdate(),
	Getdate(),
	'ML'
	)


	Update sysadm.w_sin
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin

	Update sysadm.sinistre
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin

	Update sysadm.inter
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_i = @dcIdInterRP

	Update sysadm.w_inter
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_i = @dcIdInterRP

	Update sysadm.w_gar_sin
	Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
		mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_gti = @dcIdGtiBase

	Update sysadm.gar_sin
	Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
		mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_gti = @dcIdGtiBase


	Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

	If @iCtrle = 1 
	 Begin 
		Set @asResult = 'RP (sans mouvement fournisseur) de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
		Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) + '.'
		Set @asResult = @asResult + ' Suite vDoc ' + @sVdoc + ' du DCP le '+ @sDteVdoc + '.'
		Set @asResult = @asResult + 'Libellé du RP : ' + @asLibRM + '.'

		Set @sMess = @asResult 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT
			
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT			
		END
	 End

	Update sysadm.vDocRPAlice Set marquage = 1 Where id_seq = @iIdSeq
	
 End


While Exists ( Select * From sysadm.vDocRPAlice where marquage = 3 ) 
 Begin
 
	Select 	Top 1 
		@iIdSeq = id_seq,
		@adcIdSin = id_sin,
		@adcMtAvoir = mt,
		@asLibRM = lib
	From	sysadm.vDocRPAlice
	Where	marquage = 3

	Set @asResult = 'IMPOSSIBLE de passer le RP de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ sur le sinistre '+ Convert( Varchar ( 10) , @adcIdSin )  
	Set @asResult = @asResult + ' La vDoc ' + @sVdoc + ' du DCP du '+ @sDteVdoc + ' n''est donc pas traitée pour ce dossier'
	Set @asResult = @asResult + 'Libellé du RP demandé mais non traité : ' + @asLibRM + '.'

	Set @sMess = @asResult 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT
		
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT			
	END


	Update sysadm.vDocRPAlice Set marquage = 4 Where id_seq = @iIdSeq

 End
 

Set @sObjet    = 'Traitement vDoc' + @sVdoc
set @sMessage  = 'Bonjour Alice,' + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + 'Le traitement de la vDoc ' + @sVdoc + ' est passé cette nuit, vérifie en interrogeant quelques dossiers que tout soit bien ok pour toi.' + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CONVERT ( varchar ( 15 ), @iRPok ) + ' RP ont/a rééllement créé un RP sur SIMPA2 + un contact SHERPA.'
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CONVERT ( varchar ( 15 ), @iRPko ) + ' RP ont/a simplement créé un contact SHERPA faute de RN sur SIMPA2.'
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  

set @sMessage  = @sMessage + 'Jean-François,'

exec sysadm.PS_VDOC_RP_ALICE_EXTRACT_FICHIER @sFicOut OUTPUT

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'adumenil@spb.eu,jff@spb.fr,fpinon@spb.eu,cbailly@spb.eu,groupefacturation@spb.fr',
--		'jff@spb.fr',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL
Go

grant execute on sysadm.PS_VDOC_RP_ALICE_TRAITEMENT to rolebddsinistres
go


--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC_RP_ALICE_EXTRACT
-- Auteur               :       FPI
-- Date                 :       01/02/2016
-- Libellé              :        
-- Commentaires         :       Extraction du résultat de l'insertion de RP en masse
-- Références           :       [VDOC15707]
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC_RP_ALICE_EXTRACT' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC_RP_ALICE_EXTRACT
GO
CREATE PROCEDURE sysadm.PS_VDOC_RP_ALICE_EXTRACT
as

set NOCOUNT ON

Declare	@dtNow	datetime,
	@dtH1	datetime

set	@dtNow = getdate()
Set @dtH1  = dateadd(hour,-1,@dtNow)


Select	v.id_sin,
		v.mt,
		v.lib,
		'RP Réél'
from   sysadm.vDocRPAlice v,
	   sysadm.reglement r
where  r.id_sin = v.id_sin
and    r.mt_tot_reg = v.mt
and    r.cod_mot_reg = 'RP'
and    r.lib_reg = v.lib
and    r.cree_le between '26/01/2016 0:00' and '26/01/2016 04:00'
Union  
Select	v.id_sin,
		v.mt,
		v.lib,
		'Aucun RP, juste contact'
from   sysadm.vDocRPAlice v
Where Not exists (	
		Select Top 1 1
		From   sysadm.reglement r
		where  r.id_sin = v.id_sin
		and    r.mt_tot_reg = v.mt
		and    r.cod_mot_reg = 'RP'
		and    r.lib_reg = v.lib
		and    r.cree_le between @dtH1 and @dtNow
)


GO

grant execute on sysadm.PS_VDOC_RP_ALICE_EXTRACT to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC_RP_ALICE_EXTRACT_FICHIER
-- Auteur               :       FPI
-- Date                 :       01/02/2016
-- Libellé              :        
-- Commentaires         :       Extraction du résultat de l'insertion de RP en masse
-- Références           :       [VDOC15707]
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC_RP_ALICE_EXTRACT_FICHIER' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC_RP_ALICE_EXTRACT_FICHIER
GO

CREATE PROCEDURE sysadm.PS_VDOC_RP_ALICE_EXTRACT_FICHIER
	@sFicOut varchar(255) OUTPUT
as

Declare @dDateJour	datetime,
	@sCommande	VarChar(250)

set NOCOUNT ON

SET @dDateJour = GetDate()

SET @sFicOut = master.sysadm.SPB_FN_GET_ROOT()+ 'Sinistre\Export_vDOC_RP_Alice\Export_vDOC_RP_Alice_' + 
               CONVERT (char(4), DatePart (year,@dDateJour)  ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(month,@dDateJour) ),  2 ) + '-' +
               RIGHT ( '00' + CONVERT (varchar(2),DatePart(day,@dDateJour ) ),  2 ) + '.Xls'


SET @sCommande = 'sqlcmd /S' + @@servername + ' /E /Q"' + 
            'SIMPA2_PRO.sysadm.PS_VDOC_RP_ALICE_EXTRACT " /o ' 
			+ @sFicOut + ' -s"	" -w5000 -u' 
EXEC master.dbo.xp_cmdshell @sCommande, no_output

GO
grant execute on sysadm.PS_VDOC_RP_ALICE_EXTRACT_FICHIER to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procédure            :       PS_VDOC_RP_ALICE 
-- Auteur               :       FPI
-- Date                 :       02/02/2016
-- Libellé              :        
-- Commentaires         :       Insertion de RP en masse
-- Références           :       
--
-- Arguments            :       Rien
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_VDOC_RP_ALICE_V01' AND type = 'P' )
        DROP procedure sysadm.PS_VDOC_RP_ALICE_V01
GO


CREATE procedure sysadm.PS_VDOC_RP_ALICE_V01
	@sVdoc VarChar ( 20 ),
	@sDteVdoc VarChar ( 20 )
As


DECLARE @sMessage    Varchar(1000),
	    @sObjet      VarChar(255),
	    @sRetourErrMail VarChar(255),
		@sFicOut varchar(255),
	    @iRPok integer,
	    @iRPko integer

Update sysadm.vDocRPAlice
Set marquage = 3
from sysadm.vDocRPAlice vd
where not exists ( 
		Select 1
		From sysadm.reglement r,
			  sysadm.inter i
		Where r.id_sin = vd.id_sin
		And   r.cod_mode_reg = 'FM'
		And   i.id_sin = r.id_sin
		And   i.id_i = r.id_i
		And   i.id_four in ( 'O2M', 'PSM' )
	 )
	and marquage=0

Select @iRPok = COUNT(*)
From   sysadm.vDocRPAlice
Where  marquage = 0

Select @iRPko = COUNT(*)
From   sysadm.vDocRPAlice
Where  marquage = 3

If @iRPok is null set @iRPok = 0
If @iRPko is null set @iRPko = 0


Declare 
	@adcIdSin		Decimal ( 10 ), -- [PI062]
	@aiIdSeq		Integer,
	@asIdFour		VarChar ( 3 ),
	@adcMtAvoir		Decimal (11, 2 ),
	@asLibRM		VarChar ( 35 ),
	@asResult		Varchar ( 255 ) 

Declare @dcIdInterRP Decimal (7)
Declare @dcIdRegBase Decimal (7)
Declare @dcIdReg Decimal (7)
Declare @dcIdGtiBase Decimal (7)
Declare @sCodInter Varchar ( 1 )
Declare @sCodModeReg Varchar ( 5 )
Declare @iCtrle Integer
Declare @sMess Varchar ( 255 )
Declare @iIdCt Integer
Declare @dcMtTotReg Decimal (11,2)
Declare @dcSomRMPrecedent Decimal (11,2)
Declare @sIdFourCtrle Varchar ( 3 )

Declare @iNbre  Integer
Declare @iIdSeq integer
Declare @iCpt integer


While Exists ( Select * From sysadm.vDocRPAlice where marquage = 0 ) 
 Begin
 
	Select 	Top 1 
		@iIdSeq = id_seq,
		@adcIdSin = id_sin,
		@adcMtAvoir = mt,
		@asLibRM = lib
	From	sysadm.vDocRPAlice
	Where	marquage = 0

	Select  Top 1
			@dcIdRegBase = r.id_reg,
			@sCodInter = r.cod_inter,
			@dcIdInterRP = r.id_i,
			@sCodModeReg = r.cod_mode_reg,
			@dcIdGtiBase = d.id_gti,
			@dcMtTotReg = r.mt_tot_reg,
			@sIdFourCtrle = i.id_four
			
	From	sysadm.reglement r,
			sysadm.inter i,
			sysadm.detail d
			
	Where   r.id_sin = @adcIdSin
	And     r.cod_mode_reg = 'FM'
	And     r.cod_mot_reg = 'RN'
	And		d.id_sin = r.id_sin
	And		d.id_reg = r.id_reg
	And		i.id_sin = r.id_sin
	And     i.id_i = r.id_i

	And		( 
				i.id_four = 'O2M'
			 Or
			    ( i.id_four = 'PSM'
				  And		
				  Not Exists ( 
						Select 1
						From	sysadm.reglement r1,
								sysadm.inter i1
						Where   r1.id_sin = r.id_sin
						And     r1.cod_mode_reg = r.cod_mode_reg
						And     r1.cod_mot_reg = r.cod_mot_reg
						And		i1.id_sin = r1.id_sin
						And     i1.id_i = r1.id_i
						And		i1.id_four = 'O2M'
						)		  
			    
			    )
			 )	


	Update sysadm.sinistre 
	Set    cpt_reg = cpt_reg + 1
	where  id_sin = @adcIdSin

	Select @dcIdReg = cpt_reg 
	From sysadm.sinistre 
	where id_sin = @adcIdSin

	Insert Into sysadm.reglement values ( 
	@adcIdSin,
	@dcIdReg,
	@adcMtAvoir,
	@asLibRM,
	Convert ( Varchar ( 20 ), Getdate(), 103 ),
	null, 
	null,
	null,
	null,
	@sCodInter,
	'C', 
	'RP',
	@dcIdInterRP,
	@dcIdRegBase,
	Getdate(),
	'ML',
	Getdate(),
	Getdate(),
	'ML',
	null
	)
	  
	Insert Into sysadm.reg_gti values ( 
	@adcIdSin,
	@dcIdReg,
	@dcIdGtiBase,
	@dcIdGtiBase,
	@dcIdInterRP,
	@adcMtAvoir,
	@adcMtAvoir,
	Getdate(),
	Getdate(),
	'ML'
	)


	Update sysadm.w_sin
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin

	Update sysadm.sinistre
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin

	Update sysadm.inter
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_i = @dcIdInterRP

	Update sysadm.w_inter
	Set mt_reg = mt_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_i = @dcIdInterRP

	Update sysadm.w_gar_sin
	Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
		mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_gti = @dcIdGtiBase

	Update sysadm.gar_sin
	Set mt_nplaf_reg = mt_nplaf_reg + @adcMtAvoir,
		mt_plaf_reg  = mt_plaf_reg + @adcMtAvoir
	Where id_sin = @adcIdSin
	and   id_gti = @dcIdGtiBase


	Select @iCtrle = COUNT ( * ) From sysadm.reglement where id_sin = @adcIdSin and id_reg = @dcIdReg 

	If @iCtrle = 1 
	 Begin 
		Set @asResult = 'RP (sans mouvement fournisseur) de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ passé sur le sinistre ' + Convert( Varchar ( 10) , @adcIdSin )  
		Set @asResult = @asResult + ' et sur l''id_reg ' + CONVERT ( VarChar ( 10 ), @dcIdReg ) + '.'
		Set @asResult = @asResult + ' Suite vDoc ' + @sVdoc + ' du DCP le '+ @sDteVdoc + '.'
		Set @asResult = @asResult + 'Libellé du RP : ' + @asLibRM + '.'

		Set @sMess = @asResult 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT
			
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT			
		END
	 End

	Update sysadm.vDocRPAlice Set marquage = 1 Where id_seq = @iIdSeq
	
 End


While Exists ( Select * From sysadm.vDocRPAlice where marquage = 3 ) 
 Begin
 
	Select 	Top 1 
		@iIdSeq = id_seq,
		@adcIdSin = id_sin,
		@adcMtAvoir = mt,
		@asLibRM = lib
	From	sysadm.vDocRPAlice
	Where	marquage = 3

	Set @asResult = 'IMPOSSIBLE de passer le RP de ' + CONVERT ( VarChar ( 20), @adcMtAvoir )+ '€ sur le sinistre '+ Convert( Varchar ( 10) , @adcIdSin )  
	Set @asResult = @asResult + ' La vDoc ' + @sVdoc + ' du DCP du '+ @sDteVdoc + ' n''est donc pas traitée pour ce dossier'
	Set @asResult = @asResult + 'Libellé du RP demandé mais non traité : ' + @asLibRM + '.'

	Set @sMess = @asResult 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT
		
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'ML', 300, @iIdCt OUTPUT			
	END


	Update sysadm.vDocRPAlice Set marquage = 4 Where id_seq = @iIdSeq

 End
 

Set @sObjet    = 'Traitement vDoc' + @sVdoc
set @sMessage  = 'Bonjour Alice,' + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + 'Le traitement de la vDoc ' + @sVdoc + ' est passé cette nuit, vérifie en interrogeant quelques dossiers que tout soit bien ok pour toi.' + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CONVERT ( varchar ( 15 ), @iRPok ) + ' RP ont/a rééllement créé un RP sur SIMPA2 + un contact SHERPA.'
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CONVERT ( varchar ( 15 ), @iRPko ) + ' RP ont/a simplement créé un contact SHERPA faute de RN sur SIMPA2.'
set @sMessage  = @sMessage + CHAR ( 10 )  
set @sMessage  = @sMessage + CHAR ( 10 )  

set @sMessage  = @sMessage + 'Jean-François,'

exec sysadm.PS_VDOC_RP_ALICE_EXTRACT_FICHIER @sFicOut OUTPUT

EXEC master.dbo.SPB_PS_MAIL 
		@sRetourErrMail OUTPUT, 
		'adumenil@spb.eu,jff@spb.fr,fpinon@spb.eu',
--		'jff@spb.fr',
		@sMessage, 
		@sObjet, 
		'', 
		'', 
		@sFicOut, 
		NULL, 
		NULL, 
		NULL, 
		NULL

Go
