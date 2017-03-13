InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"SwapBuffers Test")

LoadSprite(1,"green.bmp")

Rad=100
Repeat
  ClearScreen(128,128,128)
  
  Speed.f+0.005
  
  For Y=0 To  30 Step 5
    For X=0 To 500 Step 5
      DisplayTransparentSprite(1,200+Sin(X+Speed)*Rad+Y,200+Cos(X+Speed)*Rad+Y)
    Next
  Next
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  FrontColor(255,255,0)
  DrawText(Str(FPS)+" FPS")
  StopDrawing()
  
  Frames+1:If GetTickCount_()-S>=1000:S=GetTickCount_():FPS=Frames:Frames=0:EndIf
  
  SwapBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
End
