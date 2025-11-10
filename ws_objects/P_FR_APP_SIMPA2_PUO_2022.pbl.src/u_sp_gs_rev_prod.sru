$PBExportHeader$u_sp_gs_rev_prod.sru
$PBExportComments$---} User Object pour les contrôles de gestion relatifs aux révisions d'un produit.
forward
global type u_sp_gs_rev_prod from u_spb_gs_anc
end type
end forward

global type u_sp_gs_rev_prod from u_spb_gs_anc
end type
global u_sp_gs_rev_prod u_sp_gs_rev_prod

forward prototypes
public function boolean uf_terminervalider (long adcidprod, datetime adtmajle)
public function boolean uf_preparervalider (long adcidprod)
public function string uf_gs_presencerevision ()
end prototypes

public function boolean uf_terminervalider (long adcidprod, datetime adtmajle);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_TerminerValider
//* Auteur			:	N°6
//* Date				:	19/06/1997 14:05:59
//* Libellé			: 
//* Commentaires	:	Envoie tous les Inserts en cas de duplication des garanties.
//*
//* Arguments		:	Long		adcIdProd	( Val ) : identifant du produit.
//*					 	DateTime	adtMajLe		( Val )
//*
//* Retourne		: Boolean	Vrai la validation continue.
//*
//*-----------------------------------------------------------------------*/
// 10/09/2025	FPI	[FPI_20250910] ajout de la table souplesse
/*-----------------------------------------------------------------------*/

Boolean	bRet				// Valeur de retour de la fonction.

Long		dcIdRev			// Identifiant de la révision.
Long		dcIdRevAnc		// Identifiant de la révision N-1.

String	sCreeLe			// Date de création.
String	sMajLe			// Date de Mise à jour.
String	sTable			// Nom de la table à tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement tracé.
String	sCol [ 2 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 2 ]		// Tableau des valeurs des colonnes à tracer.

Long		lRet				// Valeur de retour du Find.
Long		lNbrLig			// Nbre de ligne à supprimer ou à inserer.

bRet = True

/*------------------------------------------------------------------*/
/* Validation du detail puis insertion des lignes si duplication    */
/*------------------------------------------------------------------*/
bRet = idw_1.Uf_Update ()

