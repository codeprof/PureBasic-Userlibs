format MS COFF




public PB_S3DR_CompressSprite


macro align8 { rb 7-($-CodeSegment+7)mod 8}

extrn _PB_DDrawBase
extrn _PB_IsSprite@4

section '.text' code readable executable
CodeSegment:




PB_S3DR_CompressSprite:
  PUSH   ebp
  PUSH   ebx
  PS2=156
  SUB    esp,144
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,144
_ClearLoop2:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop2                                                                                                 
; *Sprite.PB_Sprite=IsSprite(Sprite)
  PUSH   dword [esp+PS2+0]
  CALL  _PB_IsSprite@4
  MOV    dword [esp],eax
; If *Sprite=0:ProcedureReturn 0:EndIf
  MOV    ebx,dword [esp]
  And    ebx,ebx
  JNE   _EndIf2
  XOr    eax,eax
  JMP   _EndProcedure3
_EndIf2:
; 
; *DD.IDirectDraw7=DDrawBase()
  MOV EAX,[_PB_DDrawBase]
  MOV    dword [esp+4],eax
; DDSD.DDSURFACEDESC2
  LEA    eax,[esp+8]
; DDSD\dwSize=SizeOf(DDSURFACEDESC2)
  LEA    ebp,[esp+8]
  MOV    dword [ebp],124
; DDSD\dwFlags=#DDSD_CAPS|#DDSD_HEIGHT|#DDSD_WIDTH|#DDSD_PIXELFORMAT
  MOV    dword [ebp+4],4103
; DDSD\ddsCaps\dwCaps=#DDSCAPS_TEXTURE
  MOV    dword [ebp+104],4096
; DDSD\ddpfPixelFormat\dwSize=SizeOf(DDPIXELFORMAT)
  MOV    dword [ebp+72],32
; DDSD\ddpfPixelFormat\dwFlags=#DDPF_FOURCC 
  MOV    dword [ebp+76],4
; 
; DDSD\ddpfPixelFormat\dwFourCC='1TXD'
  MOV    dword [ebp+80],827611204
; 
; DDSD\dwWidth=*Sprite\Width
  MOV    ebp,dword [esp]
  MOVSX  eax,word [ebp+4]
  PUSH   eax
  LEA    ebp,[esp+12]
  POP    eax
  MOV    dword [ebp+12],eax
; DDSD\dwHeight=*Sprite\Height
  MOV    ebp,dword [esp]
  MOVSX  eax,word [ebp+6]
  PUSH   eax
  LEA    ebp,[esp+12]
  POP    eax
  MOV    dword [ebp+8],eax
; 
; Result=*DD\CreateSurface(DDSD,@*DDS.IDirectDrawSurface7,0)
  PUSH   dword 0
  LEA    eax,[esp+140]
  PUSH   eax
  LEA    eax,[esp+16]
  PUSH   eax
  MOV    eax,dword [esp+16]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+24]
  MOV    dword [esp+132],eax
; If Result:ProcedureReturn 0:EndIf
  CMP    dword [esp+132],0
  JE    _EndIf4
  XOr    eax,eax
  JMP   _EndProcedure3
_EndIf4:
; *OldDDS.IDirectDrawSurface7=*Sprite\Sprite
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp]
  MOV    dword [esp+140],eax
; Result=*DDS\BltFast(0,0,*OldDDS,0,0)
  PUSH   dword 0
  PUSH   dword 0
  PUSH   dword [esp+148]
  PUSH   dword 0
  PUSH   dword 0
  MOV    eax,dword [esp+156]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+28]
  MOV    dword [esp+132],eax
; If Result:*DDS\Release():ProcedureReturn 0:EndIf
  CMP    dword [esp+132],0
  JE    _EndIf6
  MOV    eax,dword [esp+136]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
  XOr    eax,eax
  JMP   _EndProcedure3
_EndIf6:
; *OldDDS\Release()
  MOV    eax,dword [esp+140]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; *Sprite\Sprite=*DDS
  PUSH   dword [esp+136]
  MOV    ebp,dword [esp+4]
  POP    dword [ebp]
; ProcedureReturn 1
  MOV    eax,1
  JMP   _EndProcedure3
; EndProcedure
  XOr    eax,eax
_EndProcedure3:
  ADD    esp,144
  POP    ebx
  POP    ebp
  RET    4
