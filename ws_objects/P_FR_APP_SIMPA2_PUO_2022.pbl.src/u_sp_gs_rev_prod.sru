HA$PBExportHeader$u_sp_gs_rev_prod.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux r$$HEX1$$e900$$ENDHEX$$visions d'un produit.
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
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 14:05:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Envoie tous les Inserts en cas de duplication des garanties.
//*
//* Arguments		:	Long		adcIdProd	( Val ) : identifant du produit.
//*					 	DateTime	adtMajLe		( Val )
//*
//* Retourne		: Boolean	Vrai la validation continue.
//*
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.

Long		dcIdRev			// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.
Long		dcIdRevAnc		// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision N-1.

String	sCreeLe			// Date de cr$$HEX1$$e900$$ENDHEX$$ation.
String	sMajLe			// Date de Mise $$HEX2$$e0002000$$ENDHEX$$jour.
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String	sCol [ 2 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 2 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.

Long		lRet				// Valeur de retour du Find.
Long		lNbrLig			// Nbre de ligne $$HEX2$$e0002000$$ENDHEX$$supprimer ou $$HEX2$$e0002000$$ENDHEX$$inserer.

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
				/* Duplication des pi$$HEX1$$e800$$ENDHEX$$ces                                           */
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
				/* Duplication des d$$HEX1$$e900$$ENDHEX$$lais                                           */
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
				/* Duplication des cartes affili$$HEX1$$e900$$ENDHEX$$es                                 */
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

			/*------------------------------------------------------------------*/
			/* On v$$HEX1$$e900$$ENDHEX$$rifie si d'autres revision existe : elle peuvent aussi      */
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
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 14:05:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Supprime les ligne dans les tables d$$HEX1$$e900$$ENDHEX$$pendantes de Revision.
//*
//* Arguments		:	Long		adcIdProd	( Val ) : identifant du produit.
//*
//* Retourne		:	Boolean	Vrai la validation continue.
//*
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.

Long		dcIdRev			// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision.

String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String	sCol [ 2 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 2 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.

Long		lCpt				// Compteur des lignes.
Long		lNbrLig			// Nbre de ligne $$HEX2$$e0002000$$ENDHEX$$supprimer ou $$HEX2$$e0002000$$ENDHEX$$inserer.

bRet = True

/*------------------------------------------------------------------*/
/* Verifie si une r$$HEX1$$e900$$ENDHEX$$vision $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$supprim$$HEX1$$e900$$ENDHEX$$e.                         */
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
		/* Suppression des enregistrements li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$cette r$$HEX1$$e900$$ENDHEX$$vision et $$HEX2$$e0002000$$ENDHEX$$ce    */
		/*	produit.                                                         */
		/*------------------------------------------------------------------*/
		itrTrans.PS_SUPREVISION ( adcIdProd, dcIdRev )

		If itrTrans.SQLCode < 0 Then

			F_DbErreur ( itrTrans.SQLDBCode, itrTrans.SQLErrText, itrTrans )
			bRet = False

		Else

			/*------------------------------------------------------------------*/
			/* Trace de la suppression des lignes li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$vision           */
			/* supprim$$HEX1$$e900$$ENDHEX$$e.                                                       */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste s'il existe au moins une r$$HEX1$$e900$$ENDHEX$$vision d$$HEX1$$e900$$ENDHEX$$finie pour le produit.
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

	sMess = "- Il n'y a aucune r$$HEX1$$e900$$ENDHEX$$vision.~r~n"

End If

Return ( sMess )

end function

on u_sp_gs_rev_prod.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_rev_prod.destroy
TriggerEvent( this, "destructor" )
end on

