HA$PBExportHeader$u_sp_gs_trait_stat_sin.sru
forward
global type u_sp_gs_trait_stat_sin from u_sp_gs_trait_anc
end type
end forward

global type u_sp_gs_trait_stat_sin from u_sp_gs_trait_anc
end type
global u_sp_gs_trait_stat_sin u_sp_gs_trait_stat_sin

type variables
Private :
	DataWindow		idw_StatSin
	DataWindow		idw_GarSinStat
	DataWindow		idw_RegGti
	DataWindow		idw_RegGti_Frais
	DataWindow		idw_UfStat

	DataWindow		idw_SuiviTrt

	Long			ilIdPeriode
	Long			ilIdPeriodePrec

	Date			idDteDeb
	Date			idDteFin

	DateTime			idtTrtDeb
	DateTime			idtTrtFin

	DateTime			idtCreeLe
end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private function long uf_trt_etape01 (long alligne)
private function long uf_trt_etape02 (long alligne)
private function long uf_cas_uf_etape01 (long alligne)
private function long uf_cas_uf_etape02 (long alligne)
private subroutine uf_periodeprecedente ()
public subroutine uf_initialiser_dw_desc (ref datawindow adw_norm[6])
private function long uf_trt_etape03 (long alligne)
private function decimal uf_somme_reggti (long alIdSin, long alidrgpt)
public subroutine uf_trace ()
private subroutine uf_suivi_trt (integer aichoix, string aslib, long alnbr, long aietat)
private subroutine uf_lancertraitement (ref s_pass astpass)
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Traitement_Sta_Sin::Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fen$$HEX1$$ea00$$ENDHEX$$tre)


Case 2					// LANCEMENT DU TRAITEMENT
	Uf_LancerTraitement ( astPass )


End Choose



end subroutine

private function long uf_trt_etape01 (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Trt_Etape01 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la Ligne
//*
//* Retourne		: Long			-1 = Il y a une erreur
//*										 1 = Tout va bien
//*
//*-----------------------------------------------------------------

Long lLig, lCodEtat, lIdSin, lIdGti, lIdRgpt, lCptOuv, lCptEtat, lCptReg, lTot, lRet
Date dDteOuv
Decimal {2} dcMtReg, dcMtProv
Boolean bTrt

lIdSin	= idw_GarSinStat.GetItemNumber	( alLigne, "ID_SIN" )
lIdGti	= idw_GarSinStat.GetItemNumber	( alLigne, "ID_GTI" )
lIdRgpt	= lIdGti
lCodEtat = idw_GarSinStat.GetItemNumber	( alLigne, "COD_ETAT" )
dDteOuv	= idw_GarSinStat.GetItemDate 		( alLigne, "DTE_OUV" )

/*------------------------------------------------------------------*/
/* La zone CPT_OUV permet de savoir si la garantie vient d'$$HEX1$$ea00$$ENDHEX$$tre     */
/* ouverte sur la p$$HEX1$$e900$$ENDHEX$$riode. (1=OUI/0=NON).                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone CPT_REG permet de savoir s'il s'agit du premier          */
/* r$$HEX1$$e800$$ENDHEX$$glement pour la garantie (1=OUI/0=NON). Cela ne concerne que   */
/* les garanties avec un COD_ETAT $$HEX2$$e0002000$$ENDHEX$$550 ou 600.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone CPT_ETAT concerne les garanties avec un COD_ETAT $$HEX2$$e0002000$$ENDHEX$$100   */
/* ou 200. Cette valeur permettra de faire un cumul sur les         */
/* garanties avec le m$$HEX1$$ea00$$ENDHEX$$me COD_ETAT. (Si COD_ETAT = 100, CPT_ETAT =  */
/* 1) (Si COD_ETAT = 200, si c'est la premi$$HEX1$$e800$$ENDHEX$$re fois que l'on        */
/* refuse la garantie (QQue soit la p$$HEX1$$e900$$ENDHEX$$riode de traitement), la      */
/* zone prend la valeur 1, sinon (Garantie d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$refus$$HEX1$$e900$$ENDHEX$$e) on met 0.  */
/*------------------------------------------------------------------*/
lCptEtat	= 0
lCptOuv	= 0
lCptReg	= 0
bTrt		= True

/*------------------------------------------------------------------*/
/* TRAITEMENT PARTICULIER POUR LES UTILISATIONS FRAUDULEUSES.       */
/*------------------------------------------------------------------*/
If	lIdGti = 7	Then
	bTrt = False
	lRet = Uf_Cas_Uf_Etape01 ( alLigne )
/*------------------------------------------------------------------*/
/* Il y a une erreur dans le traitement de la garantie UF sur les   */
/* d$$HEX1$$e900$$ENDHEX$$tails. (Le retrieve vient d'$$HEX1$$e900$$ENDHEX$$chouer, ou alors il y a une       */
/* erreur dans les commandes pr$$HEX1$$e900$$ENDHEX$$compile$$HEX1$$e900$$ENDHEX$$s). On arrete le            */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
	If	lRet = -1 Then Return ( -1 )
/*------------------------------------------------------------------*/
/* Il n'existe aucun d$$HEX1$$e900$$ENDHEX$$tail pour cette garantie UF. On va la        */
/* traiter comme un cas particulier.                                */
/*------------------------------------------------------------------*/
	If	lRet = 0	Then bTrt = True
End If

If	bTrt	Then
/*------------------------------------------------------------------*/
/* TRAITEMENT POUR LES AUTRES GARANTIES.                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si la date d'ouverture du dossier est comprise entre la date de  */
/* d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode et la date de fin de p$$HEX1$$e900$$ENDHEX$$riode alors on           */
/* positionne la zone CPT_OUV $$HEX2$$e0002000$$ENDHEX$$1.                                  */
/*------------------------------------------------------------------*/
	If	( dDteOuv >= idDteDeb ) And ( dDteOuv <= idDteFin )	Then
		lCptOuv = 1
	End If

/*------------------------------------------------------------------*/
/* On positionne un certain nombre de valeurs en fonction du        */
/* COD_ETAT de la garantie.                                         */
/*------------------------------------------------------------------*/
	Choose Case lCodEtat
	Case 100
		lCptEtat	= 1
		dcMtReg	= 0.00
		dcMtProv	= idw_GarSinStat.GetItemNumber ( alLigne, "MT_PROV" )
	
	Case 200
		lTot = 0
		itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, lCodEtat, 1, 0, lTot )
		If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
					Return ( -1 )
		Else
					If	lTot = 0 Then
						lCptEtat = 1
					End If
		End If	

		dcMtReg	= 0.00
		dcMtProv	= 0.00

	Case 550
		lTot = 0
		itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, 600, 1, 0, lTot )
		If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
					Return ( -1 )
		Else
					If	lTot = 0 Then
						lCptReg	= 1
					End If
		End If

		lCptEtat = 1
		dcMtReg	= Uf_Somme_RegGti ( lIdSin, lIdGti )
		dcMtProv	= idw_GarSinStat.GetItemNumber ( alLigne, "MT_PROV" )


	Case 600
		lTot = 0
		itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, 550, 1, 0, lTot )
		If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
					Return ( -1 )
		Else
					If	lTot = 0 Then
						lCptReg	= 1
					End If
		End If

		lCptEtat = 1
		dcMtReg	= Uf_Somme_RegGti ( lIdSin, lIdGti )
		dcMtProv	= 0.00

	Case 900
		lTot = 0
		itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, 900, 900, 3, 0, lTot )
		If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
					Return ( -1 )
		Else
					If	lTot = 0 Then
						lCptEtat = 1
					End If
		End If

		lCptReg	= 0
		dcMtReg	= 0.00
		dcMtProv	= 0.00

	End Choose

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re une ligne uniquement pour les garanties autres que     */
/* les Utilisations Frauduleuses.                                   */
/*------------------------------------------------------------------*/
	lLig = idw_StatSin.InsertRow ( 0 )

	idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
	idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )
	idw_StatSin.SetItem ( lLig, "ID_GTI", lIdGti )
	idw_StatSin.SetItem ( lLig, "ID_RGPT", lIdRgpt )
	idw_StatSin.SetItem ( lLig, "COD_ETAT", lCodEtat )

	idw_StatSin.SetItem ( lLig, "CPT_ETAT", lCptEtat )
	idw_StatSin.SetItem ( lLig, "CPT_OUV", lCptOuv )

	idw_StatSin.SetItem ( lLig, "MT_REG", dcMtReg )
	idw_StatSin.SetItem ( lLig, "CPT_REG", lCptReg )
	idw_StatSin.SetItem ( lLig, "MT_PROV", dcMtProv )

	idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
	idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
	idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )

End If

Return ( 1 )

end function

private function long uf_trt_etape02 (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Trt_Etape02 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la Ligne
//*
//* Retourne		: Long			-1 = Il y a une erreur
//*										 1 = Tout va bien
//*
//*-----------------------------------------------------------------

Long lLig, lCodEtat, lIdSin, lIdGti, lIdRgpt, lCptOuv, lCptEtat, lCptReg
Decimal {2} dcMtReg, dcMtProv

lIdSin	= idw_GarSinStat.GetItemNumber	( alLigne, "ID_SIN" )
lIdGti	= idw_GarSinStat.GetItemNumber	( alLigne, "ID_GTI" )

lIdRgpt	= lIdGti
lCodEtat = idw_GarSinStat.GetItemNumber	( alLigne, "COD_ETAT" )

lCptOuv	= 0
lCptReg	= 0
dcMtReg	= 0.00
dcMtProv	= idw_GarSinStat.GetItemNumber ( alLigne, "MT_PROV" )

/*------------------------------------------------------------------*/
/* TRAITEMENT PARTICULIER POUR LES UTILISATIONS FRAUDULEUSES.       */
/*------------------------------------------------------------------*/
If	lIdGti = 7	Then
	If	Uf_Cas_Uf_Etape02 ( alLigne ) <= 0 Then Return ( -1 )
/*------------------------------------------------------------------*/
/* TRAITEMENT POUR LES AUTRES GARANTIES.                            */
/*------------------------------------------------------------------*/
Else
/*------------------------------------------------------------------*/
/* On positionne un certain nombre de valeurs en fonction du        */
/* COD_ETAT de la garantie.                                         */
/*------------------------------------------------------------------*/
	Choose Case lCodEtat
	Case 100
		lCptEtat	= 1
	
	Case 550
		lCptEtat	= 0

	End Choose

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re une ligne uniquement pour les garanties autres que     */
/* les Utilisations Frauduleuses.                                   */
/*------------------------------------------------------------------*/
	lLig = idw_StatSin.InsertRow ( 0 )

	idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
	idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )
	idw_StatSin.SetItem ( lLig, "ID_GTI", lIdGti )
	idw_StatSin.SetItem ( lLig, "ID_RGPT", lIdRgpt )
	idw_StatSin.SetItem ( lLig, "COD_ETAT", lCodEtat )

	idw_StatSin.SetItem ( lLig, "CPT_ETAT", lCptEtat )
	idw_StatSin.SetItem ( lLig, "CPT_OUV", lCptOuv )

	idw_StatSin.SetItem ( lLig, "MT_REG", dcMtReg )
	idw_StatSin.SetItem ( lLig, "CPT_REG", lCptReg )
	idw_StatSin.SetItem ( lLig, "MT_PROV", dcMtProv )

	idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
	idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
	idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )

End If

Return ( 1 )

end function

