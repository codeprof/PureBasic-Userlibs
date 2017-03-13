InitSprite()
InitKeyboard()

OpenWindow(1,0,0,640,480,#PB_Window_ScreenCentered|#PB_Window_SystemMenu,"SpriteEx Beispiel")
OpenWindowedScreen(WindowID(),0,0,640,480,0,0,0)

GFXInfo$=GetGFXCard()+"("+GetGFXDriver()+")"

Freq=GetMonitorFreq()
SetFrameRate(1000)

StartDrawing(ScreenOutput())
PixelFormat=DrawingBufferPixelFormat() 
StopDrawing()

Font=LoadFont(1,"Arial",50)

Structure Box
  x.l
  y.l
  dx.l
  dy.l
  color.l
  RGB.l
EndStructure

Dim Boxes.Box(100)

For M=0 To 100
  Boxes(M)\x=Random(640)
  Boxes(M)\y=Random(480)
  If Random(1):Boxes(M)\dx=-1:Else:Boxes(M)\dx=1:EndIf
  If Random(1):Boxes(M)\dy=-1:Else:Boxes(M)\dy=1:EndIf
  
  If PixelFormat=#PB_PixelFormat_8Bits
    Boxes(M)\color=Random(255):Boxes(M)\RGB=Random($FFFFFF)
  Else
    Boxes(M)\RGB=Random($FFFFFF)
    Boxes(M)\color=RGBColor(PixelFormat,Red(Boxes(M)\RGB),Green(Boxes(M)\RGB),Blue(Boxes(M)\RGB))
  EndIf
Next


Repeat
  Count+1
  If GetTickCount_()-Start>=1000
    Start=GetTickCount_()
    SetWindowText_(WindowID(),"SpriteEx Beispiel   "+Str(Count)+"/"+Str(Freq)+" FPS      "+GFXInfo$)
    Count=0
  EndIf
  
  Error=ColorBox(0,0,640,480,RGBColor(PixelFormat,0,96,128))
  
  If Error
    StartDrawing(ScreenOutput())
    Box(0,0,640,480,RGB(0,96,128))
    StopDrawing()
  EndIf
  
  StartDrawing(ScreenOutput())
  FrontColor(255,255,0)
  DrawingFont(Font)
  DrawingMode(1)
  DrawText("SpriteEx Library")
  StopDrawing()
  
  Error=CopyScreenPart(0,0,550,80,0,400)  
  
  If Error
    StartDrawing(ScreenOutput())
    FrontColor(255,255,0)
    DrawingFont(Font)
    DrawingMode(1)
    Locate(0,400)
    DrawText("SpriteEx Library")
    StopDrawing()
  EndIf
  
  For M=0 To 100
    Boxes(M)\x+Boxes(M)\dx
    Boxes(M)\y+Boxes(M)\dy
    x=Boxes(M)\x:dx=Boxes(M)\dx
    y=Boxes(M)\y:dy=Boxes(M)\dy
    If x<=0:Boxes(M)\dx=1:EndIf
    If y<=0:Boxes(M)\dy=1:EndIf
    If x>=640:Boxes(M)\dx=-1:EndIf
    If y>=480:Boxes(M)\dy=-1:EndIf
    Error=ColorBox(x-10,y-10,20,20,Boxes(M)\color)
    If Error
      StartDrawing(ScreenOutput())
      Box(x-10,y-10,20,20,Boxes(M)\RGB)
      StopDrawing()
    EndIf
    
  Next
  
  WaitForVSync()  
  FlipBuffers(0)
  Event=WindowEvent()
  If Event=#PB_Event_CloseWindow:End:EndIf
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; DisableDebugger
; EOF