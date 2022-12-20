-------------------------------------------------------------------
--
-- Fichier              :       GENVIR.CP
-- Auteur               :       PLJ
-- Date                 :       05/11/1998
--
-- Commentaires         :       PS pour application GENVIR
--
-- Proc‚dures           :       PS_U01_GENVIR
--                              PS_S01_GENVIR
--				                    PS_D01_GENVIR
--				                    PS_U02_GENVIR
--                              PS_U01_PARAM_CPT	Récupération d'un numéro de chèque
--                              PS_S01_APF
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_GENVIR
-- Auteur               :       PLJ
-- Date                 :       05/11/1998
-- Libell‚              :        
-- Commentaires         :       mise … jour … 'G' de tous les virements
--                              … virer 
-- R‚f‚rences           :       GENVIR.U_Gv_Gs_Chargement::Uf_Maj_Locale (1)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_GENVIR' AND type = 'P' )
        DROP procedure sysadm.PS_U01_GENVIR
GO

CREATE procedure sysadm.PS_U01_GENVIR
      
AS
 UPDATE sysadm.w_a_virer
     SET sysadm.w_a_virer.cod_pos = 'G'
   WHERE sysadm.w_a_virer.cod_pos < '2' 

GO



--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_GENVIR
-- Auteur               :       PLJ
-- Date                 :       05/11/1998
-- Libell‚              :        
-- Commentaires         :       R‚cup‚ration des enregs … virer
--                              
-- R‚f‚rences           :       GENVIR.W_T_Gv_Chargement.Dw_A_Virer (Retrieve)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
-- Maj			: Le 24/02/2006  JFF  Ajout d'un case pour prendre le cod_prod_dms
--					      et pas le découpage du produit sinistre dans tous les cas.
--			  Le 15/05/2006  JFF  Modificatio n du code appli de SIM2 en SIM8
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GENVIR' AND type = 'P' )
        DROP procedure sysadm.PS_S01_GENVIR
GO

CREATE procedure sysadm.PS_S01_GENVIR

AS
  SELECT 
         'SIM8',
         w_a_virer.id_sin,   
         w_a_virer.id_i,   
         w_a_virer.id_reg,   
         w_a_virer.cod_inter,
         convert ( int, inter.cod_civ),
         w_a_virer.id_prod,
         Case 
	 	When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 3 )
		Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
	 end,
         Case produit.id_grp 
              When 153 Then produit.id_grp
	           Else w_a_virer.id_ets
         End, 
         w_a_virer.id_adh,   
         w_a_virer.id_sdos,
         case produit.rib_cpt
	      when '0000079030B' then '053202'
	      else '040402'
         end, 
         inter.nom,
         inter.ordre_cheque,
         reglement.num_let_cheque,
         null,
         'E',
         'SPB', 
         produit.rib_bq,   
         produit.rib_gui,   
         produit.rib_cpt,   
         produit.rib_cle,   
         w_a_virer.rib_bq_dest,   
         w_a_virer.rib_gui_dest,   
         w_a_virer.rib_cpt_dest,   
         w_a_virer.rib_cle_dest,   
         w_a_virer.mt_vir,  
         '0',
         w_a_virer.cod_mode_reg,
         produit.lib_court,
	      case produit.id_dept
		      when 260 then 	depts.lib_dept
		      else		departement.lib_dept
	      end,
	      convert (datetime, null),
	      w_a_virer.cree_le,   
         w_a_virer.maj_le,   
         w_a_virer.maj_par   
    FROM sysadm.produit,   
         sysadm.w_a_virer,
         sysadm.departement,
	      sysadm.departement   depts,
	      sysadm.inter,
         sysadm.reglement
   WHERE ( produit.id_prod   = w_a_virer.id_prod   ) and  
         ( produit.id_dept   = departement.id_dept ) and
         ( produit.id_depts  = depts.id_dept       ) and
         ( w_a_virer.id_sin  = inter.id_sin 	      ) and
         ( w_a_virer.id_i    = inter.id_i          ) and
         ( reglement.id_sin  = w_a_virer.id_sin    ) and
         ( reglement.id_reg  = w_a_virer.id_reg    ) and 
         ( w_a_virer.cod_pos = 'G' 		            )    

GO

---------------------------------------------------------------------------------------
-- V01 FS le 19/03/2008 PS_S01_GENVIR_V01 : Gestion avec IBAN-BIC
---------------------------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GENVIR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S01_GENVIR_V01
GO

CREATE procedure sysadm.PS_S01_GENVIR_V01
  @sIdAppli Varchar(4) -- V01 Nouveau parametre

