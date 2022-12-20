-------------------------------------------------------------------
--
-- Fichier              :       PC202553_SELECTRA.CP
-- Auteur               :       Fabry JF
-- Date                 :       23/06/2019
--
-- Commentaires         :       PS afférants aux PC202553, Selectra
--
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_S_FRANCHISE_PAR_CB
-- Auteur               :       Fabry JF
-- Date                 :       23/06/2019
-- Libellé              :		-- [PC202553_SELECTRA]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_FRANCHISE_PAR_CB' AND type = 'P' )
        DROP procedure sysadm.PS_S_FRANCHISE_PAR_CB
GO

CREATE procedure sysadm.PS_S_FRANCHISE_PAR_CB
	@adcIdSin   Decimal (10),
	@adtDteSurv  DateTime,
	@iRetour    Integer OUTPUT
AS

SET NOCOUNT ON

Declare @dtDteSurv  DateTime
Set @dtDteSurv = @adtDteSurv

If Exists ( 
		Select Top 1 1
		From   sysadm.div_sin dv,
			   sysadm.sinistre s
		Where  s.id_sin = @adcIdSin
		And    s.dte_surv = @dtDteSurv
		And    dv.id_sin = s.id_sin
		And    dv.nom_zone = 'franchise_paybox'
		And    dv.val_car = 'O'                   
   ) Begin 

		Select ws.id_sin,
			   pe.nom,
			   pe.prenom,
			   ws.dte_surv,
			   Case wg.id_gti
					When 10 Then 'VOL'
					When 11 Then 'DOMMAGE'
					When 24 Then 'OXYDATION'
					Else Convert ( varchar ( 5), wg.id_gti )
			   End 'garantie',
			   (
				   Select Top 1 mt_fra
				   From  sysadm.franchise fr
				   where fr.id_prod = ws.id_prod
				   And   fr.id_rev  = ws.id_rev
				   And   fr.id_gti  = wg.id_gti
				   And   fr.id_typ_fra = 5
				) 'mt_franchise',
				'DEJA_PAYE' 'action'

		From   sysadm.sinistre ws,
			   sysadm.gar_sin wg,
			   sysadm.personne pe
		Where  ws.id_sin = @adcIdSin
		And    ws.dte_surv = @dtDteSurv
		And    wg.id_sin = ws.id_sin
		And    pe.id_ordre = ws.id_ordre

		Set @iRetour = -2
		Return 
     End 

Select ws.id_sin,
	   ws.nom,
	   ws.prenom,
	   ws.dte_surv,
	   Case wg.id_gti
			When 10 Then 'VOL'
			When 11 Then 'DOMMAGE'
			When 24 Then 'OXYDATION'
			Else Convert ( varchar ( 5), wg.id_gti )
	   End 'garantie',
	   (
		   Select Top 1 mt_fra
		   From  sysadm.franchise fr
		   where fr.id_prod = ws.id_prod
		   And   fr.id_rev  = ws.id_rev
		   And   fr.id_gti  = wg.id_gti
		   And   fr.id_typ_fra = 5
		) 'mt_franchise',
		'A_PAYER' 'action'

From   sysadm.w_sin ws,
	   sysadm.w_gar_sin wg
Where  ws.id_sin = @adcIdSin
And    ws.dte_surv = @dtDteSurv
And    wg.id_sin = ws.id_sin

If @@Rowcount > 0 
	Begin
		Set @iRetour = 1
	End 
Else
	Begin  
		Set @iRetour = -1
	End 
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_FRANCHISE_PAR_CB
-- Auteur               :       Fabry JF
-- Date                 :       23/06/2019
-- Libellé              :		-- [PC202553_SELECTRA]
-- Commentaires         :       
-- Références           :
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_FRANCHISE_PAR_CB' AND type = 'P' )
        DROP procedure sysadm.PS_I_FRANCHISE_PAR_CB
GO

CREATE procedure sysadm.PS_I_FRANCHISE_PAR_CB
	@adcIdSin   Decimal (10),
	@dcMtFranchise Decimal ( 11,2 ),
	@iRetour    Integer OUTPUT
AS

