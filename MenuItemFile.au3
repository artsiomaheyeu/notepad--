#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu File

#ce ----------------------------------------------------------------------------

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Func SubMenuItemSave($sCheckData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSave) & @CRLF) 
	If Not ($sCheckData == _OpenFile($sMainFilePath, $FO_READ)) Then 
		$iReturn = _OpenFile($sMainFilePath, $FO_OVERWRITE, $sCheckData)
		If Not $iReturn Then SubMenuItemSaveAs($sCheckData, $hGUI)
	EndIf
EndFunc

Func SubMenuItemSaveAs($sCheckData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSaveAs) & @CRLF) 
	Local Const $sMessage = "Choose a filename..."
	Local $sFileSaveDialog = FileSaveDialog($sMessage, @ScriptDir & "\", "Text file (*.csv;*.txt)|All (*.*)", $FD_PATHMUSTEXIST, "", $hGUI)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Info", "No file was saved.")
		Return False
	Else
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSEBASIC, -1))
		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSEBASIC)
		If Not $iExtension Then $sFileSaveDialog &= ".txt"

		_OpenFile($sFileSaveDialog, $FO_OVERWRITE, $sCheckData)
		Return True
	EndIf
EndFunc

Func SubMenuItemOpen($hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemOpen) & @CRLF) 
	If _ChooseFile($hGUI) Then $sMainData = _OpenFile($sMainFilePath, $FO_READ)
	If $sMainData Then 
		$sMainFileName = _GetNameFromPath($sMainFilePath)
		Return True
	EndIf
	Return False
EndFunc

Func SubMenuItemConfig()
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemConfig) & @CRLF)
EndFunc

Func SubMenuItemExit($sCheckData, $hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemExit) & @CRLF) 
	If Not ($sCheckData == $sMainData) Then
		Local $iAnswer = MsgBox($MB_YESNOCANCEL, "Qustion?", "Do you want to safe before exit?")
		If $iAnswer == $IDYES Then 
			Switch $bIfExternalFileConnected
				Case True
					SubMenuItemSave($sCheckData, $hGUI)
				Case False
					SubMenuItemSaveAs($sCheckData, $hGUI)
			EndSwitch
		EndIf
	EndIf
EndFunc

Func _CheckFileExists($sPath)
	If Not FileExists($sPath) Then 
		if $DEBUG Then ConsoleWrite(FuncName(_CheckFileExists) & ": File is not exist" & @CRLF)
		MsgBox(4096, "Warming", "The selected file does not exist, please select another one")
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
	Local Const $sMessage = "Select text file ..."
	Local $sReturn = FileOpenDialog($sMessage, @ScriptDir & "\", "Text files (*.csv; *.txt)|All (*.*)", $FD_PROMPTCREATENEW , "", $hGUI)
	If Not @error Then
		$sMainFilePath = $sReturn
		Return True
	Else
		Return False
	EndIf
EndFunc

Func _OpenFile($sPath, $sReadType, $sData="")
	Local $hFileOpen = FileOpen($sPath, $sReadType)
	If $hFileOpen = -1 Then
		MsgBox(4096, "Warming", "An error occurred when opening the file.")
		Return Null
	EndIf
	Local $sFileRead
	Switch $sReadType
		Case $FO_READ
			$sFileRead = FileRead($hFileOpen)
			If @error Then
				MsgBox(4096, "Warming", "An error occurred when reading the file.")
				Return Null
			EndIf
		Case Else
			$sFileRead = FileWrite($sPath, $sData)
			If @error Then
				MsgBox(4096, "Warming", "An error occurred when writing the file.")
				Return Null
			EndIf		
	EndSwitch
	
	FileClose($hFileOpen)
	
	Return $sFileRead
EndFunc

Func _GetNameFromPath($sPath)
	Return StringTrimLeft($sPath, StringInStr($sPath, "\", $STR_NOCASESENSEBASIC, -1))
EndFunc