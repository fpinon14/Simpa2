-------------------------------------------------------------------
--
-- Fichier              :       W_DIV_SIN.CP
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
--
-- Commentaires         :       Gestion de la table W_DIV_SIN
--
-- Procédures           :       
-- DW_S01_W_DIV_SIN
-- PS_I01_W_DIV_SIN_WKF
-- PS_I02_W_DIV_SIN     
-- PS_I03_W_DIV_SIN  FS  24/10/2007 ( Sherpa ) Insertion W_DIV_SIN selon un élément paramétré sur DIV_PRO
-- PS_I_DIV_SIN_SANS_DIV_PRO
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_DIV_SIN
-- Auteur               :       FABRY JF
-- Date                 :       15/06/2004
-- Libellé              :        
-- Commentaires         :       Select sur la table W_DIV_SIN
-- Références           :       Utilise dans W_TM_SP_SINISTRE (Liste d‚tail)
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_DIV_SIN
GO

CREATE procedure sysadm.DW_S01_W_DIV_SIN
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

Select 
	id_sin,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	alt_prot,
	cpt_tri,
	val_nbre,
	val_mt,
	val_dte,
	val_car,
	'N',
	cpt_valide,
	cree_le,
	maj_le,
	maj_par
From 	sysadm.w_div_sin
Where	id_sin = @dcIdSin

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I01_W_DIV_SIN_WKF
-- Auteur               :       FABRY JF
-- Date                 :       18/06/2004
-- Libellé              :        
-- Commentaires         :       Insertion dans W_DIV_SIN       
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-- MAJ			: 31/10/2003	JFF	Ajout colonne mt_val_achat
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_W_DIV_SIN_WKF' AND type = 'P' )
        DROP procedure sysadm.PS_I01_W_DIV_SIN_WKF
GO

CREATE procedure sysadm.PS_I01_W_DIV_SIN_WKF
        @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS

 
INSERT INTO    sysadm.w_div_sin
(       w_div_sin.id_sin,
	w_div_sin.nom_zone,
	w_div_sin.lib_label,
	w_div_sin.id_typ_liste,
	w_div_sin.alt_liste_codecar,
	w_div_sin.id_typ_zone,
	w_div_sin.alt_oblig,
	w_div_sin.alt_prot,
	w_div_sin.cpt_tri,
	w_div_sin.val_nbre,
	w_div_sin.val_mt,
	w_div_sin.val_dte,
	w_div_sin.val_car,
	w_div_sin.cpt_valide,
	w_div_sin.cree_le,	
	w_div_sin.maj_le,		
	w_div_sin.maj_par	
	)

SELECT  div_sin.id_sin,
	div_sin.nom_zone,
	div_sin.lib_label,
	div_sin.id_typ_liste,
	div_sin.alt_liste_codecar,
	div_sin.id_typ_zone,
	div_sin.alt_oblig,
	div_sin.alt_prot,
	div_sin.cpt_tri,
	div_sin.val_nbre,
	div_sin.val_mt,
	div_sin.val_dte,
	div_sin.val_car,
	1,
	div_sin.cree_le,
	div_sin.maj_le,
	div_sin.maj_par
FROM    sysadm.div_sin

WHERE   div_sin.id_sin   = @dcIdSin

Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_I02_W_DIV_SIN
-- Auteur               :       FABRY JF
-- Date                 :       18/01/2005
-- Libellé              :        
-- Commentaires         :       Insertion temporaire dans W_DIV_SIN (cas de gestion à mémoriser)
--                              l'enregistrement sera delete lors de la validation finale.
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin                        Decimal (  7,0 )        (Val)
--                              @sCasGestion		        VarChar ( 50 ),
--                              @sIdOper                        VarChar ( 4 )
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I02_W_DIV_SIN
GO