AS
  SELECT 
         @sIdAppli          as id_appli, -- V01 Le code appli 	'SIM8' n'est plus en dur
         w_a_virer.id_sin,   
         w_a_virer.id_i,   
         w_a_virer.id_reg,   
         w_a_virer.cod_inter,
         convert ( int, inter.cod_civ),
         w_a_virer.id_prod,
         Case 
	 	When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 3 )
		Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
	 end,
         Case produit.id_grp 
              When 153 Then produit.id_grp
	           Else w_a_virer.id_ets
         End, 
         w_a_virer.id_adh,   
         w_a_virer.id_sdos,
         case produit.rib_cpt
	      when '0000079030B' then '053202'
	      else '040402'
         end, 
         inter.nom,
         inter.ordre_cheque,
         reglement.num_let_cheque,
         null,
         'E',
         'SPB', 
         produit.rib_bq,   
         produit.rib_gui,   
         produit.rib_cpt,   
         produit.rib_cle,   
         w_a_virer.rib_bq_dest,   
         w_a_virer.rib_gui_dest,   
         w_a_virer.rib_cpt_dest,   
         w_a_virer.rib_cle_dest,   
         w_a_virer.mt_vir,  
         '0',
         w_a_virer.cod_mode_reg,
         produit.lib_court,
	      case produit.id_dept
		      when 260 then 	depts.lib_dept
		      else		departement.lib_dept
	      end,
	      convert (datetime, null),
	      w_a_virer.cree_le,   
         w_a_virer.maj_le,   
         w_a_virer.maj_par ,
         null    as id_iban_dest, -- V01
         null    as id_bic_dest   -- V01  

    FROM sysadm.produit,   
         sysadm.w_a_virer,
         sysadm.departement,
	      sysadm.departement   depts,
	      sysadm.inter,
         sysadm.reglement
   WHERE ( produit.id_prod   = w_a_virer.id_prod   ) and  
         ( produit.id_dept   = departement.id_dept ) and
         ( produit.id_depts  = depts.id_dept       ) and
         ( w_a_virer.id_sin  = inter.id_sin 	      ) and
         ( w_a_virer.id_i    = inter.id_i          ) and
         ( reglement.id_sin  = w_a_virer.id_sin    ) and
         ( reglement.id_reg  = w_a_virer.id_reg    ) and 
         ( w_a_virer.cod_pos = 'G' 		            )    

GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GENVIR_V02' AND type = 'P' )
        DROP procedure sysadm.PS_S01_GENVIR_V02
GO

CREATE procedure [sysadm].[PS_S01_GENVIR_V02]
  @sIdAppli Varchar(4) -- V01 Nouveau parametre

AS
---------------------------------------------------------------------------------------
-- V02 FS le 15/01/2016 PS_S01_GENVIR_V02 : Gestion avec Status et libellé réglement
-- JFF      12/05/2020   [PI085]
---------------------------------------------------------------------------------------
  SELECT 
         @sIdAppli          as id_appli, -- V01 Le code appli 	'SIM8' n'est plus en dur
         w_a_virer.id_sin,   
         w_a_virer.id_i,   
         w_a_virer.id_reg,   
         w_a_virer.cod_inter,
         convert ( int, inter.cod_civ),
         w_a_virer.id_prod,
         Case 
			When sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
				Case 
				 	When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 5 ) --  [PI085]
					Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
				End 
			Else 
				Case 
					When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 3 )
					Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
				End 
	 end,
         Case produit.id_grp 
              When 153 Then produit.id_grp
	           Else w_a_virer.id_ets
         End, 
         w_a_virer.id_adh,   
         w_a_virer.id_sdos,
         case produit.rib_cpt
	      when '0000079030B' then '053202'
	      else '040402'
         end, 
         inter.nom,
         inter.ordre_cheque,
         reglement.num_let_cheque,
         null,
         'E',
         'SPB', 
         produit.rib_bq,   
         produit.rib_gui,   
         produit.rib_cpt,   
         produit.rib_cle,   
         w_a_virer.rib_bq_dest,   
         w_a_virer.rib_gui_dest,   
         w_a_virer.rib_cpt_dest,   
         w_a_virer.rib_cle_dest,   
         w_a_virer.mt_vir,  
         '0',
         w_a_virer.cod_mode_reg,
         produit.lib_court,
	      case produit.id_dept
		      when 260 then 	depts.lib_dept
		      else		departement.lib_dept
	      end,
	      convert (datetime, null),
	      w_a_virer.cree_le,   
         w_a_virer.maj_le,   
         w_a_virer.maj_par ,
         null    as id_iban_dest,   --V01
         null    as id_bic_dest,    --V01
		 null    as id_status_saga, --V02
		 null    as lib_reg_saga    --V02

    FROM sysadm.produit,   
         sysadm.w_a_virer,
         sysadm.departement,
	      sysadm.departement   depts,
	      sysadm.inter,
         sysadm.reglement
   WHERE ( produit.id_prod   = w_a_virer.id_prod   ) and  
         ( produit.id_dept   = departement.id_dept ) and
         ( produit.id_depts  = depts.id_dept       ) and
         ( w_a_virer.id_sin  = inter.id_sin 	      ) and
         ( w_a_virer.id_i    = inter.id_i          ) and
         ( reglement.id_sin  = w_a_virer.id_sin    ) and
         ( reglement.id_reg  = w_a_virer.id_reg    ) and 
         ( w_a_virer.cod_pos = 'G' 		            )    


