format MS COFF




public PB_S3DR_TestCollision


macro align8 { rb 7-($-CodeSegment+7)mod 8}



section '.text' code readable executable
CodeSegment:








;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------

; Procedure.f MinF(A.f,B.f,C.f,D.f)
align8
_Procedure0:
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
; Result.f=A
  FLD    dword [esp]
  FSTP   dword [esp+16]
; If B<Result:Result=B:EndIf
  FLD    dword [esp+4]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JNE   _EndIf2
  FLD    dword [esp+4]
  FSTP   dword [esp+16]
_EndIf2:
; If C<Result:Result=C:EndIf
  FLD    dword [esp+8]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JNE   _EndIf4
  FLD    dword [esp+8]
  FSTP   dword [esp+16]
_EndIf4:
; If D<Result:Result=D:EndIf
  FLD    dword [esp+12]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JNE   _EndIf6
  FLD    dword [esp+12]
  FSTP   dword [esp+16]
_EndIf6:
; ProcedureReturn Result.f
  FLD    dword [esp+16]
  JMP   _EndProcedure1
; EndProcedure
  XOR    eax,eax
_EndProcedure1:
  ADD    esp,20
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    16
; 
; Procedure.f MaxF(A.f,B.f,C.f,D.f)
  JMP   _EndProcedure2
_Procedure2:
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
  MOV    eax, dword [esi+36]
  MOV    dword [esp+12],eax
; Result.f=A
  FLD    dword [esp]
  FSTP   dword [esp+16]
; If B>Result:Result=B:EndIf
  FLD    dword [esp+4]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JE    _EndIf8
  FLD    dword [esp+4]
  FSTP   dword [esp+16]
_EndIf8:
; If C>Result:Result=C:EndIf
  FLD    dword [esp+8]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JE    _EndIf10
  FLD    dword [esp+8]
  FSTP   dword [esp+16]
_EndIf10:
; If D>Result:Result=D:EndIf
  FLD    dword [esp+12]
  FLD    dword [esp+16]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JE    _EndIf12
  FLD    dword [esp+12]
  FSTP   dword [esp+16]
_EndIf12:
; ProcedureReturn Result.f
  FLD    dword [esp+16]
  JMP   _EndProcedure3
; EndProcedure
  XOR    eax,eax
_EndProcedure3:
  ADD    esp,20
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    16
_EndProcedure2:
; 
; 
;Check for Box-Collision.
; Procedure TestCollision(O1X1.f,O1Y1.f,O1Z1.f,O1X2.f,O1Y2.f,O1Z2.f,O1X3.f,O1Y3.f,O1Z3.f,O1X4.f,O1Y4,O1Z4.f,O2X1.f,O2Y1.f,O2Z1.f,O2X2.f,O2Y2.f,O2Z2.f,O2X3.f,O2Y3.f,O2Z3.f,O2X4.f,O2Y4,O2Z4.f)
align8
PB_S3DR_TestCollision:
_Procedure4:
  PUSH   ebx
  PUSH   ecx
  PUSH   ebp
  PUSH   esi
  PUSH   edi
         MOV esi,esp
  SUB    esp,144
  MOV    eax,esp
  MOV    edx,eax
  ADD    edx,144
_ClearLoop4:
  MOV    dword [eax],0
  ADD    eax,4
  CMP    eax,edx
  JNE   _ClearLoop4                                                                                                                
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
  MOV    eax, dword [esi+72]
  MOV    dword [esp+48],eax
  MOV    eax, dword [esi+76]
  MOV    dword [esp+52],eax
  MOV    eax, dword [esi+80]
  MOV    dword [esp+56],eax
  MOV    eax, dword [esi+84]
  MOV    dword [esp+60],eax
  MOV    eax, dword [esi+88]
  MOV    dword [esp+64],eax
  MOV    eax, dword [esi+92]
  MOV    dword [esp+68],eax
  MOV    eax, dword [esi+96]
  MOV    dword [esp+72],eax
  MOV    eax, dword [esi+100]
  MOV    dword [esp+76],eax
  MOV    eax, dword [esi+104]
  MOV    dword [esp+80],eax
  MOV    eax, dword [esi+108]
  MOV    dword [esp+84],eax
  MOV    eax, dword [esi+112]
  MOV    dword [esp+88],eax
  MOV    eax, dword [esi+116]
  MOV    dword [esp+92],eax
; 
; O1MaxX.f=MaxF(O1X1,O1X2,O1X3,O1X4)
  PUSH   dword [esp+36]
  PUSH   dword [esp+28]
  PUSH   dword [esp+20]
  PUSH   dword [esp+12]
  CALL  _Procedure2
  FSTP   dword [esp+96]
; O1MinX.f=MinF(O1X1,O1X2,O1X3,O1X4)
  PUSH   dword [esp+36]
  PUSH   dword [esp+28]
  PUSH   dword [esp+20]
  PUSH   dword [esp+12]
  CALL  _Procedure0
  FSTP   dword [esp+100]
; 
; O1MaxY.f=MaxF(O1Y1,O1Y2,O1Y3,O1Y4)
  PUSH   dword [esp+40]
  FILD   dword [esp]
  FSTP   dword [esp]
  PUSH   dword [esp+32]
  PUSH   dword [esp+24]
  PUSH   dword [esp+16]
  CALL  _Procedure2
  FSTP   dword [esp+104]
