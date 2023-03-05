#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: Notification module for notepad--: Status bar

#ce ----------------------------------------------------------------------------

Dim $aStatusMessage[2][2] = [["STOP", "For stop observation press SHIFT+S"], _
							["START", "For start observation press SHIFT+S"]]

Func UpdateStatusBar($sMesssage)
	if $DEBUG Then ConsoleWrite(FuncName(UpdateStatusBar) & @CRLF)
	$StatusBarFlag = True
	Local $iRow = _ArraySearch($aStatusMessage, $sMesssage)
	Return $aStatusMessage[$iRow][1]
EndFunc