GO

grant execute on sysadm.PS_S01_GENVIR_V02 to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_GENVIR_V03' AND type = 'P' )
        DROP procedure sysadm.PS_S01_GENVIR_V03
GO

CREATE procedure [sysadm].[PS_S01_GENVIR_V03]
  @sIdAppli Varchar(4) -- V01 Nouveau parametre

AS
---------------------------------------------------------------------------------------
-- V02 FS le 15/01/2016 PS_S01_GENVIR_V02 : Gestion avec Status et libellé réglement
-- JFF      12/05/2020   [PI085]
-- V03 FS le 25/02/2021 : PS_S01_GENVIR_V03 : [BREXIT] Ajout rubriques mise en conformité pour virmt étrangers
---------------------------------------------------------------------------------------
  SELECT 
         @sIdAppli          as id_appli, -- V01 Le code appli 	'SIM8' n'est plus en dur
         w_a_virer.id_sin,   
         w_a_virer.id_i,   
         w_a_virer.id_reg,   
         w_a_virer.cod_inter,
         convert ( int, inter.cod_civ),
         w_a_virer.id_prod,
         Case 
			When sysadm.FN_CLE_NUMERIQUE ( 'PI085') > 0 Then 
				Case 
				 	When produit.cod_prod_dms is null Then Substring ( Right ( '00000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 5 ) --  [PI085]
					Else Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5 ) --  [PI085]
				End 
			Else 
				Case 
					When produit.cod_prod_dms is null Then Substring ( Right ( '0000' + Convert ( Varchar (5), w_a_virer.id_prod), 5), 1 , 3 )
					Else Right ( '0000' + Convert ( Varchar (5), produit.cod_prod_dms), 3)
				End 
	 end,
         Case produit.id_grp 
              When 153 Then produit.id_grp
	           Else w_a_virer.id_ets
         End, 
         w_a_virer.id_adh,   
         w_a_virer.id_sdos,
         case produit.rib_cpt
	      when '0000079030B' then '053202'
	      else '040402'
         end, 
         inter.nom,
         inter.ordre_cheque,
         reglement.num_let_cheque,
         null,
         'E',
         'SPB', 
         produit.rib_bq,   
         produit.rib_gui,   
         produit.rib_cpt,   
         produit.rib_cle,   
         w_a_virer.rib_bq_dest,   
         w_a_virer.rib_gui_dest,   
         w_a_virer.rib_cpt_dest,   
         w_a_virer.rib_cle_dest,   
         w_a_virer.mt_vir,  
         '0',
         w_a_virer.cod_mode_reg,
         produit.lib_court,
	      case produit.id_dept
		      when 260 then 	depts.lib_dept
		      else		departement.lib_dept
	      end,
	      convert (datetime, null),
	      w_a_virer.cree_le,   
         w_a_virer.maj_le,   
         w_a_virer.maj_par ,
         null    as id_iban_dest,   --V01
         null    as id_bic_dest,    --V01
		 null    as id_status_saga, --V02
		 null    as lib_reg_saga,   --V02
		 null    as brexit_id_pays, -- V03
		 null    as brexit_adr_1,   -- V03
		 null    as brexit_adr_2,   -- V03
		 null    as brexit_adr_3,   -- V03
		 null    as brexit_adr_4,   -- V03
		 null    as brexit_adr_5,   -- V03
		 null    as brexit_adr_6,   -- V03
		 null    as brexit_adr_7    -- V03

    FROM sysadm.produit,   
         sysadm.w_a_virer,
         sysadm.departement,
	      sysadm.departement   depts,
	      sysadm.inter,
         sysadm.reglement
   WHERE ( produit.id_prod   = w_a_virer.id_prod   ) and  
         ( produit.id_dept   = departement.id_dept ) and
         ( produit.id_depts  = depts.id_dept       ) and
         ( w_a_virer.id_sin  = inter.id_sin 	      ) and
         ( w_a_virer.id_i    = inter.id_i          ) and
         ( reglement.id_sin  = w_a_virer.id_sin    ) and
         ( reglement.id_reg  = w_a_virer.id_reg    ) and 
         ( w_a_virer.cod_pos = 'G' 		            )    
GO

grant execute on sysadm.PS_S01_GENVIR_V03 to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_D01_GENVIR
-- Auteur               :       PLJ
-- Date                 :       05/11/1998
-- Libell‚              :        
-- Commentaires         :       Supprime tous les enregs avec cod_pos … 'D'
--                              
-- R‚f‚rences           :       GENVIR.U_Gv_Gs_Chargement::Uf_Maj_Locale (2)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D01_GENVIR' AND type = 'P' )
        DROP procedure sysadm.PS_D01_GENVIR
GO

CREATE procedure sysadm.PS_D01_GENVIR

AS
  DELETE FROM sysadm.w_a_virer
   WHERE sysadm.w_a_virer.cod_pos = 'D' 

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U02_GENVIR
-- Auteur               :       PLJ
-- Date                 :       05/11/1998
-- Libell‚              :        
-- Commentaires         :       on passe tous les cod_pos de 'G' -> 'D'
--                              
-- R‚f‚rences           :       GENVIR.U_Gv_Gs_Chargement::Uf_Maj_Locale (2)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U02_GENVIR' AND type = 'P' )
        DROP procedure sysadm.PS_U02_GENVIR
GO

CREATE procedure sysadm.PS_U02_GENVIR

AS
  UPDATE sysadm.w_a_virer
     SET sysadm.w_a_virer.cod_pos = 'D'
   WHERE sysadm.w_a_virer.cod_pos = 'G' 

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_U01_PARAM_CPT
-- Auteur               :       FABRY JF
-- Date                 :       05/02/2004
-- Libell‚              :        
-- Commentaires         :       Récupération d'un numéro de chèque
--                              
-- R‚f‚rences           :       
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_PARAM_CPT' AND type = 'P' )
        DROP procedure sysadm.PS_U01_PARAM_CPT
GO

CREATE procedure sysadm.PS_U01_PARAM_CPT

	@sCodAppli	  Varchar ( 4),	
	@sBase		  Varchar (10),
	@sRefCpt          Varchar (10),
	@iCptVal	  Integer OUTPUT
AS

-------------------------------------------------------------------------------
-- La récupération du compteur n'est possible que si l'on est sur SIMPA2_PRO --
-- en code appli SIM2. Dans tout cas contraire, on ressort		     --
-------------------------------------------------------------------------------
If Upper ( @sCodAppli ) Not in ( 'SIM2', 'SIM8','SIMX' ) OR  
   Upper ( @sBase     ) <> 'SIMPA2_PRO'
 Begin
   Set @iCptVal = 0	
   Return
 End

----------------------------------   
-- Sinon On récupère une valeur --
----------------------------------   
UPDATE  GENVIR_PRO.sysadm.param_cpt
SET  	cpt_val = cpt_val + 1
WHERE  	ref_cpt = @sRefCpt

IF @@RowCount = 0	
  Begin
   Set @iCptVal = -1
   Return
  End 
---------------------------------------------------- 
-- Récupération de la dernière valeur de compteur --
----------------------------------------------------
SELECT  @iCptVal = cpt_val
FROM    GENVIR_PRO.sysadm.param_cpt
WHERE   ref_cpt = @sRefCpt

IF @@RowCount = 0	
  Begin
   Set @iCptVal = -1
   Return
  End 

GO

--------------------------------------------------------------------
--
-- Procédure            :  PS_S01_APF
-- Auteur               :  PLJ
-- Date                 :  14/06/2005
-- Libellé              :       
-- Commentaires         :	
-- Références           :       
--
-- Arguments            :  @iIdSin
--				               @iIdReg
-- Retourne             :	Rien
-------------------------------------------------------------------
-- JFF  15/10/2012  [VDOC8771]  
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_APF' AND type = 'P' )
            DROP procedure sysadm.PS_S01_APF
GO


CREATE PROC sysadm.PS_S01_APF
@iIdSin   Decimal (10), -- [PI062]
@iIdReg   Decimal (2)

AS

/*------------------------*/
/* Variables de travail   */
/*------------------------*/
DECLARE @iIdDetail   Decimal (7),
        @iIdGti      Decimal (7),
        @iIdIReg     Decimal (2),
        @iNbLigne    integer,
        @iIdRev      Decimal (7),
        @iIdProd     Decimal (7),
        @sCodInter   VarChar (1),
        @sCodModeReg VarChar (2),
        @sCodMotReg  VarChar (2),
        @iIdRegBase  Decimal (7)

/*------------------------*/
/* Variable à retourner   */
/*------------------------*/
DECLARE @iIdSeq         integer,
        @sIdFour        char(3),
        @sIdCmdFrn      char(20),
        @sNumFacture    char(20),
        @sDateFacture   char(8),
        @sRefPortFour   char(20),
        @sLibPort       varchar(70),
        @sLibPolice     varchar(35),
        @sIdCie         char(3),
        @sLibDept    VarChar (10)

-- Autre variables
Declare @iIdRegRMRP  Decimal ( 2 )
Declare @iPos integer
Declare @sNumFactureRPRM    char(35)
Declare @sDateFactureRPRM   char(8)

SET @iNbLigne    = 0
SET @iIdSeq      = -1
SET @iIdIReg     = -1
SET @sIdFour     = ''
SET @sIdCmdFrn   = ''
SET @sNumFacture = ''
SET @sDateFacture= ''
SET @sRefPortFour= ''
SET @sLibPort    = ''
SET @sLibPolice  = ''
SET @sIdCie      = ''
SET @sLibDept    = ''

   /*---------------------------------------------------*/
   /* Traitement des RM/FM/F.				*/
   /* Si détection d'un RM, alors recherche du regl.    */
   /* d'origine et modification de @iIdReg afin de      */
   /* pointer vers le réglement d'origine pour l'extrac.*/
   /*---------------------------------------------------*/
SELECT  @sCodInter   = r.cod_inter,
        @sCodModeReg = r.cod_mode_reg,
        @sCodMotReg  = r.cod_mot_reg,
	@iIdRegBase  = r.id_reg_base
FROM 	sysadm.reglement r
WHERE   r.id_sin = @iIdSin     
AND     r.id_reg = @iIdReg

If (@sCodInter = 'F' AND @sCodModeReg = 'FM' AND ( @sCodMotReg = 'RM' Or @sCodMotReg = 'RP' ) ) 
 BEGIN
	Set @iIdRegRMRP = @iIdReg 
	Set @iIdReg = @iIdRegBase
 END

SELECT @iNbLigne = count(id_detail) 
  FROM sysadm.detail
 WHERE id_sin = @iIdSin     AND
       id_reg = @iIdReg

If @iNbLigne = 1
Begin

   /*---------------------------------------------------*/
   /* Récupération Numéro de facture et date de facture */
   /*---------------------------------------------------*/
   SELECT @sNumFacture = num_facture,
          @sDateFacture= convert (char(4),year( dte_livr))                        + 
                           right ( '00' + convert(varchar(2),month(dte_livr)), 2) + 
                           right ( '00' + convert(varchar(2),  day(dte_livr)), 2),
          @iIdDetail = id_detail,
          @iIdGti    = id_gti,
          @iIdIReg   = id_i_reg   
     FROM sysadm.detail
    WHERE id_sin = @iIdSin     AND
          id_reg = @iIdReg


	 -- [VDOC8771]
	 If (@sCodInter = 'F' AND @sCodModeReg = 'FM' AND ( @sCodMotReg = 'RM' Or @sCodMotReg = 'RP' ) ) 
		BEGIN
			Select @sDateFactureRPRM = convert (char(4),year( r.cree_le))                        + 
				   right ( '00' + convert(varchar(2),month(r.cree_le)), 2) + 
				   right ( '00' + convert(varchar(2),  day(r.cree_le)), 2),
				   @sNumFactureRPRM = lTrim ( rtrim ( r.lib_reg ))
			From   sysadm.reglement r
			Where  r.id_sin = @iIdSin     
			AND    r.id_reg = @iIdRegRMRP

			Set @iPos = CharIndex ( '#', @sNumFactureRPRM )

			If @iPos > 0 
			 Begin
				Set @sNumFactureRPRM = Substring ( @sNumFactureRPRM , @iPos + 1, len ( @sNumFactureRPRM ) )
				Set @iPos = CharIndex ( '#', @sNumFactureRPRM )
				If @iPos > 0 
				 Begin		
					Set @sNumFactureRPRM = Substring ( @sNumFactureRPRM, 1, @iPos - 1 )

					Set @sDateFacture = @sDateFactureRPRM 
					Set @sNumFacture = Left ( @sNumFactureRPRM, 20 )
				 End 			
			 End 
		End
		-- [VDOC8771]


   /*---------------------------------------------------*/
   /* Détermination du nombre de comande                */
   /*---------------------------------------------------*/
   SET @iNbLigne = 0
   SELECT @iNbLigne = count(id_seq)
     FROM sysadm.commande
    WHERE id_sin    = @iIdSin     AND
          id_gti    = @iIdGti     AND
          id_detail = @iIdDetail

   /*---------------------------------------------------------------------------------------------*/
   /* S'il existe une seule commande alors on récupère les informations liées à la table commande */
   /*---------------------------------------------------------------------------------------------*/
   IF @iNbLigne = 1
   Begin
        SELECT @iIdSeq       = id_seq,
               @sIdCmdFrn    = id_cmd_frn,
               @sRefPortFour = id_ref_four,
               @sLibPort     = RTrim ( id_marq_art ) + ' ' + RTrim ( id_modl_art )
          FROM sysadm.commande
         WHERE id_sin    = @iIdSin     AND
               id_gti    = @iIdGti     AND
               id_detail = @iIdDetail
   End
   
/*------------------------------------------------------------------*/
/* JFF								    */
/* Dans la cas où aucune commande n'existe, on vérifie s'il existe  */
/* pour ce détai une marque/modèle sur div_det (comme de CASTORAMA  */
/* par exemple)                                                     */
/*------------------------------------------------------------------*/
   IF @iNbLigne = 0
   Begin
	SELECT TOP 1
	@sLibPort = Case
				When ( Select 	count (*)
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) > 0 
					Then 	Case		
						When
							(
							Select 	sysadm.FN_TRIM ( ddet.val_car )
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'aucune_marq' ) = 'O' 
							Then 
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'modl_app' )

						When
							(
							Select 	sysadm.FN_TRIM ( ddet.val_car )
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'aucune_marq' ) = 'N' 
							Then 						
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'modl_app' )
								+ ' ' +
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'marq_app' )
						End 
				Else 	(Select sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'modl_app' )
					+ ' ' +
					(Select sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'marq_app' )

				End
	
	
	  FROM 	sysadm.detail d,
	  	sysadm.div_det ddet0
	 WHERE d.id_sin = @iIdSin
	 AND   d.id_gti = @iIdGti 
	 AND   d.id_detail = @iIdDetail
	 AND   ddet0.id_sin = d.id_sin
	 AND   ddet0.id_gti = d.id_gti	 
	 AND   ddet0.id_detail = d.id_detail
	 AND   ddet0.nom_zone = 'modl_app' 
   
   End
   

   /*---------------------------------------------------*/      
   /* Récupération du fournisseur sur inter             */
   /*---------------------------------------------------*/
   SELECT @sIdFour = id_four
     FROM sysadm.inter
    WHERE id_sin = @iIdSin      AND
          id_i   = @iIdIReg

   /*---------------------------------------------------*/
   /* Récupération de la police et compagnie            */
   /*---------------------------------------------------*/
   SELECT @iIdRev  = id_rev,
          @iIdProd = id_prod
     FROM sysadm.sinistre
    WHERE id_sin = @iIdSin
   
   SELECT @sLibPolice = lib_police,
          @sIdCie     = id_cie
     FROM sysadm.garantie INNER JOIN sysadm.police ON garantie.id_police = police.id_police
    WHERE garantie.id_prod = @iIdProd  AND
          garantie.id_rev  = @iIdRev   AND
          garantie.id_gti  = @iIdGti

   /*---------------------------------------------------*/
   /* Récupération du libellé département		*/
   /*---------------------------------------------------*/
   SELECT @sLibDept = Substring ( departement.lib_dept, 1, 10 )
     FROM sysadm.produit INNER JOIN sysadm.departement ON produit.id_dept = departement.id_dept
    WHERE produit.id_prod = @iIdProd

