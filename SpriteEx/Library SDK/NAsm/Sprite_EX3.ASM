format MS COFF

public PB_DisplayDirect
public PB_StopDisplayDirect
public PB_SwapBuffers
public PB_CopyScreenPart
public PB_ColorBox
public PB_WaitForVSync
public PB_CopyBuffer
public PB_CopyBufferEx
public PB_CopyScreenPartTrans
public PB_RestoreScreen

public PB_SpriteExPrimaryBufferInit
public PB_ScrollH
public PB_ScrollV
public SpriteEx_PrimaryBuffer

extrn _PB_DDrawBase
extrn _PB_FlipBuffers@0
extrn _PB_DirectX_PrimaryBuffer 
extrn _PB_DirectX_BackBuffer 
extrn _PB_DirectX_ScreenWidth
extrn _PB_DirectX_ScreenHeight
extrn _PB_Sprite_FXBuffer

DDBLT_WAIT EQU 16777216



section '.text' code readable executable


PB_SpriteExPrimaryBufferInit:
MOV Eax,[_PB_DirectX_PrimaryBuffer]
OR Eax,Eax
JNZ GetPBPB

Push DDrawBase
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+144]

Push SpriteEx_PrimaryBuffer
MOV Eax,[DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+56]
MOV Eax,[SpriteEx_PrimaryBuffer]
RET

GetPBPB:
MOV Eax,[_PB_DirectX_PrimaryBuffer]
MOV [SpriteEx_PrimaryBuffer],Eax
RET


PB_CopyBuffer:

MOV Eax,[SpriteEx_PrimaryBuffer]
Or Eax,Eax
JNZ InitOk
Call PB_SpriteExPrimaryBufferInit
InitOk: 

