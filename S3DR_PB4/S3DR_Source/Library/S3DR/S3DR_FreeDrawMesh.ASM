format MS COFF

;extrn _PB_D3DBase
extrn _PB_Direct3D_Device

extrn _GlobalFree@4

public PB_S3DR_FreeMesh
public PB_S3DR_DrawMesh
public PB_S3DR_DrawMesh2

macro align8 { rb 7-($-CodeSegment+7)mod 8}



section '.text' code readable executable
CodeSegment:


; ProcedureDLL S3DR_DrawMesh(*Obj.Mesh,X.f,Y.f,Z.f,RX.f,RY.f,RZ.f)
align8
PB_S3DR_DrawMesh:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,376
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,376
_ClearLoop14:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop14                                                                                                              
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
; *D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()
  MOV Eax,[_PB_Direct3D_Device]
  MOV    dword [esp+28],eax
; 
; *D3DDev\GetTransform(1,IDM.D3DXMATRIX)
  LEA    eax,[esp+32]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+48]
; 
; vb=*OBJ\vb ;PeekL(Object)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp]
  MOV    dword [esp+96],eax
; Subs=*OBJ\Subs ;PeekL(Object+4)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp+4]
  MOV    dword [esp+100],eax
; tmp=*OBJ\Tmp ;PeekL(Object+8)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp+8]
  MOV    dword [esp+104],eax
; 
; 
; Move.D3DXMATRIX
  LEA    eax,[esp+108]
; RotX.D3DXMATRIX
  LEA    eax,[esp+172]
; RotY.D3DXMATRIX
  LEA    eax,[esp+236]
; RotZ.D3DXMATRIX
  LEA    eax,[esp+300]
; Move\_11=1.0 
  LEA    ebp,[esp+108]
  MOV    dword [ebp],1065353216
; Move\_44=1.0 
  MOV    dword [ebp+60],1065353216
; Move\_22=1.0
  MOV    dword [ebp+20],1065353216
; Move\_33=1.0
  MOV    dword [ebp+40],1065353216
; Move\_41=X 
  FLD    dword [esp+4]
  FSTP   dword [ebp+48]
; Move\_42=Y 
  FLD    dword [esp+8]
  FSTP   dword [ebp+52]
; Move\_43=Z 
  FLD    dword [esp+12]
  FSTP   dword [ebp+56]
; 
; RotX\_11=1.0 
  LEA    ebp,[esp+172]
  MOV    dword [ebp],1065353216
; RotX\_44=1.0 
  MOV    dword [ebp+60],1065353216
; RotX\_22= Cos(RX) 
  FLD    dword [esp+16]
  FCOS
  FSTP   dword [ebp+20]
; RotX\_23= Sin(RX)
  FLD    dword [esp+16]
  FSIN
  FSTP   dword [ebp+24]
; RotX\_32=-Sin(RX)
  FLD    dword [esp+16]
  FSIN
  FCHS
  FSTP   dword [ebp+36]
; RotX\_33= Cos(RX)
  FLD    dword [esp+16]
  FCOS
  FSTP   dword [ebp+40]
; 
; RotY\_22=1.0 
  LEA    ebp,[esp+236]
  MOV    dword [ebp+20],1065353216
; RotY\_44=1.0 
  MOV    dword [ebp+60],1065353216
; RotY\_11= Cos(RY)
  FLD    dword [esp+20]
  FCOS
  FSTP   dword [ebp]
; RotY\_13=-Sin(RY)
  FLD    dword [esp+20]
  FSIN
  FCHS
  FSTP   dword [ebp+8]
; RotY\_31= Sin(RY)
  FLD    dword [esp+20]
  FSIN
  FSTP   dword [ebp+32]
; RotY\_33= Cos(RY)
  FLD    dword [esp+20]
  FCOS
  FSTP   dword [ebp+40]
; 
; RotZ\_33=1.0
  LEA    ebp,[esp+300]
  MOV    dword [ebp+40],1065353216
