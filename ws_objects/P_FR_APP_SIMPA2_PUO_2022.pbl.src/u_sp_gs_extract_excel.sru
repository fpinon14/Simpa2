HA$PBExportHeader$u_sp_gs_extract_excel.sru
$PBExportComments$[PM02]
forward
global type u_sp_gs_extract_excel from nonvisualobject
end type
end forward

global type u_sp_gs_extract_excel from nonvisualobject autoinstantiate
end type

forward prototypes
public function boolean uf_extract_excel (string slistedatastore[], string snomonglet[], string snomfichier)
end prototypes

public function boolean uf_extract_excel (string slistedatastore[], string snomonglet[], string snomfichier);
//*-----------------------------------------------------------------
//*
//* Fonction		: (Untitled)::uf_extract_excel
//* Auteur			: F. Pinon
//* Date				: 01/04/2011 10:26:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string slistedatastore[]	 */
/* 	value string snomonglet[]	 */
/* 	value string snomfichier	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bRet
oleobject	myoleobject
integer		rc, i, count, j, colcount
datastore	mydatastore
string		mydata, colname, colnames

bRet=TRUE

mydatastore = CREATE datastore

myoleobject = CREATE oleobject
rc = myoleobject.ConnectToNewObject ( "Excel.Application" )
IF rc <> 0 THEN
	Return False
END IF

try
	myoleobject.Workbooks.Add()
	for i = 1 to UpperBound(sListeDatastore)
		If  myoleobject.ActiveWorkbook.Sheets.Count < i Then
			myoleobject.ActiveWorkbook.Sheets.Add()
		End if
		mydatastore.DataObject = sListeDatastore[i]
		mydatastore.SetTransObject(SQLCA)
		mydatastore.Retrieve()
		colcount = Integer ( mydatastore.object.DataWindow.column.count )
		FOR j = 1 TO colcount
			colname = mydatastore.Describe ( "#" + String ( j ) + ".Name" )
			CHOOSE CASE j
				CASE 1
					colnames = colname
				CASE ELSE
					colnames = colnames + '~t' + colname
			END CHOOSE
		NEXT
		colnames = colnames + "~r~n"
		mydata = mydatastore.Object.DataWindow.Data
		ClipBoard ( colnames + mydata )
		myoleobject.ActiveWorkbook.Sheets(i).Paste()
		myoleobject.ActiveWorkbook.Sheets(i).Name=snomonglet[i]
	next
	
	myoleobject.Application.DisplayAlerts = False
	myoleobject.ActiveWorkbook.SaveAs(sNomFichier)
	myoleobject.Application.DisplayAlerts = True
	
	myoleobject.ActiveWorkbook.Close()
	myoleobject.DisconnectObject()
catch ( exception e )
	bRet=FALSE
CATCH ( RuntimeError re )
	bRet=FALSE
finally
	Destroy myoleobject
end try

Return bRet
end function

on u_sp_gs_extract_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_extract_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

