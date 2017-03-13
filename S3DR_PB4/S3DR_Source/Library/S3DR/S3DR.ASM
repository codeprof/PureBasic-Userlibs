format MS COFF

public PB_S3DR_SetCameraAngles
public PB_S3DR_SetCameraPos
public PB_S3DR_CreateZBuffer
public PB_S3DR_CreateZBuffer2
public PB_S3DR_FreeZBuffer
public PB_S3DR_FreeS3DR
public PB_S3DR_BeginReal3D
public PB_S3DR_EndReal3D
public PB_S3DR_Draw3D
public PB_S3DR_SelectTexture
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
public PB_S3DR_SetFillMode
public PB_S3DR_UseTransparency
public PB_S3DR_UseDither
public PB_S3DR_SetCullMode
public PB_S3DR_SetViewPort
public PB_S3DR_GetD3DDevice
public PB_S3DR_GetZBuffer
public PB_S3DR_DrawBillboard
public PB_S3DR_SetDiffuseColors
public PB_S3DR_SetCameraRangeAndFOV

;public Draw3DUseDiffuse
;public SinYaw
;public CosYaw
;pubilc SinPitch
;pubilc CosPitch
;public SinRoll
;public CosRoll


extrn _PB_DDrawBase
extrn _PB_D3DBase
extrn _PB_Sprite3D_Quality
extrn _PB_Direct3D_Device
extrn _PB_DirectX_BackBuffer


extrn _PB_Screen_RealWidth
extrn _PB_Screen_RealHeight

_PB_DirectX_ScreenRealWidth equ _PB_Screen_RealWidth
_PB_DirectX_ScreenRealHeight equ _PB_Screen_RealHeight


extrn _GetCurrentProcess@0
extrn _WriteProcessMemory@20
extrn _PB_SpriteID@4



macro align8 { rb 7-($-CodeSegment+7)mod 8}


section '.text' code readable executable
CodeSegment:

align8
PB_S3DR_SetCameraAngles:

FLD dword[Yaw]
FLD dword[esp+4]
FSUB ST0,ST1
FSTP dword[esp+4]

FLD dword[Pitch]
FLD dword[esp+8]
FSUB ST0,ST1
FSTP dword[esp+8]

FLD dword[Roll]
FLD dword[esp+12]
FSUB ST0,ST1
FSTP dword[esp+12]

JMP PB_S3DR_RotateCamera



align8
PB_S3DR_SetCameraPos:
FLD dword[PosX]
FLD dword[esp+4]
FSUB ST0,ST1
FSTP dword[esp+4]

FLD dword[PosY]
FLD dword[esp+8]
FSUB ST0,ST1
FSTP dword[esp+8]

FLD dword[PosZ]
FLD dword[esp+12]
FSUB ST0,ST1
FSTP dword[esp+12]

JMP PB_S3DR_MoveCamera







align8
;S3DR_Draw3D(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3,X4,Y4,Z4)
PB_S3DR_Draw3D:

CMP dword[Draw3DUseDiffuse],0
JNZ UseDiffuseColor

MOV Edx,_x1
FSTP dword[Edx]

MOV Eax,[Esp+4]
MOV [Edx+4],Eax ;Y1
MOV Eax,[Esp+8]
MOV [Edx+8],Eax ;Z1


MOV Eax,[Esp+12] 
MOV [Edx+20],Eax;X2
MOV Eax,[Esp+16]
MOV [Edx+24],Eax;Y2
MOV Eax,[Esp+20]
MOV [Edx+28],Eax;Z2

MOV Eax,[Esp+24]
MOV [Edx+40],Eax;X3
MOV Eax,[Esp+28]
MOV [Edx+44],Eax;Y3
MOV Eax,[Esp+32]
MOV [Edx+48],Eax;Z3

MOV Eax,[Esp+36]
MOV [Edx+60],Eax;X4
MOV Eax,[Esp+40]
MOV [Edx+64],Eax;Y4
MOV Eax,[Esp+44]
MOV [Edx+68],Eax;Z4

