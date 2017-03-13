InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"WaitForVSync")

Repeat
  ExamineKeyboard()
  
  ClearScreen(0,0,0)
  
  C+1:If GetTickCount_()-Start>=1000:Start=GetTickCount_():FPS=C:C=0:EndIf
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  FrontColor(255,255,0)
  
  Select VSync
    Case 0
      DrawText("VSync: Off (press space)")
    Default
      DrawText("VSync: On (press space)")
  EndSelect
  Locate(0,20)
  DrawText("FPS: "+Str(FPS))
  StopDrawing()
  
  If KeyboardReleased(#PB_Key_Space):VSync=~VSync:EndIf
  
  If VSync:WaitForVSync():EndIf
  
  SwapBuffers()
Until KeyboardPushed(#PB_Key_Escape)
