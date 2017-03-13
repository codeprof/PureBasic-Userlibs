format MS COFF

public PB_RGBColor
public PB_GetMonitorFreq
public PB_GetScreenWidth
public PB_GetScreenHeight
public PB_IsWindowedMode

extrn _PB_DDrawBase
extrn _PB_DirectX_ScreenWidth
extrn _PB_DirectX_ScreenHeight
extrn _PB_DirectX_WindowedMode

extrn _EnumDisplaySettingsA@12

section '.text' code readable executable

PB_IsWindowedMode:
MOV Eax,[_PB_DirectX_WindowedMode]
RET

PB_GetScreenWidth:
MOV Eax,[_PB_DirectX_ScreenWidth]
RET

PB_GetScreenHeight:
MOV Eax,[_PB_DirectX_ScreenHeight]
RET

PB_GetMonitorFreq:
MOV Eax,[_PB_DDrawBase]
OR Eax,Eax
JE GetMonitorFreq_UseAPI
Push dword MonitorFreq
Push Eax
MOV Eax,[Eax]
Call dword[Eax+60]
MOV Eax,[MonitorFreq]
OR Eax,Eax
JNE GetMonitorFreqOK
GetMonitorFreq_UseAPI:
push dmDeviceName
push -1
push 0
Call _EnumDisplaySettingsA@12
MOV Eax,[dmDisplayFrequency]
GetMonitorFreqOK:
RET

;R      G      B
;ESP+4  ESP+8  ESP+12
PB_RGBColor:
CMP Eax,2;RGB15
JNE Weiter
SHR dword[ESP+4] ,3
SHR dword[ESP+8] ,3
SHR dword[ESP+12],3
MOV Eax,[ESP+4]
SHL Eax,10
MOV Edx,[ESP+8]
SHL Edx,5
ADD Eax,Edx
ADD Eax,[ESP+12]
JMP RGBColorEnde
Weiter:

CMP Eax,3;RGB16
JNE Weiter2
SHR dword[ESP+4] ,3
SHR dword[ESP+8] ,2
SHR dword[ESP+12],3
MOV Eax,[ESP+4]
SHL Eax,11
MOV Edx,[ESP+8]
SHL Edx,5
ADD Eax,Edx
ADD Eax,[ESP+12]
JMP RGBColorEnde
Weiter2:

CMP Eax,4;RGB24
JNE Weiter3
MOV Eax,[ESP+12]
SHL Eax,16
MOV Edx,[ESP+8]
SHL Edx,8
ADD Eax,Edx
ADD Eax,[ESP+4]
JMP RGBColorEnde
Weiter3:

CMP Eax,5;BGR24
JNE Weiter4
MOV Eax,[ESP+4]
SHL Eax,16
MOV Edx,[ESP+8]
SHL Edx,8
ADD Eax,Edx
ADD Eax,[ESP+12]
JMP RGBColorEnde
Weiter4:

CMP Eax,6;RGB32
JNE Weiter5
MOV Eax,[ESP+12]
SHL Eax,16
MOV Edx,[ESP+8]
SHL Edx,8
ADD Eax,Edx
ADD Eax,[ESP+4]
JMP RGBColorEnde
Weiter5:

;BGR32
MOV Eax,[ESP+4]
SHL Eax,16
MOV Edx,[ESP+8]
SHL Edx,8
ADD Eax,Edx
ADD Eax,[ESP+12]

RGBColorEnde:
RET 12



section '.data' readable writeable
MonitorFreq:
DD 0

dmDeviceName:
DQ 0
DQ 0
DQ 0
DQ 0     
dmSpecVersion:
DW 0    
dmDriverVersion:
DW 0
dmSize:
DW 0
dmDriverExtra:
DW 0
dmFields:
DD 0    
dmOrientation:
DW 0
dmPaperSize:
DW 0    
dmPaperLength:
DW 0
dmPaperWidth:
DW 0
dmScale:
DW 0
dmCopies:
DW 0
dmDefaultSource:
DW 0
dmPrintQuality:
DW 0
dmColor:
DW 0
dmDuplex:
DW 0
dmYResolution:
DW 0
dmTTOption:
DW 0
dmCollate:
DW 0
dmFormName:
DQ 0
DQ 0
DQ 0
DQ 0
dmLogPixels:
DW 0
dmBitsPerPel:
DD 0
dmPelsWidth:
DD 0
dmPelsHeight:
DD 0
dmDisplayFlags:
DD 0
dmDisplayFrequency:
DD 0
dmICMMethod:
DD 0
dmICMIntent:
DD 0
dmMediaType:
DD 0
dmDitherType:
DD 0
dmReserved1:
DD 0
dmReserved2:
DD 0


VersionInfo:
DB "SpriteEx v1.10",0