Push 16      ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push 0
Push dword[_PB_DirectX_BackBuffer]
Push 0
Push 0
MOV Eax,[SpriteEx_PrimaryBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
RET

PB_RestoreScreen:
Push 16      ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push 0
Push dword[_PB_DirectX_BackBuffer]
Push 0
Push 0
MOV Eax,[_PB_Sprite_FXBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
RET



;   Width ,  Height    
;    Eax  ,  [ESP+4]
PB_CopyBufferEx:

Push Eax
MOV Eax,[SpriteEx_PrimaryBuffer]
Or Eax,Eax
JNZ InitOk2
Call PB_SpriteExPrimaryBufferInit
InitOk2: 
Pop Eax

MOV [SrcRight],Eax
MOV Eax,[ESP+4]
MOV [SrcBottom],Eax

MOV Eax,[_PB_DirectX_ScreenWidth]
MOV [DestRight],Eax
MOV Eax,[_PB_DirectX_ScreenHeight]
MOV [DestBottom],Eax

;XOR Eax,Eax
;MOV dword[SrcLeft],Eax
;MOV dword[SrcTop],Eax
;MOV dword[DestLeft],Eax
;MOV dword[DestTop],Eax

Push dword dwSize
Push DDBLT_WAIT
Push dword SrcLeft
Push dword[_PB_DirectX_BackBuffer]
Push dword DestLeft
MOV Eax,[SpriteEx_PrimaryBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+20]
RET 4



PB_WaitForVSync:
Push 0
Push 1
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
MOV Eax,[Eax+88]
Call Eax
RET


PB_DisplayDirect:
MOV Eax,[_PB_DirectX_BackBuffer] 
MOV [BackBuffer],Eax 
MOV Eax,[_PB_DirectX_PrimaryBuffer] 
MOV [_PB_DirectX_BackBuffer],Eax
Call _PB_FlipBuffers@0
RET

PB_StopDisplayDirect:
MOV Eax,[BackBuffer] 
MOV [_PB_DirectX_BackBuffer],Eax
Call _PB_FlipBuffers@0
RET

PB_SwapBuffers:
MOV Eax,[SpriteEx_PrimaryBuffer]
Or Eax,Eax
JNZ InitOk3
Call PB_SpriteExPrimaryBufferInit
InitOk3:

MOV Edx,[SpriteEx_PrimaryBuffer]
MOV Eax,[Edx]
MOV Eax,[Eax+44]
Push dword  9;40
Push dword  0
Push edx
Call Eax
RET




;CopyScreenPart(ScrX,ScrY  ,ScrW  ,ScrH  ,DestX ,DestY)
;               Eax ,Esp+4 ,Esp+8 ,Esp+12,Esp+16,Esp+20
PB_CopyScreenPart:
MOV [RectLeft],Eax
MOV [RectRight],Eax
MOV Eax,[Esp+8]
ADD [RectRight],Eax

MOV Eax,[Esp+4]
MOV [RectTop],Eax
MOV [RectBottom],Eax
MOV Eax,[Esp+12]
ADD [RectBottom],Eax

MOV Eax,[Esp+16]
Or Eax,Eax;Cmp Eax,0
JGE XOk  ;größer/gleich
SUB [RectLeft],Eax
MOV dword[Esp+16],0
XOk:

MOV Eax,[Esp+20]
Or Eax,Eax;Cmp Eax,0
JGE YOk  ;größer/gleich
SUB [RectTop],Eax
MOV dword[Esp+20],0
YOk:

MOV Edx,[Esp+16]
ADD Edx,[Esp+8]

MOV Eax,[_PB_DirectX_ScreenWidth]
CMP [RectLeft],Eax
JB CopyScreenPartLeftOK;kleiner
XOR Eax,Eax
RET 20
CopyScreenPartLeftOK:

CMP Edx,Eax
JL WidthOk
SUB Edx,Eax
SUB [RectRight],Edx
WidthOk:

MOV Edx,[Esp+20]
ADD Edx,[Esp+12]

MOV Eax,[_PB_DirectX_ScreenHeight]
CMP [RectTop],Eax
JB CopyScreenPartTopOK;kleiner
XOR Eax,Eax
RET 20
CopyScreenPartTopOK:

CMP Edx,Eax
JL HeightOk
SUB Edx,Eax
SUB [RectBottom],Edx
HeightOk:

MOV Eax,[Esp+16]
CMP Eax,[_PB_DirectX_ScreenWidth]
JB CopyScreenPartDestXOK;kleiner
XOR Eax,Eax
RET 20
CopyScreenPartDestXOK:

MOV Edx,[Esp+20]
CMP Edx,[_PB_DirectX_ScreenHeight]
JB CopyScreenPartDestYOK;kleiner
XOR Eax,Eax
RET 20
CopyScreenPartDestYOK:


Push 16      ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push dword RectLeft
Push dword[_PB_DirectX_BackBuffer]
Push Edx
Push Eax
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
RET 20



;ColorBox(   x,     y,     w,     h,Color)
;          Eax, Esp+4, Esp+8,Esp+12,Esp+16
PB_ColorBox:
Or Eax,Eax
JGE ColorBoxXOk
ADD [Esp+8],Eax
XOR Eax,Eax
ColorBoxXOk:
MOV [RectLeft],Eax
MOV [RectRight],Eax
MOV Eax,[Esp+8]
ADD [RectRight],Eax

MOV Eax,[_PB_DirectX_ScreenWidth]
CMP [RectLeft],Eax
JB ColorBoxLeftOK;kleiner
XOR Eax,Eax
RET 16
ColorBoxLeftOK:

CMP [RectRight],Eax
JL ColorBoxWidthOk
MOV Edx,[RectRight]
SUB Edx,Eax
SUB [RectRight],Edx
ColorBoxWidthOk:

MOV Eax,[Esp+4]
Or Eax,Eax
JGE ColorBoxYOk
ADD [Esp+12],Eax
XOR Eax,Eax
ColorBoxYOk:
MOV [RectTop],Eax
MOV [RectBottom],Eax
MOV Eax,[Esp+12]
ADD [RectBottom],Eax

MOV Eax,[_PB_DirectX_ScreenHeight]
CMP [RectTop],Eax
JB ColorBoxTopOK;kleiner
XOR Eax,Eax
RET 16
ColorBoxTopOK:

CMP [RectBottom],Eax
JL ColorBoxHeightOk
MOV Edx,[RectBottom]
SUB Edx,Eax
SUB [RectBottom],Edx
ColorBoxHeightOk:

MOV Eax,[ESP+16]
MOV [dwFillColor],Eax

Push dword dwSize
Push 1024
Push 0
Push 0
Push dword RectLeft
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+20]
RET 16


;CopyScreenPartTrans(ScrX,ScrY  ,ScrW  ,ScrH  ,DestX ,DestY,TransColor)
;               Eax ,Esp+4 ,Esp+8 ,Esp+12,Esp+16,Esp+20,Esp+24
PB_CopyScreenPartTrans:
MOV [RectLeft],Eax
MOV [RectRight],Eax
MOV Eax,[Esp+8]
ADD [RectRight],Eax

MOV Eax,[Esp+24]
MOV [CSPT_dwColorSpaceLowValue],Eax

Push CSPT_dwColorSpaceLowValue
Push 8
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+116]
MOV [Result1],Eax

