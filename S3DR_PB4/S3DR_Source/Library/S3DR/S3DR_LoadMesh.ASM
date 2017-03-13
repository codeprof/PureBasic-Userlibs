format MS COFF

;extrn _PB_D3DBase
extrn _PB_Direct3D_Device

extrn _CloseHandle@4
extrn _CreateFileA@28
extrn _GlobalAlloc@8
extrn _GlobalFree@4
extrn _GlobalLock@4
extrn _GlobalReAlloc@12
extrn _GlobalUnlock@4
extrn _ReadFile@20
extrn _RtlMoveMemory@12

public PB_S3DR_LoadMesh

macro align8 { rb 7-($-CodeSegment+7)mod 8}


section '.text' code readable executable
CodeSegment:


align8
_Procedure0:
PB_S3DR_LoadMesh:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,92
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,92
_ClearLoop0:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop0                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
; *D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()
  MOV Eax,[_PB_Direct3D_Device]
  MOV    dword [esp+4],eax
; *D3DDev\GetDirect3D(@*D3D.IDirect3D7)
  LEA    eax,[esp+8]
  PUSH   eax
  MOV    eax,dword [esp+8]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+28]
; Handle=CreateFile_(file,#GENERIC_READ,#FILE_SHARE_READ,0,#OPEN_EXISTING,#FILE_ATTRIBUTE_NORMAL,0)
  PUSH   dword 0
  PUSH   dword 128
  PUSH   dword 3
  PUSH   dword 0
  PUSH   dword 1
  PUSH   dword -2147483648
  PUSH   dword [esp+24]
  CALL  _CreateFileA@28
  MOV    dword [esp+12],eax
; If Handle=0:ProcedureReturn 0:EndIf
  MOV    ebx,dword [esp+12]
  CMP    ebx,0
  JNE   _EndIf2
  XOR    eax,eax
  JMP   _EndProcedure1
_EndIf2:
; 
; If ReadFile_(Handle,@long,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+28]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf4:
; 
; If long<>1380201299
  MOV    ebx,dword [esp+16]
  CMP    ebx,1380201299
  JE    _EndIf6
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf6:
; 
; VBD.D3DVERTEXBUFFERDESC\dwSize=SizeOf(D3DVERTEXBUFFERDESC)
  LEA    ebp,[esp+24]
  MOV    dword [ebp],16
; If ReadFile_(Handle,@long,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+28]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf8
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf8:
; 
; VBD\dwNumVertices=long
  PUSH   dword [esp+16]
  LEA    ebp,[esp+28]
  POP    eax
  MOV    dword [ebp+12],eax
; If ReadFile_(Handle,@long,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+28]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf10
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf10:
; 
; VBD\dwFVF=long
  PUSH   dword [esp+16]
  LEA    ebp,[esp+28]
  POP    eax
  MOV    dword [ebp+8],eax
; 
; VBD\dwCaps=#D3DVBCAPS_WRITEONLY|#D3DVBCAPS_SYSTEMMEMORY
  MOV    dword [ebp+4],67584
; 
; If ReadFile_(Handle,@OSize,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+52]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf12
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf12:
; 
; mem=GlobalAlloc_(#GMEM_FIXED|#GMEM_ZEROINIT,OSize)
  PUSH   dword [esp+40]
  PUSH   dword 64
  CALL  _GlobalAlloc@8
  MOV    dword [esp+44],eax
; 
; If mem=0
  MOV    ebx,dword [esp+44]
  CMP    ebx,0
  JNE   _EndIf14
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf14:
; 
; If ReadFile_(Handle,mem,OSize,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword [esp+48]
  PUSH   dword [esp+56]
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf16
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf16:
; 
; If ReadFile_(Handle,@SizeI,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+60]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf18
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf18:
; 
; tmp=GlobalAlloc_(#GMEM_FIXED|#GMEM_ZEROINIT,SizeI)
  PUSH   dword [esp+48]
  PUSH   dword 64
  CALL  _GlobalAlloc@8
  MOV    dword [esp+52],eax
; 
; If tmp=0
  MOV    ebx,dword [esp+52]
  CMP    ebx,0
  JNE   _EndIf20
; GlobalFree_(mem)
  PUSH   dword [esp+44]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf20:
; 
; If ReadFile_(Handle,tmp,SizeI,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword [esp+56]
  PUSH   dword [esp+64]
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf22
; GlobalFree_(mem)
  PUSH   dword [esp+44]
  CALL  _GlobalFree@4
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf22:
; 
; 
; If *D3D\CreateVertexBuffer(VBD,@*VB.IDirect3DVertexBuffer7,0)
  PUSH   dword 0
  LEA    eax,[esp+60]
  PUSH   eax
  LEA    eax,[esp+32]
  PUSH   eax
  MOV    eax,dword [esp+20]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+20]
  And    eax,eax
  JE    _EndIf24
; GlobalFree_(mem)
  PUSH   dword [esp+44]
  CALL  _GlobalFree@4
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf24:
; 
; 
; If *VB\Lock(0,@addr,@size)
  LEA    eax,[esp+64]
  PUSH   eax
  LEA    eax,[esp+64]
  PUSH   eax
  PUSH   dword 0
  MOV    eax,dword [esp+68]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+12]
  And    eax,eax
  JE    _EndIf26
; *VB\Release()
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; GlobalFree_(mem)
  PUSH   dword [esp+44]
  CALL  _GlobalFree@4
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf26:
; 
; NSize=OSize
  MOV    eax,dword [esp+40]
  MOV    dword [esp+68],eax
; If Size<NSize:NSize=Size:EndIf
  MOV    ebx,dword [esp+64]
  CMP    ebx,dword [esp+68]
  JGE   _EndIf28
  MOV    eax,dword [esp+64]
  MOV    dword [esp+68],eax
_EndIf28:
; RtlMoveMemory_(addr,mem,NSize)
  PUSH   dword [esp+68]
  PUSH   dword [esp+48]
  PUSH   dword [esp+68]
  CALL  _RtlMoveMemory@12
; 
; *VB\UnLock()
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+16]
; *VB\Optimize(S3DR_GetD3DDevice(),0)
  PUSH   dword 0
  MOV Eax,[_PB_Direct3D_Device]
  PUSH   eax
  MOV    eax,dword [esp+64]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+28]
; GlobalFree_(mem)
  PUSH   dword [esp+44]
  CALL  _GlobalFree@4
; 
; If ReadFile_(Handle,@Subs,4,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 4
  LEA    eax,[esp+84]
  PUSH   eax
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf30
; *VB\Release()
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf30:
; 
; 
; *Obj.Mesh=GlobalAlloc_(#GMEM_FIXED|#GMEM_ZEROINIT,20*Subs+12)
  MOV    ebx,dword [esp+72]
  IMUL   ebx,20
  ADD    ebx,12
  PUSH   ebx
  PUSH   dword 64
  CALL  _GlobalAlloc@8
  MOV    dword [esp+76],eax
; If *Obj=0
  MOV    ebx,dword [esp+76]
  CMP    ebx,0
  JNE   _EndIf32
; *VB\Release()
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf32:
; 
; *Obj\vb=*VB
  PUSH   dword [esp+56]
  MOV    ebp,dword [esp+80]
  POP    dword [ebp]
; *Obj\Subs=Subs
  PUSH   dword [esp+72]
  MOV    ebp,dword [esp+80]
  POP    dword [ebp+4]
; *Obj\tmp=tmp
  PUSH   dword [esp+52]
  MOV    ebp,dword [esp+80]
  POP    dword [ebp+8]
; 
; ptr=*Obj+12
  MOV    ebx,dword [esp+76]
  ADD    ebx,12
  MOV    dword [esp+80],ebx
; For C=1 To Subs
  MOV    dword [esp+84],1
_For33:
  MOV    eax,dword [esp+72]
  CMP    eax,dword [esp+84]
  JL    _Next34
; If ReadFile_(Handle,ptr,20,@dummy,0)=0
  PUSH   dword 0
  LEA    eax,[esp+24]
  PUSH   eax
  PUSH   dword 20
  PUSH   dword [esp+92]
  PUSH   dword [esp+28]
  CALL  _ReadFile@20
  MOV    ebx,eax
  CMP    ebx,0
  JNE   _EndIf36
; *VB\Release()
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; GlobalFree_(tmp)
  PUSH   dword [esp+52]
  CALL  _GlobalFree@4
; GlobalFree_(*Obj)
  PUSH   dword [esp+76]
  CALL  _GlobalFree@4
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure1
; EndIf
_EndIf36:
; 
; ptr+20
  ADD    dword [esp+80],20
; 
; address=ptr-4
  MOV    ebx,dword [esp+80]
  ADD    ebx,-4
  MOV    dword [esp+88],ebx
; MOV Eax,address
  MOV    Eax,dword [esp+88]
; !MOV EDX,[Eax]
MOV EDX,[Eax]
;!IMUL EDX,3
; !LEA EDX,[EDX*2+EDX]
LEA EDX,[EDX*2+EDX]
; !MOV [Eax],EDX
MOV [Eax],EDX
; 
;PokeL(ptr-4,PeekL(ptr-4)*3)
; 
; Next
_NextContinue34:
  INC    dword [esp+84]
  JMP   _For33
_Next34:
; CloseHandle_(Handle)
  PUSH   dword [esp+12]
  CALL  _CloseHandle@4
; ProcedureReturn *Obj
  MOV    eax,dword [esp+76]
  JMP   _EndProcedure1
; EndProcedure
  XOR    eax,eax
_EndProcedure1:
  ADD    esp,92
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    4
_EndProcedure0:
