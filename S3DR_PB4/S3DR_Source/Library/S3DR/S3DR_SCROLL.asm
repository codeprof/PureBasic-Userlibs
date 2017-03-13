format MS COFF

extrn _PB_Direct3D_Device
public PB_S3DR_ScrollTexture

macro align8 { rb 7-($-CodeSegment+7)mod 8}



section '.text' code readable executable
CodeSegment:

PB_S3DR_ScrollTexture:
MOV Eax,[Esp+4]
OR Eax,Eax
JNZ ScrollTexture
MOV Eax,[Esp+8]
OR Eax,Eax
JNZ ScrollTexture
Push 0
Push 24 
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+148];SetTextureStageState
RET 8

ScrollTexture:
Push 3
Push 24 
Push 0
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+148];SetTextureStageState
OR Eax,Eax
JNZ ReturnError

MOV EAX,[Esp+4]
MOV [_31],EAX
MOV EAX,[Esp+8]
MOV [_32],EAX

PUSH _11
PUSH 16
MOV Eax,[_PB_Direct3D_Device]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+44];SetTransfrom
ReturnError:
RET 8



section '.data' readable writeable
_11:
DD  1065353216 ;1.0
_12:
DD 0 
_13:
DD 0
_14:
DD 0
_21:
DD 0 
_22:
DD  1065353216 ;1.0
_23:
DD 0
_24:
DD 0
_31:
DD 0
_32:
DD 0
_33:
DD  1065353216 ;1.0
_34:
DD 0
_41:
DD 0
_42:
DD 0
_43:
DD 0 
_44:
DD  1065353216 ;1.0