private function long uf_cas_uf_etape01 (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Cas_Uf_Etape01 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la Ligne
//*
//* Retourne		: Long			-1 = Il y a une erreur dans les commandes pr$$HEX1$$e900$$ENDHEX$$compil$$HEX1$$e900$$ENDHEX$$es
//*										 0 = Il n'y a aucune ligne de d$$HEX1$$e900$$ENDHEX$$tail pour la garantie UF
//*										 1 = Tout est OK
//*
//*-----------------------------------------------------------------

Long lIdSin, lIdGti, lCptRgpt, lTotDetail, lLig1, lLig2, lCodEtat, lLig, lCptOuv, lIdRgpt, lTot
Long lCptEtat, lCptReg
Long lCodRgpt[3]
Long lTotCas5, lTotCas5_900

Decimal {2} dcMtReg, dcMtProv

Boolean bInsert, bCasUf910

String sRech1, sRech2, sFiltre

lIdSin		= idw_GarSinStat.GetItemNumber	( alLigne, "ID_SIN" )
lIdGti		= idw_GarSinStat.GetItemNumber	( alLigne, "ID_GTI" )

lCodRgpt[1]	= 700
lCodRgpt[2]	= 720
lCodRgpt[3]	= 740

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les d$$HEX1$$e900$$ENDHEX$$tails pour le traitement des utilisations      */
/* frauduleuses. La DW contient une zone ID_RGPT correspondant au   */
/* regroupement des ID_EVT. Cette DW est tri$$HEX1$$e900$$ENDHEX$$e sur cette colonne.   */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_UfStat.SetFilter ( sFiltre )
idw_UfStat.Filter ()

idw_UfStat.Reset ()
idw_UfStat.Retrieve ( lIdSin )
idw_UfStat.Sort ()

lTotDetail = idw_UfStat.RowCount ()

/*------------------------------------------------------------------*/
/* Il n'y a aucune ligne de d$$HEX1$$e900$$ENDHEX$$tail pour la garantie UF. On va       */
/* traiter cette garantie comme les autres.                         */
/*------------------------------------------------------------------*/
If	lTotDetail < 0	Then Return ( -1 )
If	lTotDetail = 0	Then Return (  0 )

bCasUf910 = False

For	lCptRgpt = 1 To 3
		bInsert	= False

		lCodEtat	= 0
		lCptEtat	= 0
		lCptReg	= 0

/*------------------------------------------------------------------*/
/* Le 29/03/1999                                                    */
/* Modif DGA.                                                       */
/* Suite v$$HEX1$$e900$$ENDHEX$$rif DBI, la zone IdRgpt n'est pas arm$$HEX1$$e900$$ENDHEX$$e.                 */
/*------------------------------------------------------------------*/
		lIdRgpt	= lCodRgpt[ lCptRgpt ]
	
/*------------------------------------------------------------------*/
/* CAS 1                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche au moins un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 200 et valid$$HEX5$$e9002000200020002000$$ENDHEX$$*/
/* dans la p$$HEX1$$e900$$ENDHEX$$riode de traitement.                                   */
/* De plus, il ne doit y avoir aucun d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600 Ou  */
/* COD_ETAT = 100, quelle que soit la p$$HEX1$$e900$$ENDHEX$$riode.                      */
/*------------------------------------------------------------------*/
		sRech1 = "VALIDE_LE >= DateTime ( '" + String ( idtTrtDeb ) + "' ) And VALIDE_LE <= DateTime ( '" + String ( idtTrtFin ) + &
					"' ) And COD_ETAT = 200 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
		sRech2 = "( COD_ETAT = 600 Or COD_ETAT = 100 ) And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

		lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )
		lLig2	= idw_UfStat.Find ( sRech2, 1, lTotDetail )

		If	lLig1 > 0 And lLig2 = 0 Then
			bInsert	= True
			lCodEtat = 200
			dcMtReg	= 0.00
			dcMtProv	= 0.00

			lTot	= 0
			itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, lCodEtat, 1, 0, lTot )
			If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
						Return ( -1 )
			Else
						If	lTot = 0 Then
							lCptEtat	= 1
						End If
			End If
		End If

/*------------------------------------------------------------------*/
/* CAS 2                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche au moins un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 100. De plus,    */
/* il ne doit y avoir aucun d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600. Quelle que  */
/* soit la p$$HEX1$$e900$$ENDHEX$$riode dans les deux cas.                               */
/*------------------------------------------------------------------*/
		If	Not bInsert	Then
			sRech1 = "COD_ETAT = 100 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
			sRech2 = "COD_ETAT = 600 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

			lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )
			lLig2	= idw_UfStat.Find ( sRech2, 1, lTotDetail )

			If	lLig1 > 0 And lLig2 = 0 Then
				bInsert	= True
				lCodEtat = 100
		
				lCptEtat	= 1
				dcMtReg	= 0.00
				dcMtProv	= 0.00
			End If
		End If

/*------------------------------------------------------------------*/
/* CAS 3                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche au moins un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 100 et au moins  */
/* un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600. Quelle que soit la p$$HEX1$$e900$$ENDHEX$$riode dans   */
/* les deux cas.                                                    */
/*------------------------------------------------------------------*/
		If	Not bInsert	Then
			sRech1 = "COD_ETAT = 100 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
			sRech2 = "COD_ETAT = 600 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

			lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )
			lLig2	= idw_UfStat.Find ( sRech2, 1, lTotDetail )

			If	lLig1 > 0 And lLig2 > 0 Then
				bInsert	= True
				lCodEtat = 550

				lTot	= 0
				itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, 600, 1, 0, lTot )
				If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
							Return ( -1 )
				Else
							If	lTot = 0 Then
								lCptReg	= 1
							End If
				End If

				lCptEtat	= 1
				dcMtReg	= Uf_Somme_RegGti ( lIdSin, lCodRgpt[ lCptRgpt ] )
				dcMtProv	= 0.00

			End If
		End If

/*------------------------------------------------------------------*/
/* CAS 4                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Aucun des cas pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents ne se pr$$HEX1$$e900$$ENDHEX$$sentent et il existe au moins  */
/* un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600. Quelle que soit la p$$HEX1$$e900$$ENDHEX$$riode de     */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
		If	Not bInsert	Then
			sRech1 = "COD_ETAT = 600 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

			lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )

			If	lLig1 > 0	Then
				bInsert	= True
				lCodEtat = 600

				lTot	= 0
				itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, 550, 1, 0, lTot )
				If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
						Return ( -1 )
				Else
						If	lTot = 0 Then
							lCptReg	= 1
						End If
				End If

				lCptEtat	= 1
				dcMtReg	= Uf_Somme_RegGti ( lIdSin, lCodRgpt[ lCptRgpt ] )
				dcMtProv	= 0.00
			End If
		End If

/*------------------------------------------------------------------*/
/* CAS 5                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Aucun des cas pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents ne se pr$$HEX1$$e900$$ENDHEX$$sentent et tous les d$$HEX1$$e900$$ENDHEX$$tails    */
/* poss$$HEX1$$e900$$ENDHEX$$dent un COD_ETAT = 900. Quelle que soit la p$$HEX1$$e900$$ENDHEX$$riode de       */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
		If	Not bInsert	Then
			sFiltre = "ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
			idw_UfStat.SetFilter ( sFiltre )
			idw_UfStat.Filter ()
			lTotCas5 = idw_UfStat.RowCount ()

			sFiltre = "COD_ETAT = 900 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
			idw_UfStat.SetFilter ( sFiltre )
			idw_UfStat.Filter ()
			lTotCas5_900 = idw_UfStat.RowCount ()

			sFiltre = ""
			idw_UfStat.SetFilter ( sFiltre )
			idw_UfStat.Filter ()

			If	lTotCas5 = lTotCas5_900	And ( lTotCas5 > 0 ) Then
				bInsert	= True
				lCodEtat = 900

				lTot	= 0
				itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, 900, 900, 3, 0, lTot )
				If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
						Return ( -1 )
				Else
						If	lTot = 0 Then
							lCptEtat	= 1
						End If
				End If

				lCptReg	= 0
				dcMtReg	= 0.00
				dcMtProv	= 0.00
			End If
		End If


