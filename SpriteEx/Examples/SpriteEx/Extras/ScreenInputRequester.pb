IncludeFile "DisplayWindowOnScreen.pbi"

Procedure.s ScreenInputRequester(Title$,Text$,Eing$) 
  AllowDisplayWindows()
  
  Flags=#PB_Window_ScreenCentered|#PB_Window_TitleBar 
  OpenWindow(1000,0,0,320,90,Flags,Title$,ScreenID()) 
  MakeScreenWindow(WindowID())
  CreateGadgetList(WindowID()) 
  TextGadget(1,0,0,320,60,Text$) 
  gadget=StringGadget(2,0,60,270,20,Eing$) 
  ButtonGadget(3,275,60,40,20,"&Ok",#PB_Button_Default) 
  
  SetFocus_(gadget) 
  SendMessage_(gadget,#EM_SETSEL,0,Len(Eing$)) 
  SetWindowPos_(WindowID(),#HWND_TOPMOST,0,0,0,0,#SWP_NOSIZE|#SWP_NOMOVE)  
  Quit=0 
  
  Repeat 
    Event=WaitWindowEvent() 
    
    If EventGadgetID()=3 And Event=#PB_Event_Gadget:Quit=1:EndIf 
  Until Quit=1 
  Result.s=GetGadgetText(2) 
  
  Repeat:Until WindowEvent()=0 
  CloseScreenWindow(WindowID())
  StopDisplayWindows()
  ProcedureReturn Result.s 
EndProcedure 




InitSprite()

OpenScreen(1024,768,16,"ScreenOpenFileRequester")

StartDrawing(ScreenOutput())
Circle(1024/2,768/2,400,#blue)
StopDrawing()

FlipBuffers()

ScreenInputRequester("title","text","bla bla bla bla")


; ExecutableFormat=Windows
; DisableDebugger
; EOF