MOV Eax,[Esp+4]
MOV [RectTop],Eax
MOV [RectBottom],Eax
MOV Eax,[Esp+12]
ADD [RectBottom],Eax

MOV Eax,[Esp+16]
Or Eax,Eax;Cmp Eax,0
JGE TrnsXOk  ;größer/gleich
SUB [RectLeft],Eax
MOV dword[Esp+16],0
TrnsXOk:

MOV Eax,[Esp+20]
Or Eax,Eax;Cmp Eax,0
JGE TrnsYOk  ;größer/gleich
SUB [RectTop],Eax
MOV dword[Esp+20],0
TrnsYOk:

MOV Edx,[Esp+16]
ADD Edx,[Esp+8]

MOV Eax,[_PB_DirectX_ScreenWidth]
CMP [RectLeft],Eax
JB CopyScreenPartTransLeftOK;kleiner
XOR Eax,Eax
RET 24
CopyScreenPartTransLeftOK:

CMP Edx,Eax
JL TransWidthOk
SUB Edx,Eax
SUB [RectRight],Edx
TransWidthOk:

MOV Edx,[Esp+20]
ADD Edx,[Esp+12]

MOV Eax,[_PB_DirectX_ScreenHeight]
CMP [RectTop],Eax
JB CopyScreenPartTransTopOK;kleiner
XOR Eax,Eax
RET 24
CopyScreenPartTransTopOK:

CMP Edx,Eax
JL TransHeightOk
SUB Edx,Eax
SUB [RectBottom],Edx
TransHeightOk:

MOV Eax,[Esp+16]
CMP Eax,[_PB_DirectX_ScreenWidth]
JB CopyScreenPartTransDestXOK;kleiner
XOR Eax,Eax
RET 24
CopyScreenPartTransDestXOK:

MOV Edx,[Esp+20]
CMP Edx,[_PB_DirectX_ScreenHeight]
JB CopyScreenPartTransDestYOK;kleiner
XOR Eax,Eax
RET 24
CopyScreenPartTransDestYOK:

Push 17     ;DDBLTFAST_SRCCOLORKEY|DDBLTFAST_WAIT
Push dword RectLeft
Push dword[_PB_DirectX_BackBuffer]
Push Edx
Push Eax
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR Eax,[Result1]
RET 24





PB_ScrollH:

CMP Eax,0
JG ScrollHG
JL ScrollHL

XOr Eax,Eax
RET

ScrollHG:

MOV [ScrollX],Eax
MOV Edx,[_PB_DirectX_ScreenWidth]
MOV [RectRight],Edx
SUB Edx,Eax
ADD [RectLeft],Edx
MOV dword[RectTop],0
MOV Edx,[_PB_DirectX_ScreenHeight]
MOV [RectBottom],Edx
MOV [ScrollSurfaceDesc2Width],Eax
MOV [ScrollSurfaceDesc2Height],Edx

