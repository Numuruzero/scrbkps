; #Persistent
; #SingleInstance, Ignore
WinId := 1  ;SET TO ONE UNTIL SET TO ZERO UNTIL A WINDOW IS CLICKED
WinT := 255
WinTog := false

^NumpadDot:: { ;SET HOTKEY TO TOGGLE CLICK-THROUGH
    global WinTog, WinId
    WinTog := !WinTog
    if WinTog
        WinSetExStyle("+0x20", WinId)
    else
        WinSetExStyle("-0x20", WinId)
    return
}

^NumpadMult:: { ;SET HOTKEY TO RESET SELECTED WINDOW
    global WinId, WinTog
    if WinTog { ;IF CLICK-THROUGH IS ENABLED, DISABLE IT FIRST
        WinSetExStyle("-0x20", WinId)
        WinTog := !WinTog
    }
    if (WinId = 1)
        WinId := 0
    else
        WinId := 1
    return
}

#HotIf (WinId = 0)
LButton:: {
    global WinId
    MouseGetPos(, , &WinId)
    return
}

#HotIf MouseIsOver(WinId)
global WinT, WinId
WheelUp:: {
    global WinT, WinId
    if (WinT < 255) {
        WinT += 10
        WinSetTransparent(WinT, WinId)
    }
    return
}

WheelDown:: {
    global WinT, WinId
    if (WinT > 10) {
        WinT -= 10
        WinSetTransparent(WinT, WinId)
    }
    return
}

MouseIsOver(WinId) {
    MouseGetPos(, , &Win)
    if (Win = WinId) {
        return WinExist("ahk_id " . Win)
    }
}
