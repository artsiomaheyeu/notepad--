#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=D:\notepad--\notepad--\build\notepad--.exe
#AutoIt3Wrapper_Res_Description=A simple text editor for logging test sessions
#AutoIt3Wrapper_Res_Fileversion=0.0.0.20
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=notepad--
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=Aheyeu Artsiom
#AutoIt3Wrapper_Run_After=copy "config.ini" "D:\notepad--\notepad--\build"
#AutoIt3Wrapper_Run_After=start "D:\notepad--\notepad--\source\third-party\build.bat"
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
#include <GuiEdit.au3>
#include <Timers.au3>
;#include <GuiMenu.au3>

#Region ### Variables section ###
#include "constants.au3"

#include "config.au3"
Global $bIfExternalFileConnected = False ; [True|False]
Global $sMainFilePath = ""
Global $sMainFileName = ""
Global $sMainData = ""
Global $bOpbservationStatus = False
Local $sObservationName = $DEFUNSAFENAME
Local $bIsStadyNamed = False
Local $bWinActiveFlag0, $bWinActiveFlag1
Global $hStarttime								; Var a timestamp number (in milliseconds).
Global $iLastRelTime = $TIMEOFFSET				; Timestamp returned from a previous call to _Timer_Init() plus time correction (in milliseconds)
Global $iTimeBuff = 0							; Last timestamp buffer  (in milliseconds)

#EndRegion ### Variables section ###

#include "module/MenuItemFile.au3"
#include "module/MenuItemEdit.au3"
#include "module/MenuItemAbout.au3"

Opt("GUIResizeMode", $GUI_DOCKAUTO)
Opt("TrayIconHide", 1) ;0=show, 1=hide tray icon

OnAutoItExitRegister('OnAutoItExit')

#Region ### START Koda GUI section ### Form=FormDesigner.kxf
Global $sHeaderName = $APPNAME & "  " & $sObservationName & "*"
$MainForm = GUICreate($sHeaderName, $APPSIZE[0], $APPSIZE[1], -1, -1, $WS_OVERLAPPEDWINDOW)

$MenuItemFile = GUICtrlCreateMenu("&File")
GUICtrlSetState($MenuItemFile, $GUI_CHECKED)
$SubMenuItemSave 	= GUICtrlCreateMenuItem("&Save		      Ctrl+S", $MenuItemFile)
$SubMenuItemSaveAs 	= GUICtrlCreateMenuItem("Save &As..	Ctrl+Shift+S", $MenuItemFile)
$SubMenuItemOpen 	= GUICtrlCreateMenuItem("&Open..			  Ctrl+O", $MenuItemFile)
$SubMenuItemConfig 	= GUICtrlCreateMenuItem("&Edit config", $MenuItemFile)
GUICtrlCreateMenuItem("", $MenuItemFile)
$SubMenuItemExit 	= GUICtrlCreateMenuItem("E&xit", $MenuItemFile)

If Not $bIfExternalFileConnected Then GUICtrlSetState($SubMenuItemSave, $GUI_DISABLE)

$MenuItemEdit = GUICtrlCreateMenu("&Edit")
$SubMenuItemStartStop = GUICtrlCreateMenuItem("&Start observation... [Shift+S]", $MenuItemEdit)

$MenuItemAbout = GUICtrlCreateMenu("&?")
$SubMenuItemAbout = GUICtrlCreateMenuItem("&About", $MenuItemAbout)

$FakeGUIEnter = GUICtrlCreateDummy()

Dim $aMainForm_AccelTable[1][2] = [["{ENTER}", $FakeGUIEnter]]		; Enter

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
_GUICtrlStatusBar_SetText($StatusBar, "", 0)
_GUICtrlStatusBar_SetText($StatusBar, "Use the Enter key to move to the next line", 1)
_GUICtrlStatusBar_SetMinHeight($StatusBar, 25)

GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_HOTKEY, 'WM_HOTKEY')

$MainEdit = GUICtrlCreateEdit("", 1, 1, $APPSIZE[0] - 2, $APPSIZE[1] - 49, BitOR($GUI_SS_DEFAULT_EDIT, $WS_BORDER))
GUICtrlSendMsg($MainEdit, $EM_LIMITTEXT, -1, 0)
GUICtrlSetResizing($MainEdit, BitOR($GUI_DOCKLEFT, $GUI_DOCKRIGHT, $GUI_DOCKTOP, $GUI_DOCKBOTTOM))
GUICtrlSetFont($MainEdit, $FONTSIZE, $FONTWEIGHT, $FONTATTRIBUT, $FONTNAME)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

GUICtrlSetData($MainEdit, _InroductionData(), 1)

#Region ### MAIN ###
While 1
	_IsWinActive($MainForm)
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $SubMenuItemExit
			SubMenuItemExit(GUICtrlRead($MainEdit), $MainForm)
			Exit
		Case $GUI_EVENT_CLOSE 
			SubMenuItemExit(GUICtrlRead($MainEdit), $MainForm)
			Exit
		Case $SubMenuItemStartStop
			If Not $TIMERRESET Then
				$iTimeBuff = $iLastRelTime
			Else
				$iTimeBuff  = $TIMEOFFSET
			EndIf
			if $bOpbservationStatus = False Then
				If Not $bIsStadyNamed Then $sObservationName = SubMenuItemStart($MainForm)
				If $sObservationName Then
					$bIsStadyNamed = True
					GUICtrlSetData($MainEdit, StringReplace(GUICtrlRead($MainEdit), $DEFUNSAFENAME, $sObservationName))
					$hStarttime = _Timer_Init()
					$bOpbservationStatus = True
					_GUICtrlEdit_AppendText($MainEdit, _AbsolutTimeStamp() & _RelativeTimeStamp() & "Status changed" & $SEPARATOR & "Observation started")
					GUICtrlSetData($SubMenuItemStartStop, "Stop observation     [Shift+S]")
				EndIf
			Else
				If SubMenuItemStop($MainForm) Then
					_GUICtrlEdit_AppendText($MainEdit, _AbsolutTimeStamp() & _RelativeTimeStamp() & "Status changed" & $SEPARATOR & "Observation stopped")
					$bOpbservationStatus = False
					GUICtrlSetData($SubMenuItemStartStop, "Start observation... [Shift+S]")
					If $TIMERRESET Then $iLastRelTime = $TIMEOFFSET
				EndIf
			EndIf
			_UpdateFormTitle()
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
			If SubMenuItemOpen($MainForm, GUICtrlRead($MainEdit)) Then 	
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
			_GUICtrlEdit_AppendText($MainEdit, _AbsolutTimeStamp() & _RelativeTimeStamp() & SubMenuItemEdit($aKeySection[$iRow][$iColValue], $aKeySection[$iRow][$iColKey]) & $SEPARATOR)
		Case $FakeGUIEnter
			_GUICtrlEdit_AppendText($MainEdit, _AbsolutTimeStamp() & _RelativeTimeStamp() & $DEFAUTHOR & $SEPARATOR)
	EndSwitch
WEnd
#EndRegion ### MAIN ###

#Region ### Functions ###
Func _IsWinActive($hWnd)
	If WinActive($hWnd) Then $bWinActiveFlag0 = True
    If $bWinActiveFlag0 <> $bWinActiveFlag1 Then $bWinActiveFlag1 = _RegisterHotKey($bWinActiveFlag0)
	$bWinActiveFlag0 = False
EndFunc		;==>_IsWinActive

Func _RegisterHotKey($bFlag)
	If $bFlag Then
		_WinAPI_RegisterHotKey($MainForm, $SubMenuItemSave, $MOD_CONTROL, $VK[_ArraySearch($VK, "S")][1]) 						; Ctrl+S
		_WinAPI_RegisterHotKey($MainForm, $SubMenuItemSaveAs, BitOR($MOD_CONTROL, $MOD_SHIFT), $VK[_ArraySearch($VK, "S")][1]) 	; Ctrl+Shift+S
		_WinAPI_RegisterHotKey($MainForm, $SubMenuItemOpen, $MOD_CONTROL, $VK[_ArraySearch($VK, "O")][1]) 						; Ctrl+O
		_WinAPI_RegisterHotKey($MainForm, $SubMenuItemStartStop, $MOD_SHIFT, $VK[_ArraySearch($VK, "S")][1])					; Shift+S
        if $DEBUG Then ConsoleWrite("--> RegisterHotKey" & @CRLF)
    Else
		_WinAPI_UnregisterHotKey($MainForm, $SubMenuItemSave)
		_WinAPI_UnregisterHotKey($MainForm, $SubMenuItemSaveAs)
		_WinAPI_UnregisterHotKey($MainForm, $SubMenuItemOpen)
		_WinAPI_UnregisterHotKey($MainForm, $SubMenuItemStartStop)
		if $DEBUG Then ConsoleWrite("RegisterHotKey <--" & @CRLF)
    EndIf
	Return $bFlag
