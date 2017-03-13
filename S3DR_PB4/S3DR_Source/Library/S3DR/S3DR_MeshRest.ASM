format MS COFF

;extrn _PB_D3DBase
extrn _PB_Direct3D_Device


extrn _GlobalAlloc@8
extrn _GlobalFree@4
extrn _GlobalLock@4
extrn _GlobalReAlloc@12
extrn _GlobalUnlock@4
extrn _RtlMoveMemory@12


public PB_S3DR_CreateMesh_SetTriangleTextureCoords
public PB_S3DR_CreateMesh_SetQuadTextureCoords
public PB_S3DR_CreateMesh_AddTriangle
public PB_S3DR_CreateMesh_AddQuad
public PB_S3DR_StopCreateMesh
public PB_S3DR_StartCreateMesh

macro align8 { rb 7-($-CodeSegment+7)mod 8}



section '.text' code readable executable
CodeSegment:












align8
_Procedure2:
PB_S3DR_StartCreateMesh:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi                                                                                                                                                                                                                                                           
; *TempTri=GlobalAlloc_(#GMEM_FIXED,SizeOf(Tri))
  PUSH   dword 60
  PUSH   dword 0
  CALL  _GlobalAlloc@8
  MOV    dword [p_TempTri],eax
; If *TempTri=0:ProcedureReturn -1:EndIf
  MOV    ebx,dword [p_TempTri]
  CMP    ebx,0
  JNE   _EndIf38
  MOV    eax,-1
  JMP   _EndProcedure3
_EndIf38:
; *TempQuad=GlobalAlloc_(#GMEM_FIXED,SizeOf(Quad))
  PUSH   dword 120
  PUSH   dword 0
  CALL  _GlobalAlloc@8
  MOV    dword [p_TempQuad],eax
; If *TempQuad=0:GlobalFree_(*TempTri):ProcedureReturn -1:EndIf
  MOV    ebx,dword [p_TempQuad]
  CMP    ebx,0
  JNE   _EndIf40
  PUSH   dword [p_TempTri]
  CALL  _GlobalFree@4
  MOV    eax,-1
  JMP   _EndProcedure3
_EndIf40:
; *TempQuad\tu1=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+12],0
; *TempQuad\tv1=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+16],0
; *TempQuad\tu2=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+32],1065353216
; *TempQuad\tv2=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+36],0
; *TempQuad\tu3=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+52],0
; *TempQuad\tv3=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+56],1065353216
; *TempQuad\tu4=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+72],1065353216
; *TempQuad\tv4=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+76],0
; *TempQuad\tu5=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+92],1065353216
; *TempQuad\tv5=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+96],1065353216
; *TempQuad\tu6=0
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+112],0
; *TempQuad\tv6=1
  MOV    ebp,dword [p_TempQuad]
  MOV    dword [ebp+116],1065353216
; 
; *TempTri\tu1=0
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+12],0
; *TempTri\tv1=0
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+16],0
; *TempTri\tu2=1
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+32],1065353216
; *TempTri\tv2=0
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+36],0
; *TempTri\tu3=0
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+52],0
; *TempTri\tv3=1
  MOV    ebp,dword [p_TempTri]
  MOV    dword [ebp+56],1065353216
; 
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure3
; EndProcedure
  XOR    eax,eax
_EndProcedure3:
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET
_EndProcedure2:
; 











; ProcedureDLL S3DR_StopCreateMesh()
align8
_Procedure4:
PB_S3DR_StopCreateMesh:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,44
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,44
_ClearLoop4:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop4                                                                                                                  
; *D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()
  MOV Eax,[_PB_Direct3D_Device]
  MOV    dword [esp],eax
; *D3DDev\GetDirect3D(@*D3D.IDirect3D7)
  LEA    eax,[esp+4]
  PUSH   eax
  MOV    eax,dword [esp+4]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+28]