Push 0
Push 4
Push Edx
Push 258 ;D3DFVF_XYZ|D3DFVF_TEX1
Push 5   ;D3DPT_TRIANGLESTRIP

Push dword[_PB_Direct3D_Device]
Call dword[Draw3D]
RET 44


UseDiffuseColor:
MOV Edx,x1
FSTP dword[Edx]

MOV Eax,[Esp+4]
MOV [Edx+4],Eax ;Y1
MOV Eax,[Esp+8]
MOV [Edx+8],Eax ;Z1


MOV Eax,[Esp+12] 
MOV [Edx+24],Eax;X2
MOV Eax,[Esp+16]
MOV [Edx+28],Eax;Y2
MOV Eax,[Esp+20]
MOV [Edx+32],Eax;Z2

MOV Eax,[Esp+24]
MOV [Edx+48],Eax;X3
MOV Eax,[Esp+28]
MOV [Edx+52],Eax;Y3
MOV Eax,[Esp+32]
MOV [Edx+56],Eax;Z3

MOV Eax,[Esp+36]
MOV [Edx+72],Eax;X4
MOV Eax,[Esp+40]
MOV [Edx+76],Eax;Y4
MOV Eax,[Esp+44]
MOV [Edx+80],Eax;Z4

Push 0
Push 4
Push Edx
Push 258+64 ;D3DFVF_XYZ|D3DFVF_TEX1    +DIFFUSE
Push 5   ;D3DPT_TRIANGLESTRIP

Push dword[_PB_Direct3D_Device]
Call dword[Draw3D]
RET 44




align8
;(Color1,Color2,Color3,Color4)
PB_S3DR_SetDiffuseColors:  

CMP EAX,16777215 ;White
JNZ DiffuseEnable
CMP dword[Esp+4],16777215 ;White
JNZ DiffuseEnable
CMP dword[Esp+8],16777215 ;White
JNZ DiffuseEnable
CMP dword[Esp+12],16777215 ;White
JNZ DiffuseEnable

;Disable Diffuse:
CMP dword[Draw3DUseDiffuse],0
JNZ DiffuseDisable
RET 12 ; already disabled

DiffuseDisable:
MOV dword[Draw3DUseDiffuse],0

;MOV Eax,16777215  ;is already white
MOV [Color1],EAX
MOV [Color2],EAX
MOV [Color3],EAX
MOV [Color4],EAX

MOV Eax,[tu1]
MOV [_tu1],Eax
MOV Eax,[tu2]
MOV [_tu2],Eax
MOV Eax,[tu3]
MOV [_tu3],Eax
MOV Eax,[tu4]
MOV [_tu4],Eax

MOV Eax,[tv1]
MOV [_tv1],Eax
MOV Eax,[tv2]
MOV [_tv2],Eax
MOV Eax,[tv3]
MOV [_tv3],Eax
MOV Eax,[tu4]
MOV [_tv4],Eax

RET 12


DiffuseEnable:

CMP dword[Draw3DUseDiffuse],0
JNZ DiffuseAlreadyEnabled

;EnableDiffuse
MOV dword[Draw3DUseDiffuse],1

MOV Edx,Eax

MOV Eax,[_tu1]
MOV [tu1],Eax
MOV Eax,[_tu2]
MOV [tu2],Eax
MOV Eax,[_tu3]
MOV [tu3],Eax
MOV Eax,[_tu4]
MOV [tu4],Eax

MOV Eax,[_tv1]
MOV [tv1],Eax
MOV Eax,[_tv2]
MOV [tv2],Eax
MOV Eax,[_tv3]
MOV [tv3],Eax
MOV Eax,[_tu4]
MOV [tv4],Eax

MOV Eax,Edx

DiffuseAlreadyEnabled:
BSWAP EAX 
SHR EAX,8
MOV [Color1],EAX
MOV Eax,[Esp+4]
BSWAP EAX 
SHR EAX,8
MOV [Color2],EAX
MOV Eax,[Esp+8]
BSWAP EAX 
SHR EAX,8
MOV [Color3],EAX
MOV Eax,[Esp+12]
BSWAP EAX 
SHR EAX,8
MOV [Color4],EAX
RET 12






