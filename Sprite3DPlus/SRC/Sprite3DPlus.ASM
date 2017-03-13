format MS COFF

public PB_S3DP_SetFillMode
public PB_S3DP_UseTransparency
public PB_S3DP_UseDither
public PB_S3DP_SetCullMode
public PB_S3DP_SetViewPort
public PB_S3DP_GetD3DDevice

public PB_S3DR_CreateZBuffer
public PB_S3DR_FreeZBuffer
public PB_S3DR_StartReal3D
public PB_S3DR_StopReal3D
public PB_S3DR_Draw3D
public PB_S3DR_UseTexture
public PB_S3DR_SetTextureCoordinates
public PB_S3DR_ClearScreenAndZBuffer
public PB_S3DR_RotateCamera
public PB_S3DR_MoveCamera
public PB_S3DR_GetCameraX
public PB_S3DR_GetCameraY
public PB_S3DR_GetCameraZ
public PB_S3DR_GetCameraAngleX
public PB_S3DR_GetCameraAngleY
public PB_S3DR_GetCameraAngleZ
public PB_S3DR_UseFog


extrn _PB_DDrawBase
extrn _PB_D3DBase
extrn _PB_Direct3D_Device
extrn _PB_DirectX_BackBuffer

extrn _PB_Sprite_ObjectsArea

extrn _PB_DirectX_ScreenRealWidth
extrn _PB_DirectX_ScreenRealHeight


section '.text' code readable executable


;S3DR_Draw3D(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,X4,Y4,Z4)
PB_S3DR_Draw3D:

MOV Edx,x1
MOV Eax,[Esp+4]
MOV [Edx],Eax   ;X1
MOV Eax,[Esp+8]
MOV [Edx+4],Eax ;Y1
MOV Eax,[Esp+12]
MOV [Edx+8],Eax ;Z1

MOV Eax,[Esp+16] 
MOV [Edx+20],Eax;X2
MOV Eax,[Esp+20]
MOV [Edx+24],Eax;Y2
MOV Eax,[Esp+24]
MOV [Edx+28],Eax;Z2

MOV Eax,[Esp+28]
MOV [Edx+40],Eax;X3
MOV Eax,[Esp+32]
MOV [Edx+44],Eax;Y3
MOV Eax,[Esp+36]
MOV [Edx+48],Eax;Z3

MOV Eax,[Esp+40]
MOV [Edx+60],Eax;X4
MOV Eax,[Esp+44]
MOV [Edx+64],Eax;Y4
MOV Eax,[Esp+48]
MOV [Edx+68],Eax;Z4

Push 0
Push 4
Push Edx
Push 258 ;D3DFVF_XYZ|D3DFVF_TEX1
Push 5   ;D3DPT_TRIANGLESTRIP

Push dword[_PB_Direct3D_Device]
Call dword[Draw3D]
RET 48


;S3DR_SetTextureCoordinates(tv1,tu1,tv2,tu2,tv3,tu3,tv4,tu4)

PB_S3DR_SetTextureCoordinates:
MOV Edx,tv1
MOV Eax,[Esp+4]
MOV [Edx],Eax
MOV Eax,[Esp+8]
MOV [Edx+4],Eax

MOV Eax,[Esp+12]
MOV [Edx+20],Eax
MOV Eax,[Esp+16]
MOV [Edx+24],Eax

MOV Eax,[Esp+20]
MOV [Edx+40],Eax
MOV Eax,[Esp+24]
MOV [Edx+44],Eax

MOV Eax,[Esp+28]
MOV [Edx+60],Eax
MOV Eax,[Esp+32]
MOV [Edx+64],Eax

RET 32


SearchZBuffer:

MOV Eax,[Esp+4]
MOV Eax,[Eax+4]
CMP Eax,1024 ;DDPF_ZBUFFER 

JNZ Next

MOV Eax,[Esp+4]
PUSH EDI
PUSH ESI
PUSH ECX
MOV EDI,PFdwSize
MOV ESI,EAX
MOV ECX,8
CLD
REP MOVSD
POP ECX
POP ESI
POP EDI

