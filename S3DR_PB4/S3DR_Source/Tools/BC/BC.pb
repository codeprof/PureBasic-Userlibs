

Structure D3DXMATRIX 
  _11.f 
  _12.f 
  _13.f 
  _14.f 
  _21.f 
  _22.f 
  _23.f 
  _24.f 
  _31.f 
  _32.f 
  _33.f 
  _34.f 
  _41.f 
  _42.f 
  _43.f 
  _44.f 
EndStructure

#D3DTS_PROJECTION=3 
#D3DTS_VIEW=2 


#Width=800
#Height=600
#Title="BlockCreator"

Global windowed
Global Start
Global dx8vb
Global D3DXMatrixInverse
Global bkcolor
Global Quality

Global PosX
Global PosY
Global PosZ
Global SetPosY

Global Gwidth,Gheight,Gdepth
Gwidth=10:Gdepth=10:Gheight=20
Dim W3d(Gwidth,Gheight,Gdepth)


Procedure RaiseError()
If Start:StartWindowScreen():EndIf
Result=MessageRequester("Error","There was a Error."+Chr(10)+Chr(13)+"Do you want to continue ?",#MB_YESNO|#MB_DEFBUTTON2|#MB_ICONEXCLAMATION)
If Start:StopWindowScreen():EndIf
If Result=#IDNO:End:EndIf
EndProcedure

OnErrorGosub(@RaiseError())

If ReadFile(1,"BlockCreator.Inf")
bkcolor=ReadLong()
Quality=ReadLong()
CloseFile(1)
Else
bkColor=RGB(192,192,255)
EndIf





Procedure Start()
dx8vb=OpenLibrary(1,"dx8vb.dll")
If dx8vb=0:MessageRequester("ERROR","DirectX 8 is needed.",#MB_ICONEXCLAMATION):End:EndIf

If InitKeyboard()=0
RaiseError()
EndIf

If InitMouse()=0
RaiseError()
EndIf

If InitSprite()=0
RaiseError()
EndIf

If InitSprite3D()=0
RaiseError()
EndIf

If ExamineDesktops()=0
RaiseError()
EndIf

Result=OpenScreen(#Width,#Height,16,#title)
If Result=0
Result=OpenScreen(#Width,#Height,32,#title)
EndIf
If Result=0
Result=OpenScreen(#Width,#Height,24,#title)
EndIf
If Result
If StartWindowScreen()
CloseScreen()
Result=0
Else
EndIf
StopWindowScreen()
EndIf

If Result=0
windowed=1
Flags=#PB_Window_ScreenCentered|#PB_Window_BorderLess
Result=OpenWindow(1,0,0,DesktopWidth(0),DesktopHeight(0),Flags,#title)
If Result=0:RaiseError():EndIf
Result=OpenWindowedScreen(WindowID(1),0,0,#Width,#Height,1,0,0)
If Result=0:RaiseError():EndIf
EndIf
If S3DR_CreateZBuffer()=0
RaiseError()
EndIf

Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,10,-2)
S3DR_RotateCamera(1.3,0,0)

S3DR_UseDither(#S3DR_TRUE)
S3DR_UseFog(1,20,50,bkcolor)

S3DR_SetCameraRangeAndFOV(1,50,120)
*D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()
*D3DDev\SetRenderState(23,2)
Sprite3DQuality(1)
S3DR_EndReal3D()
Stop3D()

D3DXMatrixInverse=IsFunction(1,"VB_D3DXMatrixInverse")
If D3DXMatrixInverse=0:RaiseError():EndIf

If CatchSprite(0,?mouse)=0
RaiseError()
EndIf
If CatchSprite(1,?Ground,#PB_Sprite_Texture)=0
RaiseError()
EndIf
If CatchSprite(2,?Ground2,#PB_Sprite_Texture)=0
RaiseError()
EndIf
If CatchSprite(3,?Texture,#PB_Sprite_Texture)=0
RaiseError()
EndIf
TransparentSpriteColor(0,255,0,255)
Start=1
EndProcedure

Procedure StartWin()
;If windowed  ;hide the old mouse
;FlipBuffers()
;Else
;CopyBuffer()
;EndIf
ShowCursor_(-1)
StartWindowScreen()
EndProcedure

Procedure StopWin()
StopWindowScreen()
ShowCursor_(0)
EndProcedure


Procedure SetGround()
StartWin()
OpenWindow(2,0,0, 210, 130,#PB_Window_SystemMenu|#PB_Window_ScreenCentered,"Settings",ScreenID())
CreateGadgetList(WindowID())
StringGadget(1, 40, 40, 60, 18, Str(gwidth+1), #PB_String_Numeric)
TextGadget(10, 10, 40, 30, 20, "width:")
TextGadget(11, 100, 40, 40, 20, "height:")
StringGadget(2, 140, 40, 60, 18, Str(gdepth+1), #PB_String_Numeric)
Frame3DGadget(13, 0, 20, 210, 50, "Ground:")
TextGadget(12, 10, 80, 80, 20, "maximal height:")
StringGadget(3, 90, 80, 60, 18, Str(gheight+1))
ButtonGadget(4, 10, 110, 70, 20, "Apply")
ButtonGadget(5, 130, 110, 70, 20, "Cancel")     
Repeat
event=WindowEvent()

If event=#PB_Event_CloseWindow:CloseWindow(2):StopWin():ProcedureReturn 0:EndIf

If event=#PB_Event_Gadget

Select EventGadgetID()
Case 5
CloseWindow(2):StopWin():ProcedureReturn 0
Case 4
Exit=1
EndSelect

EndIf
Until Exit


Gwidth=Val(GetGadgetText(1))-1
Gheight=Val(GetGadgetText(3))-1
Gdepth=Val(GetGadgetText(2))-1

If Gwidth%2=1 Or Gdepth%2=1
MessageRequester("ERROR","The width and height for the Ground must be odd.",#MB_ICONHAND)
If Gwidth%2=1:Gwidth+1:EndIf
If Gdepth%2=1:Gdepth+1:EndIf
EndIf


Dim W3d(Gwidth,Gheight,Gdepth)

If W3d()=0
Gwidth=10
Gdepth=10
Gheight=20
Dim W3d(Gwidth,Gheight,Gdepth)
RaiseError()
EndIf

CloseWindow(2)
StopWin()
EndProcedure

Procedure ChangeBkColor()
StartWin()
bkcolor=ColorRequester(bkcolor)
StopWin()
Start3D()
S3DR_BeginReal3D()
S3DR_UseFog(1,20,50,bkcolor)
Stop3D()
EndProcedure

Global MouseX
Global MouseY



Procedure DrawScene()
Start3D()
S3DR_BeginReal3D()

S3DR_ClearScreenAndZBuffer(bkcolor)

NW=Gwidth/2
PW=Gwidth-NW

ND=Gdepth/2
PD=Gdepth-ND

S3DR_SelectTexture(1)
For X=-NW To PW
For Z=-ND To PD

If X=PosX And Z=PosZ
S3DR_SelectTexture(2)
S3DR_SetCullMode(#S3DR_NONE)
;S3DR_Draw3D(x-0.5,SetPosY+0.01,z+0.5,x+0.5,SetPosY+0.01,z+0.5,x-0.5,SetPosY+0.01,z-0.5,x+0.5,SetPosY+0.01,z-0.5)        

PX.f=PosX
PY.f=SetPosY+0.5
PZ.f=PosZ

S3DR_Draw3D( 0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D( 0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY,-0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D( 0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ, 0.5+PX,-0.5+PY, 0.5+PZ)


S3DR_SelectTexture(1)
S3DR_SetCullMode(#S3DR_CCW)
Else
S3DR_Draw3D(x-0.5,0,z+0.5,x+0.5,0,z+0.5,x-0.5,0,z-0.5,x+0.5,0,z-0.5)     
EndIf

Next
Next

S3DR_SelectTexture(3)

For X=0 To gwidth
For Y=0 To gheight
For Z=0 To gdepth

If W3D(X,Y,Z)
PX.f=X-gwidth/2
PY.f=Y+0.5
PZ.f=Z-gdepth/2
S3DR_Draw3D( 0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D( 0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY,-0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY, 0.5+PZ,-0.5+PX, 0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY, 0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D(-0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY,-0.5+PZ,-0.5+PX,-0.5+PY,-0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ)
S3DR_Draw3D( 0.5+PX, 0.5+PY,-0.5+PZ, 0.5+PX, 0.5+PY, 0.5+PZ, 0.5+PX,-0.5+PY,-0.5+PZ, 0.5+PX,-0.5+PY, 0.5+PZ)
EndIf

Next
Next
Next  

S3DR_EndReal3D()
Stop3D()
DisplayTransparentSprite(0,MouseX,MouseY)
EndProcedure


Procedure Camera()
StartWin()
OpenWindow(2,0,0,120,170,#PB_Window_SystemMenu|#PB_Window_ScreenCentered,"change Camera",ScreenID())
CreateGadgetList(WindowID())
TextGadget(21,0,10,40,20,"rotate x")
TextGadget(22,0,30,40,20,"rotate y")
TextGadget(23,0,50,40,20,"rotate z")
TextGadget(24,0,80,40,20,"move x")
TextGadget(25,0,100,40,20,"move y")
TextGadget(26,0,120,40,20,"move z")

ButtonGadget(1,40,10,20,18,"<")
ButtonGadget(2,60,10,20,18,">")
ButtonGadget(3,40,30,20,18,"<")
ButtonGadget(4,60,30,20,18,">")
ButtonGadget(5,40,50,20,18,"<")
ButtonGadget(6,60,50,20,18,">")
ButtonGadget(7,40,80,20,18,"<")
ButtonGadget(8,60,80,20,18,">")
ButtonGadget(9,40,100,20,18,"<")
ButtonGadget(10,60,100,20,18,">")
ButtonGadget(11,40,120,20,18,"<")
ButtonGadget(12,60,120,20,18,">")
ButtonGadget(13,10,150,100,20,"Return")
Repeat
event=WindowEvent()

If Event=#PB_Event_Gadget

Select EventGadgetID()
Case 1
S3DR_RotateCamera(0,-0.1,0)
Case 2
S3DR_RotateCamera(0,0.1,0)
Case 3
S3DR_RotateCamera(-0.1,0,0)
Case 4
S3DR_RotateCamera(0.1,0,0)
Case 5
S3DR_RotateCamera(0,0,-0.1)
Case 6
S3DR_RotateCamera(0,0,0.1)

Case 7
S3DR_MoveCamera(-0.5,0,0)
Case 8
S3DR_MoveCamera(0.5,0,0)
Case 9
S3DR_MoveCamera(0,-0.5,0)
Case 10
S3DR_MoveCamera(0,0.5,0)
Case 11
S3DR_MoveCamera(0,0,-0.5)
Case 12
S3DR_MoveCamera(0,0,0.5)
Case 13
Exit=1
EndSelect


DrawScene()
RefreshWindowScreen()
EndIf

Until event=#PB_Event_CloseWindow Or Exit=1
CloseWindow(2)
StopWin()
EndProcedure


Procedure Save()
StartWin()
File$=SaveFileRequester("","Noname.blc","BlockCreator (*.blc)|*.blc",0)
If ReadFile(1,File$)
CloseFile(1)
If MessageRequester("Question","Overwrite file ?",#MB_YESNO|#MB_ICONQUESTION)=#IDNO:StopWin():ProcedureReturn 0:EndIf
EndIf
If CreateFile(1,File$)
WriteLong(gWidth)
WriteLong(gHeight)
WriteLong(gDepth)
Size=(gWidth+1)*(gHeight+1)*(gDepth+1)*4
WriteLong(Size)
WriteData(@W3D(),Size)
CloseFile(1)
EndIf
StopWin()
EndProcedure

Procedure Load()
StartWin()
File$=OpenFileRequester("","Noname.blc","BlockCreator (*.blc)|*.blc",0)
If ReadFile(1,File$)
gWidth=ReadLong()
gHeight=ReadLong()
gDepth=ReadLong()
Size=ReadLong()
Dim W3D(gWidth,gHeight,gDepth)
ReadData(@W3D(),Size)
CloseFile(1)
EndIf
StopWin()
EndProcedure

Procedure Insert()
StartWin()

File$=OpenFileRequester("","Noname.blc","BlockCreator (*.blc)|*.blc",0)

If ReadFile(1,File$)

PlusX=PosX+gWidth/2
PlusZ=PosZ+gdepth/2

TgWidth=ReadLong()
TgHeight=ReadLong()
TgDepth=ReadLong()
Size=ReadLong()
Dim T3D(TgWidth,TgHeight,TgDepth)
ReadData(@T3D(),Size)
CloseFile(1)

For X=0 To TgWidth
For Y=0 To TgHeight
For Z=0 To TgDepth

SX=X+PlusX
SY=Y
SZ=Z+PlusZ

If SX>=0 And SX<=gWidth
If SZ>=0 And SZ<=gDepth
If SY>=0 And SY<=gHeight
W3D(SX,SY,SZ)=T3D(X,Y,Z)
EndIf
EndIf
EndIf

Next
Next
Next
Dim T3D(0,0,0)
EndIf
StopWin()
EndProcedure




Start()


Repeat
ExamineMouse()
ExamineKeyboard()

MouseX=MouseX()
MouseY=MouseY()

*D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()

*D3DDev\GetTransform(#D3DTS_PROJECTION,matProj.D3DXMATRIX)
*D3DDev\GetTransform(#D3DTS_VIEW,matView.D3DXMATRIX)

VecX.f=(((2.0*MouseX)/#Width)-1)/matProj\_11
VecY.f=-(((2.0*MouseY)/#Height)-1)/matProj\_22
VecZ.f=1.0

CallFunctionFast(D3DXMatrixInverse,Inv.D3DXMATRIX,0,matView)

DirX.f=VecX*Inv\_11+VecY*Inv\_21+VecZ*Inv\_31
DirY.f=VecX*Inv\_12+VecY*Inv\_22+VecZ*Inv\_32
DirZ.f=VecX*Inv\_13+VecY*Inv\_23+VecZ*Inv\_33
    
FacY.f=((-Inv\_42+SetPosY)/(DirY))
    
PosX=Inv\_41+(DirX)*FacY
PosY=SetPosY
PosZ=Inv\_43+(DirZ)*FacY

;vPickRayDir.D3DXVECTOR3
;vPickRayOrig.D3DXVECTOR3

;vPickRayDir\x  = v\x*m\_11 + v\y*m\_21 + v\z*m\_31;
;vPickRayDir\y  = v\x*m\_12 + v\y*m\_22 + v\z*m\_32;
;vPickRayDir\z  = v\x*m\_13 + v\y*m\_23 + v\z*m\_33;
;vPickRayOrig\x = m\_41;
;vPickRayOrig\y = m\_42;
;vPickRayOrig\z = m\_43;

        
;facY.f=-vPickRayOrig\y/vPickRaydir\y



;Nx=vPickRayOrig\x+vPickRayDir\x*facY
;Ny=0
;Nz=vPickRayOrig\z+vPickRayDir\z*facY



If KeyboardPushed(#PB_Key_Q) :S3DR_RotateCamera(-0.025,0,0):EndIf
If KeyboardPushed(#PB_Key_A):S3DR_RotateCamera(0.025,0,0):EndIf

If KeyboardPushed(#PB_Key_PageUp) :S3DR_RotateCamera(-0.01,0,0):EndIf
If KeyboardPushed(#PB_Key_PageDown):S3DR_RotateCamera(0.01,0,0):EndIf


If KeyboardPushed(#PB_Key_Left) :S3DR_RotateCamera(0,-0.025,0):EndIf
If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf
If KeyboardPushed(#PB_Key_Up)   :S3DR_MoveCamera(0,0,0.25):EndIf 
If KeyboardPushed(#PB_Key_Down) :S3DR_MoveCamera(0,0,-0.25):EndIf
 
  
  
If KeyboardReleased(#PB_Key_1):SetPosY+1:EndIf 
If KeyboardReleased(#PB_Key_2):SetPosY-1:EndIf
If KeyboardReleased(#PB_Key_Add):SetPosY+1:EndIf 
If KeyboardReleased(#PB_Key_Subtract):SetPosY-1:EndIf
SetPosY+MouseWheel()
If SetPosY<0:SetPosY=0:EndIf  
If SetPosY>gheight-1:SetPosY=gheight-1:EndIf


If KeyboardReleased(#PB_Key_F2):Save():EndIf
If KeyboardReleased(#PB_Key_F3):Load():EndIf

If KeyboardReleased(#PB_Key_F4)
Nr=0
Repeat
result=FileSize("Screenshot"+Str(Nr)+".bmp")
If result=>0
Nr+1
EndIf
Until result<9
GrabSprite(10,0,0,#Width,#Height)
SaveSprite(10,"Screenshot"+Str(Nr)+".bmp")
FreeSprite(10)
Shot=80
EndIf

If KeyboardReleased(#PB_Key_F6):Camera():EndIf
If KeyboardReleased(#PB_Key_F7):SetGround():EndIf
If KeyboardReleased(#PB_Key_F8):ChangeBkColor():EndIf
If KeyboardReleased(#PB_Key_F9):Insert():EndIf

DrawScene()

If MouseButton(1)
SX=PosX+gWidth/2
SY=PosY
SZ=PosZ+gdepth/2


If SX>=0 And SX<=gwidth
If SY>=0 And SY<=gheight
If SZ>=0 And SZ<=gdepth
W3D(SX,SY,SZ)=1
EndIf
EndIf
EndIf

EndIf


If MouseButton(2)
SX=PosX+gWidth/2
SY=PosY
SZ=PosZ+gdepth/2

If SX>=0 And SX<=gwidth
If SY>=0 And SY<=gheight
If SZ>=0 And SZ<=gdepth
W3D(SX,SY,SZ)=0
EndIf
EndIf
EndIf

EndIf


If Shot>0
Shot-1
StartDrawing(ScreenOutput())
DrawingFont(GetStockObject_(#ANSI_VAR_FONT))
DrawingMode(1)
DrawText("Screenshot saved.")
;Locate(750,550)
;DrawText(Str(PosX+gWidth/2)+","+Str(PosZ+gdepth/2))
StopDrawing()
EndIf

FlipBuffers()
If windowed:Event=WindowEvent():EndIf

Until KeyboardPushed(#PB_Key_Escape)



CreateFile(1,"BlockCreator.inf")
WriteLong(BkColor)
WriteLong(Quality)
CloseFile(1)


End


DataSection
Mouse:
IncludeBinary "C:\mouse.bmp"
Ground:
IncludeBinary "C:\Ground.bmp"
Ground2:
IncludeBinary "C:\Ground3.bmp"
Texture:
IncludeBinary "C:\Ground2.bmp"
EndDataSection
; IDE Options = PureBasic v4.00 (Windows - x86)
; FirstLine = 3
; Folding = --
; UseIcon = C:\Dokumente und Einstellungen\Stefan\Eigene Dateien\BCI.ico
; Executable = BlockCreator.exe
; IncludeVersionInfo
; VersionField3 = Sprite3DReal Block Creator
; VersionField4 = 0.1
; VersionField5 = 0.1
; VersionField13 = VOS_NT_WINDOWS32
; VersionField14 = VFT_APP
; VersionField15 = 0407 German (Standard)