align8
;S3DR_SetTextureCoordinates(tv1,tu1,tv2,tu2,tv3,tu3,tv4,tu4)
PB_S3DR_SetTextureCoordinates:

CMP dword[Draw3DUseDiffuse],0
JNZ CoordsWithDiffuse

MOV Edx,_tv1
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

CoordsWithDiffuse:
MOV Edx,tv1
MOV Eax,[Esp+4]
MOV [Edx],Eax
MOV Eax,[Esp+8]
MOV [Edx+4],Eax

MOV Eax,[Esp+12]
MOV [Edx+24],Eax
MOV Eax,[Esp+16]
MOV [Edx+28],Eax

MOV Eax,[Esp+20]
MOV [Edx+48],Eax
MOV Eax,[Esp+24]
MOV [Edx+52],Eax

MOV Eax,[Esp+28]
MOV [Edx+72],Eax
MOV Eax,[Esp+32]
MOV [Edx+76],Eax
RET 32





align8
SearchZBuffer:
MOV Eax,[Esp+4]
MOV Eax,[Eax+4]
CMP Eax,1024 ;DDPF_ZBUFFER 

JNZ Next

MOV EAX,[ESP+4]
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

MOV dword[ddsCaps1],147456 ;DDSCAPS_VIDEOMEMORY 

CMP dword[Device_Type],0
JZ UseVideoZBuffer
MOV dword[ddsCaps1],133120  ; SOFTWARE ZBUFFER
UseVideoZBuffer:




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



align8
PB_INTS3DR_CreateTnLOrHALDevice:
Push dword[Esp+16]
Push dword[_PB_DirectX_BackBuffer]
Push IID_IDirect3DTnLHalDevice
Push dword[_PB_D3DBase]
CALL dword[OldCreateDeviceProc]
PUSH EAX
OR EAX,EAX
JZ HardwareDeviceOk
POP EAX
Push dword[Esp+16]
Push dword[_PB_DirectX_BackBuffer]
Push IID_IDirect3DHALDevice
Push dword[_PB_D3DBase]
CALL dword[OldCreateDeviceProc]
PUSH EAX
HardwareDeviceOk:
MOV EAX,[_PB_D3DBase]
MOV EAX,[EAX]
ADD EAX,16 ;CreateDevice()
PUSH 0
PUSH 4
PUSH dword OldCreateDeviceProc
PUSH EAX
CALL _GetCurrentProcess@0
PUSH EAX
CALL _WriteProcessMemory@20
POP EAX
RET 16

align8
PB_INTS3DR_CreateRGBDevice:
Push dword[Esp+16]
Push dword[_PB_DirectX_BackBuffer]
Push IID_IDirect3DRGBDevice
Push dword[_PB_D3DBase]
CALL dword[OldCreateDeviceProc]
PUSH EAX
MOV EAX,[_PB_D3DBase]
MOV EAX,[EAX]
ADD EAX,16 ;CreateDevice()

PUSH 0
PUSH 4
PUSH dword OldCreateDeviceProc
PUSH EAX
CALL _GetCurrentProcess@0
PUSH EAX
CALL _WriteProcessMemory@20
POP EAX
RET 16


align8
PB_S3DR_CreateZBuffer:
XOR Eax,Eax
JMP PB_S3DR_CreateZBuffer2



align8
PB_S3DR_CreateZBuffer2:

CMP EAX,0
JNZ CreateSoftwareDevice

MOV EAX,[_PB_D3DBase]
MOV EAX,[EAX]
ADD EAX,16 ;CreateDevice()
MOV EDX,EAX
MOV EDX,[EDX]
MOV [OldCreateDeviceProc],EDX
MOV EDX,PB_INTS3DR_CreateTnLOrHALDevice
MOV dword[DeviceProc],EDX

PUSH 0
PUSH 4
PUSH DeviceProc
PUSH EAX
CALL _GetCurrentProcess@0
PUSH EAX
CALL _WriteProcessMemory@20
MOV dword[Device_Type],0
JMP OverCreateSoftwareDevice



