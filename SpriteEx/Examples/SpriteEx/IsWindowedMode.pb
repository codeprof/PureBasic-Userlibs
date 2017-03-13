InitSprite()

OpenScreen(1024,768,16,"IsWindowedMode()")

StartDrawing(ScreenOutput())
DrawingFont(LoadFont(1,"Arial",16))
FrontColor(255,0,0)
DrawingMode(1)

DrawText("WindowedMode="+Str(IsWindowedMode()))
StopDrawing()

FlipBuffers()
Delay(4000)

CloseScreen()

OpenWindow(1,0,0,640,480,#PB_Window_ScreenCentered,"IsWindowedMode()")
OpenWindowedScreen(WindowID(),0,0,640,480,0,0,0)

StartDrawing(ScreenOutput())
DrawingFont(FontID())
FrontColor(255,0,0)
DrawingMode(1)

DrawText("WindowedMode="+Str(IsWindowedMode()))
StopDrawing()

FlipBuffers()
Delay(4000)
CloseFont(1)
; ExecutableFormat=Windows
; EOF