End

If @sIdCmdFrn is Null 
   Begin 
      Set @sIdCmdFrn = 'Aucun'
   End

SELECT @iIdSeq       AS id_seq,
       @sIdFour      AS id_four,
       @sIdCmdFrn    AS id_cmd_four,
       @sNumFacture  AS num_facture,
       @sDateFacture AS date_facture,
       @sRefPortFour AS ref_port_four,
       @sLibPort     AS lib_marq_modl,
       @sLibPolice   AS lib_police,
       @sIdCie       AS id_cie,
       @sLibDept     AS lib_dept

Go

--------------------------------------------------------------------
--
-- Procédure            :  PS_S01_APF_V01
-- Auteur               :  PLJ
-- Date                 :  14/06/2005
-- Libellé              :       
-- Commentaires         :	
-- Références           :       
--
-- Arguments            :  @iIdSin
--				               @iIdReg
-- Retourne             :	Rien
-------------------------------------------------------------------
-- JFF  15/10/2012  [VDOC8771]  
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_APF_V01' AND type = 'P' )
            DROP procedure sysadm.PS_S01_APF_V01
GO

CREATE PROC sysadm.PS_S01_APF_V01
@iIdSin   Decimal (10),  -- [PI062]
@iIdReg   Decimal (2)

AS