CreateSoftwareDevice:
MOV EAX,[_PB_D3DBase]
MOV EAX,[EAX]
ADD EAX,16 ;CreateDevice()
MOV EDX,EAX
MOV EDX,[EDX]
MOV [OldCreateDeviceProc],EDX

MOV EDX,PB_INTS3DR_CreateRGBDevice
MOV dword[DeviceProc],EDX

PUSH 0
PUSH 4
PUSH DeviceProc
PUSH EAX
CALL _GetCurrentProcess@0
PUSH EAX
CALL _WriteProcessMemory@20
MOV dword[Device_Type],1

OverCreateSoftwareDevice:



CMP dword[ZBufferCreated],0
JZ CreateZBuffer2
XOR Eax,Eax
RET
CreateZBuffer2:

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







align8
PB_S3DR_FreeZBuffer:
PB_S3DR_FreeS3DR:
CMP dword[ZBufferCreated],-1
JNE CantFreeZBuffer
MOV dword[ZBufferCreated],0
MOV dword[FirstCall],0
MOV Eax,[ZBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
XOR Eax,Eax
MOV dword[ZBuffer],Eax
RET
CantFreeZBuffer:
MOV Eax,-1
RET












align8
PB_S3DR_BeginReal3D:

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
OR Eax,Eax
JZ ProjOk
RET
ProjOk:

NoInit:

Push 1
Push 7 ;ZENABLE
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ ZENABLEOK
RET
ZENABLEOK:

Push 0
Push 137 ;LIGHTING
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ DISLIGHTOK
RET
DISLIGHTOK:

CMP dword[_PB_Sprite3D_Quality],0
JZ NoTextureFilter
Push 2
Push 17
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+148]
OR Eax,Eax
JZ FilterOk
RET
FilterOk:

Push 1
Push 18
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+148]
OR Eax,Eax
JZ FilterOk2
RET
FilterOk2:
NoTextureFilter:


MOV Eax,[ZBufferCreated]
NOT Eax

RET













align8

PB_S3DR_EndReal3D:
Push 0
Push 7 ;ZENABLE
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ DisZBufferOk
RET
DisZBufferOk:

Push 1
Push 137 ;LIGHTING
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET




align8
PB_S3DR_ClearScreenAndZBuffer:
BSWAP EAX 
SHR EAX,8 

CMP dword[ZBufferCreated],0
JZ DontClearZBuffer

Push 0
Push 1065353216 ;1.0
Push Eax
Push 3 ;D3DCLEAR_TARGET|D3DCLEAR_ZBUFFER
Push 0
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+40]
RET

DontClearZBuffer:
Push 0
Push 0          ;0.0
Push Eax
Push 1 ;D3DCLEAR_TARGET
Push 0
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+40]
RET



align8
PB_S3DR_SelectTexture:
PUSH EAX
CALL _PB_SpriteID@4

Push Eax 
Push 0
Push dword[_PB_Direct3D_Device]
Call dword[UseTexture]
RET





align8
PB_S3DR_RotateCamera:
FLD    dword [Pitch]
FADD   dword [esp+4]
FSTP   dword [Pitch]
FLD    dword [Yaw]
FADD   dword [esp+8]
FSTP   dword [Yaw]
FLD    dword [Roll]
FADD   dword [esp+12]
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
RET    12




align8
PB_S3DR_MoveCamera:                                                                                                                 
FLD    dword [PosX]
FLD    dword [RightX]
FMUL   dword [esp+4]
FADDP  ST1,ST0
FSTP   dword [PosX]
FLD    dword [PosY]
FLD    dword [RightY]
FMUL   dword [esp+4]
FADDP  ST1,ST0
FSTP   dword [PosY]
FLD    dword [PosX]
FLD    dword [RightZ]
FMUL   dword [esp+4]
FADDP  ST1,ST0
FSTP   dword [PosX]
FLD    dword [PosX]
FLD    dword [UpX]
FMUL   dword [esp+8]
FADDP  ST1,ST0
FSTP   dword [PosX]
FLD    dword [PosY]
FLD    dword [UpY]
FMUL   dword [esp+8]
FADDP  ST1,ST0
FSTP   dword [PosY]
FLD    dword [PosZ]
FLD    dword [UpZ]
FMUL   dword [esp+8]
FADDP  ST1,ST0
FSTP   dword [PosZ]
FLD    dword [PosX]
FLD    dword [DirX]
FMUL   dword [esp+12]
FADDP  ST1,ST0
FSTP   dword [PosX]
FLD    dword [PosY]
FLD    dword [DirY]
FMUL   dword [esp+12]
FADDP  ST1,ST0
FSTP   dword [PosY]
FLD    dword [PosZ]
FLD    dword [DirZ]
FMUL   dword [esp+12]
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
RET 12











