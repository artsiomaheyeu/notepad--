#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu Edit

#ce ----------------------------------------------------------------------------


Func SubMenuItemEdit($sItemName, $sItemKey)
	if $DEBUG Then 	ConsoleWrite(FuncName(SubMenuItemEdit) & $sItemName & $sItemKey &@CRLF)
	Return $sItemName
EndFunc

Func SubMenuItemStart($hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemStart) & @CRLF)
	Return InputBox("Enter the name", "Enter the name of your observation subject:", $DEFUNSAFENAME,"",-1,-1,Default,Default, 0, $hGUI)
EndFunc

Func SubMenuItemStop($hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemStop) & @CRLF)
	Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_ICONQUESTION), "Stop observation", "Do you really want to stop observation?", 0, $hGUI)
	If $iAnswer == $IDNO Then Return False
	Return True
EndFunc

Func ExecuteList($sKey, $sValue)
	ProgressOn("Progress Meter", $sValue & " request is being processed" & @CRLF & "..." , "0%", -1, -1, BitOR($DLG_NOTONTOP, $DLG_MOVEABLE))
	Local $iPID
	Dim $aReturn[5]
	$aReturn[0] = 1
	$aReturn[1] = $sKey
	$aReturn[2] = $sValue
	Switch $sKey
		Case 'cmd'
			$aReturn[3] = Run(@ComSpec & " /c " & $sValue, @SystemDir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
			$aReturn[4] = "CMD_" & @HOUR & @MIN & @SEC & @MSEC & ".log"
			
			Local $i = 1
			While 1
				$sline = StdoutRead($aReturn[3])
				If @error Then ExitLoop
					If $sline <> "" Then 
					_OpenFile($aReturn[4], $FO_APPEND, $sline)
					ProgressSet($i, $i & "%")
					If $i < 100 Then $i += 1
					EndIf
			Wend
			If StderrRead($aReturn[3]) Then $aReturn[0] = 0
		Case 'app'
			$aReturn[3] = ShellExecute($sValue)
			if @error Then $aReturn[0] = 0
	EndSwitch
	ProgressSet(100, "Done", "Complete")
	ProgressOff()
	Return $aReturn
EndFunc	;==> ExecuteList