---------------------------------------------------------------------------------------------
-- PS_S01_APF_V01 Extraction des données pour le fichier APF ( V01 = + n° bon cadeau auchan )
---------------------------------------------------------------------------------------------

/*------------------------*/
/* Variables de travail   */
/*------------------------*/
DECLARE @iIdDetail   Decimal (7),
        @iIdGti      Decimal (7),
        @iIdIReg     Decimal (2),
        @iNbLigne    integer,
        @iIdRev      Decimal (7),
        @iIdProd     Decimal (7),
        @sCodInter   VarChar (1),
        @sCodModeReg VarChar (2),
        @sCodMotReg  VarChar (2),
        @iIdRegBase  Decimal (7)

/*------------------------*/
/* Variable à retourner   */
/*------------------------*/
DECLARE @iIdSeq         integer,
        @sIdFour        char(3),
        @sIdCmdFrn      char(20),
        @sNumFacture    char(20),
        @sDateFacture   char(8),
        @sRefPortFour   char(20),
        @sLibPort       varchar(70),
        @sLibPolice     varchar(35),
        @sIdCie         char(3),
        @sLibDept       VarChar (10),
        @sNumBonCadeau  Varchar(6)

SET @iNbLigne    = 0
SET @iIdSeq      = -1
SET @iIdIReg     = -1
SET @sIdFour     = ""
SET @sIdCmdFrn   = ""
SET @sNumFacture = ""
SET @sDateFacture= ""
SET @sRefPortFour= ""
SET @sLibPort    = ""
SET @sLibPolice  = ""
SET @sIdCie      = ""
SET @sLibDept    = ""
Set @sNumBonCadeau = "" -- V01

   /*---------------------------------------------------*/
   /* Traitement des RM/FM/F.				*/
   /* Si détection d'un RM, alors recherche du regl.    */
   /* d'origine et modification de @iIdReg afin de      */
   /* pointer vers le réglement d'origine pour l'extrac.*/
   /*---------------------------------------------------*/
