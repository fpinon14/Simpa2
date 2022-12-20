-------------------------------------------------------------------
--
-- Fichier              :   Carte.cp
-- Auteur               :   YP
-- Date                 :   14/08/97 09:28:18
--
-- Commentaires         :   Liste des procédure de gestion des cartes.
--
-- Procédures           :
-- Fonctions            :   IM_S01_CARTE
--                          IM_S02_CARTE
--                          IM_S03_CARTE
--                          IM_S04_CARTE
--                          DW_S01_CARTE
--                          DW_I01_CARTE
--                          DW_D01_CARTE
--                          PS_S01_CARTE_SINISTRE
--			    PS_S02_GENERE_CARTE_ECBLEU
--                          IM_S05_CARTE
-------------------------------------------------------------------

If NOT EXISTS ( SELECT cpt_val FROM sysadm.parametre WHERE ref_cpt='ID_CARTE' )
       INSERT INTO sysadm.parametre SELECT 'ID_CARTE', ISNULL ( MAX ( id_carte ), 0), -1 FROM sysadm.carte
GO

-------------------------------------------------------------------
--
-- Procédure            :   IM_S01_CARTE
-- Auteur               :   YP
-- Date                 :   13/08/97 14:32:27
-- Libellé              :   Permet de savoir si le groupe que l'on desire supprimer
--                          n'est pas lie à une carte.
-- Commentaires         :
-- Références           :   Appelé par l'User Object U_SP_GS_GROUPECARTE dans la
--                          fonction Uf_Gs_GroupeCarte()
--
-- Arguments            :   @dcIdGrp      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :   Le nombre de lignes existantes
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_CARTE' AND type = 'P' )
            DROP procedure sysadm.IM_S01_CARTE
GO

CREATE PROC sysadm.IM_S01_CARTE
  @dcIdGrp  decimal ( 7, 0 )
AS

  SELECT sysadm.carte.id_grp
    FROM sysadm.carte
   WHERE sysadm.carte.id_grp  = @dcIdGrp

  RETURN @@ROWCOUNT

GO

-------------------------------------------------------------------
--
-- Procédure            :   IM_S02_CARTE
-- Auteur               :   YP
-- Date                 :   04/09/97 14:32:27
-- Libellé              :   Permet de savoir si la carte chevauche une plage existante.
--
-- Commentaires         :
-- Références           :   Appelé par l'User Object U_SP_GS_CARTE dans la
--                          fonction Uf_Gs_Chevaucher()
--
-- Arguments            :   @dcIdCarte      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :   Le nombre de ligne existante
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S02_CARTE' AND type = 'P' )
            DROP procedure sysadm.IM_S02_CARTE
GO

CREATE PROC sysadm.IM_S02_CARTE
  @dcIdCarte  decimal ( 7, 0 ),
  @sRangMini  Varchar ( 19 ),
  @sRangMaxi  Varchar ( 19 )
AS

 SELECT sysadm.carte.id_carte
 FROM   sysadm.carte
 WHERE  sysadm.carte.val_rg_mini >= @sRangMini AND 
        sysadm.carte.val_rg_mini <= @sRangMaxi AND
        sysadm.carte.id_carte    <> @dcIdCarte

  RETURN @@ROWCOUNT

GO


-------------------------------------------------------------------
--
-- Procédure            :   IM_S03_CARTE
-- Auteur               :   YP
-- Date                 :   04/09/97 14:32:27
-- Libellé              :   Permet de savoir si la carte chevauche une plage existante.
--
-- Commentaires         :
-- Références           :   Appelé par l'User Object U_SP_GS_CARTE dans la
--                          fonction Uf_Gs_Chevaucher()
--
-- Arguments            :   @dcIdCarte      decimal ( 7, 0 ) ( Val )
--
-- Retourne             :   Le nombre de ligne existante
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S03_CARTE' AND type = 'P' )
            DROP procedure sysadm.IM_S03_CARTE
GO

CREATE PROC sysadm.IM_S03_CARTE
           @dcIdCarte  decimal ( 7, 0 ),
           @sRangMini  Varchar ( 19 ),
           @sRangMaxi  Varchar ( 19 )
AS

 SELECT sysadm.carte.id_carte
 FROM   sysadm.carte
 WHERE  sysadm.carte.val_rg_max >= @sRangMini AND 
        sysadm.carte.val_rg_max <= @sRangMaxi AND
        sysadm.carte.id_carte   <> @dcIdCarte

  RETURN @@ROWCOUNT

