#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#InstallKeybdHook

WarrID := 0
ShamID := 0
LockID := 0

CoordMode, Mouse, Client

BreakFollow(wID) {
	ControlSend, ahk_parent, {Left}, ahk_id %wID%
}

BreakFollowAll() {
	BreakFollow(ShamID)
	BreakFollow(LockID)
}

PostRaidWarning(msg) {
	Send, /rw{Space}%msg%{Enter}
}

#IfWinActive World of Warcraft
::raidrules::
Loop, Read, kos_pug_rules.txt
{
	WinActivate, ahk_id %WarrID%
	PostRaidWarning(A_LoopReadLine)
	Sleep 5000
}
return

#IfWinActive World of Warcraft
::zgrules::
Loop, Read, kos_pug_rules_zg.txt
{
	WinActivate, ahk_id %WarrID%
	PostRaidWarning(A_LoopReadLine)
	Sleep 5000
}
return

#IfWinActive World of Warcraft
::gdkprules::
Loop, Read, kos_pug_gdkp_rules.txt
{
	WinActivate, ahk_id %WarrID%
	PostRaidWarning(A_LoopReadLine)
	Sleep 5000
}
return
	
#IfWinActive World of Warcraft
NumpadEnter::
WinGet, winCur, ID, World of Warcraft
if (winCur = ShamID) {
	BreakFollow(winCur)
	Sleep 50
}
ControlSend, ahk_parent, u, ahk_id %winCur%
return

; Set Warr
#IfWinActive World of Warcraft
^1::
WinGet, WarrID, ID, World of Warcraft
return

; Set Sham
#IfWinActive World of Warcraft
^2::
WinGet, ShamID, ID, World of Warcraft
return

; Set Lock
#IfWinActive World of Warcraft
^3::
WinGet, LockID, ID, World of Warcraft
return

; Heal Main
#IfWinActive World of Warcraft
AppsKey::
BreakFollow(ShamID)
Sleep 50
ControlSend, ahk_parent, q, ahk_id %ShamID%
return

; Assist Attack
#IfWinActive World of Warcraft
^Numpad0::
WinGet, winCur, ID, World of Warcraft
ControlSend, ahk_parent, w, ahk_id %ShamID%
if (winCur = ShamID) {
	WinActivate, ahk_id %WarrID%
}
return

; Assist Shock
#IfWinActive World of Warcraft
^Numpad7::
WinGet, winCur, ID, World of Warcraft
ControlSend, ahk_parent, d, ahk_id %ShamID%
if (winCur = ShamID) {
	WinActivate, ahk_id %WarrID%
}
return

; Windfury
#IfWinActive World of Warcraft
+Delete::
ControlSend, ahk_parent, {Delete}, ahk_id %ShamID%
return

; Str of Earth
#IfWinActive World of Warcraft
+End::
ControlSend, ahk_parent, t, ahk_id %ShamID%
return

; ManaSpring
#IfWinActive World of Warcraft
+Xbutton2::
ControlSend, ahk_parent, f, ahk_id %ShamID%
return

; Poison Cleansing
#IfWinActive World of Warcraft
^Xbutton2::
ControlSend, ahk_parent, d, ahk_id %ShamID%
return

; All Mount
#IfWinActive World of Warcraft
$Home::
ControlSend, ahk_parent, {Home}, ahk_id %WarrID%
ControlSend, ahk_parent, {Home}, ahk_id %ShamID%
ControlSend, ahk_parent, {Home}, ahk_id %LockID%
return

; Toggle Sham/Warr
#IfWinActive World of Warcraft
NumLock::
WinGet, winCur, ID, World of Warcraft
if (winCur = WarrID) {
	WinActivate, ahk_id %ShamID%
} else {
	WinActivate, ahk_id %WarrID%
}
return

; Toggle Lock/Warr
#IfWinActive World of Warcraft
Pause::
WinGet, winCur, ID, World of Warcraft
if (winCur = WarrID or winCur = ShamID) {
	WinActivate, ahk_id %LockID%
} else {
	WinActivate, ahk_id %WarrID%
}
return