SELECT  @sCodInter   = r.cod_inter,
        @sCodModeReg = r.cod_mode_reg,
        @sCodMotReg  = r.cod_mot_reg,
	@iIdRegBase  = r.id_reg_base
FROM 	sysadm.reglement r
WHERE   r.id_sin = @iIdSin     
AND     r.id_reg = @iIdReg

If (@sCodInter = 'F' AND @sCodModeReg = 'FM' AND ( @sCodMotReg = 'RM' Or @sCodMotReg = 'RP' ) ) 
 BEGIN
	Set @iIdReg = @iIdRegBase
 END

SELECT @iNbLigne = count(id_detail) 
  FROM sysadm.detail
 WHERE id_sin = @iIdSin     AND
       id_reg = @iIdReg

If @iNbLigne = 1
Begin

   /*---------------------------------------------------*/
   /* Récupération Numéro de facture et date de facture */
   /*---------------------------------------------------*/
   SELECT @sNumFacture = num_facture,
          @sDateFacture= convert (char(4),year( dte_livr))                        + 
                           right ( '00' + convert(varchar(2),month(dte_livr)), 2) + 
                           right ( '00' + convert(varchar(2),  day(dte_livr)), 2),
          @iIdDetail = id_detail,
          @iIdGti    = id_gti,
          @iIdIReg   = id_i_reg   
     FROM sysadm.detail
    WHERE id_sin = @iIdSin     AND
          id_reg = @iIdReg

   /*---------------------------------------------------*/
   /* Détermination du nombre de comande                */
   /*---------------------------------------------------*/
   SET @iNbLigne = 0
   SELECT @iNbLigne = count(id_seq)
     FROM sysadm.commande
    WHERE id_sin    = @iIdSin     AND
          id_gti    = @iIdGti     AND
          id_detail = @iIdDetail

   /*---------------------------------------------------------------------------------------------*/
   /* S'il existe une seule commande alors on récupère les informations liées à la table commande */
   /*---------------------------------------------------------------------------------------------*/
   IF @iNbLigne = 1
   Begin
        SELECT @iIdSeq       = id_seq,
               @sIdCmdFrn    = id_cmd_frn,
               @sRefPortFour = id_ref_four,