; 
; *M.Mesh=GlobalAlloc_(#GMEM_FIXED,SizeOf(Mesh))
  PUSH   dword 12
  PUSH   dword 0
  CALL  _GlobalAlloc@8
  MOV    dword [esp+8],eax
; 
; If *M=0
  MOV    ebx,dword [esp+8]
  CMP    ebx,0
  JNE   _EndIf42
; GlobalFree_(*TempTri)
  PUSH   dword [p_TempTri]
  CALL  _GlobalFree@4
; GlobalFree_(*TempQuad)
  PUSH   dword [p_TempQuad]
  CALL  _GlobalFree@4
; GlobalFree_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalFree@4
; TempVB=0
  MOV    dword [v_TempVB],0
; VBSize=0
  MOV    dword [v_VBSize],0
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure5
; EndIf
_EndIf42:
; 
; VBD.D3DVERTEXBUFFERDESC\dwSize=SizeOf(D3DVERTEXBUFFERDESC)
  LEA    ebp,[esp+12]
  MOV    dword [ebp],16
; VBD\dwNumVertices=VBSize/20
  MOV    ebx,dword [v_VBSize]
  MOV    eax,ebx
  MOV    ebx,20
  CDQ
  IDIV   ebx
  MOV    ebx, eax
  PUSH   ebx
  POP    eax
  MOV    dword [ebp+12],eax
; 
; VBD\dwFVF=#D3DFVF_TEX1|#D3DFVF_XYZ
  MOV    dword [ebp+8],258
; VBD\dwCaps=#D3DVBCAPS_WRITEONLY|#D3DVBCAPS_SYSTEMMEMORY
  MOV    dword [ebp+4],67584
; 
; If *D3D\CreateVertexBuffer(VBD,@*VB.IDirect3DVertexBuffer7,0)
  PUSH   dword 0
  LEA    eax,[esp+32]
  PUSH   eax
  LEA    eax,[esp+20]
  PUSH   eax
  MOV    eax,dword [esp+16]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+20]
  And    eax,eax
  JE    _EndIf44
; GlobalFree_(*M)
  PUSH   dword [esp+8]
  CALL  _GlobalFree@4
; GlobalFree_(*TempTri)
  PUSH   dword [p_TempTri]
  CALL  _GlobalFree@4
; GlobalFree_(*TempQuad)
  PUSH   dword [p_TempQuad]
  CALL  _GlobalFree@4
; GlobalFree_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalFree@4
; TempVB=0
  MOV    dword [v_TempVB],0
; VBSize=0
  MOV    dword [v_VBSize],0
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure5
; EndIf
_EndIf44:
; 
; *M\Vb=*VB
  PUSH   dword [esp+28]
  MOV    ebp,dword [esp+12]
  POP    dword [ebp]
; *M\tmp=VBSize/20
  MOV    ebx,dword [v_VBSize]
  MOV    eax,ebx
  MOV    ebx,20
  CDQ
  IDIV   ebx
  MOV    ebx, eax
  PUSH   ebx
  MOV    ebp,dword [esp+12]
  POP    eax
  MOV    dword [ebp+8],eax
; *M\Subs=0
  MOV    ebp,dword [esp+8]
  MOV    dword [ebp+4],0
; 
; If *VB\Lock(0,@addr,@size)
  LEA    eax,[esp+36]
  PUSH   eax
  LEA    eax,[esp+36]
  PUSH   eax
  PUSH   dword 0
  MOV    eax,dword [esp+40]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+12]
  And    eax,eax
  JE    _EndIf46
; *VB\Release()
  MOV    eax,dword [esp+28]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; GlobalFree_(*M)
  PUSH   dword [esp+8]
  CALL  _GlobalFree@4
; GlobalFree_(*TempTri)
  PUSH   dword [p_TempTri]
  CALL  _GlobalFree@4
; GlobalFree_(*TempQuad)
  PUSH   dword [p_TempQuad]
  CALL  _GlobalFree@4
; GlobalFree_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalFree@4
; TempVB=0
  MOV    dword [v_TempVB],0
; VBSize=0
  MOV    dword [v_VBSize],0
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure5
; EndIf
_EndIf46:
; 
; pTempVB=GlobalLock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalLock@4
  MOV    dword [esp+40],eax