/*------------------------------------------------------------------*/
/* INSERTION DE LA LIGNE DANS STAT_SIN SI BESOIN.                   */
/*------------------------------------------------------------------*/
		If	bInsert	Then
			bCasUf910	= True
			lCptOuv		= 0
			lTot			= 0
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine la valeur pour CPT_OUV. Pour cela, on v$$HEX1$$e900$$ENDHEX$$rifie s'il  */
/* existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$une ligne dans STAT_SIN avec le m$$HEX1$$ea00$$ENDHEX$$me ID_SIN et le    */
/* m$$HEX1$$ea00$$ENDHEX$$me ID_RGPT.                                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On utilise la proc$$HEX1$$e900$$ENDHEX$$dure PS_S02_STAT_SIN_STAT avec le param$$HEX1$$e800$$ENDHEX$$tre   */
/* 2 qui permet de faire un s$$HEX1$$e900$$ENDHEX$$lect sans se pr$$HEX1$$e900$$ENDHEX$$occuper du COD_ETAT.  */
/*------------------------------------------------------------------*/
			itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, 0, 0, 2, 0, lTot )

			If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
						Return ( -1 )
			Else
						If	lTot = 0 Then
							lCptOuv	= 1
						End If
			End If

			lLig = idw_StatSin.InsertRow ( 0 )

			idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
			idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )

			idw_StatSin.SetItem ( lLig, "ID_GTI", lIdGti )
			idw_StatSin.SetItem ( lLig, "ID_RGPT", lIdRgpt )
			idw_StatSin.SetItem ( lLig, "COD_ETAT", lCodEtat )

			idw_StatSin.SetItem ( lLig, "CPT_ETAT", lCptEtat )
			idw_StatSin.SetItem ( lLig, "CPT_OUV", lCptOuv )

			idw_StatSin.SetItem ( lLig, "MT_REG", dcMtReg )
			idw_StatSin.SetItem ( lLig, "CPT_REG", lCptReg )
			idw_StatSin.SetItem ( lLig, "MT_PROV", dcMtProv )

			idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )
		End If
Next

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si on vient de traiter au moins un de ces cas, quel   */
/* que le soit le regroupement trait$$HEX1$$e900$$ENDHEX$$. Si oui, on v$$HEX1$$e900$$ENDHEX$$rifie pour la   */
/* p$$HEX1$$e900$$ENDHEX$$riode pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente s'il existe au moins une ligne pour le m$$HEX1$$ea00$$ENDHEX$$me   */
/* ID_SIN, ID_GTI, ID_GRPT (7) et COD_ETAT = 100.                   */
/*------------------------------------------------------------------*/

If	bCasUf910	Then
	lTot			= 0

	itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, 7, 100, 100, 4, ilIdPeriodePrec, lTot )

	If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
				Return ( -1 )
	Else
		If	lTot > 0 Then
			lLig = idw_StatSin.InsertRow ( 0 )

			idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
			idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )

			idw_StatSin.SetItem ( lLig, "ID_GTI", 7 )
			idw_StatSin.SetItem ( lLig, "ID_RGPT", 7 )
			idw_StatSin.SetItem ( lLig, "COD_ETAT", 910 )

			idw_StatSin.SetItem ( lLig, "CPT_ETAT", 0 )
			idw_StatSin.SetItem ( lLig, "CPT_OUV", -1 )

			idw_StatSin.SetItem ( lLig, "MT_REG", 0.00 )
			idw_StatSin.SetItem ( lLig, "CPT_REG", 0 )
			idw_StatSin.SetItem ( lLig, "MT_PROV", 0.00 )

			idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )
		End If
	End If
		
End If

Return ( 1 )
end function

private function long uf_cas_uf_etape02 (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Cas_Uf_Etape02 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la Ligne
//*
//* Retourne		: Long			-1 = Il y a une erreur quelque part
//*										 1 = Tout est OK
//*
//*-----------------------------------------------------------------

Long lIdSin, lIdGti, lCptRgpt, lTotDetail, lLig1, lLig2, lCodEtat, lLig, lIdRgpt
Long lCodRgpt[3]

Boolean bInsert


String sRech1, sRech2

lIdSin		= idw_GarSinStat.GetItemNumber	( alLigne, "ID_SIN" )
lIdGti		= idw_GarSinStat.GetItemNumber	( alLigne, "ID_GTI" )

lCodRgpt[1]	= 700
lCodRgpt[2]	= 720
lCodRgpt[3]	= 740

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les d$$HEX1$$e900$$ENDHEX$$tails pour le traitement des utilisations      */
/* frauduleuses. La DW contient une zone ID_RGPT correspondant au   */
/* regroupement des ID_EVT. Cette DW est tri$$HEX1$$e900$$ENDHEX$$e sur cette colonne.   */
/*------------------------------------------------------------------*/
idw_UfStat.Reset ()
idw_UfStat.Retrieve ( lIdSin )
idw_UfStat.Sort ()

lTotDetail = idw_UfStat.RowCount ()

For	lCptRgpt = 1 To 3
		bInsert	= False
	
/*------------------------------------------------------------------*/
/* CAS 1                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche au moins un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 100 et valid$$HEX5$$e9002000200020002000$$ENDHEX$$*/
/* avant la date de d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode.                               */
/* De plus, il ne doit y avoir aucun d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600 et  */
/* valid$$HEX2$$e9002000$$ENDHEX$$avant la date de d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode.                        */
/*------------------------------------------------------------------*/
		sRech1 = "VALIDE_LE <= DateTime ( '" + String ( idtTrtDeb ) + "' ) And COD_ETAT = 100 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
		sRech2 = "VALIDE_LE <= DateTime ( '" + String ( idtTrtDeb ) + "' ) And COD_ETAT = 600 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

		lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )
		lLig2	= idw_UfStat.Find ( sRech2, 1, lTotDetail )

		If	lLig1 > 0 And lLig2 = 0 Then
			bInsert	= True
			lCodEtat = 100
		End If

/*------------------------------------------------------------------*/
/* CAS 2                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On recherche au moins un d$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 100 et valid$$HEX5$$e9002000200020002000$$ENDHEX$$*/
/* avant la date de d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode.                               */
/* De plus, il ne doit avoir au moins und$$HEX1$$e900$$ENDHEX$$tail avec COD_ETAT = 600  */
/* et valid$$HEX2$$e9002000$$ENDHEX$$avant la date de d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode.                      */
/*------------------------------------------------------------------*/
		If	Not bInsert	Then
			sRech1 = "VALIDE_LE <= DateTime ( '" + String ( idtTrtDeb ) + "' ) And COD_ETAT = 100 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )
			sRech2 = "VALIDE_LE <= DateTime ( '" + String ( idtTrtDeb ) + "' ) And COD_ETAT = 600 And ID_RGPT = " + String ( lCodRgpt[ lCptRgpt ] )

			lLig1	= idw_UfStat.Find ( sRech1, 1, lTotDetail )
			lLig2	= idw_UfStat.Find ( sRech2, 1, lTotDetail )

			If	lLig1 > 0 And lLig2 > 0 Then
				bInsert	= True
				lCodEtat = 550
			End If
		End If

