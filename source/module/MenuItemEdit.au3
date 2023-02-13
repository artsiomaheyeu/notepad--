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
	Return InputBox("Question?", "Enter the name of your observation subject:", $DEFUNSAFENAME,"",-1,-1,Default,Default, 0, $hGUI)
EndFunc

Func SubMenuItemStop($hGUI)
	if $DEBUG Then ConsoleWrite(FuncName(SubMenuItemStop) & @CRLF)
	Local $iAnswer = MsgBox($MB_YESNO, "Qustion?", "Do you want to stop observation?", 0, $hGUI)
	If $iAnswer == $IDNO Then Return False
	Return True
EndFunc