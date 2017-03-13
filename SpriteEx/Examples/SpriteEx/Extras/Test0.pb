IncludeFile "DisplayWindowOnScreen.pbi"
InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"DisplayWindowOnScreen")


StartDrawing(ScreenOutput())
Box(0,0,1024,768,#green)
StopDrawing()

FlipBuffers()

AllowDisplayWindows()
OpenWindow(1,0,0,100,100,#PB_Window_SystemMenu|#PB_Window_ScreenCentered,"Window")
MakeScreenWindow(WindowID())

Repeat
Until WindowEvent()=#PB_Event_CloseWindow

CloseScreenWindow(WindowID())

StopDisplayWindows()

Delay(500)
End
; ExecutableFormat=Windows
; DisableDebugger
; EOF