align8
PB_S3DR_GetZBuffer:
MOV Eax,[ZBuffer]
RET



align8
PB_S3DR_GetD3DDevice:
MOV Eax,[_PB_Direct3D_Device]
RET




align8
PB_S3DR_SetFillMode:
Push Eax
Push 8
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET



align8
PB_S3DR_UseTransparency:
Push Eax
Push 41
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET




align8
PB_S3DR_UseDither:
Push Eax
Push 26
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET




align8
PB_S3DR_SetCullMode:
Push Eax
Push 22
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET







align8
;S3DR_SetViewPort(X,Y,Width,Height)
PB_S3DR_SetViewPort:
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




align8
PB_S3DR_GetCameraX:
FLD dword[PosX]
RET



align8
PB_S3DR_GetCameraY:
FLD dword[PosY]
RET



align8
PB_S3DR_GetCameraZ:
FLD dword[PosZ]
RET



align8
PB_S3DR_GetCameraAngleX:
FLD dword[Pitch]
RET



align8
PB_S3DR_GetCameraAngleY:
FLD dword[Yaw]
RET




align8
PB_S3DR_GetCameraAngleZ:
FLD dword[Roll]
RET



align8
PB_S3DR_UseFog:
OR Eax,Eax
JZ DisableFog

Push 1
Push 28 ;ENABLE FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ FogEnableOk
RET 12
FogEnableOk:

Push 3
Push 35 ;LINEAR FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ LinearFogOk
RET 12
LinearFogOk:

Push dword[Esp+4]
Push 36 ;FOG START
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ FogStartOk
RET 12
FogStartOk:

Push dword[Esp+8]
Push 37 ;FOG END
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ FogEndOk
RET 12
FogEndOk:

MOV Eax,[Esp+12]
BSWAP Eax
SHR EAX,8 

Push Eax
Push 34 ;FOG COLOR
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
OR Eax,Eax
JZ FogColorOk
RET 12
FogColorOk:

RET 12
DisableFog:

Push 0
Push 28 ;DISABLE FOG
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+80]
RET 12








align8
;(X,Y,Z,Width,Height)
PB_S3DR_DrawBillboard:

FLD dword[esp+16]
FMUL dword[BB_ZERO_POINT_FIVE]
FST dword[BBWidthP]
FCHS 
FSTP dword[BBWidthN]

FLD dword[esp+20]
FMUL dword[BB_ZERO_POINT_FIVE]
FST dword[BBHeightP]
FCHS 
FSTP dword[BBHeightN]


MOV Eax,[Esp+4]
MOV [BM41],Eax
MOV Eax,[Esp+8]
MOV [BM42],Eax
MOV Eax,[Esp+12]
MOV [BM43],Eax

FLD dword[Yaw];RX-Matrix
FSINCOS
FST    dword [RX33];COS
FSTP   dword [RX11];COS
FST    dword [RX31];SIN
FCHS
FSTP   dword [RX13];-SIN

FLD dword[Pitch];RY-MATRIX
FSINCOS
FST    dword [RY22];COS
FSTP   dword [RY33];COS
FST    dword [RY23];SIN
FCHS
FSTP   dword [RY32];-SIN

FLD dword[Roll];RZ-MATRIX
FSINCOS
FST    dword [RZ11];COS
FSTP   dword [RZ22];COS
FST    dword [RZ12];SIN
FCHS
FSTP   dword [RZ21];-SIN

