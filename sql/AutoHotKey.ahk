; eveExport.ahk

; by David Skinner
; for Dasa Eve
; September 23, 2012

; This is an AutoHotKey script 
; designed to run on Window XP 2003 Server
; with MsSql2008 R2 with SQL Server manaagement Studio
; and AutoHotKey 
; after eveonline.bak has been restored

; this script requires the preparation of a sorted list of tables
; create and empty C:\EveExport directory
; start the SQL Server Management Studio
; connect
; press New Query button
; select eveonline from the Available Databases
; paste following SQL command into query window
; SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_NAME;
; press Execute button
; right click corner of Results table
; select Save As
; C:\EveExport\TABLE_NAME.csv
; close SQL Server Management Studio
; edit C:\EveExport\TABLE_NAME.csv
; delete header TABLE_NAME if found

; this macro will export all tables
; the macro cannot tell when the export of a table is complete
; so you will need to press the Yes button presented by the macro
; when the process is completed for each table.

; if there are any problems, you can rerun the macro and it
; will only export the tables that are not in C:\EveExport\

; Ctrl Alt B starts this script.
	 
#z::Run www.autohotkey.com

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return

^!b::
IfNotExist, C:\EveExport\TABLE_NAME.csv
{
    MsgBox, C:\EveExport\TABLE_NAME.csv is missing - Please read ahk file
    Return
}

CoordMode, Mouse, Relative
myLine := 0
Loop, Read, C:\EveExport\TABLE_NAME.csv
{
    IfNotExist, C:\EveExport\%A_LoopReadLine%.csv
    {
	Run "C:\Program Files\Microsoft SQL Server\100\DTS\Binn\DTSWizard.exe"
	Sleep, 3000
	
	; Welcome
	; Next
	SendInput, !n
	Sleep, 1000
	
	; Choose a Data Source
	SendInput, !T
	Sleep, 300
	SendInput, eveonline
	; Next
	Sleep, 3000
	SendInput !n
	Sleep, 1000
	
	; Choose a Destination
	; select Flat File
	SendInput !dF!i
	; File Name
	SendInput, C:\EveExport\%A_LoopReadLine%.csv
	; Select Unicode
	SendInput, !u
	; Text Qualifier Quote
	SendInput, !q{Del 6}"
	; Column names in the first data row
	SendInput, {tab}{space}
	; Next	
	Sleep, 3000
	SendInput !n
	Sleep, 1000
	
	;Specify Table Copy or Query
	; Next	
	Sleep, 3000
	SendInput !n
	Sleep, 1000
	
	; Configure Flat File Destination
	SendInput {down %myLine%}
	; Next	
	Sleep, 3000
	SendInput !n
	Sleep, 1000
	
	; Run Package
	; Next	
	Sleep, 3000
	SendInput !n
	Sleep, 1000
	
	; Complete the Wizard
	; Finish
	Sleep, 3000
	SendInput !f
	Sleep, 1000
	
	MsgBox, 1, Wait until Query is Complete
	IfMsgBox Cancel
		Return
	; Close 
	Sleep, 1000
	SendInput, {Return}
	Sleep, 3000	
    }
    myLine := myLine + 1	
}
MsgBox, Job Completed
return