@sLibPort     = RTrim ( id_marq_art ) + ' ' + RTrim ( id_modl_art )
          FROM sysadm.commande
         WHERE id_sin    = @iIdSin     AND
               id_gti    = @iIdGti     AND
               id_detail = @iIdDetail
   End
   
/*------------------------------------------------------------------*/
/* JFF								    */
/* Dans la cas où aucune commande n'existe, on vérifie s'il existe  */
/* pour ce détai une marque/modèle sur div_det (comme de CASTORAMA  */
/* par exemple)                                                     */
/*------------------------------------------------------------------*/
   IF @iNbLigne = 0
   Begin
	SELECT TOP 1
	@sLibPort = Case
				When ( Select 	count (*)
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'aucune_marq' ) > 0 
					Then 	Case		
						When
							(
							Select 	sysadm.FN_TRIM ( ddet.val_car )
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'aucune_marq' ) = 'O' 
							Then 
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'modl_app' )

						When
							(
							Select 	sysadm.FN_TRIM ( ddet.val_car )
							From   	sysadm.div_det ddet
							Where  	ddet.id_sin = d.id_sin
							And 	ddet.id_gti = d.id_gti
							And 	ddet.id_detail = d.id_detail
							And 	ddet.nom_zone = 'aucune_marq' ) = 'N' 
							Then 						
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'modl_app' )
								+ ' ' +
								(Select sysadm.FN_TRIM ( ddet.val_car )
								From   	sysadm.div_det ddet
								Where  	ddet.id_sin = d.id_sin
								And 	ddet.id_gti = d.id_gti
								And 	ddet.id_detail = d.id_detail
								And 	ddet.nom_zone = 'marq_app' )
						End 
				Else 	(Select sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'modl_app' )
					+ ' ' +
					(Select sysadm.FN_TRIM ( ddet.val_car )
					From   	sysadm.div_det ddet
					Where  	ddet.id_sin = d.id_sin
					And 	ddet.id_gti = d.id_gti
					And 	ddet.id_detail = d.id_detail
					And 	ddet.nom_zone = 'marq_app' )

				End
	
	
	  FROM 	sysadm.detail d,
	  	sysadm.div_det ddet0
	 WHERE d.id_sin = @iIdSin
	 AND   d.id_gti = @iIdGti 
	 AND   d.id_detail = @iIdDetail
	 AND   ddet0.id_sin = d.id_sin
	 AND   ddet0.id_gti = d.id_gti	 
	 AND   ddet0.id_detail = d.id_detail
	 AND   ddet0.nom_zone = 'modl_app' 
   
   End
   

   /*---------------------------------------------------*/      
   /* Récupération du fournisseur sur inter             */
   /*---------------------------------------------------*/
   SELECT @sIdFour = id_four
     FROM sysadm.inter
    WHERE id_sin = @iIdSin      AND
          id_i   = @iIdIReg

   /*---------------------------------------------------*/
   /* Récupération de la police et compagnie            */
   /*---------------------------------------------------*/
   SELECT @iIdRev  = id_rev,
          @iIdProd = id_prod
     FROM sysadm.sinistre
    WHERE id_sin = @iIdSin
   
   SELECT @sLibPolice = lib_police,
          @sIdCie     = id_cie
     FROM sysadm.garantie INNER JOIN sysadm.police ON garantie.id_police = police.id_police
    WHERE garantie.id_prod = @iIdProd  AND
          garantie.id_rev  = @iIdRev   AND
          garantie.id_gti  = @iIdGti