If bRet	Then

	lNbrLig = idw_1.RowCount ()

	If lNbrLig > 0	Then

		lRet 		= idw_1.Find ( "#10 = 'O'", 1, lNbrLig )
		sCreeLe  = "'" + String ( adtMajLe, "yyyy-mm-dd hh:mm:ss.ff" ) + "'"
		sMajLe   = "'" + String ( adtMajLe, "yyyy-mm-dd hh:mm:ss.ff" ) + "'"

		Do While lRet > 0

			dcIdRev    = idw_1.GetItemNumber ( lRet, "ID_REV" )
			dcIdRevAnc = idw_1.GetItemNumber ( lRet, "ID_REV" ) -1

			sType       = "C"
			sCol[ 1 ]   = "ID_PROD"
			sCol[ 2 ]   = "ID_REV"
			sCle[ 1 ] 	= "'" + String ( adcIdProd  ) + "'"
			sCle[ 2 ] 	= "'" + String ( dcIdRev    ) + "'"
			sVal[ 1 ] 	= "'" + String ( adcIdProd  ) + "'"
			sVal[ 2 ] 	= "'" + String ( dcIdRevAnc ) + "'"

			/*------------------------------------------------------------------*/
			/* Duplication des garanties                                        */
			/*------------------------------------------------------------------*/
         itrTrans.IM_I01_GARANTIE ( adcIdProd , &
												dcIdRev   , &
												dcIdRevAnc, &
												adtMajLe  , &
												adtMajLe  , &
												stGlb.sCodOper )

			If itrTrans.SQLCode < 0 Then

				F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
				bRet = False

			ElseIf iTrTrans.SQLCode = 0 Then

				sTable 		= "GARANTIE"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des pièces                                           */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_PIECE ( adcIdProd , &
			                           dcIdRev   , &
	   	                          	dcIdRevAnc, &
	      		                     adtMajLe  , &
	            	                  adtMajLe  , &
	               	               stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "PIECE"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des motifs de refus                                  */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_MOTIF ( adcIdProd , &
												dcIdRev   , &
												dcIdRevAnc, &
												adtMajLe  , &
												adtMajLe  , &
												stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable = "MOTIF"
					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des conditions                                       */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_CONDITION ( adcIdProd , &
													 dcIdRev   , &
					                    		 dcIdRevAnc, &
		               						 adtMajLe  , &
	                             			 adtMajLe  , &
	                            			 stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "CONDITION"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des délais                                           */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_DELAI 	(	adcIdProd , &
													dcIdRev   , &
					                    		dcIdRevAnc, &
		               						adtMajLe  , &
	                             			adtMajLe  , &
	                            			stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "DELAI"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des plafonds                                         */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_PLAFOND (	adcIdProd , &
													dcIdRev   , &
					                    		dcIdRevAnc, &
		               						adtMajLe  , &
	                             			adtMajLe  , &
	                            			stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "PLAFOND"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des franchises                                       */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_FRANCHISE  (	adcIdProd , &
														dcIdRev   , &
					                    			dcIdRevAnc, &
		               							adtMajLe  , &
	                             				adtMajLe  , &
	                            				stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "FRANCHISE"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des cartes affiliées                                 */
				/*------------------------------------------------------------------*/
	         itrTrans.IM_I01_AFFILIER (  adcIdProd , &
													 dcIdRev   , &
					                    		 dcIdRevAnc, &
		               						 adtMajLe  , &
	                             			 adtMajLe  , &
	                            			 stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "AFFILIER"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If

			// [FPI_20250910] 
			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Duplication des souplesses                          */
				/*------------------------------------------------------------------*/
	         	itrTrans.IM_I01_SOUPLESSE (  adcIdProd , &
													 dcIdRev   , &
					                    		 dcIdRevAnc, &
		               						 adtMajLe  , &
	                             			 adtMajLe  , &
	                            			 stGlb.sCodOper )

				If itrTrans.SQLCode < 0 Then

					F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
					bRet = False

				ElseIf iTrTrans.SQLCode = 0 Then

					sTable 		= "SOUPLESSE"

					If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
	
						bRet = False

					End If

				End If

			End If
			// :[FPI_20250910] 
			
			/*------------------------------------------------------------------*/
			/* On vérifie si d'autres revision existe : elle peuvent aussi      */
			/* impliquer une duplication.                                       */
			/*------------------------------------------------------------------*/
			If bRet And ( lRet < lNbrLig )	Then

				lRet = idw_1.Find ( "#10='O'", lRet, lNbrLig )

			Else

				lRet = 0

			End If

		Loop

	End If

End If

Return ( bRet )
end function

public function boolean uf_preparervalider (long adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_PreparerValider ()
//* Auteur			:	N°6
//* Date				:	19/06/1997 14:05:59
//* Libellé			: 
//* Commentaires	:	Supprime les ligne dans les tables dépendantes de Revision.
//*
//* Arguments		:	Long		adcIdProd	( Val ) : identifant du produit.
//*
//* Retourne		:	Boolean	Vrai la validation continue.
//*
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.

Long		dcIdRev			// Identifiant de la révision.

String	sTable			// Nom de la table à tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement tracé.
String	sCol [ 2 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 2 ]		// Tableau des valeurs des colonnes à tracer.

Long		lCpt				// Compteur des lignes.
Long		lNbrLig			// Nbre de ligne à supprimer ou à inserer.

bRet = True

/*------------------------------------------------------------------*/
/* Verifie si une révision à été supprimée.                         */
/* Si oui supprimer les lignes dans les tables :                    */
/*		ETABLISSEMENT                                                 */
/*		GARANTIE                                                      */
/*		PIECE                                                         */
/*		MOTIF                                                         */
/*		CONDITION                                                     */
/*		DELAI, PLAFOND et FRANCHISE                                   */
/*		AFFILIER                                                      */
/*------------------------------------------------------------------*/

lNbrLig = idw_1.DeletedCount ()

If LNbrLig > 0	Then

	For lCpt = 1	To lNbrLig

		dcIdRev  = idw_1.GetItemNumber ( lCpt, "ID_REV", DELETE!, False )

		/*------------------------------------------------------------------*/
		/* Suppression des enregistrements liés à cette révision et à ce    */
		/*	produit.                                                         */
		/*------------------------------------------------------------------*/
		itrTrans.PS_SUPREVISION ( adcIdProd, dcIdRev )

		If itrTrans.SQLCode < 0 Then

			F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
			bRet = False

		Else

			/*------------------------------------------------------------------*/
			/* Trace de la suppression des lignes liées à la révision           */
			/* supprimée.                                                       */
			/*------------------------------------------------------------------*/
			sType 		= 'D'
			sCle[ 1 ] 	= "'" + String ( adcIdProd ) + "'"
			sCle[ 2 ] 	= "'" + String ( dcIdRev   ) + "'"

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de CONDITION                        */
			/*------------------------------------------------------------------*/
			sTable 		= "CONDITION"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If



			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de PIECE                            */
				/*------------------------------------------------------------------*/
				sTable 		= "PIECE"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de MOTIF                            */
				/*------------------------------------------------------------------*/
				sTable 		= "MOTIF"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de GARANTIE                         */
				/*------------------------------------------------------------------*/
				sTable 		= "GARANTIE"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de DELAI                            */
				/*------------------------------------------------------------------*/
				sTable 		= "DELAI"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de PLAFOND                          */
				/*------------------------------------------------------------------*/
				sTable 		= "PLAFOND"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes de FRANCHISE                        */
				/*------------------------------------------------------------------*/
				sTable 		= "FRANCHISE"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes dans AFFILIER                       */
				/*------------------------------------------------------------------*/
				sTable 		= "AFFILIER"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If

			/*------------------------------------------------------------------*/
			/* Trace suppression des lignes de ETABLISSEMENT                    */
			/*------------------------------------------------------------------*/
			sTable 		= "ETABLISSEMENT"

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If
			
			
			// [FPI_20250910] ajout de la table souplesse
			If bRet	Then

				/*------------------------------------------------------------------*/
				/* Trace suppression des lignes dans SOUPLESSE              */
				/*------------------------------------------------------------------*/
				sTable 		= "SOUPLESSE"

				If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

					bRet = False

				End If

			End If
			// :[FPI_20250910]
			
		End If
		
		If Not ( bRet )	Then Exit

	Next

End If

Return ( bRet )
end function

public function string uf_gs_presencerevision ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Gs_PresenceRevision
//* Auteur			:	YP
//* Date				:	01/09/1997 17:13:46
//* Libellé			:	Teste s'il existe au moins une révision définie pour le produit.
//*
//* Commentaires	: 
//*
//* Arguments		:	
//*
//* Retourne		:	String
//*
//*-----------------------------------------------------------------

String		sMess		// Valeur de retour de la fonction

If iDw_1.RowCount () = 0 then

	sMess = "- Il n'y a aucune révision.~r~n"

End If

Return ( sMess )

end function

on u_sp_gs_rev_prod.create
call super::create
end on

on u_sp_gs_rev_prod.destroy
call super::destroy
end on