/*------------------------------------------------------------------*/
/* INSERTION DE LA LIGNE DANS STAT_SIN SI BESOIN.                   */
/*------------------------------------------------------------------*/
		If	bInsert	Then
			lIdRgpt = lCodRgpt[ lCptRgpt ]

			lLig = idw_StatSin.InsertRow ( 0 )

			idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
			idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )

			idw_StatSin.SetItem ( lLig, "ID_GTI", lIdGti )
			idw_StatSin.SetItem ( lLig, "ID_RGPT", lIdRgpt )
			idw_StatSin.SetItem ( lLig, "COD_ETAT", lCodEtat )

			idw_StatSin.SetItem ( lLig, "CPT_ETAT", 1 )
			idw_StatSin.SetItem ( lLig, "CPT_OUV", 0 )

			idw_StatSin.SetItem ( lLig, "MT_REG", 0.00 )
			idw_StatSin.SetItem ( lLig, "CPT_REG", 0 )
			idw_StatSin.SetItem ( lLig, "MT_PROV", 0.00 )

			idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
			idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )
		End If
Next

Return ( 1 )
end function

private subroutine uf_periodeprecedente ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_PeriodePrecedente (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/01/1999 17:01:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Obtenir la valeur de la p$$HEX1$$e900$$ENDHEX$$riode pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lLig, lIdPeriode, lTot

idw_Dates.GetChild ( "DTE_FIN", dwChild )
lLig 			= dwChild.GetRow ()
lIdPeriode 	= dwChild.GetItemNumber ( lLig, "ID_PERIODE" )

/*------------------------------------------------------------------*/
/* On calcule la valeur de la p$$HEX1$$e900$$ENDHEX$$riode pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente. On positionne la  */
/* valeur dans une variable d'instance.                             */
/*------------------------------------------------------------------*/
lTot = dwChild.RowCount ()

If	lLig -1 > 0	Then
	ilIdPeriodePrec	= dwChild.GetItemNumber ( lLig - 1, "ID_PERIODE" )	
Else
	ilIdPeriodePrec	= 0
End If




end subroutine

public subroutine uf_initialiser_dw_desc (ref datawindow adw_norm[6]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: DataWindow				adw_Norm[6]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DataWindow
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table GAR_SIN                                  */
/*------------------------------------------------------------------*/
idw_GarSinStat	= adw_Norm[1]

/*------------------------------------------------------------------*/
/* DataWindow sur la table STAT_SIN                                 */
/*------------------------------------------------------------------*/
idw_StatSin	= adw_Norm[2]
idw_StatSin.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table REG_GTI                                  */
/*------------------------------------------------------------------*/
idw_RegGti	= adw_Norm[3]
idw_RegGti.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table DETAIL (Pour les UF)                     */
/*------------------------------------------------------------------*/
idw_UfStat	= adw_Norm[4]
idw_UfStat.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table REG_GTI pour les FRAIS                   */
/*------------------------------------------------------------------*/
idw_RegGti_Frais	= adw_Norm[5]
idw_RegGti_Frais.SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur la table STAT_SIN                                 */
/*------------------------------------------------------------------*/
idw_SuiviTrt	= adw_Norm[6]



end subroutine

private function long uf_trt_etape03 (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Trt_Etape03 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la Ligne
//*
//* Retourne		: Long			-1 = Il y a une erreur
//*										 1 = Tout va bien
//*
//*-----------------------------------------------------------------

Long lLig, lCodEtat, lIdSin, lIdGti, lIdRgpt, lCptOuv, lCptEtat, lCptReg, lTot
Decimal {2} dcMtReg, dcMtProv

lIdSin	= idw_RegGti_Frais.GetItemNumber	( alLigne, "ID_SIN" )
lIdGti	= -1
lIdRgpt	= -1
lCodEtat = 600

lCptEtat	= 1
lCptOuv	= 0

dcMtProv	= 0.00


lTot = 0
itrTrans.PS_S02_STAT_SIN_STAT ( lIdSin, lIdRgpt, lCodEtat, lCodEtat, 1, 0, lTot )
If	Not	F_Procedure ( stMessage, itrTrans, "PS_S02_STAT_SIN_STAT" )	Then
			Return ( -1 )
Else
			If	lTot = 0 Then
				lCptReg	= 1
			End If
End If


dcMtReg	= Uf_Somme_RegGti ( lIdSin, lIdGti )

lLig = idw_StatSin.InsertRow ( 0 )

idw_StatSin.SetItem ( lLig, "ID_SIN", lIdSin )
idw_StatSin.SetItem ( lLig, "ID_PERIODE", ilIdPeriode )
idw_StatSin.SetItem ( lLig, "ID_GTI", lIdGti )
idw_StatSin.SetItem ( lLig, "ID_RGPT", lIdRgpt )
idw_StatSin.SetItem ( lLig, "COD_ETAT", lCodEtat )

idw_StatSin.SetItem ( lLig, "CPT_ETAT", lCptEtat )
idw_StatSin.SetItem ( lLig, "CPT_OUV", lCptOuv )

idw_StatSin.SetItem ( lLig, "MT_REG", dcMtReg )
idw_StatSin.SetItem ( lLig, "CPT_REG", lCptReg )
idw_StatSin.SetItem ( lLig, "MT_PROV", dcMtProv )

idw_StatSin.SetItem ( lLig, "CREE_LE", idtCreeLe )
idw_StatSin.SetItem ( lLig, "MAJ_LE", idtCreeLe )
idw_StatSin.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )

Return ( 1 )

end function

private function decimal uf_somme_reggti (long alIdSin, long alidrgpt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Somme_RegGti (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 16:54:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long			alIdSin				(Val)	Identifiant du sinistre en cours de traitement
//* 					: Long			alIdRgpt				(Val)	Valeur de regroupement (ID_RGPT pour UF/ID_GTI pour les autes garanties)
//*
//* Retourne		: Decimal {2,0}	Montant de la table REG_GTI
//*
//*-----------------------------------------------------------------

Long lTotReg, lCpt

Decimal {2} dcMtReg, dcMtTotReg

idw_RegGti.Reset ()
idw_RegGti.Retrieve ( alIdSin, alIdRgpt, idtTrtDeb , idtTrtFin )

lTotReg = idw_RegGti.RowCount ()

For	lCpt = 1 To lTotReg
		dcMtReg = idw_RegGti.GetItemNumber ( lCpt, "MT_REG" )
		dcMtTotReg += dcMtReg
Next

/*------------------------------------------------------------------*/
/* Il est possible que l'on ne trouve aucune ligne dans REG_GTI.    */
/* Voila la manipulation exacte, insertion d'un d$$HEX1$$e900$$ENDHEX$$tail (REGLE)      */
/* pour le traitement N-1, puis insertion d'un d$$HEX1$$e900$$ENDHEX$$tail (REFUSE)      */
/* pour le traitement N. La garantie reste positionn$$HEX1$$e900$$ENDHEX$$e avec un      */
/* COD_ETAT $$HEX2$$e0002000$$ENDHEX$$600 (NORMAL). Donc on conserve la ligne dans          */
/* STAT_SIN mais avec un montant $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro.                            */
/*------------------------------------------------------------------*/
If	dcMtTotReg = 0 Then dcMtTotReg = 0

Return ( dcMtTotReg )
end function

public subroutine uf_trace ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Stat_Sin::Uf_Trace (Private)
//* Auteur			: Erick John Stark
//* Date				: 18/01/1999 15:48:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de terminer le traitement. On $$HEX1$$e900$$ENDHEX$$crit une trace r$$HEX1$$e900$$ENDHEX$$capitulative.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iPeriode
String sText, sNomMachine, sTab, sNouvelleLigne
String sLib, sDeb, sFin, sEtat
Long lTotLig, lCpt
//u_DeclarationFuncky uoDeclarationFuncky	 //[I037] Migration FUNCKy

sNouvelleLigne = "~r"
sTab				= "~t"

//uoDeclarationFuncky	= Create u_DeclarationFuncky
//sNomMachine 			= uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
sNomMachine 			= stGLB.uoWin.uf_getenvironment( "SQL" )
//Destroy					uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit dans un fichier TRT_GEN.LOG. On se sert de la fonction  */
/* Uf_Log ().                                                       */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Ouverture du fichier de trace.                                   */
/*------------------------------------------------------------------*/
Uf_Log ( 1, "", "GEN" )

/*------------------------------------------------------------------*/
/* Ecriture de l'en-t$$HEX1$$ea00$$ENDHEX$$te.                                           */
/*------------------------------------------------------------------*/
Uf_Log ( 2, "", "" )

idtTrtDeb = DateTime ( Date ( "27/11/1998"), Now () )
idtTrtFin = DateTime ( Date ( "28/12/1998"), Now () )
ilIdPeriode = 199812

iPeriode = Integer ( Right ( String ( ilIdPeriode ), 2 ) )

sText =	"Le " + String ( Datetime ( Today (), Now () ), "dd/mm/yyyy hh:mm" ) 											+	&
			" Lanc$$HEX2$$e9002000$$ENDHEX$$par Op$$HEX1$$e900$$ENDHEX$$rateur " + stGLB.sCodOper + " ( Machine " + sNomMachine + " ) " 								+	&
			"Traitement du " + String ( idtTrtDeb, "dd/mm/yyyy" ) + " au " + String ( idtTrtFin, "dd/mm/yyyy" )	+	&
			sNouvelleLigne																														+	&
			"P$$HEX1$$e900$$ENDHEX$$riode de " + F_Mois_En_Lettre ( iPeriode ) + " " + Left ( String ( ilIdPeriode ), 4 )

Uf_Log ( 3, sText, "" )
Uf_Log ( 2, "", "" )

/*------------------------------------------------------------------*/
/* On va maintenant $$HEX1$$e900$$ENDHEX$$crire le contenu de la DW du suivi de          */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
lTotLig	= idw_SuiviTrt.RowCount ()

For	lCpt = 1 To	lTotLig

		sLib	= idw_SuiviTrt.GetItemString ( lCpt, "LIB" )
		sDeb	= String ( idw_SuiviTrt.GetItemDateTime ( lCpt, "DEBUT" ), "dd/mm/yyyy hh:mm:ss" )
		sFin	= String ( idw_SuiviTrt.GetItemDateTime ( lCpt, "FIN" ), "dd/mm/yyyy hh:mm:ss" )
		sEtat	= idw_SuiviTrt.GetItemString ( lCpt, "ETAT" )

		sText	= sLib + sTab + sDeb + sTab + sFin + sTab + sEtat
		Uf_Log ( 3, sText, "" )

Next

Uf_Log ( 4, "", "" )
end subroutine

private subroutine uf_suivi_trt (integer aichoix, string aslib, long alnbr, long aietat);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trtai_Stat_Sin::Uf_Suivi_Trt (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/12/1998 14:45:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suivi visuel du traitement
//*
//* Arguments		: Integer		aiChoix				(Val)	Type de traitement attendu
//*					  String			asLib					(Val)	Libelle
//*					  Long			alNbr					(Val)	Nombre
//*					  Long			aiEtat				(Val)	Etat
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLig, lTot, lCpt

DateTime dtMaintenant

dtMaintenant = DateTime ( Today (), Now () )

Choose Case aiChoix
	Case 1
		lLig = idw_SuiviTrt.InsertRow ( 0 )

		idw_SuiviTrt.SetItem ( lLig, "LIB", asLib )
		idw_SuiviTrt.SetItem ( lLig, "DEBUT", dtMaintenant )
		idw_SuiviTrt.SetItem ( lLig, "ETAT", "En Cours" )
/*------------------------------------------------------------------*/
/* On met une boucle de temporisation. En effet, il y a un d$$HEX1$$e900$$ENDHEX$$calage */
/* entre le InsertRow() el les SetItem ().                          */
/*------------------------------------------------------------------*/
		For	lCpt = 1 To 2
				Yield ()
		Next


	Case 2
		lTot = idw_SuiviTrt.RowCount ()
		idw_SuiviTrt.SetItem ( lTot, "FIN", dtMaintenant )
		If	Not IsNull ( alNbr )	Then
			idw_SuiviTrt.SetItem ( lTot, "NBR", alNbr )
		End If

		If	Not IsNull ( aiEtat )	Then
			If	aiEtat >= 0	Then
				idw_SuiviTrt.SetItem ( lTot, "ETAT", "OK" )
			Else
				idw_SuiviTrt.SetItem ( lTot, "ETAT", "Erreur" )
			End If
		End If


/*------------------------------------------------------------------*/
/* On met une boucle de temporisation. En effet, il y a un d$$HEX1$$e900$$ENDHEX$$calage */
/* entre le InsertRow() el les SetItem ().                          */
/*------------------------------------------------------------------*/
		For	lCpt = 1 To 2
				Yield ()
		Next

End Choose


end subroutine

private subroutine uf_lancertraitement (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Traitement_Stat_Sin::Uf_LancerTraitement (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 15:36:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On lance le traitement pour la table STAT_SIN
//*
//* Arguments		: s_Pass			astPass				(R$$HEX1$$e900$$ENDHEX$$f)	Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 08/03/2004		Ctrl de l'heure de lancement du trt
//*									pour $$HEX1$$ea00$$ENDHEX$$tre s$$HEX1$$fb00$$ENDHEX$$r que la base est arr$$HEX1$$ea00$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$e
//*-----------------------------------------------------------------
//* #2	 DGA	 31/11/2004		Modification de la proc$$HEX1$$e900$$ENDHEX$$dure SPB_PS_MAIL. Ajout du param$$HEX1$$e800$$ENDHEX$$tre @asRetourErr.
//*									Dans l'utilisation actuelle - passage par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence - ce param$$HEX1$$e800$$ENDHEX$$tre ne peut $$HEX1$$ea00$$ENDHEX$$tre correctement utilis$$HEX1$$e900$$ENDHEX$$.
//*									L'envoi pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent du mail ne fonctionne pas. Probl$$HEX1$$e800$$ENDHEX$$me dans les quotes et doubles quotes
 //* 			FPI	15/09/2014	[OPTIM_SQL]
 //				FPI	21/07/2016	[VDoc21291] ajout du redressement de stat_sin
 //*-----------------------------------------------------------------

Long dcNbrLig, lTotGarSin, lCpt, lRet, lTotFrais, lTotStatSin
String sMess, sSql
Boolean bRet 

/*------------------------------------------------------------------*/
/* #1 CAG 08/03/2004 : Ctrl de l'heure du serveur                   */
/*------------------------------------------------------------------*/
DateTime dtDateJour
Time		tHeureCte
String	sContenu, sObjet

// [OPTIM_SQL]
dtDateJour=Datetime( Today(), Now() )
// :[OPTIM_SQL]
	
tHeureCte = Time ( dtDateJour )

// si les heures sont modifi$$HEX1$$e900$$ENDHEX$$es ici, il faut les modifier aussi dans le message envoy$$HEX2$$e9002000$$ENDHEX$$(cf qq lgn plus bas)
If ( tHeureCte < 22:00:00 And tHeureCte > 05:30:00 ) And Upper ( itrTrans.DataBase ) = "SIMPA2_PRO" Then

	stMessage.sTitre		= "Gestion des traitements - SIMPA2"
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "STAT130"
	stMessage.Icon			= StopSign!

	F_Message ( stMessage )

	idw_SuiviTrt.Visible	= True
	sMess	= "Lancement du traitement"
	Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )
	Uf_Suivi_Trt ( 2, stNul.str, stNul.Lng, -1 )

	sContenu	= "'Le traitement a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$lanc$$HEX2$$e9002000$$ENDHEX$$en dehors des heures autoris$$HEX1$$e900$$ENDHEX$$es, il a donc $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$annul$$HEX1$$e900$$ENDHEX$$. Il doit $$HEX1$$ea00$$ENDHEX$$tre lanc$$HEX2$$e9002000$$ENDHEX$$entre 22h et 5h30.'"
	sObjet	= "'Traitement Mensuel Simpa2'"

	sSql = "EXECUTE master.dbo.SPB_PS_MAIL '', 'productioninformatique@spb.fr', " + sContenu + ", " + sObjet + ", '', 'jf.fabry@spb.fr'"

	F_execute ( sSql, itrTrans )
	
	Return
End If

bRet 		= True
dcNbrLig = 0
lRet		= 1

/*------------------------------------------------------------------*/
/* On va d'abord v$$HEX1$$e900$$ENDHEX$$rifier les dates de traitement. On va aussi      */
/* armer la date de d$$HEX1$$e900$$ENDHEX$$but de traitement et la periode.              */
/*------------------------------------------------------------------*/
bRet = Uf_VerifierDatesTrt ( "M" )

/*------------------------------------------------------------------*/
/* Le traitement a t-il d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$lanc$$HEX2$$e9002000$$ENDHEX$$?                            */
/*------------------------------------------------------------------*/
If	bRet	Then
	idw_SuiviTrt.Visible	= True

	sMess	= "V$$HEX1$$e900$$ENDHEX$$rification si le traitement n'a pas d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$lanc$$HEX1$$e900$$ENDHEX$$"
	Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

	ilIdPeriode = idw_Dates.GetItemNumber ( 1, "ID_PERIODE" )
	itrTrans.PS_S01_STAT_SIN_STAT ( ilIdPeriode, dcNbrLig )
	If	Not	F_Procedure ( stMessage, itrTrans, "PS_S01_STAT_SIN_STAT" )	Then
/*------------------------------------------------------------------*/
/* La commande DW_S01_STAT_SIN_STAT vient d'$$HEX1$$e900$$ENDHEX$$chouer. La structure   */
/* de message est arm$$HEX1$$e900$$ENDHEX$$e sur F_Procedure.                            */
/*------------------------------------------------------------------*/
		bRet = False

		F_Message ( stMessage )
	End If
End If

If	bRet Then
	If	dcNbrLig > 0 Then
		stMessage.sTitre		= "Gestion des traitements - SIMPA2"
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "STAT110"
		stMessage.Icon			= StopSign!
		stMessage.sVar[1]		= String ( ilIdPeriode )

		F_Message ( stMessage )
		bRet = False
		Uf_Suivi_Trt ( 2, stNul.str, stNul.Lng, -1 )
	End If
End If

If	bRet Then
	Uf_Suivi_Trt ( 2, stNul.str, stNul.Lng, 1 )
/*------------------------------------------------------------------*/
/* On s'occupe de la premi$$HEX1$$e800$$ENDHEX$$re partie du traitement, c'est $$HEX2$$e0002000$$ENDHEX$$dire    */
/* toutes les garanties trait$$HEX1$$e900$$ENDHEX$$es dans la p$$HEX1$$e900$$ENDHEX$$riode.                   */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur de la p$$HEX1$$e900$$ENDHEX$$riode pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente.                  */
/*------------------------------------------------------------------*/
	Uf_PeriodePrecedente ()

	sMess	= "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des garanties valid$$HEX1$$e900$$ENDHEX$$es dans la p$$HEX1$$e900$$ENDHEX$$riode"
	Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

	idDteDeb = idw_Dates.GetItemDate ( 1, "DTE_DEB" )
	idDteFin = idw_Dates.GetItemDate ( 1, "DTE_FIN" )

	idtTrtDeb = DateTime ( idDteDeb, Time ( "00:00" ) )
	idtTrtFin = DateTime ( idDteFin, Time ( "23:59" ) )

	idw_GarSinStat.DataObject = "D_Sp_Gar_Sin_Stat_Etape01"
	idw_GarSinStat.SetTransObject ( This.itrTrans )

	lTotGarSin	= idw_GarSinStat.Retrieve ( idtTrtDeb, idtTrtFin )
	idw_GarSinStat.Sort ()

	Uf_Suivi_Trt ( 2, stNul.Str, lTotGarSin, lTotGarSin  )

/*------------------------------------------------------------------*/
/* On positionne la valeur d'instance pour CREE_LE maintenant.      */
/*------------------------------------------------------------------*/
	idtCreeLe = DateTime ( Today (), Now () )

	sMess	= "Traitement sur les garanties valid$$HEX1$$e900$$ENDHEX$$es dans la p$$HEX1$$e900$$ENDHEX$$riode"
	Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

	iuoDefil.Visible = True
	iuoDefil.Uf_Init ( lTotGarSin )

	For	lCpt = 1 To lTotGarSin
			lRet = Uf_Trt_Etape01 ( lCpt )
			If	lRet <= 0	Then
				Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )
				bRet	= False
				Exit
			End If
			iuoDefil.Uf_Progression ( lCpt )
	Next

/*------------------------------------------------------------------*/
/* On s'occupe de la seconde partie du traitement, c'est $$HEX2$$e0002000$$ENDHEX$$dire     */
/* les garanties avec un COD_ETAT $$HEX2$$e0002000$$ENDHEX$$100 ou 550 et dont VALIDE_LE    */
/* est inf$$HEX1$$e900$$ENDHEX$$rieur strictement $$HEX2$$e0002000$$ENDHEX$$la date de d$$HEX1$$e900$$ENDHEX$$but de traitement.      */
/*------------------------------------------------------------------*/
	If	bRet	Then
		Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )

		idw_GarSinStat.DataObject = "D_Sp_Gar_Sin_Stat_Etape02"
		idw_GarSinStat.SetTransObject ( This.itrTrans )

		sMess	= "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des garanties EN ATTENTE (Valid$$HEX1$$e900$$ENDHEX$$es avant la p$$HEX1$$e900$$ENDHEX$$riode)"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		lTotGarSin	= idw_GarSinStat.Retrieve ( idtTrtDeb )
		idw_GarSinStat.Sort ()

		Uf_Suivi_Trt ( 2, stNul.Str, lTotGarSin, lTotGarSin )
		iuoDefil.Uf_Init ( lTotGarSin )

		sMess	= "Traitement sur les garanties EN ATTENTE (Valid$$HEX1$$e900$$ENDHEX$$es avant la p$$HEX1$$e900$$ENDHEX$$riode)"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		For	lCpt = 1 To lTotGarSin
				lRet = Uf_Trt_Etape02 ( lCpt )
				If	lRet <= 0	Then	
					Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )
					bRet	= False
					Exit
				End If
				iuoDefil.Uf_Progression ( lCpt )
		Next
	End If

/*------------------------------------------------------------------*/
/* On s'occupe de la derni$$HEX1$$e800$$ENDHEX$$re partie du traitement, c'est $$HEX2$$e0002000$$ENDHEX$$dire    */
/* que l'on va traiter les frais valid$$HEX1$$e900$$ENDHEX$$s dans la p$$HEX1$$e900$$ENDHEX$$riode.           */
/*------------------------------------------------------------------*/
	If	bRet	Then
		Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )

		sMess	= "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des frais (Valid$$HEX1$$e900$$ENDHEX$$s dans la p$$HEX1$$e900$$ENDHEX$$riode)"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		lTotFrais	= idw_RegGti_Frais.Retrieve ( idtTrtDeb, idtTrtFin )
		idw_RegGti_Frais.Sort ()

		Uf_Suivi_Trt ( 2, stNul.Str, lTotFrais, lTotFrais )
		iuoDefil.Uf_Init ( lTotFrais )

		sMess	= "Traitement sur les frais (Valid$$HEX1$$e900$$ENDHEX$$es dans la p$$HEX1$$e900$$ENDHEX$$riode)"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		For	lCpt = 1 To lTotFrais
				lRet = Uf_Trt_Etape03 ( lCpt )
				If	lRet <= 0	Then	
					Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )
					bRet	= False
					Exit
				End If
				iuoDefil.Uf_Progression ( lCpt )
		Next
	End If

/*------------------------------------------------------------------*/
/* On envoie l'UPDATE sur idw_Stat_Sin. On va ins$$HEX1$$e900$$ENDHEX$$rer quelques      */
/* milliers de lignes. La commande SQL est positionn$$HEX1$$e900$$ENDHEX$$e sur          */
/* l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement SqlPreview de la DW. La progression de la barre de   */
/* d$$HEX1$$e900$$ENDHEX$$filement se fait aussi sur cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement.                      */
/*------------------------------------------------------------------*/
	If	bRet	Then
		Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )

		sMess	= "Insertion des lignes dans STAT_SIN"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		lTotStatSin = idw_StatSin.RowCount ()
		iuoDefil.Uf_Init ( lTotStatSin )

		lRet = idw_StatSin.Update ()

		If	lRet < 0	Then
			F_Commit ( itrTrans, False )
			Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, lRet  )
			bRet = False
		Else
