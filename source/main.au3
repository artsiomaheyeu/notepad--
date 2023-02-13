#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=D:\notepad--\notepad--\build\notepad--.exe
#AutoIt3Wrapper_Res_Description=A simple text editor for logging test sessions
#AutoIt3Wrapper_Res_Fileversion=0.0.0.7
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=notepad--
#AutoIt3Wrapper_Res_ProductVersion=0.1
#AutoIt3Wrapper_Res_CompanyName=Aheyeu Artsiom
#AutoIt3Wrapper_Run_After=copy "config.ini" "D:\notepad--\notepad--\build"
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
#include <Date.au3>

#Region ### Variables section ###
#include "constants.au3"
#include "config.au3"
Global $bIfExternalFileConnected = False ; [True|False]
Global $sMainFilePath = ""
Global $sMainFileName = ""
Global $sMainData = ""
Global $bOpbservationStatus = False
#EndRegion ### Variables section ###

#include "module/MenuItemFile.au3"
#include "module/MenuItemEdit.au3"
#include "module/MenuItemAbout.au3"

Opt("GUIResizeMode", $GUI_DOCKAUTO)

#Region ### START Koda GUI section ### Form=FormDesigner.kxf
Global $sHeaderName = $APPNAME & "  " & $DEFUNSAFENAME
$MainForm = GUICreate($sHeaderName, $APPSIZE[0], $APPSIZE[1], -1, -1, $WS_OVERLAPPEDWINDOW)

$MenuItemFile = GUICtrlCreateMenu("File")
GUICtrlSetState($MenuItemFile, $GUI_CHECKED)
$SubMenuItemStartStop 	= GUICtrlCreateMenuItem("Start observation...   ", $MenuItemFile)
$SubMenuItemSave 	= GUICtrlCreateMenuItem("Save		      Ctrl+S", $MenuItemFile)
$SubMenuItemSaveAs 	= GUICtrlCreateMenuItem("Save As..	Ctrl+Shift+S", $MenuItemFile)
$SubMenuItemOpen 	= GUICtrlCreateMenuItem("Open..			  Ctrl+O", $MenuItemFile)
$SubMenuItemConfig 	= GUICtrlCreateMenuItem("Edit config", $MenuItemFile)
GUICtrlCreateMenuItem("", $MenuItemFile)
$SubMenuItemExit 	= GUICtrlCreateMenuItem("Exit", $MenuItemFile)

If Not $bIfExternalFileConnected Then GUICtrlSetState($SubMenuItemSave, $GUI_DISABLE)

$MenuItemEdit = GUICtrlCreateMenu("Edit")

$MenuItemAbout = GUICtrlCreateMenu("?")
$SubMenuItemAbout = GUICtrlCreateMenuItem("About", $MenuItemAbout)

$FakeGUIEnter = GUICtrlCreateMenu("")
GUICtrlSetState($FakeGUIEnter, $GUI_DISABLE)

Dim $aMainForm_AccelTable[4][2] = [["^s", $SubMenuItemSave], _
								   ["^+s", $SubMenuItemSaveAs], _ 
								   ["^o", $SubMenuItemOpen], _
								   ["{ENTER}", $FakeGUIEnter]]

If IsArray($aKeySection)  Then
	Local $i = 1
	Local $aSubMenuItemEdit[$aKeySection[0][0] + 1]
	Local $iColKey = 0
	Local $iColValue = 1
	Local $iAccelTableCount = UBound($aMainForm_AccelTable)
	ReDim $aMainForm_AccelTable[$iAccelTableCount + $aKeySection[0][0]][2]

	While $i <= $aKeySection[0][0]
		#cs 
			$aKeySection returned from config module as array:
			$aKeySection[0][0] = Number of rows
			$aKeySection[i][0] = ist Key
			$aKeySection[i][1] = ist Value
		#ce
		$aSubMenuItemEdit[$i] = GUICtrlCreateMenuItem($aKeySection[$i][$iColValue] & " [" & $aKeySection[$i][$iColKey] & "]", $MenuItemEdit)
		$aMainForm_AccelTable[$iAccelTableCount][$iColKey] = "{" & $aKeySection[$i][$iColKey] & "}"
		$aMainForm_AccelTable[$iAccelTableCount][$iColValue] = $aSubMenuItemEdit[$i]
		$iAccelTableCount += 1
		$i += 1
	WEnd
