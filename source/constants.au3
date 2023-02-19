#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Artsiom Aheyeu

 Script Function:
	Constants basket for notepad--

#ce ----------------------------------------------------------------------------

Global Const $DEBUG 		= True

Global Const $INI 			= "config.ini"
Global Const $INIDEFAULSTS 	= "Basic"
Global Const $INIEXE 		= "Execute"
Global Const $INIKEYS 		= "Keys"

Global Const $APPNAME 		= "notepad-- v1.1"
Global Const $AUTHOR 		= "Artsiom Aheyeu"
Global Const $BOXMAIL 		= "artiom.ageev@gmail.com"
Global Const $REPURL 		= "https://github.com/artsiomaheyeu/notepad--.git"
Global Const $ABOUTURL 		= "https://github.com/artsiomaheyeu/notepad--#readme"

Global Const $BUILDFOLDER 	= "/build"

Global Const $APPSIZE[2] 	= [1128, 246] ; [width, height] TODO: @DesktopWidth - 200, @DesktopHeight - 400
Global Const $DEFUNSAFENAME = "Untitled"

Global Const $DEFAUTHOR 	= @UserName

Global Const $VK[175][3] 	= [["LBUTTON", 0x01, "Left mouse button"], _
							["RBUTTON", 0x02, "Right mouse button"], _
							["CANCEL", 0x03, "Control-break processing"], _
							["MBUTTON", 0x04, "Middle mouse button (three-button mouse)"], _
							["XBUTTON1", 0x05, "X1 mouse button"], _
							["XBUTTON2", 0x06, "X2 mouse button"], _
							["BACK", 0x08, "BACKSPACE key"], _
							["TAB", 0x09, "TAB key"], _
							["CLEAR", 0x0C, "CLEAR key"], _
							["RETURN", 0x0D, "ENTER key"], _
							["SHIFT", 0x10, "SHIFT key"], _
							["CONTROL", 0x11, "CTRL key"], _
							["MENU", 0x12, "ALT key"], _
							["PAUSE", 0x13, "PAUSE key"], _
							["CAPITAL", 0x14, "CAPS LOCK key"], _
							["KANA", 0x15, "IME Kana mode"], _
							["HANGUEL", 0x15, "IME Hanguel mode (maintained for compatibility; use HANGUL)"], _
							["HANGUL", 0x15, "IME Hangul mode"], _
							["IME_ON", 0x16, "IME On"], _
							["JUNJA", 0x17, "IME Junja mode"], _
							["FINAL", 0x18, "IME final mode"], _
							["HANJA", 0x19, "IME Hanja mode"], _
							["KANJI", 0x19, "IME Kanji mode"], _
							["IME_OFF", 0x1A, "IME Off"], _
							["ESCAPE", 0x1B, "ESC key"], _
							["CONVERT", 0x1C, "IME convert"], _
							["NONCONVERT", 0x1D, "IME nonconvert"], _
							["ACCEPT", 0x1E, "IME accept"], _
							["MODECHANGE", 0x1F, "IME mode change request"], _
							["SPACE", 0x20, "SPACEBAR"], _
							["PRIOR", 0x21, "PAGE UP key"], _
							["NEXT", 0x22, "PAGE DOWN key"], _
							["END", 0x23, "END key"], _
							["HOME", 0x24, "HOME key"], _
							["LEFT", 0x25, "LEFT ARROW key"], _
							["UP", 0x26, "UP ARROW key"], _
							["RIGHT", 0x27, "RIGHT ARROW key"], _
							["DOWN", 0x28, "DOWN ARROW key"], _
							["SELECT", 0x29, "SELECT key"], _
							["PRINT", 0x2A, "PRINT key"], _
							["EXECUTE", 0x2B, "EXECUTE key"], _
							["SNAPSHOT", 0x2C, "PRINT SCREEN key"], _
							["INSERT", 0x2D, "INS key"], _
							["DELETE", 0x2E, "DEL key"], _
							["HELP", 0x2F, "HELP key"], _
							["LWIN", 0x5B, "Left Windows key (Natural keyboard)"], _
							["RWIN", 0x5C, "Right Windows key (Natural keyboard)"], _
							["APPS", 0x5D, "Applications key (Natural keyboard)"], _
							["SLEEP", 0x5F, "Computer Sleep key"], _
							["NUMPAD0", 0x60, "Numeric keypad 0 key"], _
							["NUMPAD1", 0x61, "Numeric keypad 1 key"], _
							["NUMPAD2", 0x62, "Numeric keypad 2 key"], _
							["NUMPAD3", 0x63, "Numeric keypad 3 key"], _
							["NUMPAD4", 0x64, "Numeric keypad 4 key"], _
							["NUMPAD5", 0x65, "Numeric keypad 5 key"], _
							["NUMPAD6", 0x66, "Numeric keypad 6 key"], _
							["NUMPAD7", 0x67, "Numeric keypad 7 key"], _
							["NUMPAD8", 0x68, "Numeric keypad 8 key"], _
							["NUMPAD9", 0x69, "Numeric keypad 9 key"], _
							["MULTIPLY", 0x6A, "Multiply key"], _
							["ADD", 0x6B, "Add key"], _
							["SEPARATOR", 0x6C, "Separator key"], _
							["SUBTRACT", 0x6D, "Subtract key"], _
							["DECIMAL", 0x6E, "Decimal key"], _
							["DIVIDE", 0x6F, "Divide key"], _
							["F1", 0x70, "F1 key"], _
							["F2", 0x71, "F2 key"], _
							["F3", 0x72, "F3 key"], _
							["F4", 0x73, "F4 key"], _
							["F5", 0x74, "F5 key"], _
							["F6", 0x75, "F6 key"], _
							["F7", 0x76, "F7 key"], _
							["F8", 0x77, "F8 key"], _
							["F9", 0x78, "F9 key"], _
							["F10", 0x79, "F10 key"], _
							["F11", 0x7A, "F11 key"], _
							["F12", 0x7B, "F12 key"], _
							["F13", 0x7C, "F13 key"], _
							["F14", 0x7D, "F14 key"], _
							["F15", 0x7E, "F15 key"], _
							["F16", 0x7F, "F16 key"], _
							["F17", 0x80, "F17 key"], _
							["F18", 0x81, "F18 key"], _
							["F19", 0x82, "F19 key"], _
							["F20", 0x83, "F20 key"], _
							["F21", 0x84, "F21 key"], _
							["F22", 0x85, "F22 key"], _
							["F23", 0x86, "F23 key"], _
							["F24", 0x87, "F24 key"], _
							["NUMLOCK", 0x90, "NUM LOCK key"], _
							["SCROLL", 0x91, "SCROLL LOCK key"], _
							["LSHIFT", 0xA0, "Left SHIFT key"], _
							["RSHIFT", 0xA1, "Right SHIFT key"], _
							["LCONTROL", 0xA2, "Left CONTROL key"], _
							["RCONTROL", 0xA3, "Right CONTROL key"], _
							["LMENU", 0xA4, "Left ALT key"], _
							["RMENU", 0xA5, "Right ALT key"], _
							["BROWSER_BACK", 0xA6, "Browser Back key"], _
							["BROWSER_FORWARD", 0xA7, "Browser Forward key"], _
							["BROWSER_REFRESH", 0xA8, "Browser Refresh key"], _
							["BROWSER_STOP", 0xA9, "Browser Stop key"], _
							["BROWSER_SEARCH", 0xAA, "Browser Search key"], _
							["BROWSER_FAVORITES", 0xAB, "Browser Favorites key"], _
							["BROWSER_HOME", 0xAC, "Browser Start and Home key"], _
							["VOLUME_MUTE", 0xAD, "Volume Mute key"], _
							["VOLUME_DOWN", 0xAE, "Volume Down key"], _
							["VOLUME_UP", 0xAF, "Volume Up key"], _
							["MEDIA_NEXT_TRACK", 0xB0, "Next Track key"], _
							["MEDIA_PREV_TRACK", 0xB1, "Previous Track key"], _
							["MEDIA_STOP", 0xB2, "Stop Media key"], _
							["MEDIA_PLAY_PAUSE", 0xB3, "Play/Pause Media key"], _
							["LAUNCH_MAIL", 0xB4, "Start Mail key"], _
							["LAUNCH_MEDIA_SELECT", 0xB5, "Select Media key"], _
							["LAUNCH_APP1", 0xB6, "Start Application 1 key"], _
							["LAUNCH_APP2", 0xB7, "Start Application 2 key"], _
							["OEM_1", 0xBA, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ';:' key"], _
							["OEM_PLUS", 0xBB, "For any country/region, the '+' key"], _
							["OEM_COMMA", 0xBC, "For any country/region, the ',' key"], _
							["OEM_MINUS", 0xBD, "For any country/region, the '-' key"], _
							["OEM_PERIOD", 0xBE, "For any country/region, the '.' key"], _
							["OEM_2", 0xBF, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '/?' key"], _
							["OEM_3", 0xC0, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '`~' key"], _
							["OEM_4", 0xDB, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '[{' key"], _
							["OEM_5", 0xDC, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '\|' key"], _
							["OEM_6", 0xDD, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ']}' key"], _
							["OEM_7", 0xDE, "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the 'single-quote/double-quote' key"], _
							["OEM_8", 0xDF, "Used for miscellaneous characters; it can vary by keyboard."], _
							["OEM_102", 0xE2, "The <> keys on the US standard keyboard, or the \\| key on the non-US 102-key keyboard"], _
							["PROCESSKEY", 0xE5, "IME PROCESS key"], _
							["PACKET", 0xE7, "Used to pass Unicode characters as if they were keystrokes. The PACKET key is the low word of a 32-bit Virtual Key value used for non-keyboard input methods. For more information, see Remark in KEYBDINPUT, SendInput, WM_KEYDOWN, and WM_KEYUP"], _
							["ATTN", 0xF6, "Attn key"], _
							["CRSEL", 0xF7, "CrSel key"], _
							["EXSEL", 0xF8, "ExSel key"], _
							["EREOF", 0xF9, "Erase EOF key"], _
							["PLAY", 0xFA, "Play key"], _
							["ZOOM", 0xFB, "Zoom key"], _
							["NONAME", 0xFC, "Reserved"], _
							["PA1", 0xFD, "PA1 key"], _
							["OEM_CLEAR", 0xFE, "Clear key"], _
							["0", 0x30, "0 key"], _
							["1", 0x31, "1 key"], _
							["2", 0x32, "2 key"], _
							["3", 0x33, "3 key"], _
							["4", 0x34, "4 key"], _
							["5", 0x35, "5 key"], _
							["6", 0x36, "6 key"], _
							["7", 0x37, "7 key"], _
							["8", 0x38, "8 key"], _
							["9", 0x39, "9 key"], _
							["A", 0x41, "A key"], _
							["B", 0x42, "B key"], _
							["C", 0x43, "C key"], _
							["D", 0x44, "D key"], _
							["E", 0x45, "E key"], _
							["F", 0x46, "F key"], _
							["G", 0x47, "G key"], _
							["H", 0x48, "H key"], _
							["I", 0x49, "I key"], _
							["J", 0x4A, "J key"], _
							["K", 0x4B, "K key"], _
							["L", 0x4C, "L key"], _
							["M", 0x4D, "M key"], _
							["N", 0x4E, "N key"], _
							["O", 0x4F, "O key"], _
							["P", 0x50, "P key"], _
							["Q", 0x51, "Q key"], _
							["R", 0x52, "R key"], _
							["S", 0x53, "S key"], _
							["T", 0x54, "T key"], _
							["U", 0x55, "U key"], _
							["V", 0x56, "V key"], _
							["W", 0x57, "W key"], _
							["X", 0x58, "X key"], _
							["Y", 0x59, "Y key"], _
							["Z", 0x5A, "Z key"]]

Global Const $LANG[137][2] 	= [[0x0804, "Chinese Simplified"], _
							[0x1004, "Chinese Singapore"], _
							[0x0404, "Chinese Traditional"], _
							[0x041A, "Croatian"], _
							[0x0405, "Czech"], _
							[0x0406, "Danish"], _
							[0x0413, "Dutch"], _
							[0x0C09, "English Australia"], _
							[0x2809, "English Belize"], _
							[0x1009, "English Canadian"], _
							[0x2409, "English Caribbean"], _
							[0x1813, "English Ireland"], _
							[0x2009, "English Jamaica"], _
							[0x1409, "English New Zealand"], _
							[0x3409, "English Philippines"], _
							[0x1C09, "English South Africa"], _
							[0x2C09, "English Trinidad"], _
							[0x0809, "English U.K."], _
							[0x0409, "English U.S."], _
							[0x3009, "English Zimbabwe"], _
							[0x0425, "Estonian"], _
							[0x0438, "Faeroese"], _
							[0x0429, "Farsi"], _
							[0x040B, "Finnish"], _
							[0x040C, "French"], _
							[0x2C0C, "French Cameroon"], _
							[0x0C0C, "French Canadian"], _
							[0x300C, "French Cote d'Ivoire"], _
							[0x140C, "French Luxembourg"], _
							[0x340C, "French Mali"], _
							[0x180C, "French Monaco"], _
							[0x200C, "French Reunion"], _
							[0x280C, "French Senegal"], _
							[0x1C0C, "French West Indies"], _
							[0x240C, "French Congo (DRC)"], _
							[0x0462, "Frisian Netherlands"], _
							[0x083C, "Gaelic Ireland"], _
							[0x043C, "Gaelic Scotland"], _
							[0x0456, "Galician"], _
							[0x0437, "Georgian"], _
							[0x0407, "German"], _
							[0x0C07, "German Austria"], _
							[0x1407, "German Liechtenstein"], _
							[0x1007, "German Luxembourg"], _
							[0x0408, "Greek"], _
							[0x0447, "Gujarati"], _
							[0x040D, "Hebrew"], _
							[0x0439, "Hindi"], _
							[0x040E, "Hungarian"], _
							[0x040F, "Icelandic"], _
							[0x0421, "Indonesian"], _
							[0x0410, "Italian"], _
							[0x0411, "Japanese"], _
							[0x044B, "Kannada"], _
							[0x0460, "Kashmiri"], _
							[0x043F, "Kazakh"], _
							[0x0453, "Khmer"], _
							[0x0440, "Kirghiz"], _
							[0x0457, "Konkani"], _
							[0x0412, "Korean"], _
							[0x0454, "Lao"], _
							[0x0426, "Latvian"], _
							[0x0427, "Lithuanian"], _
							[0x042F, "FYRO Macedonian"], _
							[0x044C, "Malayalam"], _
							[0x083E, "Malay Brunei Darussalam"], _
							[0x043E, "Malaysian"], _
							[0x043A, "Maltese"], _
							[0x0458, "Manipuri"], _
							[0x044E, "Marathi"], _
							[0x0450, "Mongolian"], _
							[0x0461, "Nepali"], _
							[0x0414, "Norwegian Bokmol"], _
							[0x0814, "Norwegian Nynorsk"], _
							[0x0448, "Oriya"], _
							[0x0415, "Polish"], _
							[0x0816, "Portuguese"], _
							[0x0446, "Punjabi"], _
							[0x0417, "Rhaeto-Romanic"], _
							[0x0418, "Romanian"], _
							[0x0818, "Romanian Moldova"], _
							[0x0419, "Russian"], _
							[0x0819, "Russian Moldova"], _
							[0x043B, "Sami Lappish"], _
							[0x044F, "Sanskrit"], _
							[0x0C1A, "Serbian Cyrillic"], _
							[0x081A, "Serbian Latin"], _
							[0x0430, "Sesotho"], _
							[0x0459, "Sindhi"], _
							[0x041B, "Slovak"], _
							[0x0424, "Slovenian"], _
							[0x042E, "Sorbian"], _
							[0x040A, "Spanish (Traditional)"], _
							[0x2C0A, "Spanish Argentina"], _
							[0x400A, "Spanish Bolivia"], _
							[0x340A, "Spanish Chile"], _
							[0x240A, "Spanish Colombia"], _
							[0x140A, "Spanish Costa Rica"], _
							[0x1C0A, "Spanish Dominican Republic"], _
							[0x300A, "Spanish Ecuador"], _
							[0x440A, "Spanish El Salvador"], _
							[0x100A, "Spanish Guatemala"], _
							[0x480A, "Spanish Honduras"], _
							[0x4C0A, "Spanish Nicaragua"], _
							[0x180A, "Spanish Panama"], _
							[0x3C0A, "Spanish Paraguay"], _
							[0x280A, "Spanish Peru"], _
							[0x500A, "Spanish Puerto Rico"], _
							[0x0C0A, "Spanish Spain (Modern Sort)"], _
							[0x380A, "Spanish Uruguay"], _
							[0x200A, "Spanish Venezuela"], _
							[0x0430, "Sutu"], _
							[0x0441, "Swahili"], _
							[0x041D, "Swedish"], _
							[0x081D, "Swedish Finland"], _
							[0x100C, "Swiss French"], _
							[0x0807, "Swiss German"], _
							[0x0810, "Swiss Italian"], _
							[0x0428, "Tajik"], _
							[0x0449, "Tamil"], _
							[0x0444, "Tatar"], _
							[0x044A, "Telugu"], _
							[0x041E, "Thai"], _
							[0x0451, "Tibetan"], _
							[0x0431, "Tsonga"], _
							[0x0432, "Tswana"], _
							[0x041F, "Turkish"], _
							[0x0442, "Turkmen"], _
							[0x0422, "Ukrainian"], _
							[0x0420, "Urdu"], _
							[0x0843, "Uzbek Cyrillic"], _
							[0x0443, "Uzbek Latin"], _
							[0x0433, "Venda"], _
							[0x042A, "Vietnamese"], _
							[0x0452, "Welsh"], _
							[0x0434, "Xhosa"], _
							[0x0435, "Zulu"]]