GO

-------------------------------------------------------------------
--
-- Procédure            :       IM_S04_CARTE
-- Auteur               :       YP
-- Date                 :       04/09/97 14:32:27
-- Libellé              :       permet de savoir si le type de carte supprimée est utilisé par une carte.
--
-- Commentaires         :
-- Références           :       Appelé par l'User Object U_SP_GS_TYPE_CARTE dans la
--                              fonction Uf_Gs_Sup_Type_Carte()
--
-- Arguments            :       @sIdTypeCarte      String ( Val )
--
-- Retourne             :       Le nombre de ligne existante
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S04_CARTE' AND type = 'P' )
            DROP procedure sysadm.IM_S04_CARTE
GO

CREATE PROC sysadm.IM_S04_CARTE
            @sIdTypeCarte  Varchar ( 3 ) 
AS

 SELECT sysadm.carte.id_carte
 FROM   sysadm.carte
 WHERE  sysadm.carte.id_type_carte = @sIdTypeCarte

  RETURN @@ROWCOUNT

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_CARTE
-- Auteur               :       YP
-- Date                 :       04/09/97 10:42:10
-- Libellé              :       Sélection d'une carte
-- Commentaires         :
-- Références           :       D_SP_CARTE
--
-- Arguments            :       @dcIdCarte     decimal ( 7, 0 ) ( Val ) : identifiant de la carte cherchée.
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CARTE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CARTE
GO

CREATE PROC sysadm.DW_S01_CARTE
            @dcIdCarte     decimal ( 7, 0 )
AS

  SELECT sysadm.carte.id_carte,
         sysadm.carte.id_type_carte,
         sysadm.carte.id_grp,
         sysadm.carte.lib_carte,
         sysadm.carte.val_rg_mini,
         sysadm.carte.val_rg_max,
         sysadm.carte.cree_le,
         sysadm.carte.maj_le,
         sysadm.carte.maj_par
    FROM sysadm.carte
   WHERE sysadm.carte.id_carte = @dcIdCarte

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_CARTE
-- Auteur               :       YP
-- Date                 :       04/09/97 10:44:43
-- Libellé              :       Insert dans la table Carte.
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_1 de la fenêtre W_T_SP_CARTE
--
-- Arguments            :       @dcIdCarte     decimal ( 7, 0 )  ( Ref ) : identifiant de la nouvelle Carte
--                              @sIdTypeCarte  String   ( Val )
--                              @dcIdGrp       decimal ( 7, 0 )  ( Val )
--                              @sLibCarte     String   ( Val )
--                              @sValRgMini    String   ( Val )
--                              @sValRgMax     String   ( Val )
--                              @dtCreeLe      DateTime ( Val )
--                              @dtMajLe       DateTime ( Val )
--                              @sMajPar       String   ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_CARTE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_CARTE
GO

CREATE PROC sysadm.DW_I01_CARTE
            @dcIdCarte     decimal ( 7, 0 ) OUTPUT,
            @sIdTypeCarte  Varchar( 3 ),
            @dcIdGrp       decimal ( 7, 0 ) ,
            @sLibCarte     Varchar ( 35 ),
            @sValRgMini    Varchar ( 19 ),
            @sValRgMax     Varchar ( 19 ),
            @dtCreeLe      DateTime,
            @dtMajLe       DateTime,
            @sMajPar       Varchar ( 4 )
AS

  DECLARE      @iEtat     Integer
 
  
	EXECUTE @iEtat = sysadm.PS_X_INCREMENTER 'ID_CARTE', @dcIdCarte OUTPUT
	
  IF @iEtat = -1	
     BEGIN
        Return -1
     END

  INSERT INTO sysadm.carte
            ( carte.id_carte,
              carte.id_type_carte,
              carte.id_grp,
              carte.lib_carte,
              carte.val_rg_mini,
              carte.val_rg_max,
              carte.cree_le,
              carte.maj_le,
              carte.maj_par )
       VALUES 
            ( @dcIdCarte, @sIdTypeCarte, @dcIdGrp, @sLibCarte, 
              @sValRgMini, @sValRgMax, @dtCreeLe, @dtMajLe, @sMajPar )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_CARTE
-- Auteur               :       YP
-- Date                 :       04/09/97 10:53:24
-- Libellé              :       Suppression d'une carte.
-- Commentaires         :
-- Références           :       SQLPREVIEW de Dw_1 de la fenêtre W_T_SP_CARTE
--
-- Arguments            :       @dcIdCarte   decimal ( 7, 0 ) ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_CARTE' AND type = 'P' )
            DROP procedure sysadm.DW_D01_CARTE
