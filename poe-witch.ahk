#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

curse_x := 0
curse_y := 0

tele_x := 0
tele_y := 0

hkey_mmouse_x := 1600
hkey_mmouse_y := 974

^!r::Reload

#IfWinActive Path of Exile
^!a::
	MouseGetPos, curse_x, curse_y
return

#IfWinActive Path of Exile
^!s::
	MouseGetPos, tele_x, tele_y
return

; Switch mmouse hotkey to curse skill
#IfWinActive Path of Exile
a::
	If GetKeyState("LButton") {
		return
	}

	MouseGetPos, x, y

	Click, %hkey_mmouse_x%, %hkey_mmouse_y%
	Sleep 100
	Click, %curse_x%, %curse_y%
	Sleep 100

	MouseMove, %x%, %y%
return

; Switch mmouse hotkey to tele skill
#IfWinActive Path of Exile
s::
	If GetKeyState("LButton") {
		return
	}

	MouseGetPos, x, y

	Click, %hkey_mmouse_x%, %hkey_mmouse_y%
	Sleep 100
	Click, %tele_x%, %tele_y%
	Sleep 100

	MouseMove, %x%, %y%
return