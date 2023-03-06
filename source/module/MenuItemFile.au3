#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu File

#ce ----------------------------------------------------------------------------

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Func SubMenuItemSave($sPath, ByRef $sData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSave) & @CRLF)
	If Not ($sData == _OpenFile($sPath, $FO_READ, $sData)) Then 
		Local $iReturn = _OpenFile($sPath, $FO_OVERWRITE, $sData)
		If Not $iReturn Then SubMenuItemSaveAs($sData, $hGUI)
	EndIf
EndFunc

Func SubMenuItemSaveAs($sData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSaveAs) & @CRLF) 
	Local Const $sMessage = "Save: Choose a filename..."
	Local $sDialogReturnPath = FileSaveDialog($sMessage, @ScriptDir & "\", "Text file (*.csv;*.txt)|All (*.*)", $FD_PATHMUSTEXIST, "", $hGUI)
	If @error Then
		MsgBox($MB_ICONINFORMATION, "Info", "No file was saved.")
		Return False
	Else
		$sMainFileName = _GetNameFromPath($sDialogReturnPath)
		If Not _OpenFile($sDialogReturnPath, $FO_OVERWRITE, $sData) Then Return False
	EndIf
	$sMainFilePath = $sDialogReturnPath
	Return True
EndFunc

Func SubMenuItemOpen($hGUI, $sData)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemOpen) & @CRLF)
	If $bIfExternalFileConnected Then 
	Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_ICONQUESTION), "Recent changes not saved", "Do you want to save " & $sMainFileName & " file before closing?")
	If $iAnswer == $IDYES Then SubMenuItemSave($sMainFilePath, $sData, $hGUI)
	EndIf
	If _ChooseFile($hGUI) Then $sMainData = _OpenFile($sMainFilePath, $FO_READ, $sMainData)
	If $sMainData Then 
		$sMainFileName = _GetNameFromPath($sMainFilePath)
		Return True
	EndIf
	Return False
EndFunc

Func SubMenuItemConfig()  ;TODO: Create config panel with apply changes
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemConfig) & @CRLF)
	ShellExecute("Notepad", $INI)
EndFunc

Func SubMenuItemExit($sCheckData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemExit) & @CRLF) 
	If Not ($sCheckData == $sMainData) Then
		Local $iAnswer = MsgBox(BitOR($MB_YESNOCANCEL, $MB_ICONQUESTION), "Exit", "Do you want to save "& $sMainFileName &" file before exit?")
		If $iAnswer == $IDYES Then 
			Switch $bIfExternalFileConnected
				Case True
					Return SubMenuItemSave($sMainFilePath, $sCheckData, $hGUI)
				Case False
					Return SubMenuItemSaveAs($sCheckData, $hGUI)
			EndSwitch
		ElseIf $iAnswer == $IDNO Then 
			Return True
		EndIf
	EndIf
	Return False
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

Func _OpenFile($sPath, $sReadType, ByRef $sData)
	Local $hFileOpen = FileOpen($sPath, BitOR($sReadType, $FO_UTF8))
	If $hFileOpen = -1 Then MsgBox($MB_ICONWARNING, "Warming", "An error occurred when opening the file.")
	Local $sFileData
	Switch $sReadType
		Case $FO_READ
			$sFileData = FileRead($hFileOpen)
			If @error Then MsgBox($MB_ICONWARNING, "Warming", "An error occurred when reading the file.")
		Case Else
			$sFileData = FileWrite($hFileOpen, $sData)
			If @error Then MsgBox($MB_ICONWARNING, "Warming", "An error occurred when writing the file.")	
	EndSwitch
	FileClose($hFileOpen)
	Return $sFileData
EndFunc

Func _GetNameFromPath($sPath)
	Return StringTrimLeft($sPath, StringInStr($sPath, "\", $STR_NOCASESENSEBASIC, -1))
EndFunc