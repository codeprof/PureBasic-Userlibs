#WindowFlags=#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_ScreenCentered
OpenWindow(0,0,0,200,100,"Select Render-Device",#WindowFlags)
CreateGadgetList(WindowID(0))
Frame3DGadget(1,5,5,190,70,"Render-Device")
OptionGadget(2,20,20,160,20,"Software Device")
OptionGadget(3,20,40,160,20,"Hardware accelerated Device")
SetGadgetState(2,1)
ButtonGadget(4,50,80,100,20,"Start")
Repeat
Event=WaitWindowEvent()
If Event=#PB_Event_CloseWindow:End:EndIf
If Event=#PB_Event_Gadget
If EventGadget()=4:Start=1:EndIf
EndIf
Until Start

DeviceType=#S3DR_SoftwareDevice
If GetGadgetState(3):DeviceType=#S3DR_HWAcceleratedDevice:EndIf
CloseWindow(0)


InitSprite()
InitSprite3D()
InitKeyboard()


SetFrameRate(8000)

Title$="Use hardware-device for rendering"
If DeviceType=#S3DR_SoftwareDevice:Title$="Use software-device for rendering":EndIf

OpenWindow(1,0,0,320,240,Title$,#WindowFlags)
OpenWindowedScreen(WindowID(1),0,0,320,240,1,0,0)

S3DR_CreateZBuffer(DeviceType)

Start3D()
S3DR_BeginReal3D()

;Create a cube
S3DR_StartCreateMesh()
S3DR_CreateMesh_AddQuad( 1,-1, 1,-1,-1, 1, 1,-1,-1,-1,-1,-1)
S3DR_CreateMesh_AddQuad( 1, 1, 1,-1, 1, 1, 1,-1, 1,-1,-1, 1)
S3DR_CreateMesh_AddQuad(-1, 1, 1, 1, 1, 1,-1, 1,-1, 1, 1,-1)
S3DR_CreateMesh_AddQuad(-1, 1, 1,-1, 1,-1,-1,-1, 1,-1,-1,-1)
S3DR_CreateMesh_AddQuad(-1, 1,-1, 1, 1,-1,-1,-1,-1, 1,-1,-1)
S3DR_CreateMesh_AddQuad( 1, 1,-1, 1, 1, 1, 1,-1,-1, 1,-1, 1)
Cube=S3DR_StopCreateMesh()

S3DR_MoveCamera(0,0,-5)
S3DR_EndReal3D()
Stop3D()

LoadSprite(1,"apple.bmp",#PB_Sprite_Texture)

Repeat

Start3D()
S3DR_BeginReal3D()

S3DR_ClearScreenAndZBuffer(#Blue)


Angle.f=ElapsedMilliseconds()/1000
S3DR_SelectTexture(1)
S3DR_DrawMesh(Cube,0,0,0,Angle,Angle,Angle)

S3DR_EndReal3D()
Stop3D()

FrameCount+1
If ElapsedMilliseconds()-time=>1000:time=ElapsedMilliseconds():FPS=FrameCount:FrameCount=0:EndIf

StartDrawing(ScreenOutput())
DrawingMode(1)
FrontColor(#White)
DrawingFont(GetStockObject_(#ANSI_VAR_FONT))
DrawText(0,0,"FPS:"+Str(FPS))
StopDrawing()

ExamineKeyboard()
If KeyboardReleased(#PB_Key_F1):NumberOfTrees+1:EndIf

FlipBuffers(0)

Until WindowEvent()=#PB_Event_CloseWindow


; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 77
; FirstLine = 55
; Folding = -
; DisableDebugger