Push BM11
Push 1
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44];SetTransform
OR Eax,Eax
JNZ MatrixFail

Push RX11
Push 1
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+56];MultiplyTransform
OR Eax,Eax
JNZ MatrixFail

Push RY11
Push 1
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+56];MultiplyTransform
OR Eax,Eax
JNZ MatrixFail

Push RZ11
Push 1
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+56];MultiplyTransform
OR Eax,Eax
JNZ MatrixFail

;                  X Y Z X Y Z  X  Y Z X  Y Z
;     S3DR_Draw3D(-1,1,0,1,1,0,-1,-1,0,1,-1,0)

Push 0
Push dword[BBHeightN]
Push dword[BBWidthP]
Push 0
Push dword[BBHeightN]
Push dword[BBWidthN]
Push 0
Push dword[BBHeightP]
Push dword[BBWidthP]
Push 0
Push dword[BBHeightP]
FLD dword[BBWidthN]
Call PB_S3DR_Draw3D
OR Eax,Eax
JNZ MatrixFail

;MOV Eax,[BBWidthN]
;MOV [x1],Eax
;MOV [x3],Eax
;MOV Eax,[BBWidthP]
;MOV [x2],Eax
;MOV [x4],Eax

;MOV Eax,[BBHeightP]
;MOV [y1],Eax
;MOV [y2],Eax
;MOV Eax,[BBHeightN]
;MOV [y3],Eax
;MOV [y4],Eax

;XOR Eax,Eax
;MOV [z1],Eax
;MOV [z2],Eax
;MOV [z3],Eax
;MOV [z4],Eax

;Push 0
;Push 4
;Push Edx
;Push 258 ;D3DFVF_XYZ|D3DFVF_TEX1
;Push 5   ;D3DPT_TRIANGLESTRIP

;Push dword[_PB_Direct3D_Device]
;Call dword[Draw3D]
;OR Eax,Eax
;JNZ MatrixFail

Push SBM11
Push 1
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44];SetTransform
MatrixFail:
RET 20





align8
PB_S3DR_SetCameraRangeAndFOV:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,20
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,20
__ClearLoop0:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   __ClearLoop0                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
; fov.f=Angle*0.017453  
  FLD    dword [esp+8]
  MOV    dword [esp-4],1016002968
  FMUL   dword [esp-4]
  FSTP   dword [esp+12]
; h.f =(2*Cos(fov/2)/Sin(fov/2))/zn  
  FLD    dword [esp+12]
  MOV    dword [esp-4],1073741824
  FDIV   dword [esp-4]
  FCOS
  MOV    dword [esp-4],1073741824
  FMUL   dword [esp-4]
  FLD    dword [esp+12]
  MOV    dword [esp-4],1073741824
  FDIV   dword [esp-4]
  FSIN
  FDIVP  ST1,ST0
  FDIV   dword [esp]
  FSTP   dword [esp+16]
; matProj\_11=h
  FLD    dword [esp+16]
  LEA    ebp,[P11]
  FSTP   dword [ebp]
; matProj\_22=h
  FLD    dword [esp+16]
  FSTP   dword [ebp+20]
; matProj\_33=zf/(zf-zn)
  FLD    dword [esp+4]
  FLD    dword [esp+4]
  FSUB   dword [esp]
  FDIVP  ST1,ST0
  FSTP   dword [ebp+40]
; matProj\_34=1.0 
  MOV    dword [ebp+44],1065353216
; matProj\_43=-zn*zf/(zf-zn) 
  FLD    dword [esp]
  FCHS
  FMUL   dword [esp+4]
  FLD    dword [esp+4]
  FSUB   dword [esp]
  FDIVP  ST1,ST0
  FSTP   dword [ebp+56]
; *Dev\SetTransform(3,@matProj) 
  PUSH   dword P11
  PUSH   dword 3
  MOV    eax,dword [_PB_Direct3D_Device]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+44]
  ADD    esp,20
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    12











































































section '.data' readable writeable