GO

CREATE PROC sysadm.DW_D01_CARTE
            @dcIdCarte  decimal ( 7, 0 )
AS

 DELETE sysadm.carte
  WHERE sysadm.carte.id_carte = @dcIdCarte

GO


--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CARTE_SINISTRE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       La carte est-elle couverte ?
-- Références           :       U_GS_SP_SINISTRE
--
-- Arguments            :       @sRang          Varchar ( 19   )        (Val)
--                              @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdCarte      Decimal (  7,0 ) OUTPUT (R‚f)
--                              @sIdTypeCarte   Varchar (  3   ) OUTPUT (R‚f)
--                              @dcIdGrp        decimal (  7,0 ) OUTPUT (R‚f)
--                              @sPasAffilier   Integer          OUTPUT (R‚f)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CARTE_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_CARTE_SINISTRE
GO

CREATE procedure sysadm.PS_S01_CARTE_SINISTRE
        @sRang          Varchar ( 19 )                  ,
        @dcIdProd       Decimal (  7,0 )                ,
        @dcIdCarte      decimal (  7,0 )        OUTPUT  ,
        @sIdTypeCarte   Varchar (  3 )          OUTPUT  ,
        @dcIdGrp        decimal (  7,0 )        OUTPUT  ,
        @iNbAffilier    Integer                 OUTPUT
AS
 SELECT @dcIdCarte      = carte.id_carte,
        @dcIdGrp        = carte.id_grp,
        @sIdTypeCarte   = ( CASE id_type_carte
                            WHEN 'CCE' THEN
                              CASE Substring ( @sRang, 9, 1 ) 
                              WHEN '3' THEN 'C3'
                              WHEN '4' THEN 'C2'
                              WHEN '0' THEN 'C4'
                              WHEN '5' THEN 'C02'
                              WHEN '7' THEN 'C01'
                              WHEN '8' THEN 'C03'
                              ELSE '00'
                              END
                            ELSE id_type_carte
                            END )
 FROM   sysadm.carte
 WHERE  carte.val_rg_mini      <= @sRang        AND
        carte.val_rg_max       >= @sRang

/* ... On vérifie l'affiliation de la carte dans la table AFFILIER */
/* ... Cela va provoquer l'affichage d'un message non bloquant */

 IF @dcIdProd IS NOT NULL

        SELECT  @iNbAffilier = COUNT(*)
        FROM    sysadm.affilier
        WHERE   affilier.id_prod        = @dcIdProd    AND
                affilier.id_carte       = @dcIdCarte
GO


-------------------------------------------------------------------
--
-- Procédure            :   IM_S05_CARTE
-- Auteur               :   FABRY JF
-- Date                 :   28/07/00 14:58:27
-- Libellé              :   Permet de savoir si la carte chevauche une plage existante.
--
-- Commentaires         :   Cette requête annull et remplace les requete IM_S02_CARTE et IM_S03_CARTE
-- Références           :   Appelé par l'User Object U_SP_GS_CARTE dans la
--                          fonction Uf_Gs_Chevaucher()
--
-- Arguments            :   @dcIdCarte      decimal ( 7, 0 ) ( Val )
--		            @sRangMini  Varchar ( 19 ),
--			    @sRangMaxi  Varchar ( 19 )
--
-- Retourne             :   Le nombre de ligne existante
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S05_CARTE' AND type = 'P' )
            DROP procedure sysadm.IM_S05_CARTE
GO

CREATE PROC sysadm.IM_S05_CARTE
           @dcIdCarte  decimal ( 7, 0 ),
           @sRangMini  Varchar ( 19 ),
           @sRangMaxi  Varchar ( 19 ),
	   @sText      Varchar ( 255 ) OUTPUT
AS

Select 	@sText = convert ( Varchar ( 7 ), id_carte ) + ';' + lib_carte + ';' + val_rg_mini + ';' + val_rg_max + ';'

from	sysadm.carte

where	(
	( val_rg_mini >= @sRangMini AND val_rg_mini <= @sRangMaxi ) 
OR	( val_rg_max >= @sRangMini AND val_rg_max <= @sRangMaxi ) 
OR 	( val_rg_mini <= @sRangMini And val_rg_max >= @sRangMaxi ) 
	)
And     id_carte   <> @dcIdCarte
Order	by id_carte desc

