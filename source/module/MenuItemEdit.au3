#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function: GUI module for notepad--: Menu Edit

#ce ----------------------------------------------------------------------------

Func SubMenuItemEdit($sItemName, $sItemKey)
	if $DEBUG Then 	ConsoleWrite(FuncName(SubMenuItemEdit) & $sItemName & $sItemKey &@CRLF)
	Return $sItemName
EndFunc