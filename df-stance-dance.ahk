#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

force_equip_count := 0

stance := new GatherStance()

class DFHotkey {
    static equip_twohand    := "q"
    static equip_onehand    := "{RCtrl}{RShift}4"
    static equip_board      := "{RCtrl}{RShift}5"
    static equip_bow        := "e"
    static equip_staff      := "{CapsLock}"
}

class Stance {
}

class TwoHandStance extends Stance {
    __New() {
    }

    Equip() {
        Send, % DFHotkey.equip_twohand
    }
}

class OneHandStance extends Stance {
    __New() {
    }

    Equip() {
        Send, % DFHotkey.equip_onehand
        Sleep, 600
        this.EquipBoard()
    }

    EquipBoard() {
        Send, % DFHotkey.equip_board
    }
}

class ArcherStance extends Stance {
    __New() {
    }

    Equip() {
        Send, % DFHotkey.equip_bow
    }
}

class MageStance extends Stance {
    __New() {
    }

    Equip() {
        Send, % DFHotkey.equip_staff
    }
}

class GatherStance extends Stance {
}

; TwoHand
*$q::
    if (stance.__class != TwoHandStance.__class) {
        stance := new TwoHandStance()
        stance.Equip()
    } else {
        ForceEquip()
    }
    return


; OneHand
*$Tab::
    if (stance.__class != OneHandStance.__class) {
        stance := new OneHandStance()
        stance.Equip()
    } else {
        stance.EquipBoard()
    }
    return

; Archer
*$e::
    if (stance.__class != ArcherStance.__class) {
        stance := new ArcherStance()
        stance.Equip()
    } else {
        ForceEquip()
    }
    return

; Mage
*$CapsLock::
    if (stance.__class != MageStance.__class) {
        stance := new MageStance()
        stance.Equip()
    } else {
        ForceEquip()
    }
    return
    

*Pause::
    Suspend
    return


; This allows you to force call Equip() method if the weapon wasn't successfully equipped initially
ForceEquip() {
    global force_equip_count

    SetTimer, force_equip, -200, 1
    force_equip_count += 1
    return

force_equip:
    ; If you press the key 3 times you will force call Equip() method again
    ; If you spam the key 3 times when you initially change stances force_equip_count will be 2, therefor stance.Equip() will only be called once during the initial stance change
    if (force_equip_count >= 3) {
        stance.Equip()
    }
    force_equip_count := 0
    return
}

;;
;;
;;
f1::
MsgBox,,, % stance.__class
return
