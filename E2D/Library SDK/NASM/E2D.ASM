format MS COFF


public PB_InitPointFast
public PB_FreePointFast
public PB_PointFast
public PB_GadgetOutput
public PB_DesktopOutput
public PB_CurrentBufferOutput

extrn _PB_DirectX_PixelFormat
extrn _PB_2DDrawing_DrawingInfo
extrn _PB_2DDrawing_CurrentDC 
extrn _GlobalAlloc@8
extrn _GlobalFree@4
extrn _PB_Point@8

extrn _GetDC@4
extrn _GetWindowDC@4
extrn _ReleaseDC@8
extrn PB_GadgetID

extrn _PB_ScreenOutput@0
extrn _PB_Sprite_CurrentBitmap
extrn _PB_DirectX_BackBuffer


macro align8 {rb 7-($-CodeSegment+7)mod 8}

section '.text' code readable executable
CodeSegment:


PB_InitPointFast:
Push Ecx
Push Ebx
Push Edi

Push 262140+4
Push 64
Call _GlobalAlloc@8
MOV [Table565],Eax

Push 262140+4
Push 64
Call _GlobalAlloc@8
MOV [Table555],Eax

MOV Ecx,65535
CreateTable565:

MOV Eax,Ecx
AND Eax,11111b
SHL Eax,3
MOV Edx,Eax
SHR Edx,5
OR Eax,Edx

MOV Edx,Ecx
SHR Edx,5
AND Edx,111111b
SHL Edx,2
MOV Ebx,Edx
SHR Ebx,6
OR Edx,Ebx
SHL Edx,8
OR Eax,Edx

MOV Edx,Ecx
SHR Edx,11
AND Edx,11111b
SHL Edx,3
MOV Ebx,Edx
SHR Ebx,5
OR Edx,Ebx
SHL Edx,16
OR Eax,Edx

BSWAP Eax 
SHR Eax,8 

MOV Edi,Ecx
SHL Edi,2
ADD Edi,[Table565]

MOV [Edi],Eax

DEC Ecx
JNZ CreateTable565


MOV Ecx,65535
CreateTable555:

MOV Eax,[Esp]
AND Eax,11111b
SHL Eax,3
MOV Edx,Eax
SHR Edx,5
OR Eax,Edx

MOV Edx,[Esp]
SHR Edx,5
AND Edx,11111b
SHL Edx,3
MOV Ebx,Edx
SHR Ebx,5
OR Edx,Ebx
SHL Edx,8
OR Eax,Edx

MOV Edx,[Esp]
SHR Edx,11
AND Edx,11111b
SHL Edx,3
MOV Ebx,Edx
SHR Ebx,5
OR Edx,Ebx
SHL Edx,16
OR Eax,Edx

BSWAP Eax 
SHR Eax,8 

MOV Edi,Ecx
SHL Edi,2
ADD Edi,[Table555]
MOV [Edi],Eax

DEC Ecx
JNZ CreateTable555

Pop Edi
Pop Ebx
Pop Ecx
RET

align8
PB_FreePointFast:
Push dword[Table565]
Call _GlobalFree@4
Push dword[Table555]
Call _GlobalFree@4
RET


align8
PB_PointFast:

MOV Edx,dword[_PB_DirectX_PixelFormat]
CMP EDX,2 
JL UseGetPixel ;8-Bit oder kein direkter speicherzugriff möglich

CMP EDX,3 ;#PB_PixelFormat_16Bits 
JNE TryBGR32

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
SHL Eax,1
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
AND Eax,65535

SHL Eax,2
ADD Eax,[Table565]
MOV Eax,[Eax]

RET 4


TryBGR32:
CMP EDX,7 ;#PB_PixelFormat_32Bits_BGR
JNE TryRGB15

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
SHL Eax,2
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
BSWAP Eax 
SHR Eax,8 

RET 4



align8
TryRGB15:
CMP EDX,2 ;#PB_PixelFormat_15Bits 
JNE TryRGB32

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
SHL Eax,1
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
AND Eax,32767 ;???

SHL Eax,2
ADD Eax,[Table555]

MOV Eax,[Eax]
RET 4



align8
TryRGB32:
CMP EDX,6  ;#PB_PixelFormat_32Bits_RGB  
JNE TryBGR24

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
SHL Eax,2
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
RET 4


align8
TryBGR24:
CMP EDX,5  ;#PB_PixelFormat_24Bits_BGR 
JNE TryRGB24

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
LEA Eax,[Eax*2+Eax]
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
BSWAP Eax 
SHR Eax,8

AND Eax,16777215
RET 4



align8
TryRGB24:
CMP EDX,4  ;#PB_PixelFormat_24Bits_RGB 
JNE UseGetPixel

MOV Edx,[Esp+4]
IMUL Edx,[_PB_2DDrawing_DrawingInfo+20];Pitch
LEA Eax,[Eax*2+Eax]
ADD Edx,Eax
ADD Edx,[_PB_2DDrawing_DrawingInfo+16];Addr

MOV Eax,[Edx]
AND Eax,16777215
RET 4

align8
UseGetPixel:
Push dword[Esp+4]
Push Eax
;Push dword[_PB_2DDrawing_CurrentDC]
Call _PB_Point@8
RET 4

align8
PB_GadgetOutput:
Call PB_GadgetID
MOV [GWindow],Eax
Push Eax
Call _GetWindowDC@4
MOV [GDC],Eax
MOV Eax,GDrawingInfoStruct
RET
GadgetStopDrawing:
Push dword[GDC]
Push dword[GWindow]
Call _ReleaseDC@8
RET


align8
PB_DesktopOutput:
Push 0
Call _GetDC@4
MOV [DDC],Eax
MOV Eax,DDrawingInfoStruct
RET
DesktopStopDrawing:
Push dword[DDC]
Push 0
Call _ReleaseDC@8
RET

align8
CBStopDrawing:
Call dword[OldReleaseProc]
MOV Eax,[BkBuffer]
MOV [_PB_DirectX_BackBuffer],Eax
RET

align8
PB_CurrentBufferOutput:
MOV Eax,[_PB_DirectX_BackBuffer]
MOV [BkBuffer],Eax
MOV Eax,[_PB_Sprite_CurrentBitmap]
MOV [_PB_DirectX_BackBuffer],Eax
Call _PB_ScreenOutput@0
MOV Edx,[Eax+12]
MOV [OldReleaseProc],Edx
MOV Edx,CBStopDrawing
MOV [Eax+12],Edx
RET


section '.data' readable writeable

Table565:
DQ 0
Table555:
DQ 0

BkBuffer:
DD 0
OldReleaseProc:
DD 0



DDrawingInfoStruct:
DType:
DD 2
DWindow:
DD 0
DDC:
DD 0
DReleaseProcedure:
DD DesktopStopDrawing
DPixelBuffer:
DD 0
DPitch:
DD 0
DWidth:
DD 0
DHeight:
DD 0
DDepth:
DD 0

GDrawingInfoStruct:
GType:
DD 2
GWindow:
DD 0
GDC:
DD 0
GReleaseProcedure:
DD GadgetStopDrawing
GPixelBuffer:
DD 0
GPitch:
DD 0
GWidth:
DD 0
GHeight:
DD 0
GDepth:
DD 0