; RtlMoveMemory_(addr,pTempVB,size)
  PUSH   dword [esp+36]
  PUSH   dword [esp+44]
  PUSH   dword [esp+40]
  CALL  _RtlMoveMemory@12
; GlobalUnlock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalUnlock@4
; *VB\UnLock()
  MOV    eax,dword [esp+28]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+16]
;*VB\Optimize(S3DR_GetD3DDevice(),0)
; 
; GlobalFree_(*TempTri)
  PUSH   dword [p_TempTri]
  CALL  _GlobalFree@4
; GlobalFree_(*TempQuad)
  PUSH   dword [p_TempQuad]
  CALL  _GlobalFree@4
; GlobalFree_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalFree@4
; TempVB=0
  MOV    dword [v_TempVB],0
; VBSize=0
  MOV    dword [v_VBSize],0
; ProcedureReturn *M
  MOV    eax,dword [esp+8]
  JMP   _EndProcedure5
; EndProcedure
  XOR    eax,eax
_EndProcedure5:
  ADD    esp,44
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET
_EndProcedure4:
; 










; ProcedureDLL S3DR_CreateMesh_AddQuad(x1.f,y1.f,z1.f,x2.f,y2.f,z2.f,x3.f,y3.f,z3.f,x4.f,y4.f,z4.f)
align8
_Procedure6:
PB_S3DR_CreateMesh_AddQuad:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,52
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,52
_ClearLoop6:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop6                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
  MOV    eax, dword [esi+36]
  MOV    dword [esp+12],eax
  MOV    eax, dword [esi+40]
  MOV    dword [esp+16],eax
  MOV    eax, dword [esi+44]
  MOV    dword [esp+20],eax
  MOV    eax, dword [esi+48]
  MOV    dword [esp+24],eax
  MOV    eax, dword [esi+52]
  MOV    dword [esp+28],eax
  MOV    eax, dword [esi+56]
  MOV    dword [esp+32],eax
  MOV    eax, dword [esi+60]
  MOV    dword [esp+36],eax
  MOV    eax, dword [esi+64]
  MOV    dword [esp+40],eax
  MOV    eax, dword [esi+68]
  MOV    dword [esp+44],eax
; *TempQuad\x1=x1
  FLD    dword [esp]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp]
; *TempQuad\y1=y1
  FLD    dword [esp+4]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+4]
; *TempQuad\z1=z1
  FLD    dword [esp+8]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+8]
; *TempQuad\x2=x2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+20]
; *TempQuad\y2=y2
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+24]
; *TempQuad\z2=z2
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+28]
; *TempQuad\x3=x3
  FLD    dword [esp+24]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+40]
; *TempQuad\y3=y3
  FLD    dword [esp+28]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+44]
; *TempQuad\z3=z3
  FLD    dword [esp+32]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+48]
; 
; 
; 
; *TempQuad\x4=x2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+60]
; *TempQuad\y4=y2
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+64]
; *TempQuad\z4=z2
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+68]
; *TempQuad\x5=x4
  FLD    dword [esp+36]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+80]
; *TempQuad\y5=y4
  FLD    dword [esp+40]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+84]
; *TempQuad\z5=z4
  FLD    dword [esp+44]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+88]
; *TempQuad\x6=x3
  FLD    dword [esp+24]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+100]
; *TempQuad\y6=y3
  FLD    dword [esp+28]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+104]
; *TempQuad\z6=z3
  FLD    dword [esp+32]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+108]
; 
; 
; 
; If TempVB=0
  MOV    ebx,dword [v_TempVB]
  CMP    ebx,0
  JNE   _EndIf48