GO


--------------------------------------------------------------------
--
-- Procedure            :       PS_S02_GENERE_CARTE_ECBLEU
-- Auteur               :       FABRY JF
-- Date                 :       12/10/2004
-- Libelle              :       Génération automatique d'un numéro de carte pour le produit E-Carte Bleu
-- Commentaires         :       La banque donne a ses client un n° de C. Bleu ne servant qu'une seule fois,
--				et n'apparaissant pas sur les relevés de compte.
--				On génére donc un numéro en respectant les bornes et en s'assurant qu'il n'existe pas dans les bases
-- References           :       Ne gère que les banques 189 et 255.
--
--				Exec sysadm.PS_S02_GENERE_CARTE_ECBLEU 189, ''  -- NATEXIS BANQUE POPULAIRE
--				Exec sysadm.PS_S02_GENERE_CARTE_ECBLEU 255, ''  -- LA POSTE
--
-- Arguments            :       @iIdGrp         Integer 
--				@sRacine	VarChar ( 6 ) OutPut   -- 6 premier chiffres imposés (éventuellement)
--
-- Retourne             :       Rien
--
-- #1 DCMP 070559  ajout de la SG id_carte 1618
-- #2 [DMDI022755] Ajout de CE NORD_FRANCE_EUROPE,id_grp 101, id_carte 1704
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_GENERE_CARTE_ECBLEU' AND type = 'P' )
        DROP procedure sysadm.PS_S02_GENERE_CARTE_ECBLEU
GO

CREATE procedure sysadm.PS_S02_GENERE_CARTE_ECBLEU
        @iIdGrp         Decimal ( 7 ) ,
        @sRacine        VarChar ( 6 )   OUTPUT
AS

Declare @iFin integer
Declare @iCpt integer
Declare @iSom  integer
Declare @iCalc  integer
Declare @Coef integer
Declare @iTour integer
Declare @iIdCarte Decimal ( 7 )
Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
Declare @sNumCarte VarChar ( 16 )    -- Carte Def Construit
Declare @sCle VarChar ( 1 )    -- Cle calculée

Set @iTour = 0
Set @sNumCarte = ''

While  ( @iTour = 0 ) Or 
       Exists ( Select * From SIMPA2_PRO.sysadm.sinistre where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SIMPA2_PRO.sysadm.w_sin where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SAVANE_PRO.sysadm.sinistre where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SAVANE_PRO.sysadm.w_sin where id_adh = @sNumCarte ) -- [PI038][RELEVE]
Begin
        Set @iTour = @iTour + 1
        Set @iFin = 0
        Set @iCpt = 1
        Set @iIdCarte = -1
        Set @sNumCarte = ''
        Set @iSom = 0
        
        select @CpltRacine = Convert ( varchar (24) , getdate (),14 ) + Convert ( varchar ( 24) , getdate (),14 ) 
        
        WHILE ( @iCpt <= Len ( @CpltRacine ) )
        BEGIN
           If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
             Begin
                Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
                Set @iCpt = 1
             End 
           Else
             Begin
                Set @iCpt = @iCpt + 1
             End 
        
        End
        
        If ( Len (@sRacine) = 6 )
         Begin
           If ( Select Count ( * ) 
                From   carte c
                Where  val_rg_mini like @sRacine + '%' 
                And    (    ( @iIdGrp = 189 And c.id_carte between 1133 and 1158 ) 
                        Or  ( @iIdGrp = 255 And c.id_carte in ( 992, 1025 ) ) 
			Or  ( @iIdGrp = 20 And c.id_carte in ( 1618 ) )  -- #1
			Or  ( @iIdGrp = 101 And c.id_carte in ( 1704 ) )  -- #2
                        ) 
              ) <> 1 
             Begin      
                Set @sRacine = '-1'
                Select 'Plus d''un Bin ! correspondant à ces 6 premiers chiffres'
                Return -1  -- Plus d'un BIN, Problème
             End 
         End 
        Else 
         Begin
           Select @sRacine = Left ( c.val_rg_mini, 6 ) 
           From   carte c
           Where  ( @iIdGrp = 189 and c.id_carte = 1133 )
           Or     ( @iIdGrp = 449 and c.id_carte = 1134 )
           Or     ( @iIdGrp = 255 and c.id_carte = 992 )
	   Or     ( @iIdGrp = 20 And c.id_carte = 1618 )  -- #1           
	   Or     ( @iIdGrp = 101 And c.id_carte = 1704 )  -- #2
         End

        If ( Len (@sRacine) < 6 )
          Begin  
            Select 'Pas de racine trouvée'
            Return -2 -- Pas de Racine trouvée
          End 
        
        Set @sNumCarte = Left ( @sRacine + @CpltRacine, 15 )
        
        Set @iCpt = 1
        
        While @iCpt <= 15
         Begin
           If ( @iCpt % 2 <> 0 )
             Begin
                Set @iCalc = Convert ( integer, SubString ( @sNumCarte, @iCpt, 1 ) ) * 2
                If  @iCalc >= 10 
                  Begin
                    Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
                                 Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
                  End
           
                Set @iSom = @iSom + @iCalc
             End
           Else
             Begin
                Set @iSom = @iSom + Convert ( integer, SubString ( @sNumCarte, @iCpt, 1 ) )
             End
           Set @iCpt = @iCpt + 1
         End 
        
        If ( @iSom % 10 = 0 ) 
         Set @sCle = 0
        Else
         Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )
        
        Set @sNumCarte = @sNumCarte + @sCle
