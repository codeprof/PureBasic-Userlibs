InitSprite()
InitKeyboard()

OpenWindow(1,0,0,320,200,#PB_Window_ScreenCentered|#PB_Window_SystemMenu,GetSpriteExVersion())
OpenWindowedScreen(WindowID(),0,0,320,200,0,0,0)


StartDrawing(ScreenOutput())
PixelFormat=DrawingBufferPixelFormat() 
StopDrawing()

Repeat
  ClearScreen(0,0,0)
  
  StartDrawing(ScreenOutput())
  Box(0,0,50,50,#green)
  For M=15 To 0 Step -1
    Circle(25,25,M,RGB(255,255-(15*M),0))
  Next
  StopDrawing()
  
  For Z=0 To 7
    CopyScreenPartTrans(0,0,50,50,200,Z*15,RGBColor(PixelFormat,0,255,0))
  Next
  
  FlipBuffers()
  Event=WindowEvent()
  If Event=#PB_Event_CloseWindow:End:EndIf
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; DisableDebugger
; EOF