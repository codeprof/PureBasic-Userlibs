format MS COFF

public PB_GetGFXCard
public PB_GetGFXDriver
public PB_GetSpriteExVersion

extrn _PB_DDrawBase
extrn PB_StringBase
extrn SYS_CopyString

section '.text' code readable executable

PB_GetGFXCard:
CMP dword[DevIdentifier_Flag],0
JNE GetGFXCard_Direct
Push 1
Push DevIdentifier
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+108];extrem langsam
MOV dword[DevIdentifier_Flag],1
MOV Edx,DevIdentifier+512
PUSH dword [PB_StringBase]
CALL SYS_CopyString
POP Eax
RET
GetGFXCard_Direct:
MOV Edx,DevIdentifier+512
PUSH dword [PB_StringBase]
CALL SYS_CopyString
POP Eax
RET


PB_GetGFXDriver:
CMP dword[DevIdentifier_Flag],0
JNE GetGFXDriver_Direct
Push 1
Push DevIdentifier
MOV Eax,[_PB_DDrawBase]
Push Eax
MOV Eax,[Eax]
Call dword[Eax+108];extrem langsam
MOV dword[DevIdentifier_Flag],1
MOV Edx,DevIdentifier
PUSH dword [PB_StringBase]
CALL SYS_CopyString
POP Eax
MOV dword [PB_StringBase],Eax
RET
GetGFXDriver_Direct:
MOV Edx,DevIdentifier
PUSH dword [PB_StringBase]
CALL SYS_CopyString
POP Eax
RET

PB_GetSpriteExVersion:
MOV Edx,VersionInfo
PUSH dword [PB_StringBase]
CALL SYS_CopyString
POP Eax
RET

section '.data' readable writeable

DevIdentifier_Flag:
DD 0
DevIdentifier:
RB 1068

VersionInfo:
DB "SpriteEx v1.10",0
