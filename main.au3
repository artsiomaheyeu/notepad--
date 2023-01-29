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


#include "constants.au3"
#include "config.au3"
#include "MenuItemFile.au3"
#include "MenuItemEdit.au3"
#include "MenuItemAbout.au3"

#Region ### Variables section ###
Global $bIfExternalFileConnected = False ; [True|False]
Global $sMainFilePath = ""
Global $sMainData = ""
#EndRegion ### Variables section ###

Opt("GUIResizeMode", $GUI_DOCKAUTO)

#Region ### START Koda GUI section ### Form=FormDesigner.kxf
$MainForm = GUICreate($APPNAME, $APPSIZE[0], $APPSIZE[1], -1, -1, $WS_OVERLAPPEDWINDOW)

$MenuItemFile = GUICtrlCreateMenu("File")
GUICtrlSetState($MenuItemFile, $GUI_CHECKED)
$SubMenuItemSave = GUICtrlCreateMenuItem("Save", $MenuItemFile)
If Not $bIfExternalFileConnected Then GUICtrlSetState(-1, $GUI_DISABLE)
$SubMenuItemSaveAs = GUICtrlCreateMenuItem("Save As..", $MenuItemFile)
$SubMenuItemOpen = GUICtrlCreateMenuItem("Open...", $MenuItemFile)
$SubMenuItemConfig = GUICtrlCreateMenuItem("Edit config", $MenuItemFile)
GUICtrlCreateMenuItem("", $MenuItemFile)
$SubMenuItemExit = GUICtrlCreateMenuItem("Exit", $MenuItemFile)

$MenuItemEdit = GUICtrlCreateMenu("Edit")

Local $i = 1
Local $aSubMenuItemEdit[$aKeySection[0][0]]
While $i <= $aKeySection[0][0]
	$aSubMenuItemEdit[$i - 1] = GUICtrlCreateMenuItem($aKeySection[$i][1] & " [" & $aKeySection[$i][0] & "]", $MenuItemEdit)
	$i += 1
WEnd

$MenuItemAbout = GUICtrlCreateMenu("?")
$SubMenuItemAbout = GUICtrlCreateMenuItem("About", $MenuItemAbout)

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
			SubMenuItemExit(GUICtrlRead($MainEdit))
			Exit
		Case $GUI_EVENT_CLOSE 
			SubMenuItemExit(GUICtrlRead($MainEdit))
			Exit
		Case $SubMenuItemSave
		    $sMainData = GUICtrlRead($MainEdit)
			SubMenuItemSave($sMainData)
		Case $SubMenuItemSaveAs
			$sMainData = GUICtrlRead($MainEdit)
			SubMenuItemSaveAs($sMainData)
		Case $SubMenuItemOpen
			If SubMenuItemOpen() Then 
				GUICtrlSetData($MainEdit, $sMainData)
				$bIfExternalFileConnected = True
				GUICtrlSetState($SubMenuItemSave, $GUI_ENABLE)
			EndIf
		Case $SubMenuItemConfig
			SubMenuItemConfig()
		Case $SubMenuItemAbout
			SubMenuItemAbout()
	EndSwitch
WEnd
#EndRegion ### MAIN ###

#Region ### Functions ###

#EndRegion ### Functions ###
