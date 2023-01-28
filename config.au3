#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function:
	Config read for notepad--

#ce ----------------------------------------------------------------------------

#include <Array.au3>

$aBasicSection = _ReadINISection($INI, "Basic")
$aKeySection = _ReadINISection($INI, "Keys")

Func _ReadINISection($sFileName, $sSectionName)
	$aValueSection = IniReadSection($sFileName, $sSectionName)
	If Not @error Then
		if $DEBUG Then _ArrayDisplay($aValueSection, $sSectionName)
		Return $aValueSection
	Else
		MsgBox(4096, "Error", "An error has occurred, the " & $sFileName & " file may be missing or the section " & $sSectionName & " may not exist or is empty")
		if $DEBUG  Then ConsoleWriteError("ERROR:_ReadINISection" & @CRLF)
		Exit
	EndIf
EndFunc