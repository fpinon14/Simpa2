HA$PBExportHeader$w_t_sp_cas_rech.srw
forward
global type w_t_sp_cas_rech from Window
end type
type st_2 from statictext within w_t_sp_cas_rech
end type
type st_1 from statictext within w_t_sp_cas_rech
end type
type dw_rech from datawindow within w_t_sp_cas_rech
end type
type cb_2 from commandbutton within w_t_sp_cas_rech
end type
type cb_ok from commandbutton within w_t_sp_cas_rech
end type
end forward

global type w_t_sp_cas_rech from Window
int X=1335
int Y=689
int Width=2839
int Height=1713
boolean TitleBar=true
string Title="Recherche des Homonymes"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
st_2 st_2
st_1 st_1
dw_rech dw_rech
cb_2 cb_2
cb_ok cb_ok
end type
global w_t_sp_cas_rech w_t_sp_cas_rech

on open;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_sp_cas_rech
//* Evenement 		: Open
//* Auteur			: DBI
//* Date				: 28/03/2000 18:00:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Affichage des Homonymes
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

s_Pass	stPass
DataWindowChild	dwChild, dwChild1

stPass = Message.PowerObjectParm

stPass.dwNorm[1].ShareData ( Dw_Rech )


stPass.DwNorm[1].GetChild 	( "COD_CIV", dwChild )
Dw_Rech.GetChild 				( "COD_CIV", dwChild1 )

dwChild.ShareData 			( dwChild1 )




end on

on w_t_sp_cas_rech.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_rech=create dw_rech
this.cb_2=create cb_2
this.cb_ok=create cb_ok
this.Control[]={ this.st_2,&
this.st_1,&
this.dw_rech,&
this.cb_2,&
this.cb_ok}
end on

on w_t_sp_cas_rech.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_rech)
destroy(this.cb_2)
destroy(this.cb_ok)
end on

type st_2 from statictext within w_t_sp_cas_rech
int X=430
int Y=1385
int Width=1989
int Height=73
boolean Enabled=false
string Text="Clickez sur Annuler dans le cas contraire"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_t_sp_cas_rech
int X=430
int Y=1313
int Width=1989
int Height=73
boolean Enabled=false
string Text="S$$HEX1$$e900$$ENDHEX$$lectionnez l'assur$$HEX2$$e9002000$$ENDHEX$$s'il se trouve dans la liste, puis clickez sur OK"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_rech from datawindow within w_t_sp_cas_rech
int X=51
int Y=49
int Width=2734
int Height=1225
int TabOrder=10
string DataObject="d_sp_cas_maj_nom_rech"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on clicked;Long	row

row = This.GetClickedRow ()

If row > 0 Then

	This.SelectRow ( 0, False )
	This.SelectRow ( row, True )
	This.SetRow ( row )
Else
	
	This.SelectRow ( 0, False )
	This.SetRow ( 0 )
End If
end on

type cb_2 from commandbutton within w_t_sp_cas_rech
int X=1532
int Y=1493
int Width=298
int Height=109
int TabOrder=30
string Text="&Annuler"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: cb_2
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 28/03/2000 18:04:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture sans s$$HEX1$$e900$$ENDHEX$$lection
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.sTab[1]	= ""

CloseWithReturn ( Parent, stPass )

end on

type cb_ok from commandbutton within w_t_sp_cas_rech
int X=970
int Y=1493
int Width=298
int Height=109
int TabOrder=20
string Text="&Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: cb_Ok
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 28/03/2000 18:04:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture Avec S$$HEX1$$e900$$ENDHEX$$lection
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

s_Pass	stPass
Long		lLig

lLig	=	Dw_Rech.GetSelectedRow (0)

If lLig > 0 Then 

	stPass.sTab[1]	= String ( lLig ) 
	CloseWithReturn ( Parent, stPass )
Else

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour la mise $$HEX2$$e0002000$$ENDHEX$$jour de nom"
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "CASP510"
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )

End If

end on

