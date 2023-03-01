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
			Local $sFileName = $sObservationName & "_" & @WDAY & @HOUR & @MIN & @SEC & @MSEC & ".log"
			Local $i = 1
			While 1
				$sline = StdoutRead($aReturn[3])
				If @error Then ExitLoop
					If $sline <> "" Then 
					If _OpenFile($sFileName, $FO_APPEND, $sline) Then $aReturn[4] = $sFileName
					ProgressSet($i, $i & "%")
					If $i < 100 Then $i += 1
					EndIf
			Wend
			$sErr = StderrRead($aReturn[3])
			If $sErr Then 
				$aReturn[0] = 0
				If _OpenFile($sFileName, $FO_APPEND, $sErr) Then $aReturn[4] = "ERROR: " & $sFileName
				EndIf
		Case 'app'
			Local $aValue = StringSplit($sValue, " ")
			If $aValue[0] = 1 Then 
				$aReturn[3] = ShellExecute($sValue)
			Else
				Local $sParameters
				For $i = 2 To $aValue[0]
					$sParameters &= $aValue[$i] & " "
				Next
				$aReturn[3] = ShellExecute($aValue[1], $sParameters)
			EndIf
				if @error Then $aReturn[0] = 0
	EndSwitch
	ProgressSet(100, "Done", "Complete")
	ProgressOff()
	Return $aReturn
EndFunc	;==> ExecuteList