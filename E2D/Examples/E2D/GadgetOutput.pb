Flags=#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget
OpenWindow(1,0,0,200,200,Flags,"GadgetOutput()")

CreateGadgetList(WindowID())

OptionGadget(1,50,50,75,20,"Gadget 1")
OptionGadget(2,50,70,75,20,"Gadget 2")
OptionGadget(3,50,90,75,20,"Gadget 3")


Repeat
  
  Event=WaitWindowEvent()
  
  For Gadget=1 To 3
    
    StartDrawing(GadgetOutput(Gadget))
    If GetGadgetState(Gadget)
      Circle(8,8,8,#yellow)
    Else
      Circle(8,8,8,#blue)
    EndIf
    StopDrawing()
    
  Next
  
Until Event=#PB_Event_CloseWindow
; ExecutableFormat=Windows
; EOF