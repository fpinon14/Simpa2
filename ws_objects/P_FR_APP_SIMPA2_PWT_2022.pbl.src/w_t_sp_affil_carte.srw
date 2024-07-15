HA$PBExportHeader$w_t_sp_affil_carte.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre response pour demander la date d'affiliation pour les cartes affili$$HEX1$$e900$$ENDHEX$$es dont la date d'affiliation n'est pas encore renseign$$HEX1$$e900$$ENDHEX$$e.
forward
global type w_t_sp_affil_carte from w_ancetre
end type
type st_1 from statictext within w_t_sp_affil_carte
end type
type em_1 from editmask within w_t_sp_affil_carte
end type
type pb_1 from u_8_pbretour within w_t_sp_affil_carte
end type
type pb_2 from u_8_pbvalider within w_t_sp_affil_carte
end type
end forward

global type w_t_sp_affil_carte from w_ancetre
int X=1139
int Y=861
int Width=1363
int Height=677
WindowType WindowType=response!
boolean Visible=true
boolean TitleBar=true
string Title="Date d'affiliation pour les cartes ins$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es"
st_1 st_1
em_1 em_1
pb_1 pb_1
pb_2 pb_2
end type
global w_t_sp_affil_carte w_t_sp_affil_carte

on ue_valider;call w_ancetre::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sa_affil_carte
//* Evenement 		: Ue_Valider
//* Auteur			: V.Capelle
//* Date				: 27/03/1997 11:40:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lecture de la date d'affiliation saisie en renvoi
//*					  de cette date $$HEX2$$e0002000$$ENDHEX$$la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 		sDateAffiliation

sDateAffiliation		=	em_1.Text
//Message.StringParm	=	sDateAffiliation

CloseWithReturn ( This, sDateAffiliation )

end on

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sa_affil_carte
//* Evenement 		: Ue_Retour
//* Auteur			: V.Capelle
//* Date				: 27/03/1997 11:45:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre et renvoi de la valeur Null
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Message.StringParm	= stNul.str

Close ( This )

end on

on w_t_sp_affil_carte.create
int iCurrent
call w_ancetre::create
this.st_1=create st_1
this.em_1=create em_1
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_1
this.Control[iCurrent+2]=em_1
this.Control[iCurrent+3]=pb_1
this.Control[iCurrent+4]=pb_2
end on

on w_t_sp_affil_carte.destroy
call w_ancetre::destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.pb_1)
destroy(this.pb_2)
end on

type st_1 from statictext within w_t_sp_affil_carte
int X=202
int Y=81
int Width=956
int Height=133
boolean Enabled=false
string Text="Entrez la date d'affiliation pour les nouvelles cartes:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_t_sp_affil_carte
int X=494
int Y=249
int Width=366
int Height=89
int TabOrder=10
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
long TextColor=16711680
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_1 from u_8_pbretour within w_t_sp_affil_carte
int X=769
int Y=397
int TabOrder=30
end type

type pb_2 from u_8_pbvalider within w_t_sp_affil_carte
int X=357
int Y=397
int TabOrder=20
int TextSize=-7
string FaceName="Arial"
end type