x1: 
DD 0
y1: 
DD 0
z1: 
DD 0
Color1:
DD 16777215
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
Color2:
DD 16777215
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
Color3:
DD 16777215
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
Color4:
DD 16777215
tv4:
DD 1065353216
tu4:
DD 1065353216



_x1: 
DD 0
_y1: 
DD 0
_z1: 
DD 0
_tv1:
DD 0
_tu1:
DD 0

_x2: 
DD 0
_y2: 
DD 0
_z2: 
DD 0
_tv2:
DD 1065353216
_tu2:
DD 0

_x3: 
DD 0
_y3: 
DD 0
_z3: 
DD 0
_tv3:
DD 0
_tu3:
DD 1065353216

_x4: 
DD 0
_y4: 
DD 0
_z4: 
DD 0
_tv4:
DD 1065353216
_tu4:
DD 1065353216


Draw3D:
DD 0

Draw3DUseDiffuse:
DD 0

UseTexture:
DD 0

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






;---------------------- Billboard -------------------------------
;----------------------------------------------------------------

BBWidthP:
DD 0
BBWidthN:
DD 0
BBHeightP:
DD 0
BBHeightN:
DD 0
BB_ZERO_POINT_FIVE:
DD 1056964608 ;0.5


SBM11:
DD 1065353216
SBM12:
DD 0
SBM13:
DD 0
SBM14:
DD 0
SBM21:
DD 0
SBM22:
DD 1065353216
SBM23:
DD 0
SBM24:
DD 0
SBM31:
DD 0
SBM32:
DD 0
SBM33:
DD 1065353216
SBM34:
DD 0
SBM41:
DD 0
SBM42:
DD 0
SBM43:
DD 0
SBM44:
DD 1065353216

BM11:
DD 1065353216
BM12:
DD 0
BM13:
DD 0
BM14:
DD 0
BM21:
DD 0
BM22:
DD 1065353216
BM23:
DD 0
BM24:
DD 0
BM31:
DD 0
BM32:
DD 0
BM33:
DD 1065353216
BM34:
DD 0
BM41:
DD 0
BM42:
DD 0
BM43:
DD 0
BM44:
DD 1065353216

RX11:
DD 0
RX12:
DD 0
RX13:
DD 0
RX14:
DD 0
RX21:
DD 0
RX22:
DD 1065353216
RX23:
DD 0
RX24:
DD 0
RX31:
DD 0
RX32:
DD 0
RX33:
DD 0
RX34:
DD 0
RX41:
DD 0
RX42:
DD 0
RX43:
DD 0
RX44:
DD 1065353216

RY11:
DD 1065353216
RY12:
DD 0
RY13:
DD 0
RY14:
DD 0
RY21:
DD 0
RY22:
DD 0
RY23:
DD 0
RY24:
DD 0
RY31:
DD 0
RY32:
DD 0
RY33:
DD 0
RY34:
DD 0
RY41:
DD 0
RY42:
DD 0
RY43:
DD 0
RY44:
DD 1065353216

RZ11:
DD 0
RZ12:
DD 0
RZ13:
DD 0
RZ14:
DD 0
RZ21:
DD 0
RZ22:
DD 0
RZ23:
DD 0
RZ24:
DD 0
RZ31:
DD 0
RZ32:
DD 0
RZ33:
DD 1065353216
RZ34:
DD 0
RZ41:
DD 0
RZ42:
DD 0
RZ43:
DD 0
RZ44:
DD 1065353216

;----------------------------------------------------------------
;----------------------------------------------------------------

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
DD 147456  ;131072
ddsCaps2:
DD 0
ddsCaps3:
DD 0
ddsCaps4:
DD 0
dwTextureStage:
DD 0



OldCreateDeviceProc:
DD 0

Device_Type:
DD 0

DeviceProc:
DD 0

IID_IDirect3DHALDevice:
DD -2065285664
DW 18090,4559
DB -127,111,0,0,-64,32,21,110

IID_IDirect3DRGBDevice:
DD -1536795552
DW 9843,4559
DB 163,26,0,170,0,185,51,86


IID_IDirect3DTnLHalDevice:
DD -184246664
DW 18529,4562
DB 164,7,0,160,201,6,41,168