; RotZ\_44=1.0
  MOV    dword [ebp+60],1065353216
; RotZ\_11=Cos(RZ)
  FLD    dword [esp+24]
  FCOS
  FSTP   dword [ebp]
; RotZ\_12=Sin(RZ)
  FLD    dword [esp+24]
  FSIN
  FSTP   dword [ebp+4]
; RotZ\_21=-Sin(RZ)
  FLD    dword [esp+24]
  FSIN
  FCHS
  FSTP   dword [ebp+16]
; RotZ\_22=Cos(RZ)
  FLD    dword [esp+24]
  FCOS
  FSTP   dword [ebp+20]
; 
; *D3DDev\SetTransform(1,Move)
  LEA    eax,[esp+108]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+44]
; *D3DDev\MultiplyTransform(1,RotX)
  LEA    eax,[esp+172]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; *D3DDev\MultiplyTransform(1,RotY)
  LEA    eax,[esp+236]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; *D3DDev\MultiplyTransform(1,RotZ)
  LEA    eax,[esp+300]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; 
; If Subs=0
  MOV    ebx,dword [esp+100]
  CMP    ebx,0
  JNE   _EndIf58
; 
; *D3DDev\DrawPrimitiveVB(#D3DPT_TRIANGLELIST,VB,0,tmp,0)
  PUSH   dword 0
  PUSH   dword [esp+108]
  PUSH   dword 0
  PUSH   dword [esp+108]
  PUSH   dword 4
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+124]
; 
; Else
  JMP   _EndIf57
_EndIf58:
; ptr=*Obj+12
  MOV    ebx,dword [esp]
  ADD    ebx,12
  MOV    dword [esp+364],ebx
; For c=1 To Subs
  MOV    dword [esp+368],1
_For60:
  MOV    eax,dword [esp+100]
  CMP    eax,dword [esp+368]
  JL    _Next61
; 
; *D.Draw3D=ptr
  MOV    eax,dword [esp+364]
  MOV    dword [esp+372],eax
; ptr+20
  ADD    dword [esp+364],20
; *D3DDev\DrawIndexedPrimitiveVB(*D\Typ,VB,*D\StartIndex,*D\NumIndices,tmp+*D\MinIndex*2,*D\IndexCount,0)
  PUSH   dword 0
  MOV    ebp,dword [esp+376]
  PUSH   dword [ebp+16]
  MOV    ebx,dword [esp+112]
  MOV    ebp,dword [esp+380]
  MOV    edi,dword [ebp+12]
  ADD    edi,edi
  ADD    ebx,edi
  PUSH   ebx
  MOV    ebp,dword [esp+384]
  PUSH   dword [ebp+8]
  MOV    ebp,dword [esp+388]
  PUSH   dword [ebp+4]
  PUSH   dword [esp+116]
  MOV    ebp,dword [esp+396]
  PUSH   dword [ebp]
  MOV    eax,dword [esp+56]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+128]
; Next
_NextContinue61:
  INC    dword [esp+368]
  JMP   _For60
_Next61:
; EndIf
_EndIf57:
; *D3DDev\SetTransform(1,IDM.D3DXMATRIX)
  LEA    eax,[esp+32]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+36]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+44]
; EndProcedure
  XOR    eax,eax
_EndProcedure15:
  ADD    esp,376
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    28
_EndProcedure14:
; 





; ProcedureDLL S3DR_FreeMesh(*Object.Mesh)
align8
_Procedure16:
PB_S3DR_FreeMesh:
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
_ClearLoop16:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop16                                                                                                                
  MOV    eax, dword [esi+24]
  MOV    dword [esp+0],eax
; *VB.IDirect3DVertexBuffer7=*Object\vb
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp]
  MOV    dword [esp+4],eax
; tmp=*Object\tmp
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp+8]
  MOV    dword [esp+8],eax
; *VB\Release()
  MOV    eax,dword [esp+4]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+8]