; O1MinY.f=MinF(O1Y1,O1Y2,O1Y3,O1Y4)
  PUSH   dword [esp+40]
  FILD   dword [esp]
  FSTP   dword [esp]
  PUSH   dword [esp+32]
  PUSH   dword [esp+24]
  PUSH   dword [esp+16]
  CALL  _Procedure0
  FSTP   dword [esp+108]
; 
; O1MaxZ.f=MaxF(O1Z1,O1Z2,O1Z3,O1Z4)
  PUSH   dword [esp+44]
  PUSH   dword [esp+36]
  PUSH   dword [esp+28]
  PUSH   dword [esp+20]
  CALL  _Procedure2
  FSTP   dword [esp+112]
; O1MinZ.f=MinF(O1Z1,O1Z2,O1Z3,O1Z4)
  PUSH   dword [esp+44]
  PUSH   dword [esp+36]
  PUSH   dword [esp+28]
  PUSH   dword [esp+20]
  CALL  _Procedure0
  FSTP   dword [esp+116]
; 
; O2MaxX.f=MaxF(O2X1,O2X2,O2X3,O2X4)
  PUSH   dword [esp+84]
  PUSH   dword [esp+76]
  PUSH   dword [esp+68]
  PUSH   dword [esp+60]
  CALL  _Procedure2
  FSTP   dword [esp+120]
; O2MinX.f=MinF(O2X1,O2X2,O2X3,O2X4)
  PUSH   dword [esp+84]
  PUSH   dword [esp+76]
  PUSH   dword [esp+68]
  PUSH   dword [esp+60]
  CALL  _Procedure0
  FSTP   dword [esp+124]
; 
; O2MaxY.f=MaxF(O2Y1,O2Y2,O2Y3,O2Y4)
  PUSH   dword [esp+88]
  FILD   dword [esp]
  FSTP   dword [esp]
  PUSH   dword [esp+80]
  PUSH   dword [esp+72]
  PUSH   dword [esp+64]
  CALL  _Procedure2
  FSTP   dword [esp+128]
; O2MinY.f=MinF(O2Y1,O2Y2,O2Y3,O2Y4)
  PUSH   dword [esp+88]
  FILD   dword [esp]
  FSTP   dword [esp]
  PUSH   dword [esp+80]
  PUSH   dword [esp+72]
  PUSH   dword [esp+64]
  CALL  _Procedure0
  FSTP   dword [esp+132]
; 
; O2MaxZ.f=MaxF(O2Z1,O2Z2,O2Z3,O2Z4)
  PUSH   dword [esp+92]
  PUSH   dword [esp+84]
  PUSH   dword [esp+76]
  PUSH   dword [esp+68]
  CALL  _Procedure2
  FSTP   dword [esp+136]
; O2MinZ.f=MinF(O2Z1,O2Z2,O2Z3,O2Z4)
  PUSH   dword [esp+92]
  PUSH   dword [esp+84]
  PUSH   dword [esp+76]
  PUSH   dword [esp+68]
  CALL  _Procedure0
  FSTP   dword [esp+140]
; 
; If O1MaxX=>O2MinX  And O1MinX<=O2MaxX 
  FLD    dword [esp+96]
  FLD    dword [esp+124]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JE    _AO_No0
  FLD    dword [esp+100]
  FLD    dword [esp+120]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JNE   _AO_No0
_AO_Ok0:
  MOV    eax,1
  JMP   _AO0
_AO_No0:
  XOR    eax,eax
_AO0:
  And    eax,eax
  JE    _EndIf14
; If O1MaxY=>O2MinY  And O1MinY<=O2MaxY 
  FLD    dword [esp+104]
  FLD    dword [esp+132]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JE    _AO_No1
  FLD    dword [esp+108]
  FLD    dword [esp+128]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JNE   _AO_No1
_AO_Ok1:
  MOV    eax,1
  JMP   _AO1
_AO_No1:
  XOR    eax,eax
_AO1:
  And    eax,eax
  JE    _EndIf16
; If O1MaxZ=>O2MinZ  And O1MinZ<=O2MaxZ
  FLD    dword [esp+112]
  FLD    dword [esp+140]
  FCOMPP
  FNSTSW ax
  TEST   ah,41h
  JE    _AO_No2
  FLD    dword [esp+116]
  FLD    dword [esp+136]
  FCOMPP
  FNSTSW ax
  TEST   ah,1h
  JNE   _AO_No2
_AO_Ok2:
  MOV    eax,1
  JMP   _AO2
_AO_No2:
  XOR    eax,eax
_AO2:
  And    eax,eax
  JE    _EndIf18
; ProcedureReturn 1 
  MOV    eax,1
  JMP   _EndProcedure5
; EndIf
_EndIf18:
; EndIf
_EndIf16:
; EndIf
_EndIf14:
; 
; ProcedureReturn 0
  MOV    eax,0
  JMP   _EndProcedure5
; EndProcedure
  XOR    eax,eax
_EndProcedure5:
  ADD    esp,144
  POP    edi
  POP    esi
  POP    ebp
  POP    ecx
  POP    ebx
  RET    96
_EndProcedure4:
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------
;--------------------------------------------------------------------





