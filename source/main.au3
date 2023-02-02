#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=build\notepad--.exe
#AutoIt3Wrapper_Res_Description=A simple text editor for logging test sessions
#AutoIt3Wrapper_Res_Fileversion=0.0.0.5
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=notepad--
#AutoIt3Wrapper_Res_ProductVersion=0.1
#AutoIt3Wrapper_Res_CompanyName=Aheyeu Artsiom
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: main module

#ce ----------------------------------------------------------------------------

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>

#Region ### Variables section ###
#include "constants.au3"
#include "config.au3"
Global $bIfExternalFileConnected = False ; [True|False]
Global $sMainFilePath = ""
Global $sMainFileName = ""
Global $sMainData = ""
#EndRegion ### Variables section ###

#include "module/MenuItemFile.au3"
#include "module/MenuItemEdit.au3"
#include "module/MenuItemAbout.au3"

Opt("GUIResizeMode", $GUI_DOCKAUTO)

#Region ### START Koda GUI section ### Form=FormDesigner.kxf
Global $sHeaderName = $APPNAME & "  " & "Untitled"
$MainForm = GUICreate($sHeaderName, $APPSIZE[0], $APPSIZE[1], -1, -1, $WS_OVERLAPPEDWINDOW)

$MenuItemFile = GUICtrlCreateMenu("File")
GUICtrlSetState($MenuItemFile, $GUI_CHECKED)
$SubMenuItemSave = GUICtrlCreateMenuItem("Save", $MenuItemFile)
If Not $bIfExternalFileConnected Then GUICtrlSetState(-1, $GUI_DISABLE)
$SubMenuItemSaveAs = GUICtrlCreateMenuItem("Save As..", $MenuItemFile)
$SubMenuItemOpen = GUICtrlCreateMenuItem("Open...", $MenuItemFile)
Dim $aMainForm_AccelTable[3][2] = [["^s", $SubMenuItemSave],["^+s", $SubMenuItemSaveAs],["^o", $SubMenuItemOpen]]
$SubMenuItemConfig = GUICtrlCreateMenuItem("Edit config", $MenuItemFile)
GUICtrlCreateMenuItem("", $MenuItemFile)
$SubMenuItemExit = GUICtrlCreateMenuItem("Exit", $MenuItemFile)

$MenuItemEdit = GUICtrlCreateMenu("Edit")

Local $i = 1
Local $aSubMenuItemEdit[$aKeySection[0][0] + 1]
Local $iAccelTableCount = UBound($aMainForm_AccelTable)
ReDim $aMainForm_AccelTable[$iAccelTableCount + $aKeySection[0][0]][2]

While $i <= $aKeySection[0][0]
	$aSubMenuItemEdit[$i] = GUICtrlCreateMenuItem($aKeySection[$i][1] & " [" & $aKeySection[$i][0] & "]", $MenuItemEdit)
	$aMainForm_AccelTable[$iAccelTableCount][0] = "{" & $aKeySection[$i][0] & "}"
	$aMainForm_AccelTable[$iAccelTableCount][1] = $aSubMenuItemEdit[$i]
	$iAccelTableCount += 1
	$i += 1
WEnd

$MenuItemAbout = GUICtrlCreateMenu("?")
$SubMenuItemAbout = GUICtrlCreateMenuItem("About", $MenuItemAbout)

GUISetAccelerators($aMainForm_AccelTable)

$StatusBar = _GUICtrlStatusBar_Create($MainForm)
Dim $StatusBar_PartsWidth[2] = [50, -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar, "Ok", 0)
_GUICtrlStatusBar_SetText($StatusBar, "Some status", 1)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)
; TODO: Fix resizing bug

$MainEdit = GUICtrlCreateEdit("", 1, 1, $APPSIZE[0] - 2, $APPSIZE[1] - 49, BitOR($GUI_SS_DEFAULT_EDIT, $WS_BORDER))
GUICtrlSetResizing($MainEdit, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

#Region ### MAIN ###
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $SubMenuItemExit
			SubMenuItemExit(GUICtrlRead($MainEdit), $MainForm)
			Exit
		Case $GUI_EVENT_CLOSE 
			SubMenuItemExit(GUICtrlRead($MainEdit), $MainForm)
			Exit
		Case $SubMenuItemSave
			if $bIfExternalFileConnected Then
		    	$sMainData = GUICtrlRead($MainEdit)
				SubMenuItemSave($sMainData, $sMainFilePath, $MainForm)
			EndIf
		Case $SubMenuItemSaveAs
			$sMainData = GUICtrlRead($MainEdit)
			If SubMenuItemSaveAs($sMainData, $MainForm) Then
				_ChangeItemStatusTo(True)
				_UpdateFormTitle()
			EndIf
		Case $SubMenuItemOpen
			if $bIfExternalFileConnected And Not ($sMainData == GUICtrlRead($MainEdit)) Then
		    	$sMainData = GUICtrlRead($MainEdit)
				SubMenuItemSave($sMainData, $sMainFilePath, $MainForm)
			EndIf
			If SubMenuItemOpen($MainForm) Then 	
				GUICtrlSetData($MainEdit, $sMainData)
				_ChangeItemStatusTo(True)
				_UpdateFormTitle()
			EndIf
		Case $SubMenuItemConfig
			SubMenuItemConfig()
		Case $SubMenuItemAbout
			SubMenuItemAbout()
		Case $aSubMenuItemEdit[1] to $aSubMenuItemEdit[UBound($aSubMenuItemEdit) - 1]
			$vElement = _ArraySearch($aSubMenuItemEdit, $nMsg)		
			SubMenuItemEdit($aKeySection[$vElement][1], $aKeySection[$vElement][0])
	EndSwitch
WEnd
#EndRegion ### MAIN ###

#Region ### Functions ###

Func _UpdateFormTitle()
	If $bIfExternalFileConnected Then WinSetTitle($MainForm, "", $APPNAME & "  " & $sMainFileName)
EndFunc

Func _ChangeItemStatusTo($bStatus)
	If BitXOR($bIfExternalFileConnected, $bStatus) Then
		$bIfExternalFileConnected = $bStatus
		If $bStatus Then
			GUICtrlSetState($SubMenuItemSave, $GUI_ENABLE)
		Else
			GUICtrlSetState($SubMenuItemSave, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc
#EndRegion ### Functions ###