; If *Object\Subs>0:GlobalFree_(tmp):EndIf
  MOV    ebp,dword [esp]
  MOV    ebx,dword [ebp+4]
  CMP    ebx,0
  JLE   _EndIf63
  PUSH   dword [esp+8]
  CALL  _GlobalFree@4
_EndIf63:
; GlobalFree_(*Object)
  PUSH   dword [esp]
  CALL  _GlobalFree@4
; EndProcedure
  XOR    eax,eax
_EndProcedure17:
  ADD    esp,12
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    4
_EndProcedure16:
; 






































align8
PB_S3DR_DrawMesh2:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,452
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,452
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
; *D3DDev.IDirect3DDevice7=S3DR_GetD3DDevice()
  MOV Eax,[_PB_Direct3D_Device]
  MOV    dword [esp+40],eax
; 
; *D3DDev\GetTransform(1,IDM.D3DXMATRIX)
  LEA    eax,[esp+44]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+48]
; 
; vb=*OBJ\vb ;PeekL(Object)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp]
  MOV    dword [esp+108],eax
; Subs=*OBJ\Subs ;PeekL(Object+4)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp+4]
  MOV    dword [esp+112],eax
; tmp=*OBJ\Tmp ;PeekL(Object+8)
  MOV    ebp,dword [esp]
  MOV    eax,dword [ebp+8]
  MOV    dword [esp+116],eax
; 
; 
; Scale.D3DXMATRIX
  LEA    eax,[esp+120]
; Move.D3DXMATRIX
  LEA    eax,[esp+184]
; RotX.D3DXMATRIX
  LEA    eax,[esp+248]
; RotY.D3DXMATRIX
  LEA    eax,[esp+312]
; RotZ.D3DXMATRIX
  LEA    eax,[esp+376]
; Move\_11=1.0 
  LEA    ebp,[esp+184]
  MOV    dword [ebp],1065353216
; Move\_44=1.0 
  MOV    dword [ebp+60],1065353216
; Move\_22=1.0
  MOV    dword [ebp+20],1065353216
; Move\_33=1.0
  MOV    dword [ebp+40],1065353216
; Move\_41=X 
  FLD    dword [esp+4]
  FSTP   dword [ebp+48]
; Move\_42=Y 
  FLD    dword [esp+8]
  FSTP   dword [ebp+52]
; Move\_43=Z 
  FLD    dword [esp+12]
  FSTP   dword [ebp+56]
; 
; RotX\_11=1.0
  LEA    ebp,[esp+248]
  MOV    dword [ebp],1065353216
; RotX\_44=1.0
  MOV    dword [ebp+60],1065353216
; RotX\_22= Cos(RX)
  FLD    dword [esp+16]
  FCOS
  FSTP   dword [ebp+20]
; RotX\_23= Sin(RX)
  FLD    dword [esp+16]
  FSIN
  FSTP   dword [ebp+24]
; RotX\_32=-Sin(RX)
  FLD    dword [esp+16]
  FSIN
  FCHS
  FSTP   dword [ebp+36]
; RotX\_33= Cos(RX)
  FLD    dword [esp+16]
  FCOS
  FSTP   dword [ebp+40]
; 
; RotY\_22=1.0 
  LEA    ebp,[esp+312]
  MOV    dword [ebp+20],1065353216
; RotY\_44=1.0 
  MOV    dword [ebp+60],1065353216
; RotY\_11= Cos(RY)
  FLD    dword [esp+20]
  FCOS
  FSTP   dword [ebp]
; RotY\_13=-Sin(RY)
  FLD    dword [esp+20]
  FSIN
  FCHS
  FSTP   dword [ebp+8]
; RotY\_31= Sin(RY)
  FLD    dword [esp+20]
  FSIN
  FSTP   dword [ebp+32]
; RotY\_33= Cos(RY)
  FLD    dword [esp+20]
  FCOS
  FSTP   dword [ebp+40]
; 
; RotZ\_33=1.0
  LEA    ebp,[esp+376]
  MOV    dword [ebp+40],1065353216
; RotZ\_44=1.0
  MOV    dword [ebp+60],1065353216