//
//
			F_Commit ( itrTrans, True )
//
//
			Uf_Suivi_Trt ( 2, stNul.Str, lTotStatSin, 1  )
		End If
	End If

// [VDOC21291]
If bRet Then
	sSql = "EXECUTE sysadm.PS_U_STAT_SIN_REDRESS"

	F_execute ( sSql, itrTrans )
	
	F_Commit ( itrTrans, True )
End if
// :[VDOC21291]

/*------------------------------------------------------------------*/
/* On appelle maintenant la cr$$HEX1$$e900$$ENDHEX$$ation des lignes sur CUM_PERIODE.    */
/*------------------------------------------------------------------*/
	If	bRet	Then
		sMess	= "Insertion des lignes dans CUM_PERIODE"
		Uf_Suivi_Trt ( 1, sMess, stNul.Lng, stNul.iNum  )

		sSql = 'sysadm.PS_I01_CUM_PERIODE ' + 	String ( ilIdPeriode ) 	+ ', '	+ 	&
												'"'	+	stGLB.sCodOper				+ '"'

		// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
		//EXECUTE IMMEDIATE :sSql USING	itrTrans	;
		f_execute( sSql, itrTrans )
		// [MIGPB11] [EMD] : Fin Migration
		If	itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0	Then
		
			F_Commit ( itrTrans, False )
			Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, -1  )

			lRet = -1
			bRet = False

		Else
			Uf_Suivi_Trt ( 2, stNul.Str, stNul.Lng, 1  )
		End If
	End If

End If

/*------------------------------------------------------------------*/
/* Si le traitement $$HEX1$$e900$$ENDHEX$$choue, on affiche le message d'erreur          */
/* maintenant.                                                      */
/*------------------------------------------------------------------*/
If	lRet <= 0	And bRet = False	Then
	stMessage.sTitre	= "Gestion des statistiques - SIMPA2"
	stMessage.Icon		= StopSign!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "STAT120"

	F_Message ( stMessage )
Else
/*------------------------------------------------------------------*/
/* On va faire le COMMIT sur le moteur. (Insertion des lignes dans  */
/* STAT_SIN et CUM_PERIODE)                                         */
/*------------------------------------------------------------------*/
	F_Commit ( itrTrans, True )
End If

end subroutine

on u_sp_gs_trait_stat_sin.create
call super::create
end on

on u_sp_gs_trait_stat_sin.destroy
call super::destroy
end on