End 
Select @sNumCarte

Set @sRacine = @sNumCarte

Go

grant execute on sysadm.PS_S02_GENERE_CARTE_ECBLEU to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S03_GENERE_CARTE
-- Auteur               :       FABRY JF
-- Date                 :       12/10/2004
-- Libelle              :       Génération automatique d'un numéro de carte 
--
--				Exec sysadm.PS_S02_GENERE_CARTE_ECBLEU 2, ''  
--				Exec sysadm.PS_S02_GENERE_CARTE_ECBLEU 0, '111111' 
--
-- Arguments            :       @iIdGrp         Integer 
--				@sRacine	VarChar ( 6 ) OutPut   -- 6 premier chiffres imposés (éventuellement)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_GENERE_CARTE' AND type = 'P' )
        DROP procedure sysadm.PS_S03_GENERE_CARTE
GO

CREATE procedure sysadm.PS_S03_GENERE_CARTE
        @iIdGrp         Decimal ( 7 ) ,
        @sRacine        VarChar ( 16 )   OUTPUT
AS


-- Fournir id_Grp > 0 pour avoir un n° de carte présent dans carte
-- Sinon id_grp =0 avec racine de 6 pour autre n°

Declare @iFin integer
Declare @iCpt integer
Declare @iSom  integer
Declare @iCalc  integer
Declare @Coef integer
Declare @iTour integer
Declare @iIdCarte Decimal ( 7 )
Declare @CpltRacine VarChar ( 24 )   -- Complement de racine
Declare @sNumCarte VarChar ( 16 )    -- Carte Def Construit
Declare @sCle VarChar ( 1 )    -- Cle calculée

Set @iTour = 0
Set @sNumCarte = ''

While  ( @iTour = 0 ) Or 

       Exists ( Select * From SIMPA2_TRT.sysadm.sinistre where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SIMPA2_TRT.sysadm.w_sin where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SAVANE_SIM.sysadm.sinistre where id_adh = @sNumCarte ) Or -- [PI038][RELEVE]
       Exists ( Select * From SAVANE_SIM.sysadm.w_sin where id_adh = @sNumCarte ) -- [PI038][RELEVE]
Begin
        Set @iTour = @iTour + 1
        Set @iFin = 0
        Set @iCpt = 1
        Set @iIdCarte = -1
        Set @sNumCarte = ''
        Set @iSom = 0
        
        select @CpltRacine = Convert ( varchar (24) , getdate (),14 ) + Convert ( varchar ( 24) , getdate (),14 ) 
        
        WHILE ( @iCpt <= Len ( @CpltRacine ) )
        BEGIN
           If ( Select Substring ( @CpltRacine, @iCpt, 1 ) ) = ':' 
             Begin
                Set @CpltRacine = Left ( @CpltRacine, @iCpt - 1 ) + Substring ( @CpltRacine, @iCpt + 1, Len (@CpltRacine)  ) 
                Set @iCpt = 1
             End 
           Else
             Begin
                Set @iCpt = @iCpt + 1
             End 
        
        End
