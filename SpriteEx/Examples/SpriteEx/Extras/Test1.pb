IncludeFile "DisplayWindowOnScreen.pbi"
InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"DisplayWindowOnScreen")

FlipBuffers()

Repeat
  StartDrawing(ScreenOutput());draw something ...
  Box(0,0,1024,768,#blue)
  Circle(1024/2,768/2,200,#yellow)
  Circle(1024/2,768/2,100,#red)
  DrawText("Press ESC")
  StopDrawing()
  
  
  FlipBuffers()
  ExamineKeyboard()
  
  If KeyboardPushed(#PB_Key_Escape)
    AllowDisplayWindows()
    
    
    Flags=#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget  
    OpenWindow(1,0,0,200,100,Flags,"Move me")
    MakeScreenWindow(WindowID())
    Delay(1000)
    
    Start=GetTickCount_()
    Repeat
      Event=WindowEvent()
      Delay(25)
      
      secs$=StrF((10000-(GetTickCount_()-Start))/1000,1)
      
      SetWindowText_(WindowID(),"Close in "+secs$+" secs")
    Until Event=#PB_Event_CloseWindow Or GetTickCount_()-Start>10000
    
    CloseScreenWindow(WindowID()) ;don't use closewindow() !!!
    
    StopDisplayWindows()
    End
  EndIf
  
ForEver
; ExecutableFormat=Windows
; DisableDebugger
; EOF