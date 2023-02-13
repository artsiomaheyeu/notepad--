#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function:
	Config read for notepad--

#ce ----------------------------------------------------------------------------

#include <Array.au3>

If Not FileExists($INI) Then FileWrite($INI, "# Config file for notepad--")

Local $aSectionNames = IniReadSectionNames($INI)
If IsArray($aSectionNames) or $aSectionNames = 1 Then
	If _ArraySearch($aSectionNames, $INIDEFAULSTS) == -1 Then IniWriteSection($INI, $INIDEFAULSTS, "")
	If _ArraySearch($aSectionNames, $INIKEYS) == -1 Then IniWriteSection($INI, $INIKEYS, "")
EndIf

Global Const $TIMEOFFSET 	= _GetVar("TimeOffset", 0)
Global Const $BLOCKCOUNTS 	= _GetVar("BlocksCounts", 1)
Global Const $SEPARATOR 	= _GetVar("Separator", ";")
Global Const $FONTNAME 		= _GetVar("FontName", "Calibri")
Global Const $FONTSIZE 		= _GetVar("FontSize", 11)
Global Const $FONTWEIGHT 	= _GetVar("FontWeight", 400)
Global Const $FONTATTRIBUT 	= _GetVar("FontAttribute", 0)

Global $aKeySection = _ReadINISection($INI, $INIKEYS)

;~ For $i=0 To Ubound($aSectionNames) - 1
;~ 	Local $iRow = _ArraySearch($aKeySection, $aSectionNames[$i])
;~ 	If $iRow Then Assign()
;~ 	$aExternal = _ReadINISection($INI, $aSectionNames[$iRow])
;~ Next

Func _ReadINISection($sFileName, $sSectionName)
	Local $aValueSection = IniReadSection($sFileName, $sSectionName)
	If Not @error Then
		if $DEBUG Then _ArrayDisplay($aValueSection, $sSectionName)
		Return $aValueSection
	Else
		if $DEBUG  Then ConsoleWriteError("ERROR:_ReadINISection" & @CRLF)
		Return Null
	EndIf
EndFunc

Func _GetVar($sKeyName, $vDefault)
	Local $vReturn = IniRead($INI, $INIDEFAULSTS, $sKeyName, $vDefault)
	If $vReturn == $vDefault Then IniWrite($INI, $INIDEFAULSTS, $sKeyName, $vDefault)
	Return $vReturn
EndFunc