/*        
        If ( Len (@sRacine) = 6 )
         Begin
           If ( Select Count ( * ) 
                From   carte c
                Where  val_rg_mini like @sRacine + '%' 
                And    (    ( @iIdGrp = 189 And c.id_carte between 1133 and 1158 ) 
                        Or  ( @iIdGrp = 255 And c.id_carte in ( 992, 1025 ) ) ) 
              ) <> 1 
             Begin      
                Set @sRacine = "-1"
                Select 'Plus d''un Bin ! correspondant à ces 6 premiers chiffres'
                Return -1  -- Plus d'un BIN, Problème
             End 
         End 
        Else 
         Begin
*/
	If @iIdGrp > 0
	 Begin
           Select @sRacine = Min (Left ( c.val_rg_mini, 6 ) )
           From   carte c
           Where  ( c.id_grp = @iIdGrp )
	 End
	 
        If ( Len (@sRacine) < 6 )
          Begin  
            Select 'Pas de racine trouvée'
            Return -2 -- Pas de Racine trouvée
          End 
        
        Set @sNumCarte = Left ( @sRacine + @CpltRacine, 15 )
        
        Set @iCpt = 1
        
        While @iCpt <= 15
         Begin
           If ( @iCpt % 2 <> 0 )
             Begin
                Set @iCalc = Convert ( integer, SubString ( @sNumCarte, @iCpt, 1 ) ) * 2
                If  @iCalc >= 10 
                  Begin
                    Set @iCalc = Convert ( int, Left ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) ) + 
                                 Convert ( int, Right ( Convert ( VarChar ( 2 ), @iCalc ), 1 ) )
                  End
           
                Set @iSom = @iSom + @iCalc
             End
           Else
             Begin
                Set @iSom = @iSom + Convert ( integer, SubString ( @sNumCarte, @iCpt, 1 ) )
             End
           Set @iCpt = @iCpt + 1
         End 
        
        If ( @iSom % 10 = 0 ) 
         Set @sCle = 0
        Else
         Set @sCle = Convert ( VarChar (1),  ( ( Convert ( int ,  @iSom / 10 ) * 10 ) + 10 ) - @iSom )
        
        Set @sNumCarte = @sNumCarte + @sCle
End 
Select @sNumCarte

Set @sRacine = @sNumCarte
Go

grant execute on sysadm.PS_S03_GENERE_CARTE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_PM208_INFO_CARTE
-- Auteur               :       FABRY JF
-- Date                 :       12/10/2004
-- Libelle              :       Retourne les infos nécéssaire pour Fred pour le PM 208
--								[PM208]
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM208_INFO_CARTE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM208_INFO_CARTE
GO

CREATE procedure sysadm.PS_S_PM208_INFO_CARTE
        @asNumCarte VarChar ( 50 ),
        @iIdCarte	Integer   OUTPUT,
        @sIdTypCarte VarChar ( 10 ) OUTPUT,
        @iIdGrp Integer OUTPUT,
        @sLibErreur VarChar ( 100 ) OUTPUT
        
AS

	If @asNumCarte is null Or sysadm.FN_TRIM (  @asNumCarte ) =''
	 Begin
		Set @sLibErreur = 'Numéro de carte null ou vide'
		Return -1
	 End 
	 
	Set @asNumCarte = sysadm.FN_TRIM (  @asNumCarte )
	 
	If Len ( @asNumCarte ) <> 16 AND Len ( @asNumCarte ) <> 19
	 Begin
		Set @sLibErreur = 'Longueur différente de 16 ou 19, seules longueurs acceptables'
		Return -2
	 End 
	 
	If Len ( @asNumCarte ) = 16
	  Begin
		If sysadm.FN_CORR_NUM_CARTE ( @asNumCarte, GETDATE() ) <> @asNumCarte
		 Begin
			Set @sLibErreur = 'Numéro non valide'
			Return -3
		 End 
	  End 

	If Len ( @asNumCarte ) = 19
	  Begin
		If sysadm.FN_CORR_NUM_CARTE_19 ( @asNumCarte, GETDATE() ) <> @asNumCarte
		 Begin
			Set @sLibErreur = 'Numéro non valide'
			Return -3
		 End 
	  End 

	-- Si tous les contrôles sont Ok on renvoit les données.

	Select  @iIdCarte = c.id_carte,
			@sIdTypCarte = c.id_type_carte,
			@iIdGrp = c.id_grp
	From	sysadm.carte c
	Where   @asNumCarte Between c.val_rg_mini And c.val_rg_max

	If @iIdCarte is null 
	 Begin
		Set @sLibErreur = 'Carte ne retourne aucun ID_CARTE, ID_TYP_CARTE, ID_GRP'
		Return -4
	 End 
	Else
	 Begin
		Set @sLibErreur = 'OK'
		Return 1
	 End
Go

