#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu File

#ce ----------------------------------------------------------------------------

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Func SubMenuItemSave(ByRef $sData, $sPath, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSave) & @CRLF)
	Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_ICONQUESTION), "File is not safe", "Do you want to safe " & $sMainFileName & " file?")
	If $iAnswer == $IDNO Then Return
	If Not ($sData == _OpenFile($sPath, $FO_READ, $sData)) Then 
		Local $iReturn = _OpenFile($sPath, $FO_OVERWRITE, $sData)
		If Not $iReturn Then SubMenuItemSaveAs($sData, $hGUI)
	EndIf
EndFunc

Func SubMenuItemSaveAs($sData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSaveAs) & @CRLF) 
	Local Const $sMessage = "Safe: Choose a filename..."
	Local $sDialogReturnPath = FileSaveDialog($sMessage, @ScriptDir & "\", "Text file (*.csv;*.txt)|All (*.*)", $FD_PATHMUSTEXIST, "", $hGUI)
	If @error Then
		MsgBox($MB_ICONINFORMATION, "Info", "No file was saved.")
		Return False
	Else
		$sMainFileName = _GetNameFromPath($sDialogReturnPath)
		If Not _OpenFile($sDialogReturnPath, $FO_OVERWRITE, $sData) Then Return False
	EndIf
	Return True
EndFunc

Func SubMenuItemOpen($hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemOpen) & @CRLF)
	If _ChooseFile($hGUI) Then $sMainData = _OpenFile($sMainFilePath, $FO_READ, $sMainData)
	If $sMainData Then 
		$sMainFileName = _GetNameFromPath($sMainFilePath)
		Return True
	EndIf
	Return False
EndFunc

Func SubMenuItemConfig()
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemConfig) & @CRLF)
	ShellExecute("Notepad", $INI)
EndFunc

Func SubMenuItemExit($sCheckData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemExit) & @CRLF) 
	If Not ($sCheckData == $sMainData) Then
		Local $iAnswer = MsgBox(BitOR($MB_YESNOCANCEL, $MB_ICONQUESTION), "Exit", "Do you want to safe "& $sMainFileName &" file before exit?")
		If $iAnswer == $IDYES Then 
			Switch $bIfExternalFileConnected
				Case True
					SubMenuItemSave($sMainFilePath, $sCheckData, $hGUI)
				Case False
					SubMenuItemSaveAs($sCheckData, $hGUI)
			EndSwitch
		EndIf
	EndIf
EndFunc

Func _CheckFileExists($sPath)
	If Not FileExists($sPath) Then 
		if $DEBUG Then ConsoleWrite(FuncName(_CheckFileExists) & ": File is not exist" & @CRLF)
		MsgBox($MB_ICONWARNING, "Warming", "The selected file does not exist, please select another one")
		Return False
	Else
		Return True
	EndIf
EndFunc

Func _CheckFileZeroSize($sPath)
	If FileGetSize($sPath) == 0 Then
		Return True
	Else
		if $DEBUG Then ConsoleWrite(FuncName(_CheckFileZeroSize) & ": File is not empty" & @CRLF)
		Return False
	EndIf
EndFunc

Func _ChooseFile($hGUI)
	Local Const $sMessage = "Open: Select text file ..."
	Local $sDialogReturnPath = FileOpenDialog($sMessage, @ScriptDir & "\", "Text files (*.csv; *.txt)|All (*.*)", $FD_PROMPTCREATENEW , "", $hGUI)
	If @error Then
		MsgBox($MB_ICONINFORMATION, "Info", "File not selected.")
		Return False
	EndIf
	$sMainFilePath = $sDialogReturnPath
	Return True
EndFunc

Func _OpenFile($sPath, $sReadType, ByRef $sData) ;TODO: Refactor
	Local $hFileOpen = FileOpen($sPath, $sReadType)
	;### Debug CONSOLE ↓↓↓
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $hFileOpen = ' & $hFileOpen & @CRLF & '>Error code: ' & @error & @CRLF)
	If $hFileOpen = -1 Then
		MsgBox($MB_ICONWARNING, "Warming", "An error occurred when opening the file.")
		Return Null
	EndIf
	Local $sFileData
	Switch $sReadType
		Case $FO_READ
			$sFileData = FileRead($hFileOpen)
			If @error Then
				MsgBox($MB_ICONWARNING, "Warming", "An error occurred when reading the file.")
				;~ FileClose($hFileOpen)
				;~ Return Null
			EndIf
		Case Else
			$sFileData = FileWrite($sPath, $sData)
			If @error Then
				MsgBox($MB_ICONWARNING, "Warming", "An error occurred when writing the file.")
				;~ FileClose($hFileOpen)
				;~ Return Null
			EndIf		
	EndSwitch
	FileClose($hFileOpen)			
	;### Debug CONSOLE ↓↓↓
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFileData = ' & $sFileData & @CRLF & '>Error code: ' & @error & @CRLF)
	If $sFileData Then Return $sFileData
	;~ Else
	;~ 	Return Null
	;~ EndIf
EndFunc

Func _GetNameFromPath($sPath)
	Return StringTrimLeft($sPath, StringInStr($sPath, "\", $STR_NOCASESENSEBASIC, -1))
EndFunc