; TempVB=GlobalAlloc_(#GMEM_MOVEABLE,SizeOf(Quad))
  PUSH   dword 120
  PUSH   dword 2
  CALL  _GlobalAlloc@8
  MOV    dword [v_TempVB],eax
; Else
  JMP   _EndIf47
_EndIf48:
; TempVB=GlobalReAlloc_(TempVB,VBSize+SizeOf(Quad),#GMEM_MOVEABLE)
  PUSH   dword 2
  MOV    ebx,dword [v_VBSize]
  ADD    ebx,120
  PUSH   ebx
  PUSH   dword [v_TempVB]
  CALL  _GlobalReAlloc@12
  MOV    dword [v_TempVB],eax
; EndIf
_EndIf47:
; 
; If TempVB
  CMP    dword [v_TempVB],0
  JE    _EndIf51
; VBSize+SizeOf(Quad)
  ADD    dword [v_VBSize],120
; 
; pTempVB=GlobalLock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalLock@4
  MOV    dword [esp+48],eax
; RtlMoveMemory_(pTempVB+VBSize-SizeOf(Quad),*TempQuad,SizeOf(Quad))
  PUSH   dword 120
  PUSH   dword [p_TempQuad]
  MOV    ebx,dword [esp+56]
  ADD    ebx,dword [v_VBSize]
  ADD    ebx,-120
  PUSH   ebx
  CALL  _RtlMoveMemory@12
; GlobalUnlock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalUnlock@4
; ProcedureReturn -1
  MOV    eax,-1
  JMP   _EndProcedure7
; EndIf
_EndIf51:
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure7
; EndProcedure
  XOR    eax,eax
_EndProcedure7:
  ADD    esp,52
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    48
_EndProcedure6:
; 
; 










; 
; ProcedureDLL S3DR_CreateMesh_AddTriangle(x1.f,y1.f,z1.f,x2.f,y2.f,z2.f,x3.f,y3.f,z3.f)
align8
_Procedure8:
PB_S3DR_CreateMesh_AddTriangle:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,40
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,40
_ClearLoop8:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop8                                                                                                                  
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
  MOV    eax, dword [esi+36]
  MOV    dword [esp+12],eax
  MOV    eax, dword [esi+40]
  MOV    dword [esp+16],eax
  MOV    eax, dword [esi+44]
  MOV    dword [esp+20],eax
  MOV    eax, dword [esi+48]
  MOV    dword [esp+24],eax
  MOV    eax, dword [esi+52]
  MOV    dword [esp+28],eax
  MOV    eax, dword [esi+56]
  MOV    dword [esp+32],eax
; *TempTri\x1=x1
  FLD    dword [esp]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp]
; *TempTri\y1=y1
  FLD    dword [esp+4]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+4]
; *TempTri\z1=z1
  FLD    dword [esp+8]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+8]
; *TempTri\x2=x2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+20]
; *TempTri\y2=y2
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+24]
; *TempTri\z2=z2
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+28]
; *TempTri\x3=x3
  FLD    dword [esp+24]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+40]
; *TempTri\y3=y3
  FLD    dword [esp+28]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+44]
; *TempTri\z3=z3
  FLD    dword [esp+32]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+48]
; 
; If TempVB=0
  MOV    ebx,dword [v_TempVB]
  CMP    ebx,0
  JNE   _EndIf53