Else
	Dim $aSubMenuItemEdit[2] = [0, -1]
	GUICtrlSetState($MenuItemEdit, $GUI_DISABLE)
EndIf

if $DEBUG Then _ArrayDisplay($aMainForm_AccelTable, "HotKeys","",0, Default,"Key|control ID")
GUISetAccelerators($aMainForm_AccelTable)

$StatusBar = _GUICtrlStatusBar_Create($MainForm)
Dim $StatusBar_PartsWidth[2] = [50, -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar, "Ok", 0)
_GUICtrlStatusBar_SetText($StatusBar, "Some status", 1)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)
GUIRegisterMsg($WM_SIZE, "WM_SIZE")

$MainEdit = GUICtrlCreateEdit("", 1, 1, $APPSIZE[0] - 2, $APPSIZE[1] - 49, BitOR($GUI_SS_DEFAULT_EDIT, $WS_BORDER))
GUICtrlSendMsg($MainEdit, $EM_LIMITTEXT, -1, 0)
GUICtrlSetFont($MainEdit, $FONTSIZE, $FONTWEIGHT, $FONTATTRIBUT, $FONTNAME)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

GUICtrlSetData($MainEdit, _InroductionData(), 1)

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
		Case $SubMenuItemStartStop
			if $bOpbservationStatus = False Then 
				$sObservationName = SubMenuItemStart($MainForm)
				If $sObservationName Then
					$bOpbservationStatus = True
					;~ GUICtrlSetData($MainEdit, @CRLF & _InroductionData($sObservationName), 1)
					GUICtrlSetData($MainEdit, _AbsolutTimeStamp() & "Status changed" & $SEPARATOR & "Observation started", 1)
					GUICtrlSetData($SubMenuItemStartStop, "Stop observation")
				EndIf
			Else
				If SubMenuItemStop($MainForm) Then
					$bOpbservationStatus = False
					GUICtrlSetData($MainEdit, _AbsolutTimeStamp() & "Status changed" & $SEPARATOR & "Observation stoped", 1)
					GUICtrlSetData($SubMenuItemStartStop, "Start observation...")
				EndIf
			EndIf
			
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
			$iRow = _ArraySearch($aSubMenuItemEdit, $nMsg)
			GUICtrlSetData($MainEdit, _AbsolutTimeStamp() & SubMenuItemEdit($aKeySection[$iRow][$iColValue], $aKeySection[$iRow][$iColKey]) & $SEPARATOR, 1)
		Case $FakeGUIEnter
			GUICtrlSetData($MainEdit, _AbsolutTimeStamp() & _BlockCounts(), 1)
	EndSwitch
WEnd
#EndRegion ### MAIN ###

#Region ### Functions ###
Func _InroductionData()
	$aTimeZoneInformation = _Date_Time_GetTimeZoneInformation()
	Local $iBiasForLT = 1
	Local $iUTC = $aTimeZoneInformation[$iBiasForLT] / 60
	
	Local $sReturn = "Recording date: " & @YEAR & "/" & @MON  & "/" & @MDAY & @CRLF & _
					 "Recording time: " & @HOUR & ":" & @MIN & ":" & @SEC & "(UTC" 
					If $iUTC > 0 Then $sReturn &="-"
					If $iUTC < 0 Then $sReturn &="+"
					$sReturn &= Abs($iUTC) & ")" & @CRLF & _
					 "Time Offset: 0 ms" & @CRLF & _
					 "Study: " & $DEFUNSAFENAME & @CRLF & _
					 "Recording: " & $DEFAUTHOR & @CRLF & _
					 @CRLF & _
					 "Absolut Time" & $SEPARATOR & "Actions" & $SEPARATOR & "Comment"
	Return $sReturn
EndFunc

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

; Resize the status bar when GUI size changes
Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam
	_GUICtrlStatusBar_Resize($StatusBar)
	Return $GUI_RUNDEFMSG
EndFunc 

Func _AbsolutTimeStamp()
	Return @CRLF & @HOUR & ":" & @MIN & ":" & @SEC & "." & @MSEC & $SEPARATOR
EndFunc

Func _BlockCounts()
	$sReturn = ""
	For $i = 1 to $BLOCKCOUNTS
		$sReturn &= $DEFAUTHOR & $SEPARATOR
	Next
	Return $sReturn
EndFunc
#EndRegion ### Functions ###