CREATE procedure sysadm.PS_I02_W_DIV_SIN
        @dcIdSin                       Decimal (  10,0 ), -- [PI062]
        @sCasGestion		       VarChar ( 50 ),
        @sIdOper                       VarChar ( 4 )
AS

Delete From sysadm.w_div_sin
Where  id_sin = @dcIdSin
And    nom_zone = 'zn_tmp_cas_gestion'
 
INSERT INTO    sysadm.w_div_sin
(       w_div_sin.id_sin,
        w_div_sin.nom_zone,
        w_div_sin.lib_label,
        w_div_sin.id_typ_liste,
        w_div_sin.alt_liste_codecar,
        w_div_sin.id_typ_zone,
        w_div_sin.alt_oblig,
        w_div_sin.alt_prot,
        w_div_sin.cpt_tri,
        w_div_sin.val_nbre,
        w_div_sin.val_mt,
        w_div_sin.val_dte,
        w_div_sin.val_car,
        w_div_sin.cpt_valide,
        w_div_sin.cree_le,      
        w_div_sin.maj_le,               
        w_div_sin.maj_par       
        )

VALUES
(
        @dcIdSin,
        'zn_tmp_cas_gestion',
        'Cas de gestion à mémoriser',
        '-1',
        'N',
        'C',
        'N',
        'O',
        50,
        null,
        null,
        null,
        @sCasGestion,
        0,
        GetDate (),
        GetDate (),               
        @sIdOper
        )

Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_D01_W_DIV_SIN
-- Auteur               :       FABRY JF
-- Date                 :       18/01/2005
-- Libellé              :        
-- Commentaires         :       Suppression zone tempo sur W_Div_Sin
-- Références           :       Utilisé dans W_T_SP_CREE_TRAVAIL
--
-- Arguments            :       @dcIdSin                        Decimal (  7,0 )        (Val)
--                              @sNomzone                       VarChar ( 35 ),
--
-- Retourne             :       Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_D01_W_DIV_SIN
GO

CREATE procedure sysadm.PS_D01_W_DIV_SIN
        @dcIdSin                       Decimal (  10,0 ), -- [PI062]
        @sNomZone                      VarChar ( 35 )
AS

Delete From sysadm.w_div_sin
Where  id_sin = @dcIdSin
And    nom_zone = @sNomZone