Push 0
Push ScrollSurface 
Push ScrollSurfaceDesc2
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]
MOV [Result1],Eax


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[_PB_DirectX_BackBuffer] 
Push 0
Push 0
MOV Eax,[ScrollSurface]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
;OR [Result1],Eax


XOr Eax,Eax
Push Eax
Push dword[ScrollX]
Push dword[_PB_DirectX_ScreenHeight]
Push dword[_PB_DirectX_ScreenWidth]
Push Eax
Call PB_CopyScreenPart
;OR [Result1],Eax


XOR Edx,Edx
MOV Eax,[ScrollX]
MOV [RectLeft],Edx
MOV [RectRight],Eax
MOV [RectTop],Edx
MOV Edx,[_PB_DirectX_ScreenHeight]
MOV [RectBottom],Edx


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[ScrollSurface] 
Push 0
Push 0
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax

MOV Eax,[ScrollSurface];Release
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
MOV Eax,[Result1]
RET


ScrollHL:

XOr Edx,Edx
MOV dword[RectLeft],Edx
MOV dword[RectTop],Edx
MOV [ScrollX],Eax

NEG Eax
MOV [RectRight],Eax
MOV Edx,[_PB_DirectX_ScreenHeight]
MOV [RectBottom],Edx

MOV [ScrollSurfaceDesc2Width],Eax
MOV [ScrollSurfaceDesc2Height],Edx

Push 0
Push ScrollSurface 
Push ScrollSurfaceDesc2
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]
MOV [Result1],Eax


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[_PB_DirectX_BackBuffer] 
Push 0
Push 0
MOV Eax,[ScrollSurface]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax


XOr Eax,Eax
Push Eax
Push dword[ScrollX]
Push dword[_PB_DirectX_ScreenHeight]
Push dword[_PB_DirectX_ScreenWidth]
Push Eax
Call PB_CopyScreenPart
OR [Result1],Eax


XOR Edx,Edx
MOV Eax,[ScrollX]
NEG Eax
MOV [RectLeft],Edx
MOV [RectRight],Eax
MOV [RectTop],Edx
MOV Edx,[_PB_DirectX_ScreenHeight]
MOV [RectBottom],Edx

Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[ScrollSurface] 
Push 0
MOV Eax,[_PB_DirectX_ScreenWidth]
ADD Eax,[ScrollX]
Push Eax
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax

MOV Eax,[ScrollSurface];Release
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
MOV Eax,[Result1]
RET




PB_ScrollV:

CMP Eax,0
JG ScrollVG
JL ScrollVL

XOr Eax,Eax
RET

ScrollVG:

MOV [ScrollX],Eax
MOV dword[RectLeft],0
MOV Edx,[_PB_DirectX_ScreenHeight]
MOV [RectBottom],Edx
MOV [RectTop],Edx
SUB [RectTop],Eax
MOV Edx,[_PB_DirectX_ScreenWidth]
MOV [RectRight],Edx

MOV [ScrollSurfaceDesc2Width],Edx
MOV [ScrollSurfaceDesc2Height],Eax

Push 0
Push ScrollSurface 
Push ScrollSurfaceDesc2
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]
MOV [Result1],Eax


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[_PB_DirectX_BackBuffer] 
Push 0
Push 0
MOV Eax,[ScrollSurface]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
;OR [Result1],Eax


XOr Eax,Eax
Push dword[ScrollX]
Push Eax
Push dword[_PB_DirectX_ScreenHeight]
Push dword[_PB_DirectX_ScreenWidth]
Push Eax
Call PB_CopyScreenPart
;OR [Result1],Eax


XOR Edx,Edx
MOV Eax,dword[_PB_DirectX_ScreenWidth]
MOV [RectRight],Eax
MOV Eax,[ScrollX]
MOV [RectLeft],Edx
MOV [RectTop],Edx
MOV [RectBottom],Eax


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[ScrollSurface] 
Push 0
Push 0
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax

