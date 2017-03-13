IncludeFile "DisplayWindowOnScreen.pbi"



Procedure ScreenAlertBox(Title.s,Text.s,Buttons.s)
AllowDisplayWindows()
  If Font=0:Font=GetStockObject_(#SYSTEM_FONT):EndIf 
  Structure Button 
    Text.s 
    Width.l 
  EndStructure 
  Dim Button.Button(100) 
  Buttons+"|" 
  Text+Chr(13) 
  
  TmpDC=CreateCompatibleDC_(0) 
  SelectObject_(TmpDC,Font) 
  
  For M=1 To Len(Buttons) 
    If Mid(Buttons,M,1)="|" 
      GetTextExtentPoint32_(TmpDC,@Str$,Len(Str$),sz.size) 
      Button(ButtonAnz)\Width=sz\cx+10 
      Button(ButtonAnz)\Text=Str$ 
      
      If sz\cy+5>ButtonHeight:ButtonHeight=sz\cy+5:EndIf 
      
      GesButtonWidth=GesButtonWidth+sz\cx+10 
      Str$="" 
      ButtonAnz+1 
    Else 
      Str$=Str$+Mid(Buttons,M,1) 
    EndIf 
  Next 
  
  For M=1 To Len(Text) 
    If Mid(Text,M,1)=Chr(13) 
      GetTextExtentPoint32_(MemDC,@Str$,Len(Str$),sz.size) 
      TextHeight+sz\cy 
      If sz\cx+10>TextWidth:TextWidth=sz\cx+10:EndIf 
      Str$="" 
    Else 
      Str$=Str$+Mid(Text,M,1) 
    EndIf 
  Next 
  DeleteDC_(TmpDC) 
  
  WindowWidth=GesButtonWidth+10 
  If WindowWidth<150:WindowWidth=150:EndIf 
  If WindowWidth<TextWidth:WindowWidth=TextWidth:EndIf 
  
  WindowHeight=TextHeight+ButtonHeight+10 
  
  Flags=#PB_Window_ScreenCentered|#PB_Window_TitleBar 
  OpenWindow(1000,0,0,WindowWidth,WindowHeight,Flags,Title,ScreenID()) 
  MakeScreenWindow(WindowID())
  CreateGadgetList(WindowID()) 
  TextGadget(0,XAbs,YAbs,WindowWidth,TextHeight,Text,#PB_Text_Center) 
  ;SetGadgetFont(0,Font) 
  
  XAbs=(WindowWidth-GesButtonWidth)/2 
  YAbs=TextHeight 
  
  X=XAbs 
  For M=0 To ButtonAnz-1 
    ButtonGadget(M+2,X,YAbs,Button(M)\Width,ButtonHeight,Button(M)\Text) 
    ;SetGadgetFont(M+2,Font) 
    X+Button(M)\Width 
  Next 
  
  Quit=0 
  Repeat 
    Event=WaitWindowEvent() 
    Gadget=EventGadgetID() 
    If Gadget>=2 And Gadget<ButtonAnz+2 And Event=#PB_Event_Gadget:Quit=1:EndIf 
  Until Quit=1 
  Result=Gadget-1 
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

ScreenAlertBox("???","Do you like PureBasic ?","&Yes|&No|I don't know")
; ExecutableFormat=Windows
; DisableDebugger
; EOF