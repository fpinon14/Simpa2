HA$PBExportHeader$w_t_sp_cas_maj_nom.srw
forward
global type w_t_sp_cas_maj_nom from w_8_traitement
end type
type dw_rech from datawindow within w_t_sp_cas_maj_nom
end type
end forward

global type w_t_sp_cas_maj_nom from w_8_traitement
integer x = 165
integer y = 196
integer width = 2747
integer height = 1532
string title = "Mise $$HEX2$$e0002000$$ENDHEX$$jour Nom/Pr$$HEX1$$e900$$ENDHEX$$nom/Civilit$$HEX1$$e900$$ENDHEX$$"
dw_rech dw_rech
end type
global w_t_sp_cas_maj_nom w_t_sp_cas_maj_nom

type variables
u_gs_sp_cas_maj_nom	iuoGsMaj

end variables

forward prototypes
public function boolean wf_preparermodifier ()
public function string wf_controlergestion ()
public function boolean wf_valider ()
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerModifier
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement Sinistre
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*
//*-----------------------------------------------------------------

istPass = Message.PowerObjectParm

iuoGsMaj.uf_Traitement ( 2, istPass )

Return ( istPass.bRetour )



end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerGestion
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de gestion des zones 
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass

iuoGsMaj.uf_Traitement ( 4, istPass )

If istPass.sTab[1] = "" Then

	// REcherche des homonymes
	iuoGsMaj.uf_Traitement ( 5, istPass )
	If Dw_Rech.RowCount () > 0 Then

		stPass.dwNorm[1] = dw_Rech
		OpenWithParm ( w_t_sp_cas_rech, stPass )
		stPass = Message.PowerObjectParm

		// Un homonyme est trouv$$HEX2$$e9002000$$ENDHEX$$on demande de faire une DMDI

		If stPass.sTab[1] <> "" Then

			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la mise $$HEX2$$e0002000$$ENDHEX$$jour de nom"
			stMessage.bErreurG	= False
			stMessage.bTrace		= False
			stMessage.sCode		= "CASP530"
			stMessage.Icon			= Information!
			stMessage.Bouton		= Ok!

			F_Message ( stMessage )
			istPass.sTab[1] = "COD_CIV_NOUVEAU"
		End If
	End If
End If
Return ( istPass.sTab[1] )

end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_valider::w_t_sp_cas_maj_nom
//* Auteur			: DBI
//* Date				: 29/03/2000 10:34:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Ok ou non
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

s_Pass	stPass

iuoGsMaj.uf_Traitement ( 7, stPass )

Return stPass.bRetour


end function

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_cas_maj_nom
//* Evenement 		: Ue_Initialiser
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Init
//*					  
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DatawindowChild	DwChild
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow			dwPassageEuro[1]
DataWindow			dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation des User Object de contr$$HEX1$$f400$$ENDHEX$$les de gestion et de     */
/* saisie                                                           */
/*------------------------------------------------------------------*/

iuoGsMaj = Create u_gs_sp_cas_maj_nom
iuoGsMaj.uf_initialisation (Dw_1, itrTrans)

iuoGsMaj.uf_initialiser_Dw ( dw_rech )


/*------------------------------------------------------------------*/
/* Gestion du Passage $$HEX2$$e0002000$$ENDHEX$$l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro




end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_cas_maj_nom
//* Evenement 		: Close
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects 												  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsMaj
If IsValid(iuoGsMaj) Then Destroy iuoGsMaj
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_sp_cas_maj_nom.create
int iCurrent
call super::create
this.dw_rech=create dw_rech
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rech
end on

on w_t_sp_cas_maj_nom.destroy
call super::destroy
destroy(this.dw_rech)
end on

type dw_1 from w_8_traitement`dw_1 within w_t_sp_cas_maj_nom
integer x = 41
integer y = 256
integer width = 2651
integer height = 1148
string dataobject = "d_sp_cas_maj_nom"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_traitement::Dw_1
//* Evenement 		: ItemError 
//* Auteur			: DBI
//* Date				: 28/03/2000
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des messages d'erreur suite aux erreurs 
//*					  de saisies
//* Commentaires	: L'Erreur de type GENE003 est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par les r$$HEX1$$e800$$ENDHEX$$gles de validation.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If	ibErreur Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie"
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "GENE003"
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!

	Choose Case isErrCol

		Case "NOM_NOUVEAU"
			stMessage.sVar[1] = "nom"

		Case "PRENOM_NOUVEAU"
			stMessage.sVar[1] = "pr$$HEX1$$e900$$ENDHEX$$nom"

	End Choose
	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement`st_titre within w_t_sp_cas_maj_nom
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_cas_maj_nom
integer y = 24
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_cas_maj_nom
integer x = 535
integer y = 24
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_cas_maj_nom
boolean visible = false
integer y = 24
integer width = 229
boolean originalsize = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_cas_maj_nom
integer y = 24
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_cas_maj_nom
integer x = 786
integer y = 24
end type

type dw_rech from datawindow within w_t_sp_cas_maj_nom
boolean visible = false
integer x = 1175
integer y = 16
integer width = 1545
integer height = 556
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "a"
string dataobject = "d_sp_cas_maj_nom_rech"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

