InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"pseudo screenresolution")

LoadSprite(1,"Ring.bmp")

Repeat
  ExamineKeyboard()
  
  If KeyboardReleased(#PB_Key_Up)
    mode-1
    If mode<0:mode=3:EndIf
  EndIf
  
  If KeyboardReleased(#PB_Key_Down)
    mode+1
    If mode>3:mode=0:EndIf
  EndIf
  
  ;#################### Drawing ####################
  StartDrawing(ScreenOutput())
  Box(0,0,320,200,#blue)
  DrawingMode(1)
  FrontColor(255,255,255)
  If mode=0:FrontColor(255,0,0):EndIf
  Locate(16,0)
  DrawText("320x200")
  
  FrontColor(255,255,255)
  If mode=1:FrontColor(255,0,0):EndIf
  Locate(16,16)
  DrawText("640x480")
  
  FrontColor(255,255,255)
  If mode=2:FrontColor(255,0,0):EndIf
  Locate(16,32)
  DrawText("800x600")
  
  FrontColor(255,255,255)
  If mode=3:FrontColor(255,0,0):EndIf
  Locate(16,48)
  DrawText("1024x768")
  StopDrawing()
  
  DisplayTransparentSprite(1,0,0)
  DisplayTransparentSprite(1,0,16)
  DisplayTransparentSprite(1,0,32)
  DisplayTransparentSprite(1,0,48)
  ;################################################
  
  Select mode
    Case 0
      ScreenWidth=320:ScreenHeight=200
    Case 1
      ScreenWidth=640:ScreenHeight=480
    Case 2
      ScreenWidth=800:ScreenHeight=600
    Case 3
      ScreenWidth=1024:ScreenHeight=768
  EndSelect
  
  WaitForVSync()
  CopyBufferEx(ScreenWidth,ScreenHeight)
  
Until KeyboardPushed(#PB_Key_Escape)