Delete From sysadm.div_sin
Where  id_sin = @dcIdSin
And    nom_zone = @sNomZone
 
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I03_W_DIV_SIN
-- Auteur               :       FS
-- Date                 :       24/10/2007
-- Libellé              :        
-- Commentaires         :       Insertion W_DIV_SIN selon un élément paramétré sur DIV_PRO
-- Références           :       Utilisé dans SHERPA
--
-- Arguments            :       @dcIdSin                        Decimal (  7,0 )        (Val)
--                              @sCasGestion		        VarChar ( 50 ),
--                              @sIdOper                        VarChar ( 4 )
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- 	FPI	08/11/2011	[ITSM87939]
--  JFF 12/02/2016  [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I03_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.PS_I03_W_DIV_SIN
GO

CREATE procedure sysadm.PS_I03_W_DIV_SIN
        @dcIdProd       Decimal ( 7,0 ), -- Code Produit.
        @dcIdSin        Decimal ( 10,0 ), -- Référence sinistre. -- [PI062]
        @sNomZone       Varchar ( 35 ) , -- Nom de la zone à reporter. 
        @sValeur        VarChar ( 35 ) , -- Valeur à reporter
        @sMajPar        Varchar ( 4 )    -- Opérateur
AS

Declare @iRet Integer

INSERT INTO sysadm.w_div_sin 
		( 	id_sin, 
			nom_zone, 
			lib_label, 
			id_typ_liste, 
			alt_liste_codecar, 
			id_typ_zone, 
			alt_oblig, 
			alt_prot, 
			cpt_tri, 
			val_nbre, 
			val_mt, 
			val_dte, 
			val_car, 
			cpt_valide, 
			cree_le, 
			maj_le, 
			maj_par )

	Select
		@dcIdSin        as id_sin, 
	   dp.nom_zone , 
	   dp.lib_label,
	   dp.id_typ_liste,
	   dp.alt_liste_codecar,
	   dp.id_typ_zone, 
	   dp.alt_oblig,
      'N'             as alt_prot,
		dp.cpt_tri,

		-- Valeur nombre ( integer )

		Case 
			When dp.id_typ_zone = 'LN' Then Convert( integer, @sValeur )
			When dp.id_typ_zone = 'N'  Then Convert( integer, @sValeur )
			Else null
      End             as val_nbre,

		-- Valeur montant ( décimal )

		Case
			When dp.id_typ_zone = 'S' Then Convert ( Decimal(11,2 ), @sValeur )
         When dp.id_typ_zone = 'P' Then Convert ( Decimal(11,2 ), @sValeur ) / 100
         Else null
		End             as val_mt,

		-- Valeur date

		Case 
			When dp.id_typ_zone = 'D' Then Convert( Datetime, @sValeur )
			Else null
      End             as val_dte,

		-- Valeur chaîne ( char )

		Case 
			When dp.id_typ_zone in ( 'C', 'LC', 'X'  )Then @sValeur
			Else null
      End             as val_dte,

		0               as cpt_valide,
		getdate(),
		getdate(), 
		@sMajPar	
   From sysadm.div_pro dp
   Where
         dp.id_prod = @dcIdProd And
         dp.nom_zone = @sNomZone
	 and not exists (select * from sysadm.w_div_sin where id_sin=@dcIdSin and nom_zone=@sNomZone) -- [ITSM87939]
	 
	Set @iRet = @@error

   Return @iRet

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_I01_W_DIV_SIN
-- Auteur               :       FPI
-- Date                 :       24/12/2010
-- Libell‚              :       
-- Commentaires         :       Insertion dans w_div_sin
-- R‚f‚rences           :       W_TM_SP_SINISTRE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @sNomZone        Varchar( 35 )        (Val)
--				...
--
-- Retourne             :       Rien
---------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_DIV_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_DIV_SIN
GO

CREATE procedure sysadm.DW_I01_W_DIV_SIN
        @dcIdSin        	Decimal (  10,0 ), -- [PI062]
	@sNomZone       	Varchar( 35 ),
	@sLibLabel		Varchar(35),
        @sIdTypListe 		Varchar(5),
        @sAltListeCodecar 	Varchar(1),
        @sIdTypZone 		Varchar(3),
        @sAltOblig 		Varchar(1),
        @sAltProt 		Varchar(1),
        @iCptTri 		int,
        @iValNbre 		int,
        @dcValMt 		decimal(11,2),
        @dtValDte 		datetime,
        @sValCar 		Varchar(35),
        @dtCreeLe 		datetime,
        @dtMajLe 		datetime,
        @sMajPar 		Varchar(4)
AS
INSERT INTO sysadm.w_div_sin
           (id_sin,nom_zone,
           lib_label,id_typ_liste,alt_liste_codecar,
           id_typ_zone,alt_oblig,alt_prot,cpt_tri,
           val_nbre,val_mt,val_dte,val_car,cpt_valide,
           cree_le,maj_le,maj_par)
     VALUES
           (@dcIdSin, @sNomZone, 
           @sLibLabel, @sIdTypListe, @sAltListeCodecar, 
	   @sIdTypZone, @sAltOblig, @sAltProt, @iCptTri, 
           @iValNbre, @dcValMt, @dtValDte, @sValCar, 0, 
	   @dtCreeLe, @dtMajLe, @sMajPar)
GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_I_W_DIV_SIN_PM103
-- Auteur               :       FABRY JF
-- Date                 :       24/05/2012
-- Libellé              :       [PM103] 
-- Commentaires         :       Insertion temporaire dans W_DIV_SIN (cas de gestion à mémoriser)
--                              l'enregistrement sera delete lors de la validation finale.
-- Références           :       
--
-- Arguments            :       @dcIdSin                        Decimal (  7,0 )        (Val)
--                              @sCasGestion		        VarChar ( 50 ),
--                              @sIdOper                        VarChar ( 4 )
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_W_DIV_SIN_PM103' AND type = 'P' )
        DROP procedure sysadm.PS_I_W_DIV_SIN_PM103
GO

CREATE procedure sysadm.PS_I_W_DIV_SIN_PM103
        @dcIdSin                       Decimal (  10,0 ), -- [PI062]
        @sIdOper                       VarChar ( 4 )
AS

Delete From sysadm.w_div_sin
Where  id_sin = @dcIdSin
And    nom_zone = 'zn_tmp_PM103_1'
 
INSERT INTO    sysadm.w_div_sin
(       w_div_sin.id_sin,
        w_div_sin.nom_zone,
        w_div_sin.lib_label,
        w_div_sin.id_typ_liste,
        w_div_sin.alt_liste_codecar,
        w_div_sin.id_typ_zone,
        w_div_sin.alt_oblig,
        w_div_sin.alt_prot,
        w_div_sin.cpt_tri,
        w_div_sin.val_nbre,
        w_div_sin.val_mt,
        w_div_sin.val_dte,
        w_div_sin.val_car,
        w_div_sin.cpt_valide,
        w_div_sin.cree_le,      
        w_div_sin.maj_le,               
        w_div_sin.maj_par       
        )

VALUES
(
        @dcIdSin,
        'zn_tmp_PM103_1',
        'Validation sous mode reprise B.Manu',
        '-1',
        'N',
        'X',
        'N',
        'O',
        50,
        null,
        null,
        null,
        'O',
        0,
        GetDate (),
        GetDate (),               
        @sIdOper
        )

Return @@Error

GO
--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_FRANCHISE 
-- Auteur               :       FPI
-- Date                 :       28/12/2012
-- Libellé              :        
-- Commentaires         :       [PC801]       
-- Références           :       Appelé depuis Sherpa
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_FRANCHISE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_FRANCHISE
GO

CREATE procedure sysadm.PS_S01_FRANCHISE
        @dcIdSin                       Decimal (  10,0 ), -- [PI062]
        @sAltFranchise                 VarChar ( 1 ) OUTPUT
AS
	
	Set @sAltFranchise='X'
		
	Select @sAltFranchise=isnull(val_car,'N')
	From sysadm.w_sin s
	inner join sysadm.div_pro d on d.id_prod=s.id_prod
	left outer join sysadm.w_div_sin w on w.id_sin=s.id_sin and d.nom_zone=w.nom_zone
	Where s.id_sin=@dcIdSin 
		And d.nom_zone='franchise_paybox'
	
	If @@RowCount=0
	Begin
		Select @sAltFranchise=isnull(val_car,'N')
	From sysadm.sinistre s
		inner join sysadm.div_pro d on d.id_prod=s.id_prod
		left outer join sysadm.div_sin w on w.id_sin=s.id_sin and d.nom_zone=w.nom_zone
	Where s.id_sin=@dcIdSin 
		And d.nom_zone='franchise_paybox'
	End

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_VAL_W_DIV_SIN 
-- Auteur               :       JFF
-- Date                 :       10/05/2013
-- Libellé              :        
-- Commentaires         :       [PC938_ORANGE_V3]  
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VAL_W_DIV_SIN_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_VAL_W_DIV_SIN_V01
GO

CREATE procedure sysadm.PS_S_VAL_W_DIV_SIN_V01
        @dcIdSin     Decimal (  10,0 ), -- [PI062]
        @sNomZone	 VarChar ( 35 ),
        @sVal		 VarChar ( 35 ) OUTPUT,
        @dtMajLe	 DateTime OUTPUT
AS

	Select  @sVal =
			rTrim (
			IsNull ( CONVERT ( VarChar (35), ws.val_nbre ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_mt ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_dte , 103 ), '' ) +
			IsNull ( CONVERT ( VarChar (35), ws.val_car ), '' ) ),
			@dtMajLe = ws.maj_le
	From	sysadm.w_div_sin ws
	Where   ws.id_sin = @dcIdSin
	And     ws.nom_zone = @sNomZone

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I_DIV_SIN_SANS_DIV_PRO
-- Auteur               :       JFF
-- Date                 :       25/10/2024
-- Libellé              :        
-- Commentaires         :        
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DIV_SIN_SANS_DIV_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_I_DIV_SIN_SANS_DIV_PRO
GO

CREATE procedure sysadm.PS_I_DIV_SIN_SANS_DIV_PRO
        @adcIdSin        Decimal ( 10,0 ),-- Référence sinistre. -- [PI062]
        @asNomZone       Varchar ( 35 ) , -- Nom technique de la zone
		@asLibZone		 Varchar ( 35 ) , -- libellé d'affichage de la zone
        @asValeur        VarChar ( 35 ) , -- Valeur à reporter
		@asAltProteger   VarChar ( 1 ),   -- O : Donnée protégée (non modifiable), 'N' ou null sinon
		@asTypValeur     VarChar ( 2 ),   -- Voir tableau
		@aiRangTri		 Integer,         -- Tri (null=Tri Auto)
        @asMajPar        Varchar ( 4 )    -- Opérateur (null=AUTO)
AS

/* Type Valeur
N : nombre entier
C : Chaine car
X : Case à cocher
S : Somme décimal
D : DateTime
*/

Declare @iCptValide Integer

Set @iCptValide = 0

Set @asNomZone = lTrim ( rTrim ( @asNomZone ))
Set @asLibZone = lTrim ( rTrim ( @asLibZone ))
Set @asValeur = lTrim ( rTrim ( @asValeur ))

If @asMajPar is null Set @asMajPar = 'AUTO'
If @asAltProteger is null Set @asAltProteger = 'N'
If @asAltProteger <> 'O' Set @asAltProteger = 'N'
If @asTypValeur is null Set @asTypValeur = 'C'
If @asTypValeur  = '' Set @asTypValeur = 'C'
If @aiRangTri <= 0 Set @aiRangTri = null 


If @aiRangTri is null 
	Begin
		Select @aiRangTri = IsNull ( Max ( cpt_tri ), 100 ) + 10
		From sysadm.w_div_sin wds
		Where wds.id_sin = @adcIdSin 

		If @aiRangTri Is Null 
			Begin
				Select @aiRangTri = IsNull ( Max ( cpt_tri ), 100 ) + 10
				From sysadm.div_sin wds
				Where wds.id_sin = @adcIdSin 
			End 

		If @aiRangTri Is Null Set @aiRangTri = 110

	End 

If Exists ( Select Top 1 1 From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	Begin
		Set @iCptValide = 1

		If Exists ( Select Top 1 1 From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @asNomZone)
			Begin
				Update sysadm.div_sin 
				Set alt_prot = @asAltProteger,
					cpt_tri = @aiRangTri,
					val_nbre =	Case @asTypValeur 
									When 'N' Then Convert ( integer, @asValeur )
									Else null
								End,
					val_mt =	Case @asTypValeur 
									When 'S' Then Convert ( decimal (11,2), @asValeur ) 
									Else null
								End,
					val_dte =	Case @asTypValeur 
									When 'D' Then Convert ( datetime, @asValeur ) 
									Else null
								End,
					val_car =	Case @asTypValeur 
									When 'C' Then @asValeur  
									When 'X' Then @asValeur  
									Else null
								End,
					maj_le  = Getdate(),
					maj_par = @asMajPar
			End 
		Else
			Begin	 
				Insert into sysadm.div_sin 
				(
					   [id_sin]
					  ,[nom_zone]
					  ,[lib_label]
					  ,[id_typ_liste]
					  ,[alt_liste_codecar]
					  ,[id_typ_zone]
					  ,[alt_oblig]
					  ,[alt_prot]
					  ,[cpt_tri]
					  ,[val_nbre]
					  ,[val_mt]
					  ,[val_dte]
					  ,[val_car]
					  ,[cree_le]
					  ,[maj_le]
					  ,[maj_par]
					  ,[valide_le]
					  ,[valide_par]
				)
				values 
				( 
						@adcIdSin, 
						@asNomZone, 
						@asLibZone, 
						'-1', 
						'N', 
						@asTypValeur, 
						'N', 
						@asAltProteger, 
						@aiRangTri, 

						Case @asTypValeur 
							When 'N' Then Convert ( integer, @asValeur )
							Else null
						End,
						Case @asTypValeur 
							When 'S' Then Convert ( decimal (11,2), @asValeur ) 
							Else null
						End,
						Case @asTypValeur 
							When 'D' Then Convert ( datetime, @asValeur ) 
							Else null
						End,
						Case @asTypValeur 
							When 'C' Then @asValeur  
							When 'X' Then @asValeur  
							Else null
						End,
						getdate(), 
						getdate(), 
						@asMajPar,
						getdate(), 
						@asMajPar
	
				) 
			End
	End


If Exists ( Select Top 1 1 From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	Begin
	If Exists ( Select Top 1 1 From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @asNomZone )
		Begin
			Update sysadm.w_div_sin 
			Set alt_prot = @asAltProteger,
				cpt_tri  = @aiRangTri,
				val_nbre =	Case @asTypValeur 
								When 'N' Then Convert ( integer, @asValeur )
								Else null
							End,
				val_mt =	Case @asTypValeur 
								When 'S' Then Convert ( decimal (11,2), @asValeur ) 
								Else null
							End,
				val_dte =	Case @asTypValeur 
								When 'D' Then Convert ( datetime, @asValeur ) 
								Else null
							End,
				val_car =	Case @asTypValeur 
								When 'C' Then @asValeur  
								When 'X' Then @asValeur  
								Else null
							End,
				maj_le  = Getdate(),
				maj_par = @asMajPar
	
			Where id_sin = @adcIdSin And nom_zone = @asNomZone
		End 
	Else
		Begin	 
			Insert into sysadm.w_div_sin 
			(
				   [id_sin]
				  ,[nom_zone]
				  ,[lib_label]
				  ,[id_typ_liste]
				  ,[alt_liste_codecar]
				  ,[id_typ_zone]
				  ,[alt_oblig]
				  ,[alt_prot]
				  ,[cpt_tri]
				  ,[val_nbre]
				  ,[val_mt]
				  ,[val_dte]
				  ,[val_car]
				  ,[cpt_valide]
				  ,[cree_le]
				  ,[maj_le]
				  ,[maj_par]
			)
			values 
			( 
					@adcIdSin, 
					@asNomZone, 
					@asLibZone, 
					'-1', 
					'N', 
					@asTypValeur, 
					'N', 
					@asAltProteger, 
					@aiRangTri, 

					Case @asTypValeur 
						When 'N' Then Convert ( integer, @asValeur )
						Else null
					End,
					Case @asTypValeur 
						When 'S' Then Convert ( decimal (11,2), @asValeur ) 
						Else null
					End,
					Case @asTypValeur 
						When 'D' Then Convert ( datetime, @asValeur ) 
						Else null
					End,
					Case @asTypValeur 
						When 'C' Then @asValeur  
						When 'X' Then @asValeur  
						Else null
					End,

					@iCptValide, 
					getdate(), 
					getdate(), 
					@asMajPar
			
			) 
		End
	End


Go

