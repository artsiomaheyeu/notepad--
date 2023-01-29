#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu File

#ce ----------------------------------------------------------------------------

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>


Func SubMenuItemSave($sCheckData)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSave) & @CRLF) 
	If Not ($sCheckData == _OpenFile($sMainFilePath, $FO_READ)) Then 
		$iReturn = _OpenFile($sMainFilePath, $FO_OVERWRITE, $sCheckData)
		If Not $iReturn Then SubMenuItemSaveAs($sCheckData)
	EndIf
EndFunc

Func SubMenuItemSaveAs($sCheckData)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemSaveAs) & @CRLF) 
	Const $sMessage = "Choose a filename..."
	$sFileSaveDialog = FileSaveDialog($sMessage, @ScriptDir & "\", "Text file (*.csv;*.txt)|All (*.*)", $FD_PATHMUSTEXIST, "", $MainForm)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Info", "No file was saved.")
		Return False
	Else
		$sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSEBASIC, -1))
		$iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSEBASIC)
		If Not $iExtension Then $sFileSaveDialog &= ".txt"

		_OpenFile($sFileSaveDialog, $FO_OVERWRITE, $sCheckData)
		Return True
	EndIf
EndFunc

Func SubMenuItemOpen()
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemOpen) & @CRLF) 
	If _ChooseFile() Then $sMainData = _OpenFile($sMainFilePath, $FO_READ)
	If $sMainData Then Return True
	Return False
EndFunc

Func SubMenuItemConfig()
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemConfig) & @CRLF)
EndFunc

Func SubMenuItemExit($sCheckData)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemExit) & @CRLF) 
	If Not ($sCheckData == $sMainData) Then
		$iAnswer = MsgBox($MB_YESNOCANCEL, "Qustion?", "Do you want to safe before exit?")
		If $iAnswer == $IDYES Then 
			Switch $bIfExternalFileConnected
				Case True
					SubMenuItemSave($sCheckData)
				Case False
					SubMenuItemSaveAs($sCheckData)
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

Func _ChooseFile($sMessage = "Select text file ...")
	$sReturn = FileOpenDialog($sMessage, @ScriptDir & "\", "Text files (*.csv; *.txt)|All (*.*)", $FD_PROMPTCREATENEW , "", $MainForm)
	If Not @error Then
		$sMainFilePath = $sReturn
		Return True
	Else
		Return False
	EndIf
EndFunc

Func _OpenFile($sPath, $sReadType, $sData="")
	$hFileOpen = FileOpen($sPath, $sReadType)
	If $hFileOpen = -1 Then
		MsgBox(4096, "Warming", "An error occurred when opening the file.")
		Return Null
	EndIf
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