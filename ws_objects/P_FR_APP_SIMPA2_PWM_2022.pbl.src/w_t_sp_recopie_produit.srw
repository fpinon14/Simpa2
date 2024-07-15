HA$PBExportHeader$w_t_sp_recopie_produit.srw
$PBExportComments$---} Recopie de produit
forward
global type w_t_sp_recopie_produit from w_traitement
end type
type cbx_interbase from checkbox within w_t_sp_recopie_produit
end type
type dw_2 from u_datawindow within w_t_sp_recopie_produit
end type
end forward

global type w_t_sp_recopie_produit from w_traitement
integer x = 0
integer y = 0
integer height = 1804
string title = "Recopie de produit"
windowstate windowstate = maximized!
event ue_droitecriture ( )
cbx_interbase cbx_interbase
dw_2 dw_2
end type
global w_t_sp_recopie_produit w_t_sp_recopie_produit

type variables
Private:
u_sp_gs_recopie_produit iUoSpGsRecopieProduit
end variables

forward prototypes
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_valider ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
end prototypes

event ue_droitecriture();//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_recopie_produit
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 30/12/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

PictureButton TbPict []

TbPict[1] = pb_controler

F_Droit_Ecriture_Param ( tbPict, "" )

end event

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_recopie_produit::wf_controlersaisie
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 09:13:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de saisie des champs obligatoires
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	19/04/2013	[RECOPIE_BASE]
//       JFF   12/05/2020 [PI085]
//*-----------------------------------------------------------------