; TempVB=GlobalAlloc_(#GMEM_MOVEABLE,SizeOf(Tri))
  PUSH   dword 60
  PUSH   dword 2
  CALL  _GlobalAlloc@8
  MOV    dword [v_TempVB],eax
; Else
  JMP   _EndIf52
_EndIf53:
; TempVB=GlobalReAlloc_(TempVB,VBSize+SizeOf(Tri),#GMEM_MOVEABLE)
  PUSH   dword 2
  MOV    ebx,dword [v_VBSize]
  ADD    ebx,60
  PUSH   ebx
  PUSH   dword [v_TempVB]
  CALL  _GlobalReAlloc@12
  MOV    dword [v_TempVB],eax
; EndIf
_EndIf52:
; 
; If TempVB
  CMP    dword [v_TempVB],0
  JE    _EndIf56
; VBSize+SizeOf(Tri)
  ADD    dword [v_VBSize],60
; pTempVB=GlobalLock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalLock@4
  MOV    dword [esp+36],eax
; RtlMoveMemory_(pTempVB+VBSize-SizeOf(Tri),*TempTri,SizeOf(Tri))
  PUSH   dword 60
  PUSH   dword [p_TempTri]
  MOV    ebx,dword [esp+44]
  ADD    ebx,dword [v_VBSize]
  ADD    ebx,-60
  PUSH   ebx
  CALL  _RtlMoveMemory@12
; GlobalUnlock_(TempVB)
  PUSH   dword [v_TempVB]
  CALL  _GlobalUnlock@4
; ProcedureReturn -1
  MOV    eax,-1
  JMP   _EndProcedure9
; EndIf
_EndIf56:
; ProcedureReturn 0
  XOR    eax,eax
  JMP   _EndProcedure9
; EndProcedure
  XOR    eax,eax
_EndProcedure9:
  ADD    esp,40
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    36
_EndProcedure8:
; 






; ProcedureDLL S3DR_CreateMesh_SetQuadTextureCoords(tu1.f,tv1.f,tu2.f,tv2.f,tu3.f,tv3.f,tu4.f,tv4.f)
align8
_Procedure10:
PB_S3DR_CreateMesh_SetQuadTextureCoords:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,32
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,32
_ClearLoop10:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop10                                                                                                                
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
  MOV    eax, dword [esi+36]
  MOV    dword [esp+12],eax
  MOV    eax, dword [esi+40]
  MOV    dword [esp+16],eax
  MOV    eax, dword [esi+44]
  MOV    dword [esp+20],eax
  MOV    eax, dword [esi+48]
  MOV    dword [esp+24],eax
  MOV    eax, dword [esi+52]
  MOV    dword [esp+28],eax
; *TempQuad\tu1=tu1
  FLD    dword [esp]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+12]
; *TempQuad\tv1=tv1
  FLD    dword [esp+4]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+16]
; *TempQuad\tu2=tu2
  FLD    dword [esp+8]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+32]
; *TempQuad\tv2=tv2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+36]
; *TempQuad\tu3=tu3
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+52]
; *TempQuad\tv3=tv3
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+56]
; *TempQuad\tu4=tu2
  FLD    dword [esp+8]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+72]
; *TempQuad\tv4=tv2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+76]
; *TempQuad\tu5=tu4
  FLD    dword [esp+24]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+92]
; *TempQuad\tv5=tv4 
  FLD    dword [esp+28]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+96]
; *TempQuad\tu6=tu3
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+112]
; *TempQuad\tv6=tv3
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempQuad]
  FSTP   dword [ebp+116]
; EndProcedure
  XOR    eax,eax
_EndProcedure11:
  ADD    esp,32
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    32
_EndProcedure10:
; 


; ProcedureDLL S3DR_CreateMesh_SetTriangleTextureCoords(tu1.f,tv1.f,tu2.f,tv2.f,tu3.f,tv3.f)
align8
_Procedure12:
PB_S3DR_CreateMesh_SetTriangleTextureCoords:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,24
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,24
_ClearLoop12:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop12                                                                                                                
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
  MOV    eax, dword [esi+28]
  MOV    dword [esp+4],eax
  MOV    eax, dword [esi+32]
  MOV    dword [esp+8],eax
  MOV    eax, dword [esi+36]
  MOV    dword [esp+12],eax
  MOV    eax, dword [esi+40]
  MOV    dword [esp+16],eax
  MOV    eax, dword [esi+44]
  MOV    dword [esp+20],eax
; *TempTri\tu1=tu1
  FLD    dword [esp]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+12]
; *TempTri\tv1=tv1
  FLD    dword [esp+4]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+16]
; *TempTri\tu2=tu2
  FLD    dword [esp+8]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+32]
; *TempTri\tv2=tv2
  FLD    dword [esp+12]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+36]
; *TempTri\tu3=tu3
  FLD    dword [esp+16]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+52]
; *TempTri\tv3=tv3
  FLD    dword [esp+20]
  MOV    ebp,dword [p_TempTri]
  FSTP   dword [ebp+56]
; EndProcedure
  XOR    eax,eax
_EndProcedure13:
  ADD    esp,24
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    24
_EndProcedure12:
; 
; 
; 





section '.data' readable writeable

p_TempQuad:
DQ 0
p_TempTri:
DQ 0
v_TempVB:
DQ 0
v_VBSize:
DQ 0