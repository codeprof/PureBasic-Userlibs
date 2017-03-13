IncludeFile "DisplayWindowOnScreen.pbi"



Procedure.s ScreenOpenFileRequester(Title$,Path$,Pattern$)
  AllowDisplayWindows()
  Flags=#PB_Window_ScreenCentered|#PB_Window_TitleBar
  OpenWindow(1000,0,0,450,280,Flags,Title$)
  MakeScreenWindow(WindowID())
  CreateGadgetList(WindowID())
  
  If Path$=""
    Path$=Space(255)
    GetCurrentDirectory_(255,@Path$)
  EndIf
  
  If Right(Path$,1)<>"\":Path$+"\":EndIf
  ExplorerComboGadget(1,0,0,300,180,Path$) 
  ExplorerListGadget(2,0,25,450,200,Path$+Pattern$,#PB_Explorer_AlwaysShowSelection) 
  ChangeListIconGadgetDisplay(2,2)
  
  TextGadget(3,30,247,30,20,"File:")
  StringGadget(4,60,245,280,20,"")
  ButtonGadget(5,360,230,75,20,"&Open")
  ButtonGadget(6,360,255,75,20,"&Cancel")
  Quit=0 
  Repeat 
    Event=WaitWindowEvent() 
    
    If EventType()=#PB_EventType_Change And EventGadgetID()=2
      Pf$=GetGadgetText(2)
      SetGadgetText(1,Pf$)
      For M=0 To CountGadgetItems(2) 
        If GetGadgetItemState(2,M)=#PB_Explorer_Selected|#PB_Explorer_File:Name$=GetGadgetItemText(2,M,0):EndIf
      Next
      SetGadgetText(4,Name$)
      For M=0 To 50
        WindowEvent()
      Next
    EndIf
    
    If EventType()=#PB_EventType_LeftClick And EventGadgetID()=1
      Pf$=GetGadgetText(1)
      SetGadgetText(2,Pf$)
      For M=0 To 50
        WindowEvent()
      Next
    EndIf
    
    If EventGadgetID()=5 And Event=#PB_Event_Gadget And GetGadgetText(4)<>"":Quit=1:EndIf 
    If EventGadgetID()=6 And Event=#PB_Event_Gadget:Quit=2:EndIf 
  Until Quit
  Name$=GetGadgetText(4)
  Result.s=""
  If Quit=1:Result.s=Pf$+Name$:EndIf
  
  Repeat:Until WindowEvent()=0
  
  CloseScreenWindow(WindowID())
  StopDisplayWindows()
  ProcedureReturn Result
EndProcedure


InitSprite()

OpenScreen(1024,768,16,"ScreenOpenFileRequester")

StartDrawing(ScreenOutput())
Circle(1024/2,768/2,400,#blue)
StopDrawing()

FlipBuffers()

ScreenOpenFileRequester("Open","","*.*")
; ExecutableFormat=Windows
; DisableDebugger
; EOF