SET NOCOUNT ON

Declare @sMess VarChar ( 500 )
Declare @iIdCt Integer
Declare @iRet Integer

Exec @iRet = sysadm.PS_WEBSERV_VALID_FRANCHISE_PAYBOX_V01 @adcIdSin, @dcMtFranchise

If @iRet > 0 Set @iRet = 1
If @iRet <= 0 Set @iRet = -1

Set @iRetour = @iRet 
Return @iRet 


--------------------------------------------------------------------
-- Procédure            :       PS_I_FRANCHISE_PAR_CB_DYSFONCT_EXTRANET
-- Auteur               :       Fabry JF
-- Date                 :       23/06/2019
-- Libellé              :		-- [PC202553_SELECTRA][RS962_DYSFONC_EXTRA]
-- Commentaires         :       
-- Références           :
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_FRANCHISE_PAR_CB_DYSFONCT_EXTRANET' AND type = 'P' )
        DROP procedure sysadm.PS_I_FRANCHISE_PAR_CB_DYSFONCT_EXTRANET
GO

CREATE procedure sysadm.PS_I_FRANCHISE_PAR_CB_DYSFONCT_EXTRANET
	@adcIdSin   Decimal (10),
	@sCodOper   VarChar ( 4 )
AS

SET NOCOUNT ON

DECLARE @tb TABLE 
	( id_sin	decimal (10 ),
	  nom       varchar (35),
	  prenom       varchar (35),
	  dte_surv  datetime,
	  id_gti    varchar ( 30),
	  mt_franchise decimal (11,2),
	  action_f   varchar ( 20 )
	)

Declare @dtDteSurv Datetime
Declare @iRetour   Integer 
Declare @dcMtFranchise Decimal ( 11,2 )
Declare @sActionF varchar (30)
Declare @iRet Integer
Declare @iIdCt Integer 
Declare @sMess	VarChar ( 2000 )
Declare @dcIdProd Decimal (7)

Select @dtDteSurv = dte_surv, @dcIdProd = id_prod From sysadm.w_sin where id_sin = @adcIdSin

Insert into @tb Exec sysadm.PS_S_FRANCHISE_PAR_CB @adcIdSin, @dtDteSurv, @iRetour OUTPUT

Select Top 1 
	   @dcMtFranchise = mt_franchise,
	   @sActionF  = action_f
From @tb

If @sActionF = 'A_PAYER' 
  Begin
	Exec @iRet = sysadm.PS_I_FRANCHISE_PAR_CB @adcIdSin, @dcMtFranchise, @iRetour OUTPUT
	If @iRet > 0 
	  Begin
		Set @sMess = 'Suite à un dysfonctionnement de l''extranet DIF/SELECTRA pour payer la franchise, le marquage de franchise payée par l''assuré a été fait manuellement par le GT ' + @sCodOper + ', les précédents contacts qui confirment le paiement de la franchise n''ont donc pas été créé par l''extranet mais bien par la procédure manuelle.'
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@sCodOper   , 300, @iIdCt OUTPUT
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	@sCodOper   , 300, @iIdCt OUTPUT
		END
	  End 

	  Delete sysadm.w_div_sin where id_sin = @adcIdSin and nom_zone = 'dysfonc_extranet_franchise'
	  Delete sysadm.div_sin where id_sin = @adcIdSin and nom_zone = 'dysfonc_extranet_franchise'

		INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_car, cree_le, maj_le, maj_par, valide_le, valide_par )
			SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 'O', GETDATE(), GETDATE(), @sCodOper, GETDATE(), @sCodOper
			FROM	sysadm.div_pro dp
			WHERE	dp.id_prod	=	@dcIdProd
				AND	dp.nom_zone	in ('dysfonc_extranet_franchise')
			
		INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_car, cpt_valide, cree_le, maj_le, maj_par )
			SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 'O', 1, GETDATE(), GETDATE(), @sCodOper
			FROM	div_pro dp
			WHERE	dp.id_prod	=	@dcIdProd
				AND	dp.nom_zone	in ('dysfonc_extranet_franchise')

  End

Return @iRet 

Go