String 		sCol [11 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 11 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sVal [ 11 ]			// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.

Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Boolean 		bRecopieProduit // [RECOPIE_BASE]

bRecopieProduit=(not cbx_interbase.Checked)

If not bRecopieProduit Then dw_2.Accepttext( )

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "CODE_PROD_SRC"
sCol [ 2 ]		= "REV_PROD_SRC"
sCol [ 3 ]		= "CODE_PROD_DEST"
sCol [ 4 ]		= "LIB_COURT"
sCol [ 5 ]		= "LIB_LONG"
sCol [ 6 ]		= "LIB_REV"
sCol [ 7 ]		= "EFF_REV"
sCol [ 8 ]		= "DATE_EFF"
//	[RECOPIE_BASE]
sCol [ 9 ]		= "BASE_SOURCE"
sCol [ 10 ]		= "BASE_CIBLE"
sCol [ 11 ]		= "ID_PROD"

sErr [ 1 ]		= " - Le produit source"
sErr [ 2 ]		= " - La r$$HEX1$$e900$$ENDHEX$$vision source"
sErr [ 3 ]		= " - Le nouveau code produit"
sErr [ 4 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$court"
sErr [ 5 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$long"
sErr [ 6 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$vision"
sErr [ 7 ]		= " - L'effet de r$$HEX1$$e900$$ENDHEX$$vision"
sErr [ 8 ]		= " - La date de d$$HEX1$$e900$$ENDHEX$$but d'effet"
//	[RECOPIE_BASE]
sErr [ 9 ]		= "- La base source"
sErr [ 10 ]	=  "- La base cible"
sErr [ 11 ]	= " - Le produit source"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lNbrCol

	Choose Case lCpt

		Case 1,2,3

			sVal [ lCpt ] = String ( Dw_1.GetItemNumber ( 1, sCol [ lCpt ] ) )

		Case 4 TO 7

			sVal [ lcpt ] = Dw_1.GetItemString ( 1, sCol [ lCpt ] )

		Case 8

			sVal [ lcpt ] = String(Dw_1.GetItemDateTime ( 1, sCol [ lCpt ] )) // [PI056] getItemDate en GetItemDateTime

		Case 9,10
			sVal [ lcpt ] = Dw_2.GetItemString ( 1, sCol [ lCpt ] )
			
		Case 11 
			sVal [ lCpt ] = String ( Dw_2.GetItemDecimal ( 1, sCol [ lCpt ] ) )
			
	End Choose

Next

/*------------------------------------------------------------------*/
/* Controle des zones, sont-elles renseign$$HEX1$$e900$$ENDHEX$$e ?      */
/*------------------------------------------------------------------*/
For	lCpt = 1	To	lNbrCol

			if (bRecopieProduit and lCpt < 9)  or (lCpt > 8 and not bRecopieProduit) Then // [RECOPIE_PRODUIT]
				If ( IsNull ( sVal [ lCpt ] ) or Trim ( sVal [ lCpt ] ) = "" )	Then

					If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]

					If lCpt > 8 Then 	sPos = sCol [1]// [RECOPIE_PRODUIT]
					
					sText = sText + sErr [ lCpt ] + sNouvelleLigne

				End If
			End if
Next


/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/
If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie de recopie de produits"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* Test de longueur du code produit dest            */
/*------------------------------------------------------------------*/
If sPos = "" And bRecopieProduit Then

	// [PI085]
	// [PI085]
	If F_CLE_A_TRUE ( "PI085" ) Then
		If Len(sVal[3]) < 3 or Len(sVal[3]) > 7 Then
			sPos=sCol[3]
	
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie de recopie de produits"
			stMessage.Icon			= Information!
			stMessage.sCode		= "REPR001"
	
			f_Message ( stMessage )
			
		End if
	Else 
		If Len(sVal[3]) < 3 or Len(sVal[3]) > 5 Then
			sPos=sCol[3]
	
			stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie de recopie de produits"
			stMessage.Icon			= Information!
			stMessage.sCode		= "REPR001"
	
			f_Message ( stMessage )
		End if		
	End If			
End If

If sPos = "" And (not bRecopieProduit) Then
	If sVal[9] = sVal[10] Then
		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie de recopie de produits"
		stMessage.Icon			= Information!
		stMessage.sCode		= "REPR006"

		f_Message ( stMessage )
		
		sPos = sCol [1]
	End if
End if

Return ( sPos )




end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_recopie_produit::wf_controlergestion
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 10:15:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	19/04/2013	[RECOPIE_BASE]
//*-----------------------------------------------------------------

String sCol, sLibProduit
Decimal dcidProd
datawindowchild dwChild

sCol = ""

// [RECOPIE_BASE]
sCol=iuospgsrecopieproduit.uf_controlergestion( cbx_interbase.Checked )

/*
// Contr$$HEX1$$f400$$ENDHEX$$le d'unicit$$HEX2$$e9002000$$ENDHEX$$du code produit
dcidProd 		= Dw_1.GetItemNumber ( 1, "CODE_PROD_DEST" )

sLibProduit = iuoSpGsRecopieProduit.uf_gs_Id_Produit ( dcidProd )

/*------------------------------------------------------------------*/
/* Si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$, on d$$HEX1$$e900$$ENDHEX$$clenche le message d'erreur   */
/*------------------------------------------------------------------*/
If ( sLibProduit <> "" ) Then

		stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion de Recopie de Produits"
		stMessage.sVar[1] = String ( long(dcIdProd ))
		stMessage.sVar[2] = "au produit"
		stMessage.sVar[3] = sLibProduit
		stMessage.sCode	= "REFU001"

		f_Message ( stMessage )

		sCol 		= "CODE_PROD_DEST"

End If

// Contr$$HEX1$$f400$$ENDHEX$$le du libell$$HEX1$$e900$$ENDHEX$$
sLibProduit =  Dw_1.GetItemString ( 1, "LIB_LONG" )

dw_1.getchild("CODE_PROD_SRC",dwChild)
dwChild.Retrieve( )

If dwChild.Find("LIB_LONG='" + sLibProduit + "'",1,dwChild.RowCount()) > 0 Then
	stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion de Recopie de Produits"
	stMessage.sCode	= "REPR002"

	f_Message ( stMessage )

	sCol 		= "LIB_LONG"
End if
*/
Return ( sCol )
end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_recopie_produit::wf_valider
//* Auteur			: F. Pinon
//* Date				: 11/12/2008 12:06:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
DatawindowChild dwChild
Integer iRet

pb_valider.Enabled=FALSE

stMessage.sTitre	= "Recopie de Produit"
stMessage.Icon		= Information!

iRet=iUoSpGsRecopieProduit.uf_valider(cbx_interbase.Checked ) 
Choose case iRet
	Case 0 
		stMessage.sCode	= "REPR003"
		f_Message ( stMessage )
	Case -1	
		stMessage.sCode	= "REPR004"
		f_Message ( stMessage )
	Case 3
		stMessage.sCode	= "REPR009"
		f_Message ( stMessage )
End Choose



// Mise $$HEX2$$e0002000$$ENDHEX$$jour de la liste des produits
dw_1.getChild("CODE_PROD_SRC",dwChild)
dwChild.Retrieve()

// On ne ferme pas la fen$$HEX1$$ea00$$ENDHEX$$tre
wf_pb_ctl_vld(0)

Return FALSE 
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_recopie_produit::wf_PereparerInserer
//* Auteur			: Fabry JF
//* Date				: 30/12/2008 09:13:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le autorisation Ecriture Param
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


Return True
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_sp_recopie_produit::wf_PereparerModifier
//* Auteur			: Fabry JF
//* Date				: 30/12/2008 09:13:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le autorisation Ecriture Param
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


Return True
end function

on w_t_sp_recopie_produit.create
int iCurrent
call super::create
this.cbx_interbase=create cbx_interbase
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_interbase
this.Control[iCurrent+2]=this.dw_2
end on

on w_t_sp_recopie_produit.destroy
call super::destroy
destroy(this.cbx_interbase)
destroy(this.dw_2)
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_recopie_produit
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 10:18:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
iUoSpGsRecopieProduit = CREATE u_sp_gs_recopie_produit

iUoSpGsRecopieProduit.Uf_Initialisation ( SQLCA , Dw_1, Dw_2 )

end event

type cb_debug from w_traitement`cb_debug within w_t_sp_recopie_produit
integer x = 2368
integer y = 160
end type

type dw_1 from w_traitement`dw_1 within w_t_sp_recopie_produit
integer x = 37
integer y = 184
integer width = 2583
integer height = 1484
string dataobject = "d_sp_recopie_produit"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_recopie_produit
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 10:47:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Return iUoSpGsRecopieProduit.uf_zn_trt()
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_recopie_produit
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 11:17:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Recopie de Produit"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "CODE_PROD_SRC"
				stMessage.sVar[1] = "code du produit source"
				stMessage.sCode	= "GENE003"
				
		Case "DATE_EFF"

			stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but d'effet"
			stMessage.sCode	= "GENE002"

		Case "CODE_PROD_DEST"

			stMessage.sVar[1] = "nouveau code produit"
			stMessage.sCode	= "GENE002"
			
	End Choose

	f_Message ( stMessage )

	Return This.uf_Reinitialiser ()
End If

return AncestorReturnValue

end event

type st_titre from w_traitement`st_titre within w_t_sp_recopie_produit
boolean visible = false
integer x = 2231
integer width = 411
end type

type pb_retour from w_traitement`pb_retour within w_t_sp_recopie_produit
integer y = 32
integer width = 233
integer height = 136
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean originalsize = false
end type

event pb_retour::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_recopie_produit
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 10/12/2008 09:42:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

iwParent.TriggerEvent ( "Ue_MajAccueil" )
end event

type pb_valider from w_traitement`pb_valider within w_t_sp_recopie_produit
integer y = 32
integer width = 421
integer height = 136
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Lancer la recopie"
boolean originalsize = false
string picturename = "K:\PB4OBJ\BMP\8_VALID.BMP"
end type

type pb_imprimer from w_traitement`pb_imprimer within w_t_sp_recopie_produit
boolean visible = false
integer x = 2368
integer y = 208
integer width = 215
integer height = 88
boolean enabled = false
boolean originalsize = false
end type

type pb_controler from w_traitement`pb_controler within w_t_sp_recopie_produit
integer y = 32
integer width = 233
integer height = 136
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean originalsize = false
end type

type pb_supprimer from w_traitement`pb_supprimer within w_t_sp_recopie_produit
boolean visible = false
integer x = 2395
integer y = 80
integer width = 151
integer height = 80
boolean enabled = false
end type

type cbx_interbase from checkbox within w_t_sp_recopie_produit
integer x = 1065
integer y = 60
integer width = 910
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Recopie d~'une base $$HEX2$$e0002000$$ENDHEX$$une autre"
end type

event clicked;
dw_1.Visible=(Not this.checked )
dw_2.Visible=this.checked 
	
end event

type dw_2 from u_datawindow within w_t_sp_recopie_produit
integer x = 37
integer y = 184
integer width = 2583
integer height = 432
integer taborder = 20
string title = "none"
string dataobject = "d_sp_recopie_base"
boolean border = false
end type