/*---------------------------------------------------*/
   /* Récupération du libellé département		           */
   /*---------------------------------------------------*/
   SELECT @sLibDept = Substring ( departement.lib_dept, 1, 10 )
     FROM sysadm.produit INNER JOIN sysadm.departement ON produit.id_dept = departement.id_dept
    WHERE produit.id_prod = @iIdProd

End

If @sIdCmdFrn is Null 
   Begin 
      Set @sIdCmdFrn = "Aucun"
   End

   /*---------------------------------------------------*/
   /* V01 Récupération du numéro de bon cadeau          */
   /*---------------------------------------------------*/

	SELECT @sNumBonCadeau = sysadm.FN_GET_DIVERS_SINISTRE ( @iIdSin, "num_bon_cad_auchan", "val_car" )

	If @sNumBonCadeau is Null Set @sNumBonCadeau = "" -- Sera remplacé par 6 espaces dans Genvir

SELECT @iIdSeq       AS id_seq,
       @sIdFour      AS id_four,
       @sIdCmdFrn    AS id_cmd_four,
       @sNumFacture  AS num_facture,
       @sDateFacture AS date_facture,
       @sRefPortFour AS ref_port_four,
       @sLibPort     AS lib_marq_modl,
       @sLibPolice   AS lib_police,
       @sIdCie       AS id_cie,
       @sLibDept     AS lib_dept,
		 @sNumBonCadeau AS num_bon_cadeau -- V01

Go


--------------------------------------------------------------------
--
-- Procédure            :  PS_D_PURGE_GENVIR
-- Auteur               :  JFF
-- Date                 :  12/10/2021
-- Libellé              :  !!!!!!   A COMPILER SUR LA BASE GENVIR_xxx   !!!!!!
-- Commentaires         :	
-- Références           :       
--
-- Arguments            :  @iIdSin
--				               @iIdReg
-- Retourne             :	Rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PURGE_GENVIR' AND type = 'P' )
            DROP procedure sysadm.PS_D_PURGE_GENVIR
GO

CREATE PROC sysadm.PS_D_PURGE_GENVIR
	@iTempsEnSeconde Integer
AS

Declare @iIdSeq Integer
Declare @sIdAppli varchar (4)
Declare @dcIdSin  decimal (10)
Declare @dcIdInter decimal (7)
Declare @dcIdReg decimal (7)
Declare @sCodInter varchar (1)
Declare @dtDeb Datetime

DECLARE @tb TABLE 
	( id_seq   integer identity, 
	  id_appli varchar ( 4 ),
	  id_sin   decimal ( 10 ),
	  id_inter decimal ( 7 ),
	  id_reg   decimal ( 7 ),
	  cod_inter varchar (1)
	)

Set @dtDeb = GetDate()

While DATEDIFF ( second , @dtDeb, GETDATE() ) <= @iTempsEnSeconde 
 Begin
 
	-- La suite est montée ainsi pour une question d'optimisation, ne pas pas chercher la logique :-)
	-- Après plusieurs test, c'était bien plus rapide ainsi.

	If Not Exists ( Select Top 1 1 From @tb ) 
	  Begin
		Insert into @tb
		Select Top 100000 
			wa.id_appli, 
			wa.id_sin,   
			wa.id_inter,
			wa.id_reg,  
			wa.cod_inter
		From  sysadm.w_a_virer_histo wa
		Where dte_ecr < DateAdd ( year, -5, getdate() )
	  End 

	If Not Exists ( Select Top 1 1 From @tb ) Break
	  
	Select top 1 
			@iIdSeq   = id_seq,
			@sIdAppli = id_appli, 
			@dcIdSin  = id_sin,   
			@dcIdInter = id_inter,
			@dcIdReg = id_reg,  
			@sCodInter = cod_inter
	From @tb	  	

	Delete sysadm.w_a_virer_histo Where 
			id_appli = @sIdAppli 
	And 	id_sin   = @dcIdSin 
	And		id_inter = @dcIdInter 
	And		id_reg   = @dcIdReg 
	And 	cod_inter = @sCodInter 

	Delete @tb Where id_seq = @iIdSeq

End

Go
