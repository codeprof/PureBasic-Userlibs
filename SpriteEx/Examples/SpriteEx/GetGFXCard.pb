InitSprite()

OpenWindow(1,0,0,600,200,#PB_Window_ScreenCentered|#PB_Window_SystemMenu,"GetGFXCard()")
OpenWindowedScreen(WindowID(),0,0,600,200,0,0,0)

GFXCard$=GetGFXCard()
If GFXCard$="":MessageRequester("","GetGFXCard() is failed !"):End:EndIf
Repeat

StartDrawing(ScreenOutput())
DrawingFont(LoadFont(1,"Arial",16))
FrontColor(255,255,0)
DrawingMode(1)


DrawText("Name: "+GFXCard$)
StopDrawing()

FlipBuffers()

Until WaitWindowEvent()=#PB_Event_CloseWindow
CloseFont(1)
; ExecutableFormat=Windows
; EOF