; RotZ\_11=Cos(RZ)
  FLD    dword [esp+24]
  FCOS
  FSTP   dword [ebp]
; RotZ\_12=Sin(RZ)
  FLD    dword [esp+24]
  FSIN
  FSTP   dword [ebp+4]
; RotZ\_21=-Sin(RZ)
  FLD    dword [esp+24]
  FSIN
  FCHS
  FSTP   dword [ebp+16]
; RotZ\_22=Cos(RZ)
  FLD    dword [esp+24]
  FCOS
  FSTP   dword [ebp+20]
; 
; Scale\_11=ScaleX
  FLD    dword [esp+32]
  LEA    ebp,[esp+120]
  FSTP   dword [ebp]
; Scale\_22=ScaleY
  FLD    dword [esp+28]
  FSTP   dword [ebp+20]
; Scale\_33=ScaleZ
  FLD    dword [esp+36]
  FSTP   dword [ebp+40]
; Scale\_44=1
  MOV    dword [ebp+60],1065353216
; 
; *D3DDev\SetTransform(1,Scale)
  LEA    eax,[esp+120]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+44]
; *D3DDev\MultiplyTransform(1,Move)
  LEA    eax,[esp+184]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; *D3DDev\MultiplyTransform(1,RotX)
  LEA    eax,[esp+248]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; *D3DDev\MultiplyTransform(1,RotY)
  LEA    eax,[esp+312]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; *D3DDev\MultiplyTransform(1,RotZ)
  LEA    eax,[esp+376]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+56]
; 
; 
; If Subs=0
  MOV    ebx,dword [esp+112]
  CMP    ebx,0
  JNE   _EndIf2
; 
; *D3DDev\DrawPrimitiveVB(#D3DPT_TRIANGLELIST,VB,0,tmp,0)
  PUSH   dword 0
  PUSH   dword [esp+120]
  PUSH   dword 0
  PUSH   dword [esp+120]
  PUSH   dword 4
  MOV    eax,dword [esp+60]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+124]
; 
; Else
  JMP   _EndIf1
_EndIf2:
; ptr=*Obj+12
  MOV    ebx,dword [esp]
  ADD    ebx,12
  MOV    dword [esp+440],ebx
; For c=1 To Subs
  MOV    dword [esp+444],1
_For4:
  MOV    eax,dword [esp+112]
  CMP    eax,dword [esp+444]
  JL    _Next5
; 
; *D.Draw3D=ptr
  MOV    eax,dword [esp+440]
  MOV    dword [esp+448],eax
; ptr+20
  ADD    dword [esp+440],20
; *D3DDev\DrawIndexedPrimitiveVB(*D\Typ,VB,*D\StartIndex,*D\NumIndices,tmp+*D\MinIndex*2,*D\IndexCount,0)
  PUSH   dword 0
  MOV    ebp,dword [esp+452]
  PUSH   dword [ebp+16]
  MOV    ebx,dword [esp+124]
  MOV    ebp,dword [esp+456]
  MOV    edi,dword [ebp+12]
  ADD    edi,edi
  ADD    ebx,edi
  PUSH   ebx
  MOV    ebp,dword [esp+460]
  PUSH   dword [ebp+8]
  MOV    ebp,dword [esp+464]
  PUSH   dword [ebp+4]
  PUSH   dword [esp+128]
  MOV    ebp,dword [esp+472]
  PUSH   dword [ebp]
  MOV    eax,dword [esp+68]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+128]
; Next
_NextContinue5:
  INC    dword [esp+444]
  JMP   _For4
_Next5:
; EndIf
_EndIf1:
; *D3DDev\SetTransform(1,IDM.D3DXMATRIX)
  LEA    eax,[esp+44]
  PUSH   eax
  PUSH   dword 1
  MOV    eax,dword [esp+48]
  PUSH   eax
  MOV    eax, [eax]
  CALL   dword [eax+44]
; EndProcedure
  XOR    eax,eax
_EndProcedure1:
  ADD    esp,452
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    40
