#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=build\notepad--.exe
#AutoIt3Wrapper_Res_Description=A simple text editor for logging test sessions
#AutoIt3Wrapper_Res_Fileversion=0.0.0.3
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
#include "MenuItemFile.au3"
#include "MenuItemEdit.au3"
#include "MenuItemAbout.au3"

Opt("GUIResizeMode", $GUI_DOCKAUTO)

#Region ### START Koda GUI section ### Form=FormDesigner.kxf
$MainForm = GUICreate($APPNAME, $APPSIZE[0], $APPSIZE[1], -1, -1, $WS_OVERLAPPEDWINDOW)

$MenuItemFile = GUICtrlCreateMenu("File")
GUICtrlSetState(-1, $GUI_CHECKED)
$SubMenuItemSave = GUICtrlCreateMenuItem("Save", $MenuItemFile)
$SubMenuItemOpen = GUICtrlCreateMenuItem("Open...", $MenuItemFile)
$SubMenuItemExit = GUICtrlCreateMenuItem("Exit", $MenuItemFile)

$MenuItemEdit = GUICtrlCreateMenu("Edit")
$SubMenuItemConfig = GUICtrlCreateMenuItem("Config", $MenuItemEdit)

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

#Region ### Variables section ###
#EndRegion ### Variables section ###

#Region ### MAIN ###
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				SubMenuItemExit()
			Case $SubMenuItemSave
				SubMenuItemSave()
			Case $SubMenuItemOpen
				SubMenuItemOpen()
			Case $SubMenuItemExit
				SubMenuItemExit()
			Case $SubMenuItemConfig
				SubMenuItemConfig()
			Case $SubMenuItemAbout
				SubMenuItemAbout()
		EndSwitch
	WEnd
#EndRegion ### MAIN ###

#Region ### Functions ###

#EndRegion ### Functions ###