MOV Eax,[_PB_DirectX_ScreenRealHeight]
MOV [SurfaceDesc2Height],Eax
MOV Eax,[_PB_DirectX_ScreenRealWidth]
MOV [SurfaceDesc2Width],Eax

Or dword[ddsCaps1],16384 ;DDSCAPS_VIDEOMEMORY 

Push 0
Push ZBuffer
Push SurfaceDesc2
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]

OR Eax,Eax
JNZ Next

Push dword[ZBuffer]
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+12]

OR Eax,Eax
JNZ FreeZBuffer

MOV dword[ZBufferCreated],-1
XOR Eax,Eax
Ret 8

Next:
MOV Eax,1
ret 8
FreeZBuffer:
MOV Eax,[ZBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
MOV Eax,1
Ret 8


PB_S3DR_CreateZBuffer:
MOV Eax,[_PB_Direct3D_Device]
OR Eax,Eax
JZ DeviceNotCreated
XOR Eax,Eax
RET
DeviceNotCreated:

Push 0
Push SearchZBuffer
Push IID_IDirect3DHALDevice
MOV Eax,[_PB_D3DBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]

MOV Eax,[ZBufferCreated]
RET


PB_S3DR_FreeZBuffer:
CMP dword[ZBufferCreated],-1
JNE CantFreeZBuffer
MOV dword[ZBufferCreated],0
MOV dword[FirstCall],0
MOV Eax,[ZBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
XOR Eax,Eax
RET
MOV dword[ZBuffer],0
CantFreeZBuffer:
MOV Eax,-1
RET


PB_S3DR_StartReal3D:

CMP dword[FirstCall],0
JNE NoInit

MOV Eax,[_PB_Direct3D_Device]
MOV Eax,[Eax]
MOV Eax,[Eax+100]
MOV [Draw3D],Eax

MOV Eax,[_PB_Direct3D_Device]
MOV Eax,[Eax]
MOV Eax,[Eax+140]
MOV [UseTexture],Eax

Push P11
Push 3 ;D3DTRANSFORMSTATE_PROJECTION
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44]

NoInit:

Push 1
Push 7 ;ZENABLE
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]

Push 0
Push 137 ;LIGHTING
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]

RET


PB_S3DR_StopReal3D:
Push 0
Push 7 ;ZENABLE
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET



PB_S3DR_ClearScreenAndZBuffer:
BSWAP EAX 
SHR EAX,8 

Push 0
Push 1065353216
Push Eax
Push 3 ;D3DCLEAR_TARGET|D3DCLEAR_ZBUFFER
Push 0
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+40]
RET

PB_S3DR_UseTexture:
LEA Eax,[Eax+Eax*2]
SHL Eax,3

ADD Eax,[_PB_Sprite_ObjectsArea]

Push dword[Eax] 
Push 0
Push dword[_PB_Direct3D_Device]
Call dword[UseTexture]
RET


PB_S3DP_GetD3DDevice:
MOV Eax,[_PB_Direct3D_Device]
RET

PB_S3DP_SetFillMode:
Push Eax
Push 8
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET

PB_S3DP_UseTransparency:
Push Eax
Push 41
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET

PB_S3DP_UseDither:
Push Eax
Push 26
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET

PB_S3DP_SetCullMode:
Push Eax
Push 22
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET

;S3DP_SetViewPort(X,Y,Width,Height)
PB_S3DP_SetViewPort:
MOV [dwX],Eax
MOV Eax,[Esp+4]
MOV [dwY],Eax
MOV Eax,[Esp+8]
MOV [dwWidth],Eax
MOV Eax,[Esp+12]
MOV [dwHeight],Eax
Push dwX
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+52]
RET 12


PB_S3DR_RotateCamera:
_Procedure0:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,12
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,12
_ClearLoop0:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop0                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax

  FLD    dword [Pitch]
  FADD   dword [esp]
  FSTP   dword [Pitch]
  FLD    dword [Yaw]
  FADD   dword [esp+4]
  FSTP   dword [Yaw]
  FLD    dword [Roll]
  FADD   dword [esp+8]
  FSTP   dword [Roll]

FLD dword[Yaw]
FSINCOS
FSTP   dword [CosYaw]
FSTP   dword [SinYaw]

