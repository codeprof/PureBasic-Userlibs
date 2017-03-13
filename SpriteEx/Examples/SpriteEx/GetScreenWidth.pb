InitSprite()

OpenScreen(1024,768,16,"GetScreenWidth/GetScreenHeight")

StartDrawing(ScreenOutput())
DrawingFont(LoadFont(1,"small fonts",40))
FrontColor(255,0,0)
DrawingMode(1)
DrawText(Str(GetScreenWidth())+"x"+Str(GetScreenHeight()))
StopDrawing()

FlipBuffers()
Delay(4000)

CloseScreen()

OpenWindow(1,0,0,500,300,#PB_Window_ScreenCentered,"GetScreenWidth/GetScreenHeight")
OpenWindowedScreen(WindowID(),10,10,400,200,0,0,0)

StartDrawing(ScreenOutput())
DrawingFont(FontID())
FrontColor(255,0,0)
DrawingMode(1)
DrawText(Str(GetScreenWidth())+"x"+Str(GetScreenHeight()))
StopDrawing()

FlipBuffers()
Delay(4000)
CloseFont(1)
; ExecutableFormat=Windows
; EOF