; Follow
; Focuses Main Window
#IfWinActive World of Warcraft
$NumpadDiv::
WinGet, winCur, ID, World of Warcraft

ControlSend, ahk_parent, {NumpadDiv}, ahk_id %ShamID%
ControlSend, ahk_parent, {NumpadDiv}, ahk_id %LockID%

if (winCur != WarrID) {
	WinActivate, ahk_id %WarrID%
}
return

#IfWinActive World of Warcraft
$^Backspace::
WinGet, winCur, ID, World of Warcraft

if (winCur == WarrID) {
	BreakFollow(ShamID)
	BreakFollow(LockID)
	Sleep 50
} else if (winCur == ShamID) {
	BreakFollow(ShamID)
	Sleep 50
}

ControlSend, ahk_parent, y, ahk_id %ShamID%
return

#IfWinActive World of Warcraft
$Numpad1::
WinGet, winCur, ID, World of Warcraft

if (winCur != WarrID) {
	BreakFollow(winCur)
	Sleep 50
}

ControlSend, ahk_parent, {Numpad1}, ahk_id %winCur%
return

#IfWinActive World of Warcraft
$^Numpad1::
WinGet, winCur, ID, World of Warcraft
Suspend, On
if (winCur == WarrID) {
	BreakFollow(ShamID)
	Sleep 50
	ControlSend, ahk_parent, q, ahk_id %ShamID%
} else {
	BreakFollow(winCur)
	Sleep 50
	ControlSend, ahk_parent, {Numpad1}, ahk_id %winCur%
}
Suspend, Off
return

#IfWinActive World of Warcraft
$Numpad2::
WinGet, winCur, ID, World of Warcraft

if (winCur != WarrID) {
	BreakFollow(winCur)
	Sleep 50
}

ControlSend, ahk_parent, {Numpad2}, ahk_id %winCur%
return

#IfWinActive World of Warcraft
$^Numpad2::
WinGet, winCur, ID, World of Warcraft
Suspend, On
if (winCur == WarrID) {
	BreakFollow(ShamID)
	Sleep 50
	ControlSend, ahk_parent, w, ahk_id %ShamID%
} else {
	BreakFollow(winCur)
	Sleep 50
	ControlSend, ahk_parent, {Numpad2}, ahk_id %winCur%
}
Suspend, Off
return

#IfWinActive World of Warcraft
$Numpad3::
WinGet, winCur, ID, World of Warcraft

if (winCur != WarrID) {
	BreakFollow(winCur)
	Sleep 50
}

ControlSend, ahk_parent, {Numpad3}, ahk_id %winCur%
return

#IfWinActive World of Warcraft
$Numpad4::
WinGet, winCur, ID, World of Warcraft

if (winCur != WarrID) {
	BreakFollow(winCur)
	Sleep 50
}

ControlSend, ahk_parent, {Numpad4}, ahk_id %winCur%
return

#IfWinActive World of Warcraft
$^Numpad4::
WinGet, winCur, ID, World of Warcraft
Suspend, On
if (winCur == WarrID) {
	BreakFollow(ShamID)
	Sleep 50
	ControlSend, ahk_parent, e, ahk_id %ShamID%
} else {
	BreakFollow(winCur)
	Sleep 50
	ControlSend, ahk_parent, {Numpad4}, ahk_id %winCur%
}
Suspend, Off
return

#IfWinActive World of Warcraft
$Numpad5::
WinGet, winCur, ID, World of Warcraft

if (winCur != WarrID) {
	BreakFollow(winCur)
	Sleep 50
}

ControlSend, ahk_parent, {Numpad5}, ahk_id %winCur%
return

#IfWinActive World of Warcraft
$^Numpad5::
WinGet, winCur, ID, World of Warcraft
Suspend, On
if (winCur == WarrID) {
	BreakFollow(ShamID)
	Sleep 50
	ControlSend, ahk_parent, ro, ahk_id %ShamID%
} else {
	BreakFollow(winCur)
	Sleep 50
	ControlSend, ahk_parent, {Numpad5}, ahk_id %winCur%
}
Suspend, Off
return