MOV Eax,[ScrollSurface];Release
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
MOV Eax,[Result1]
RET

ScrollVL:

XOr Edx,Edx
MOV dword[RectLeft],Edx
MOV dword[RectTop],Edx
MOV [ScrollX],Eax

NEG Eax
MOV Edx,[_PB_DirectX_ScreenWidth]
MOV [RectRight],Edx
MOV [RectBottom],Eax

MOV [ScrollSurfaceDesc2Width],Edx
MOV [ScrollSurfaceDesc2Height],Eax

Push 0
Push ScrollSurface 
Push ScrollSurfaceDesc2
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+24]
MOV [Result1],Eax


Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[_PB_DirectX_BackBuffer] 
Push 0
Push 0
MOV Eax,[ScrollSurface]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax


XOr Eax,Eax
Push dword[ScrollX]
Push Eax
Push dword[_PB_DirectX_ScreenHeight]
Push dword[_PB_DirectX_ScreenWidth]
Push Eax
Call PB_CopyScreenPart
OR [Result1],Eax


XOR Edx,Edx
MOV Eax,[ScrollX]
NEG Eax
MOV [RectLeft],Edx
MOV [RectTop],Edx
MOV Edx,[_PB_DirectX_ScreenWidth]
MOV [RectRight],Edx

MOV [RectBottom],Eax

Push 16 ;DDBLTFAST_NOCOLORKEY|DDBLTFAST_WAIT
Push RectLeft
Push dword[ScrollSurface] 
MOV Eax,[_PB_DirectX_ScreenHeight]
ADD Eax,[ScrollX]
Push Eax
Push 0
MOV Eax,[_PB_DirectX_BackBuffer]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+28]
OR [Result1],Eax

MOV Eax,[ScrollSurface];Release
Push Eax
MOV Eax,[Eax]
Call dword[Eax+8]
MOV Eax,[Result1]
RET



section '.data' readable writeable
DDrawBase:
DD 0
SpriteEx_PrimaryBuffer:
DD 0
ScrollSurface:
DD 0
ScrollX:
DD 0

BackBuffer:
DD 0
Result1:
DD 0

RectLeft:
DD 0
RectTop:
DD 0
RectRight:
DD 0
RectBottom:
DD 0

SrcLeft:
DD 0
SrcTop:
DD 0
SrcRight:
DD 0
SrcBottom:
DD 0

DestLeft:
DD 0
DestTop:
DD 0
DestRight:
DD 0
DestBottom:
DD 0

dwSize:
DD 100
dwDDFX:
DD 0
dwROP:
DD 0
dwDDROP:
DD 0
dwRotationAngle:
DD 0
dwZBufferOpCode:
DD 0
dwZBufferLow:
DD 0
dwZBufferHigh:
DD 0
dwZBufferBaseDest:
DD 0
dwZDestConstBitDepth:
DD 0
dwZDestConst:
DD 0
dwZSrcConstBitDepth:
DD 0
dwZSrcConst:
DD 0
dwAlphaEdgeBlendBitDepth:
DD 0
dwAlphaEdgeBlend:
DD 0
dwReserved:
DD 0
dwAlphaDestConstBitDepth:
DD 0
dwAlphaDestConst:
DD 0
dwAlphaSrcConstBitDepth:
DD 0
dwAlphaSrcConst:
DD 0
dwFillColor:
DD 0
dwColorSpaceLowValue:
DD 0
dwColorSpaceHighValue:
DD 0
dwColorSpaceLowValue2:
DD 0
dwColorSpaceHighValue2:
DD 0

CSPT_dwColorSpaceLowValue:
DD 0
CSPT_dwColorSpaceHighValue:
DD 0

ScrollSurfaceDesc2:
DD 124
DD 6  ;DDSD_HEIGHT|DDSD_WIDTH
ScrollSurfaceDesc2Height:
DD 0
ScrollSurfaceDesc2Width:
DD 0
RB 108

VersionInfo:
DB "SpriteEx v1.11",0