EndFunc   ;==>_RegisterHotKey

Func OnAutoItExit()
    _RegisterHotKey(False)
EndFunc   ;==>OnAutoItExit

Func WM_HOTKEY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	if $DEBUG Then ConsoleWrite(FuncName(WM_HOTKEY) & " Catch $wParam=" & $wParam & @CRLF)
	Switch $wParam
		Case $SubMenuItemSave
			$nMsg = $SubMenuItemSave
		Case $SubMenuItemSaveAs
			$nMsg = $SubMenuItemSaveAs
		Case $SubMenuItemOpen
			$nMsg = $SubMenuItemOpen
		Case $SubMenuItemStartStop
			$nMsg = $SubMenuItemStartStop
	EndSwitch
EndFunc   ;==>WM_HOTKEY

Func _InroductionData()
	If Not $ISINRTO Then Return Null
	$aTimeZoneInformation = _Date_Time_GetTimeZoneInformation()
	Local $iBiasForLT = 1
	Local $iUTC = $aTimeZoneInformation[$iBiasForLT] / 60
	
	Local $sReturn = "Recording date: " & @YEAR & "/" & @MON  & "/" & @MDAY & @CRLF & _
					 "Recording time: " & @HOUR & ":" & @MIN & ":" & @SEC & "(UTC" 
					If $iUTC > 0 Then $sReturn &="-"
					If $iUTC < 0 Then $sReturn &="+"
					$sReturn &= Abs($iUTC) & ")" & @CRLF & _
					 "Time Offset: " & $TIMEOFFSET & " ms" & @CRLF & _
					 "Study: " & $DEFUNSAFENAME & @CRLF & _
					 "Recording: " & $DEFAUTHOR & @CRLF & _
					 @CRLF & _
					 "Absolut Time" & $SEPARATOR & "Relative Time" & $SEPARATOR & "Actions" & $SEPARATOR & "Comment"
	Return $sReturn
EndFunc		;==>_InroductionData

Func _UpdateFormTitle()
	$sHeaderName = $APPNAME & "  " & $sObservationName
	If $bIfExternalFileConnected Then 
		$sHeaderName &= ": " & $sMainFileName
	Else
		$sHeaderName &= "*"
	EndIf
	WinSetTitle($MainForm, "", $sHeaderName)
EndFunc		;==>_UpdateFormTitle

Func _ChangeItemStatusTo($bStatus)
	If BitXOR($bIfExternalFileConnected, $bStatus) Then
		$bIfExternalFileConnected = $bStatus
		If $bStatus Then
			GUICtrlSetState($SubMenuItemSave, $GUI_ENABLE)
		Else
			GUICtrlSetState($SubMenuItemSave, $GUI_DISABLE)
		EndIf
	EndIf
EndFunc		;==>_ChangeItemStatusTo

; Resize the status bar when GUI size changes
Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam
	_GUICtrlStatusBar_Resize($StatusBar)
	Return $GUI_RUNDEFMSG
EndFunc		;==>WM_SIZE

Func _AbsolutTimeStamp()
	Return @CRLF & StringFormat("%d:%.2d:%.2d.%.3d", @HOUR, @MIN, @SEC ,@MSEC) & $SEPARATOR
EndFunc		;==>_AbsolutTimeStamp

Func _RelativeTimeStamp()
	If $bOpbservationStatus Then $iLastRelTime = _Timer_Diff($hStarttime) + $iTimeBuff
	Return StringFormat("%d:%.2d:%06.3f", (Floor($iLastRelTime / 3600000)), (Floor(Mod($iLastRelTime,3600000) / 60000)), (Mod(Mod($iLastRelTime,3600000),60000) / 1000)) & $SEPARATOR
EndFunc		;==>_RelativeTimeStamp
#EndRegion ### Functions ###