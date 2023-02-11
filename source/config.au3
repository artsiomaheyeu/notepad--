#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function:
	Config read for notepad--

#ce ----------------------------------------------------------------------------

#include <Array.au3>

Global $aBasicSection = _ReadINISection($INI, $INIDEFAULSTS)

Global $bWriteFlag = False

Global Const $BLOCKCOUNTS 	= _GetVar($aBasicSection, "BlocksCounts", 1)
Global Const $SEPARATOR 	= _GetVar($aBasicSection, "Separator", ";")
Global Const $FONTNAME 		= _GetVar($aBasicSection, "FontName", "Arial")
Global Const $FONTSIZE 		= _GetVar($aBasicSection, "FontSize", 8.5)
Global Const $FONTWEIGHT 	= _GetVar($aBasicSection, "FontWeight", 400)
Global Const $FONTATTRIBUT 	= _GetVar($aBasicSection, "FontAttribute", 0)

If $bWriteFlag Then
	MsgBox($MB_ICONINFORMATION,"Info", "Update parameters in " & $INI)
	_WriteINISection($INI, $INIDEFAULSTS, $aBasicSection)
	_ArrayDisplay($aBasicSection)
EndIf

Global $aKeySection = _ReadINISection($INI, $INIKEYS)

Func _ReadINISection($sFileName, $sSectionName)
	Local $aValueSection = IniReadSection($sFileName, $sSectionName)
	If Not @error Then
		if $DEBUG Then _ArrayDisplay($aValueSection, $sSectionName)
		Return $aValueSection
	Else
		MsgBox(4096, "Error", "An error has occurred, the " & $sFileName & " file may be missing or the section " & $sSectionName & " may not exist or is empty")
		if $DEBUG  Then ConsoleWriteError("ERROR:_ReadINISection" & @CRLF)
		Exit
	EndIf
EndFunc

Func _WriteINISection($sFileName, $sSectionName, $aData)
	Local $aValueSection = IniWriteSection($sFileName, $sSectionName, $aData)
	If Not @error Then
		if $DEBUG Then _ArrayDisplay($aValueSection, $sSectionName)
		Return $aValueSection
	Else
		MsgBox(4096, "Error" & $sFileName, "An error has occurred, may be the data format is invalid")
		if $DEBUG  Then ConsoleWriteError("ERROR:_WriteINISection" & @CRLF)
		Exit
	EndIf
EndFunc

Func _GetVar($aArray, $sKeyName, $vDefault)
	Local $iKey 	= 0
	Local $iValue 	= 1
	Local $Return 	= $vDefault
	Local $iRow 	= _ArraySearch($aArray, $sKeyName)
	If Not @error Then 
		$Return = $aArray[$iRow][1]
	Else
		$bWriteFlag = True
		ReDim $aBasicSection[UBound($aBasicSection) + 1][2] 
		$aBasicSection[UBound($aBasicSection) - 1][$iKey] = $sKeyName
		$aBasicSection[UBound($aBasicSection) - 1][$iValue] = $vDefault
	EndIf
	Return $Return
EndFunc