FLD dword[Pitch]
FSINCOS
FSTP   dword [CosPitch]
FSTP   dword [SinPitch]  

FLD dword[Roll]
FSINCOS
FSTP   dword [CosRoll]
FSTP   dword [SinRoll]  

  FLD    dword [CosYaw]
  FMUL   dword [CosRoll]
  FLD    dword [SinYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [SinRoll]
  FADDP  ST1,ST0
  FSTP   dword [RightX]
  FLD    dword [SinRoll]
  FMUL   dword [CosPitch]
  FSTP   dword [RightY]
  FLD    dword [CosYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [SinRoll]
  FLD    dword [SinYaw]
  FMUL   dword [CosRoll]
  FSUBP  ST1,ST0
  FSTP   dword [RightZ]
  FLD    dword [SinYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [CosRoll]
  FLD    dword [CosYaw]
  FMUL   dword [SinRoll]
  FSUBP  ST1,ST0
  FSTP   dword [UpX]
  FLD    dword [CosRoll]
  FMUL   dword [CosPitch]
  FSTP   dword [UpY]
  FLD    dword [SinRoll]
  FMUL   dword [SinYaw]
  FLD    dword [CosRoll]
  FMUL   dword [CosYaw]
  FMUL   dword [SinPitch]
  FADDP  ST1,ST0
  FSTP   dword [UpZ]
  FLD    dword [CosPitch]
  FMUL   dword [SinYaw]
  FSTP   dword [DirX]
  FLD    dword [SinPitch]
  FCHS
  FSTP   dword [DirY]
  FLD    dword [CosPitch]
  FMUL   dword [CosYaw]
  FSTP   dword [DirZ]
  FLD    dword [RightX]
  FSTP   dword [V11]
  FLD    dword [RightY]
  FSTP   dword [V21]
  FLD    dword [RightZ]
  FSTP   dword [V31]
  FLD    dword [PosX]
  FMUL   dword [RightX]
  FLD    dword [PosY]
  FMUL   dword [RightY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [RightZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V41]
  FLD    dword [UpX]
  FSTP   dword [V12]
  FLD    dword [UpY]
  FSTP   dword [V22]
  FLD    dword [UpZ]
  FSTP   dword [V32]
  FLD    dword [PosX]
  FMUL   dword [UpX]
  FLD    dword [PosY]
  FMUL   dword [UpY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [UpZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V42]
  FLD    dword [DirX]
  FSTP   dword [V13]
  FLD    dword [DirY]
  FSTP   dword [V23]
  FLD    dword [DirZ]
  FSTP   dword [V33]
  FLD    dword [PosX]
  FMUL   dword [DirX]
  FLD    dword [PosY]
  FMUL   dword [DirY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [DirZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V43]

Push V11
Push 2 ;D3DTRANSFORMSTATE_VIEW
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44]

ADD    esp,12
POP    edi
POP    esi
POP    ebp
POP    ecx
POP    ebx
RET    12



PB_S3DR_MoveCamera:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,12
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,12
_ClearLoop2:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop2                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
  FLD    dword [PosX]
  FLD    dword [RightX]
  FMUL   dword [esp]
  FADDP  ST1,ST0
  FSTP   dword [PosX]
  FLD    dword [PosY]
  FLD    dword [RightY]
  FMUL   dword [esp]
  FADDP  ST1,ST0
  FSTP   dword [PosY]
  FLD    dword [PosX]
  FLD    dword [RightZ]
  FMUL   dword [esp]
  FADDP  ST1,ST0
  FSTP   dword [PosX]
  FLD    dword [PosX]
  FLD    dword [UpX]
  FMUL   dword [esp+4]
  FADDP  ST1,ST0
  FSTP   dword [PosX]
  FLD    dword [PosY]
  FLD    dword [UpY]
  FMUL   dword [esp+4]
  FADDP  ST1,ST0
  FSTP   dword [PosY]
  FLD    dword [PosZ]
  FLD    dword [UpZ]
  FMUL   dword [esp+4]
  FADDP  ST1,ST0
  FSTP   dword [PosZ]
  FLD    dword [PosX]
  FLD    dword [DirX]
  FMUL   dword [esp+8]
  FADDP  ST1,ST0
  FSTP   dword [PosX]
  FLD    dword [PosY]
  FLD    dword [DirY]
  FMUL   dword [esp+8]
  FADDP  ST1,ST0
  FSTP   dword [PosY]
  FLD    dword [PosZ]
  FLD    dword [DirZ]
  FMUL   dword [esp+8]
  FADDP  ST1,ST0
  FSTP   dword [PosZ]

FLD dword[Yaw]
FSINCOS
FSTP   dword [CosYaw]
FSTP   dword [SinYaw]

FLD dword[Pitch]
FSINCOS
FSTP   dword [CosPitch]
FSTP   dword [SinPitch]  

FLD dword[Roll]
FSINCOS
FSTP   dword [CosRoll]
FSTP   dword [SinRoll]  

  FLD    dword [CosYaw]
  FMUL   dword [CosRoll]
  FLD    dword [SinYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [SinRoll]
  FADDP  ST1,ST0
  FSTP   dword [RightX]
  FLD    dword [SinRoll]
  FMUL   dword [CosPitch]
  FSTP   dword [RightY]
  FLD    dword [CosYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [SinRoll]
  FLD    dword [SinYaw]
  FMUL   dword [CosRoll]
  FSUBP  ST1,ST0
  FSTP   dword [RightZ]
  FLD    dword [SinYaw]
  FMUL   dword [SinPitch]
  FMUL   dword [CosRoll]
  FLD    dword [CosYaw]
  FMUL   dword [SinRoll]
  FSUBP  ST1,ST0
  FSTP   dword [UpX]
  FLD    dword [CosRoll]
  FMUL   dword [CosPitch]
  FSTP   dword [UpY]
  FLD    dword [SinRoll]
  FMUL   dword [SinYaw]
  FLD    dword [CosRoll]
  FMUL   dword [CosYaw]
  FMUL   dword [SinPitch]
  FADDP  ST1,ST0
  FSTP   dword [UpZ]
  FLD    dword [CosPitch]
  FMUL   dword [SinYaw]
  FSTP   dword [DirX]
  FLD    dword [SinPitch]
  FCHS
  FSTP   dword [DirY]
  FLD    dword [CosPitch]
  FMUL   dword [CosYaw]
  FSTP   dword [DirZ]
  FLD    dword [RightX]
  FSTP   dword [V11]
  FLD    dword [RightY]
  FSTP   dword [V21]
  FLD    dword [RightZ]
  FSTP   dword [V31]
  FLD    dword [PosX]
  FMUL   dword [RightX]
  FLD    dword [PosY]
  FMUL   dword [RightY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [RightZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V41]
  FLD    dword [UpX]
  FSTP   dword [V12]
  FLD    dword [UpY]
  FSTP   dword [V22]
  FLD    dword [UpZ]
  FSTP   dword [V32]
  FLD    dword [PosX]
  FMUL   dword [UpX]
  FLD    dword [PosY]
  FMUL   dword [UpY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [UpZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V42]
  FLD    dword [DirX]
  FSTP   dword [V13]
  FLD    dword [DirY]
  FSTP   dword [V23]
  FLD    dword [DirZ]
  FSTP   dword [V33]
  FLD    dword [PosX]
  FMUL   dword [DirX]
  FLD    dword [PosY]
  FMUL   dword [DirY]
  FADDP  ST1,ST0
  FLD    dword [PosZ]
  FMUL   dword [DirZ]
  FADDP  ST1,ST0
  FCHS
  FSTP   dword [V43]
 
Push V11
Push 2 ;D3DTRANSFORMSTATE_VIEW
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44]

  ADD    esp,12
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    12



PB_S3DR_GetCameraX:
FLD dword[PosX]
RET

PB_S3DR_GetCameraY:
FLD dword[PosY]
RET

PB_S3DR_GetCameraZ:
FLD dword[PosZ]
RET


PB_S3DR_GetCameraAngleX:
FLD dword[Pitch]
RET

PB_S3DR_GetCameraAngleY:
FLD dword[Yaw]
RET

PB_S3DR_GetCameraAngleZ:
FLD dword[Roll]
RET

PB_S3DR_UseFog:
OR Eax,Eax
JZ DisableFog

Push 1
Push 28 ;ENABLE FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]

Push 3
Push 35 ;LINEAR FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]


Push dword[Esp+4]
Push 36 ;FOG START
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]

Push dword[Esp+8]
Push 37 ;FOG END
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]


MOV Eax,[Esp+12]
BSWAP Eax
SHR EAX,8 

Push Eax
Push 34 ;FOG COLOR
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]

RET 12
DisableFog:

Push 0
Push 28 ;DISABLE FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET 12

section '.data' readable writeable
x1: 
DD 0
y1: 
DD 0
z1: 
DD 0
tv1:
DD 0
tu1:
DD 0

x2: 
DD 0
y2: 
DD 0
z2: 
DD 0
tv2:
DD 1065353216
tu2:
DD 0

x3: 
DD 0
y3: 
DD 0
z3: 
DD 0
tv3:
DD 0
tu3:
DD 1065353216

x4: 
DD 0
y4: 
DD 0
z4: 
DD 0
tv4:
DD 1065353216
tu4:
DD 1065353216


Draw3D:
DD 0

UseTexture:
DD 0

dwX:
DD 0
dwY:
DD 0
dwWidth:
DD 0
dwHeight:
DD 0
dvMinZ:
DD 0
dvMaxZ:
DD 1065353216 ;1.0


ZBuffer:
DD 0

ZBufferCreated:
DD 0

FirstCall:
DD 0

P11:
DD 1075479159
P12:
DD 0
P13:
DD 0
P14:
DD 0
P21:
DD 0
P22:
DD 1075479159
P23:
DD 0
P24:
DD 0
P31:
DD 0
P32:
DD 0
P33:
DD 1065361613
P34:
DD 1065353216
P41:
DD 0
P42:
DD 0
P43:
DD -1082122035
P44:
DD 0



UpX:
DD 0
UpY:
DD 1065353216
UpZ:
DD 0
DirX:
DD 0
DirY:
DD 0
DirZ:
DD 1065353216
RightX:
DD 1065353216
RightY:
DD 0
RightZ:
DD 0
PosX:
DD 0
PosY:
DD 0
PosZ:
DD 0
Pitch:
DD 0
Yaw:
DD 0
Roll:
DD 0


V11:
DD 0
V12:
DD 0
V13:
DD 0
V14:
DD 0
V21:
DD 0
V22:
DD 0
V23:
DD 0
V24:
DD 0
V31:
DD 0
V32:
DD 0
V33:
DD 0
V34:
DD 0
V41:
DD 0
V42:
DD 0
V43:
DD 0
V44:
DD 1065353216


SinYaw:
DD 0
CosYaw:
DD 0
SinPitch:
DD 0
CosPitch:
DD 0
SinRoll:
DD 0
CosRoll:
DD 0


FNeg:
DD -1082130432 ;-1.0

SurfaceDesc2:
DD 124;dwSize
DD 4103;Flags
SurfaceDesc2Height:
DD 0
SurfaceDesc2Width:
DD 0
lPitch:
DD 0
dwBackBufferCount:
DD 0
dwRefreshRate:
DD 0
dwAlphaBitDepth:
DD 0
_dwReserved:
DD 0
lpSurface:
DD 0
ddckCKDestOverlay1:
DD 0
ddckCKDestOverlay2:
DD 0
ddckCKDestBlt:
DD 0
ddckCKDestBlt2:
DD 0
ddckCKSrcOverlay:
DD 0
ddckCKSrcOverlay2:
DD 0
ddckCKSrcBlt:
DD 0
ddckCKSrcBlt2:
DD 0
PFdwSize:
DD 32
PFdwFlags:
DD 0
PFdwFourCC:
DD 0
PFdwRGBBitCount:
DD 0
PFdwRBitMask:
DD 0
PFdwGBitMask:
DD 0
PFdwBBitMask:
DD 0
PFdwRGBAlphaBitMask:
DD 0
ddsCaps1:
DD 131072
ddsCaps2:
DD 0
ddsCaps3:
DD 0
ddsCaps4:
DD 0
dwTextureStage:
DD 0


IID_IDirect3DHALDevice:
DD -2065285664
DW 18090,4559
DB -127,111,0,0,-64,32,21,110
