HA$PBExportHeader$w_trt_test_plj.srw
forward
global type w_trt_test_plj from Window
end type
type cb_8 from commandbutton within w_trt_test_plj
end type
type cb_7 from commandbutton within w_trt_test_plj
end type
type cb_6 from commandbutton within w_trt_test_plj
end type
type cb_5 from commandbutton within w_trt_test_plj
end type
type dw_test from datawindow within w_trt_test_plj
end type
type cb_uf_preparer2 from commandbutton within w_trt_test_plj
end type
type cb_4 from commandbutton within w_trt_test_plj
end type
type cb_3 from commandbutton within w_trt_test_plj
end type
type cb_2 from commandbutton within w_trt_test_plj
end type
type cb_1 from commandbutton within w_trt_test_plj
end type
type dw_2 from datawindow within w_trt_test_plj
end type
type dw_1 from datawindow within w_trt_test_plj
end type
type uo_1 from u_sp_ifr_pilote within w_trt_test_plj
end type
end forward

global type w_trt_test_plj from Window
int X=1335
int Y=689
int Width=3617
int Height=2913
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
dw_test dw_test
cb_uf_preparer2 cb_uf_preparer2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
uo_1 uo_1
end type
global w_trt_test_plj w_trt_test_plj

on open;dw_1.SetTransObject (Sqlca)
dw_2.SetTransObject (Sqlca)
dw_1.Retrieve ()
dw_2.Retrieve ()
uo_1.uf_initialiser( dw_1, dw_2 )

dw_test.SetTransObject (SqlCa)
end on

on show;//uo_1.uf_preparer( "C", "ALCATEL", "ONETOUCH331", 150 )
end on

on w_trt_test_plj.create
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.dw_test=create dw_test
this.cb_uf_preparer2=create cb_uf_preparer2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.dw_test,&
this.cb_uf_preparer2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1,&
this.uo_1}
end on

on w_trt_test_plj.destroy
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.dw_test)
destroy(this.cb_uf_preparer2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.uo_1)
end on

type cb_8 from commandbutton within w_trt_test_plj
int X=2597
int Y=1965
int Width=247
int Height=109
int TabOrder=110
string Text="update"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_test.Update ()

f_commit ( SqlCa, False )
end on

type cb_7 from commandbutton within w_trt_test_plj
int X=2332
int Y=1969
int Width=247
int Height=109
int TabOrder=100
string Text="status"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_test.SetItemStatus ( 1, 0, Delete!, DataModified! )
dw_test.SetItemStatus ( 1, 0, Delete!, NotModified!  )
end on

type cb_6 from commandbutton within w_trt_test_plj
int X=2067
int Y=1965
int Width=247
int Height=109
int TabOrder=90
string Text="Delete"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dwItemStatus	status
long lTot

status = dw_test.getItemStatus ( 1, 0, Primary! )
dw_test.RowsCopy ( 1, 1, Primary!, dw_test, dw_test.DeletedCount () + 1, DELETE! )
status = dw_test.getItemStatus ( 1, 0, Delete! )

lTot = 1
end on

type cb_5 from commandbutton within w_trt_test_plj
int X=1806
int Y=1961
int Width=252
int Height=109
int TabOrder=80
string Text="Retrieve"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_test.Retrieve ( 202, -1, 2 )
end on

type dw_test from datawindow within w_trt_test_plj
int X=1806
int Y=2077
int Width=1006
int Height=521
int TabOrder=120
string DataObject="d_sp_gti_piece"
boolean LiveScroll=true
end type

on sqlpreview;MessageBox ( "", "SQLPREVIEW" )
end on

type cb_uf_preparer2 from commandbutton within w_trt_test_plj
int X=677
int Y=1649
int Width=462
int Height=109
int TabOrder=40
string Text="uf_preparer()"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_1.uf_preparer ( "R", "NOKIA", "3330", 50)
end on

type cb_4 from commandbutton within w_trt_test_plj
int X=1148
int Y=1529
int Width=371
int Height=109
int TabOrder=60
string Text="uf_filtrer_init"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_1.uf_filtrer_init ()
end on

type cb_3 from commandbutton within w_trt_test_plj
int X=2574
int Y=1513
int Width=385
int Height=105
int TabOrder=130
string Text="Consultation"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
s_Pass stPass

stPass.sTab   [1] = "CS"
stPass.sTab   [2] = "NOKIA"
stPass.sTab   [3] = "3310"
stPass.dwNorm [1] = dw_1
stPass.dwNorm [2] = dw_2

MessageBox ( "", dw_1.RowCount() )
MessageBox ( "", dw_2.RowCount() )


OpenWithParm ( w_Trt_Sp_Ifr_Consultation_Equiv, stPass )


end on

type cb_2 from commandbutton within w_trt_test_plj
int X=673
int Y=1529
int Width=462
int Height=109
int TabOrder=30
string Text="uf_preparer()"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_1.uf_preparer ( "C", "PANASONIC", "EBG520", 50)
end on

type cb_1 from commandbutton within w_trt_test_plj
int X=1532
int Y=1517
int Width=718
int Height=109
int TabOrder=20
string Text="Raffraichir"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uo_1.uf_Activer_AffRech(True)
end on

type dw_2 from datawindow within w_trt_test_plj
int X=631
int Y=1777
int Width=494
int Height=361
int TabOrder=70
string DataObject="d_lst_code_equivalence"
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_trt_test_plj
int X=115
int Y=2165
int Width=1573
int Height=589
int TabOrder=50
string DataObject="d_trt_sp_ifr_consult_marge"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type uo_1 from u_sp_ifr_pilote within w_trt_test_plj
int X=14
int Y=13
int Width=3534
int TabOrder=10
boolean Border=false
end type

on uo_1.destroy
call u_sp_ifr_pilote::destroy
end on

