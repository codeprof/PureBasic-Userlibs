

Structure D3DVERTEXBUFFER_DESC
  format.l
  FVF.l
  Pool.l
  size.l
  type.l
  Usage.l
EndStructure

Interface D3DXMesh Extends IUnknown
  DrawSubset(a)
  GetNumFaces()
  GetNumVertices()
  GetFVF()
  GetDeclaration(a)
  GetOptions()
  GetDevice(a)
  CloneMeshFVF(a,b,c,d)
  CloneMesh(a,b,c,d)
  GetVertexBuffer(a)
  GetIndexBuffer(a)
  LockVertexBuffer(a,b)
  UnlockVertexBuffer()
  LockIndexBuffer(a,b)
  UnlockIndexBuffer()
  GetAttributeTable(a,b)
  ConvertPointRepsToAdjacency(a,b)
  ConvertAdjacencyToPointReps(a,b)
  GenerateAdjacency(a,b)
  LockAttributeBuffer(a,b)
  UnlockAttributeBuffer()
  Optimize(a,b,c,d,e,f)
  OptimizeInplace(a,b,c,d,e)
EndInterface

Interface Direct3DVertexBuffer8 Extends IUnknown
  GetDevice(a)
  SetPrivateData(a,b,c,d)
  GetPrivateData(a,b,c)
  FreePrivateData(a)
  SetPriority(a)
  GetPriority()
  PreLoad()
  GetType()
  Lock(a,b,c,d)
  Unlock()
  GetDesc(a)
EndInterface

Interface Direct3DIndexBuffer8 Extends IUnknown
  GetDevice(a)
  SetPrivateData(a,b,c,d)
  GetPrivateData(a,b,c)
  FreePrivateData(a)
  SetPriority(a)
  GetPriority()
  PreLoad()
  GetType()
  Lock(a,b,c,d)
  Unlock()
  GetDesc(a)
EndInterface


;Global GrabOk
;Global VBList
;Dim VBList(1000)

Global exSubs
Global VerticesCount
Global IndicesCount

Procedure Write_DrawPrimitive(a,b,c,d)
  MessageRequester("SORRY","SORRY this is not supported yet.",#MB_ICONEXCLAMATION)
EndProcedure


Procedure Count_DrawIndexedPrimitive(Obj,Typ,MinIndex,NumIndices,StartIndex,IndexCount)
  
  exSubs+1
  ;Debug StartIndex
  ;Debug MinIndex
  ;Debug NumIndices
  ;Debug IndexCount
  
  If IndexCount+StartIndex>VerticesCount:VerticesCount=IndexCount+StartIndex:EndIf
  If MinIndex+NumIndices>IndicesCount:IndicesCount=MinIndex+NumIndices:EndIf

  ;VerticesCount+IndexCount
  ;IndicesCount+NumIndices
  
EndProcedure

Procedure Write_DrawIndexedPrimitive(Obj,Typ,MinIndex,NumIndices,StartIndex,IndexCount)
  WriteLong(Typ)
  WriteLong(StartIndex)
  WriteLong(NumIndices)
  WriteLong(MinIndex)
  WriteLong(IndexCount)
  
EndProcedure

;Procedure _SetStreamSource(Obj,Nr,*VB.Direct3DVertexBuffer8,Stride)

;GrabOk=1
;For c=0 To VBList
;If VBList(c)=*VB:GrabOk=0:ProcedureReturn 0:EndIf
;Next
;VBList(VBList)=*VB
;VBList+1

;Debug "set"

;*VB\GetDesc(DESC.D3DVERTEXBUFFER_DESC)
;Debug DESC\size
;mem=AllocateMemory(DESC\size)
;*VB\Lock(0,s,mem,16)
;WriteData(mem,DESC\Size)
;*VB\UnLock()
;FreeMemory(mem)
;EndProcedure







;Author: dige
Procedure StringToUnicode(pbstrptr.l,ucstrptr.l)    ; ANSI Strings nach Unicode codieren 
  MultiByteToWideChar_(#CP_ACP,0,pbstrptr,Len(PeekS(pbstrptr)),ucstrptr,Len(PeekS(ucstrptr))) 
  PokeL (ucstrptr+Len(PeekS(pbstrptr))*2,0) 
EndProcedure 


Structure D3DXMATRIX 
  _11.f 
  _12.f 
  _13.f 
  _14.f 
  _21.f 
  _22.f 
  _23.f 
  _24.f 
  _31.f 
  _32.f 
  _33.f 
  _34.f 
  _41.f 
  _42.f 
  _43.f 
  _44.f 
EndStructure

Procedure MoveMatrix(*Matrix.D3DXMATRIX,X.f,Y.f,Z.f) 
  *Matrix\_41=X 
  *Matrix\_42=Y 
  *Matrix\_43=Z 
EndProcedure 

Procedure RotateMatrixX(*Matrix.D3DXMATRIX,Grad.f) 
  *Matrix\_11=1.0 
  *Matrix\_44=1.0 
  *Matrix\_12=0.0 
  *Matrix\_13=0.0 
  *Matrix\_14=0.0 
  *Matrix\_41=0.0 
  *Matrix\_21=0.0 
  *Matrix\_24=0.0 
  *Matrix\_42=0.0 
  *Matrix\_31=0.0 
  *Matrix\_34=0.0 
  *Matrix\_43=0.0 
  Rad.f=Grad/PI*2 
  *Matrix\_22= Cos(Rad) 
  *Matrix\_23= Sin(Rad) 
  *Matrix\_32=-Sin(Rad) 
  *Matrix\_33= Cos(Rad) 
EndProcedure 

Procedure RotateMatrixY(*Matrix.D3DXMATRIX,Grad.f) 
  *Matrix\_22=1.0 
  *Matrix\_44=1.0 
  *Matrix\_12=0.0 
  *Matrix\_14=0.0 
  *Matrix\_41=0.0 
  *Matrix\_21=0.0 
  *Matrix\_23=0.0 
  *Matrix\_24=0.0 
  *Matrix\_42=0.0 
  *Matrix\_32=0.0 
  *Matrix\_34=0.0 
  *Matrix\_43=0.0 
  Rad.f=Grad/PI*2 
  *Matrix\_11= Cos(Rad) 
  *Matrix\_13=-Sin(Rad) 
  *Matrix\_31= Sin(Rad) 
  *Matrix\_33= Cos(Rad) 
EndProcedure 

Interface D3DX8 Extends IUnknown
  CreateFont(a,b,c)
  DrawText(a,b,c,d,e)
  GetFVFVertexSize(a,b)
  AssembleShaderFromFile(a,b,c,d,e)
  AssembleShader(a,b,c,d,e)
  GetErrorString(a,b)
  LoadSurfaceFromFile(a,b,c,d,e,f,g,h)
  LoadSurfaceFromFileInMemory(a,b,c,d,e,f,g,h,i)
  LoadSurfaceFromSurface(a,b,c,d,e,f,g,h)
  LoadSurfaceFromMemory(a,b,c,d,e,f,g,h,i,j)
  CheckTextureRequirements(a,b,c,d,e,f,g)
  CreateTexture(a,b,c,d,e,f,g,h)
  CreateTextureFromResource(a,b,c,d)
  CreateTextureFromFile(a,b,c)
  CreateTextureFromFileEx(a,b,c,d,e,f,g,h,i,j,k,l,m,n)
  CreateTextureFromFileInMemory(a,b,c,d)
  CreateTextureFromFileInMemoryEx(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o)
  FilterTexture(a,b,c,d)
  CheckCubeTextureRequirements(a,b,c,d,e,f)
  CreateCubeTexture(a,b,c,d,e,f,g)
  CreateCubeTextureFromFile(a,b,c)
  CreateCubeTextureFromFileEx(a,b,c,d,e,f,g,h,i,j,k,l,m)
  CreateCubeTextureFromFileInMemory(a,b,c,d)
  CreateCubeTextureFromFileInMemoryEx(a,b,c,d,e,f,g,h,i,j,k,l,m,n)
  FilterCubeTexture(a,b,c,d)
  CheckVolumeTextureRequirements(a,b,c,d,e,f,g,h)
  CreateTextureFromResourceEx(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o)
  CreateVolumeTexture(a,b,c,d,e,f,g,h,i)
  FilterVolumeTexture(a,b,c,d)
  LoadSurfaceFromResource(a,b,c,d,e,f,g,h,i)
  LoadVolumeFromVolume(a,b,c,d,e,f,g,h)
  LoadVolumeFromMemory(a,b,c,d,e,f,g,h,i,j,k)
  CreateMesh(a,b,c,d,e,f)
  CreateMeshFVF(a,b,c,d,e,f)
  CreateSPMesh(a,b,c,d,e)
  GeneratePMesh(a,b,c,d,e,f,g)
  SimplifyMesh(a,b,c,d,e,f,g)
  ComputeBoundingSphere(a,b,c,d,e)
  ComputeBoundingBox(a,b,c,d,e)
  ComputeNormals(a)
  DeclaratorFromFVF(a,b)
  FVFFromDeclarator(a,b)
  CreateBuffer(a,b)
  LoadMeshFromX(a,b,c,d,e,f,g)
  SaveMeshToX(a,b,c,d,e,f)
  LoadMeshFromXof(a,b,c,d,e,f,g)
  TessellateNPatches(a,b,c,d,e,f)
  BufferGetMaterial(a,b,c)
  BufferGetTextureName(a,b,c)
  BufferGetData(a,b,c,d,e)
  BufferSetData(a,b,c,d,e)
  Intersect(a,b,c,d,e,f,g,h,i,j)
  SphereBoundProbe(a,b,c,d,e)
  ComputeBoundingSphereFromMesh(a,b,c)
  ComputeBoundingBoxFromMesh(a,b,c)
  CreateSkinMesh(a,b,c,d,e,f,g)
  CreateSkinMeshFVF(a,b,c,d,e,f,g)
  CreateSkinMeshFromMesh(a,b,c)
  LoadSkinMeshFromXof(a,b,c,d,e,f,g,h,i)
  CreatePolygon(a,b,c,d,e)
  CreateBox(a,b,c,d,e,f)
  CreateCylinder(a,b,c,d,e,f,g,h)
  CreateSphere(a,b,c,d,e,f)
  CreateTorus(a,b,c,d,e,f,g)
  CreateTeapot(a,b,c)
  CreateText(a,b,c,d,e,f,g,h)
  BufferGetBoneName(a,b,c)
  CreateSprite(a,b)
  CreateRenderToSurface(a,b,c,d,e,f,g)
  CleanMesh(a,b,c,d,e)
  ValidMesh(a,b,c,d)
  BoxBoundProbe(a,b,c,d,e)
  SavePMeshToFile(a,b,c,d)
  LoadPMeshFromFile(a,b,c,d,e,f)
  BufferGetBoneCombo(a,b,c)
  BufferGetBoneComboBoneIds(a,b,c,d)
  SaveSurfaceToFile(a,b,c,d,e)
  SaveVolumeToFile(a,b,c,d,e)
  SaveTextureToFile(a,b,c,d)
EndInterface



Interface IDirectX8 Extends IUnknown
  DirectSoundCreate(a,b)
  DirectSoundCaptureCreate(a,b)
  GetDSEnum(a)
  GetDSCaptureEnum(a)
  DirectInputCreate(a)
  DirectMusicLoaderCreate(a)
  DirectMusicComposerCreate(a)
  DirectMusicPerformanceCreate(a)
  CreateEvent(a,b)
  SetEvent(a)
  DestroyEvent(a)
  CreateNewGuid(a)
  DirectPlayVoiceClientCreate(a)
  DirectPlayVoiceServerCreate(a)
  DirectPlayVoiceTestCreate(a)
  DirectXFileCreate(a)
  DirectPlayPeerCreate(a)
  DirectPlayServerCreate(a)
  DirectPlayClientCreate(a)
  DirectPlayAddressCreate(a)
  Direct3DCreate(a)
  DirectPlayLobbyClientCreate(a)
  DirectPlayLobbiedApplicationCreate(a)
EndInterface

Interface Direct3D8 Extends IUnknown
  RegisterSoftwareDevice(a)
  GetAdapterCount()
  GetAdapterIdentifier(a,b,c)
  GetAdapterModeCount(a)
  EnumAdapterModes(a,b,c)
  GetAdapterDisplayMode(a,b)
  CheckDeviceType(a,b,c,d,e)
  CheckDeviceFormat(a,b,c,d,e,f)
  CheckDeviceMultiSampleType(a,b,c,d,e)
  CheckDepthStencilMatch(a,b,c,d,e)
  GetDeviceCaps(a,b,c)
  GetAdapterMonitor(a)
  CreateDevice(a,b,c,d,e,f)
  CreateHALDevice(a,b,c,d)
  CreateSWDevice(a,b,c,d)
  CreateREFDevice(a,b,c,d)
EndInterface

Interface Direct3DDevice8 Extends IUnknown
  TestCooperativeLevel()
  GetAvailableTextureMem(a)
  ResourceManagerDiscardBytes(a)
  GetDirect3D(a)
  GetDeviceCaps(a)
  GetDisplayMode(a)
  GetCreationParameters(a)
  SetCursorProperties(a,b,c)
  SetCursorPosition(a,b,c)
  ShowCursor(a)
  CreateAdditionalSwapChain(a,b)
  Reset(a)
  Present(a,b,c,d)
  GetBackBuffer(a,b,c)
  GetRasterStatus()
  SetGammaRamp(a,b)
  GetGammaRamp(a)
  CreateTexture(a,b,c,d,e,f,g)
  CreateVolumeTexture(a,b,c,d,e,f,g,h)
  CreateCubeTexture(a,b,c,d,e,f)
  CreateVertexBuffer(a,b,c,d,e)
  CreateIndexBuffer(a,b,c,d,e)
  CreateRenderTarget(a,b,c,d,e,f)
  CreateDepthStencilSurface(a,b,c,d,e)
  CreateImageSurface(a,b,c,d)
  CopyRects(a,b,c,d,e)
  UpdateTexture(a,b)
  GetFrontBuffer(a)
  SetRenderTarget(a,b,c)
  GetRenderTarget(a)
  GetDepthStencilSurface(a)
  BeginScene()
  EndScene()
  Clear(a,b,c,d,e,f)
  SetTransform(a,b)
  GetTransform(a,b)
  MultiplyTransform(a,b)
  SetViewport(a)
  GetViewport(a)
  SetMaterial(a)
  GetMaterial(a)
  SetLight(a,b)
  GetLight(a,b)
  LightEnable(a,b)
  GetLightEnable(a,b)
  SetClipPlane(a,b)
  GetClipPlane(a,b)
  SetRenderState(a,b)
  GetRenderState(a,b)
  BeginStateBlock()
  EndStateBlock(a)
  ApplyStateBlock(a)
  CaptureStateBlock(a)
  DeleteStateBlock(a)
  CreateStateBlock(a,b)
  SetClipStatus(a)
  GetClipStatus(a)
  GetTexture(a,b)
  SetTexture(a,b)
  GetTextureStageState(a,b,c)
  SetTextureStageState(a,b,c)
  ValidateDevice(a)
  GetInfo(a,b,c)
  SetPaletteEntries(a,b)
  GetPaletteEntries(a,b)
  SetCurrentTexturePalette(a)
  GetCurrentTexturePalette(a)
  DrawPrimitive(a,b,c)
  DrawIndexedPrimitive(a,b,c,d,e)
  DrawPrimitiveUP(a,b,c,d)
  DrawIndexedPrimitiveUP(a,b,c,d,e,f,g,h)
  ProcessVertices(a,b,c,d,e)
  CreateVertexShader(a,b,c,d)
  SetVertexShader(a)
  GetVertexShader(a)
  DeleteVertexShader(a)
  SetVertexShaderConstant(a,b,c)
  GetVertexShaderConstant(a,b,c)
  GetVertexShaderDeclaration(a,b,c)
  GetVertexShaderFunction(a,b,c)
  SetStreamSource(a,b,c)
  GetStreamSource(a,b,c)
  SetIndices(a,b)
  GetIndices(a,b)
  CreatePixelShader(a,b)
  SetPixelShader(a)
  GetPixelShader(a)
  DeletePixelShader(a)
  SetPixelShaderConstant(a,b,c)
  GetPixelShaderConstant(a,b,c)
  GetPixelShaderFunction(a,b,c)
  DrawRectPatch(a,b,c)
  DrawTriPatch(a,b,c)
  DeletePatch(a)
EndInterface

Structure D3D_TLVERTEX8 
  X.f 
  Y.f 
  Z.f 
  rhw.f
  tu.f
  tv.f
EndStructure 

Structure D3DPresent_Parameters 
  BackBufferWidth.l 
  BackBufferHeight.l 
  BackBufferFormat.l 
  BackBufferCount.l 
  MultiSampleType.l 
  SwapEffect.l 
  hDeviceWindow.l 
  Windowed.l 
  EnableAutoDepthStencil.l 
  AutoDepthStencilFormat.l 
  flags.l 
  FullScreen_RefreshRateInHz.l 
  FullScreen_PresentationInterval.l 
EndStructure 

Structure D3DDISPLAYMODE 
  Width.l 
  Height.l 
  RefreshRate.l 
  format.l 
EndStructure 


Structure D3DMATERIAL
  Diffuse.l
  Ambient.l
  Specular.l
  Emissive.l
  Power.f
EndStructure

Structure D3DXMATERIAL
  MatD3D.D3DMATERIAL
  pTextureFilename.l
EndStructure

Interface D3DXBuffer Extends IUnknown
  GetBufferPointer()
  GetBufferSize()
EndInterface

#D3DFVF_XYZRHW=4 
#D3DFVF_DIFFUSE=64
#D3DFVF_TEX0=0
#D3DFVF_TEX1=256
#D3DFVF_TEX2=512
#D3DFVF_TEX3=768
#D3DFVF_TEX4=1024
#D3DFVF_TEX5=1280
#D3DFVF_TEX6=1536
#D3DFVF_TEX7=1792 
#D3DFVF_TEX8=2048

#D3DFVF_NORMAL=16
#D3DFVF_SPECULAR=128
#D3DFVF_XYZ=2

#D3DSWAPEFFECT_FLIP=2 
#D3DSWAPEFFECT_COPY=3 
#D3DSWAPEFFECT_DISCARD=1 

#D3DCLEAR_TARGET=1 

#D3DADAPTER_DEFAULT=0 
#D3DDEVTYPE_HAL=1 
#D3DDEVTYPE_REF=2 
#D3DDEVTYPE_SW=3 

#D3DCREATE_SOFTWARE_VERTEXPROCESSING=32 
#D3DCREATE_HARDWARE_VERTEXPROCESSING=64 
#D3DCREATE_MIXED_VERTEXPROCESSING=128 

#D3DPT_POINTLIST=1 
#D3DPT_LINELIST=2 
#D3DPT_LINESTRIP=3 
#D3DPT_TRIANGLELIST=4 
#D3DPT_TRIANGLESTRIP=5 

#D3D_SDK_VERSION=220 

#D3DFMT_R5G6B5=23     ;16 Bit 
#D3DFMT_R8G8B8=20     ;24 Bit 
#D3DFMT_X8R8G8B8=22   ;32 Bit 

#D3DXMESH_32BIT=1
#D3DXMESH_DONOTCLIP=2
#D3DXMESH_POINTS=4
#D3DXMESH_RTPATCHES=8
#D3DXMESH_VB_SYSTEMMEM=16
#D3DXMESH_VB_MANAGED=32
#D3DXMESH_VB_WRITEONLY=64
#D3DXMESH_VB_DYNAMIC=128
#D3DXMESH_IB_SYSTEMMEM=256
#D3DXMESH_SYSTEMMEM=272
#D3DXMESH_IB_MANAGED=512
#D3DXMESH_MANAGED=544
#D3DXMESH_WRITEONLY=816
#D3DXMESH_IB_WRITEONLY=1024
#D3DXMESH_IB_DYNAMIC=2048
#D3DXMESH_DYNAMIC=2176
#D3DXMESH_VB_SHARE=4096
#D3DXMESH_USEHWONLY=8192
#D3DDEVCAPS_NPATCHES=16777216
    




Procedure Error()
  MessageRequester("ERROR","Sorry, There was an error."+Chr(13)+"DirectX8 is needed !",#MB_ICONEXCLAMATION)
  End
EndProcedure


DC=CreateDC_("display",0,0,0)
bpp=GetDeviceCaps_(DC,#BITSPIXEL)
If bpp<=8:MessageRequester("ERROR","16Bit/24Bit/32Bit screenmode is needed !",#MB_ICONEXCLAMATION):End:EndIf
DeleteDC_(DC)

OnErrorGosub(@Error())

flags=#PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget     
OpenWindow(1,0,0,300,80,flags,"CONV2S3DR v1.2")

;CreateStatusBar(0, WindowID())
;AddStatusBarField(300)
;StatusBarText(0,0,"This converter is really really slow !")
   

CreateGadgetList(WindowID())
TextGadget(1,0,0,100,20,"Export as:")
StringGadget(2,0,20,200,20,"")
ButtonGadget(3,200,20,100,20,"convert")
TextGadget(4,10,58,35,20,"Quality:")
TrackBarGadget(5,50,48,250,32,1,100,#TBS_BOTH|256) 
SetGadgetState(5,100)
;DisableGadget(5,1)
;DisableGadget(4,1)

File$=OpenFileRequester("Open X-File","*.x","x-files(*.x)|*.x",0)
If ReadFile(1,File$)=0
  MessageRequester("ERORR","Can't load file.")
  End
EndIf
CloseFile(1)

out$=Left(File$,FindString(File$,".",1))+"s3dr"

SetGadgetText(2,out$)


Repeat
  Event=WaitWindowEvent()
  
  If Event=#PB_Event_Gadget
    If EventGadgetID()=3
      out$=GetGadgetText(2)
      conv=-1
    EndIf
  EndIf
  
  If Event=#PB_Event_CloseWindow:End:EndIf
  
Until conv
 Quality=GetGadgetState(5)
  

filew$=Space(5000)
StringToUnicode(@File$,@filew$)
  
inst=OpenLibrary(1,"DX8VB.dll")
If inst=0
  MessageRequester("ERROR","Can't load dx8vb.dll !",#MB_ICONEXCLAMATION)
  End
EndIf

CallFunction(1,"DllRegisterServer")
CallFunction(1,"DllGetClassObject",?M1,?M2,@*object1.IUnknown)
CallFunctionFast(PeekL(PeekL(*object1)+12),*object1,0,?M3,@*DX.IDirectX8)  
  
result=*DX\Direct3DCreate(@*D3D.Direct3D8)
If result
  MessageRequester("ERROR","Can't create Direct3D8 !",#MB_ICONEXCLAMATION)
  End
EndIf 

CallFunction(1,"DllGetClassObject",?X1,?X2,@*object2)
CallFunctionFast(PeekL(PeekL(*object2)+12),*object2,0,?M3,@*D3DX.D3DX8)


*D3D\GetAdapterDisplayMode(#D3DADAPTER_DEFAULT,ScrInfo.D3DDISPLAYMODE ) 


D3DWnd.D3DPresent_Parameters\SwapEffect=#D3DSWAPEFFECT_DISCARD 
D3DWnd\BackBufferFormat=ScrInfo\format 
D3DWnd\Windowed=-1 
D3DWnd\hDeviceWindow=WindowID() 

result=*D3D\CreateDevice(#D3DADAPTER_DEFAULT,#D3DDEVTYPE_HAL,WindowID(),#D3DCREATE_SOFTWARE_VERTEXPROCESSING,D3DWnd,@*D3DDevice.Direct3DDevice8)
If result
  MessageRequester("ERROR","Can't create 3D-Device !",#MB_ICONEXCLAMATION)
  End
EndIf 

SetWindowTitle(1,"CONV2S3DR please wait...")

start=GetTickCount_()



CreateFile(1,out$)
*D3DX\LoadMeshFromX(@filew$,#D3DXMESH_IB_SYSTEMMEM|#D3DXMESH_VB_SYSTEMMEM|#D3DXMESH_SYSTEMMEM,*D3DDevice,@*Adj.D3DXBuffer,@*Buffer.D3DXBuffer,@Subs,@*OldMesh.D3DXMesh)



VS=#D3DFVF_TEX1|#D3DFVF_XYZ ;VertexShader
*OldMesh\CloneMeshFVF(#D3DXMESH_IB_SYSTEMMEM|#D3DXMESH_VB_SYSTEMMEM|#D3DXMESH_SYSTEMMEM,VS,*D3DDevice,@*Mesh.D3DXMesh)
If *Mesh=0:MessageRequester("ERROR","Can't clone Mesh !"):End:EndIf

If Quality<>100
NumVerticesNew=(*Mesh\GetNumVertices()*Quality)/100
ptr=*Adj\GetBufferPointer()
*D3DX\SimplifyMesh(*Mesh,ptr,0,0,NumVerticesNew,1,@*Mesh)
EndIf
*OldMesh\Release()

;off1=OffsetOf(Direct3DDevice8\DrawPrimitive())
;Addr1=PeekL(*D3DDevice)+off1
;PokeL(Addr1,@Count_DrawPrimitive()) ;<=== writeprocessmemory !!!

off2=OffsetOf(Direct3DDevice8\DrawIndexedPrimitive())
Addr2=PeekL(*D3DDevice)+off2
PokeL(Addr2,@Count_DrawIndexedPrimitive()) ;<=== writeprocessmemory !!!

For c=0 To Subs-1 ; -1 ???


  *Mesh\DrawSubset(c)  
; *D3DDevice\GetIndices(@dummy1,@dummy2)
; Debug dummy2
Next

;VerticesCount=*Mesh\GetNumFaces();*MESH\GetNumFaces() ;VerticesCount
;Debug NumV
;NumV=*Mesh\GetNumFaces()
;Debug NumV
;NumV=
;Debug NumV
VerticesCount=*Mesh\GetNumVertices()

GetDataV=IsFunction(1,"D3DXMeshVertexBuffer8GetData")



*Mesh\GetVertexBuffer(@*Vertex.Direct3DIndexBuffer8) 
*Mesh\GetIndexBuffer(@*Index.Direct3DIndexBuffer8) 

Structure D3DINDEXBUFFER_DESC
  Format.l
  Type.l
  Usage.l
  Pool.l
  Size.l
EndStructure

*Index\GetDesc(IB.D3DINDEXBUFFER_DESC)
*Index\Release()

;*Index\GetDesc(VB.D3DVERTEXBUFFER_DESC)
;Debug VB\Size



;Debug (VerticesCount)*(4*5)
;Debug (VerticesCount/3)*(4*5)-1500

size=(VerticesCount)*(4*5)
mem=AllocateMemory(size)
result=CallFunctionFast(GetDataV,*Mesh,0,size,0,mem)
;If result:Error():EndIf
;Debug result

GetDataI=IsFunction(1,"D3DXMeshIndexBuffer8GetData")

sizei=IB\Size
memi=AllocateMemory(sizei)
result=CallFunctionFast(GetDataI,*Mesh,0,sizei,0,memi)
;If result::EndIf
;Debug result





;For c=0 To NumV*2 Step 2
;If PeekW(memi+c)>NumV-1:Debug "ERR":EndIf
;Next






WriteData(@"S3DR",4)
WriteLong(VerticesCount)
WriteLong(VS)
WriteLong(size)
WriteData(mem,size)
WriteLong(sizei)
WriteData(memi,sizei)
WriteLong(Subs)


FreeMemory(mem)
FreeMemory(memi)


off1=OffsetOf(Direct3DDevice8\DrawPrimitive())
Addr1=PeekL(*D3DDevice)+off1
PokeL(Addr1,@Write_DrawPrimitive()) ;<=== writeprocessmemory !!!

off2=OffsetOf(Direct3DDevice8\DrawIndexedPrimitive())
Addr2=PeekL(*D3DDevice)+off2
PokeL(Addr2,@Write_DrawIndexedPrimitive()) ;<=== writeprocessmemory !!!

For c=0 To Subs-1  ; -1 ???
  *Mesh\DrawSubset(c)
Next

CloseFile(1)


SetWindowTitle(1,"CONV2S3DR")

If exSubs
  Text$=".S3DR-file successful created."+Chr(13)
  Text$+"-------------------------------------------------"+Chr(13)
  Text$+Str(exSubs)+" Subset(s) exported"+Chr(13)
  Text$+"Vertexbuffer size: "+Str(size)+" bytes"+Chr(13)
  Text$+"Indexbuffer size: "+Str(sizei)+" bytes"+Chr(13)
  Text$+"Number of Vertices: "+Str(VerticesCount)+Chr(13)
  Text$+"Number of Indices: "+Str(sizei/2)+Chr(13)
  
  Text$+"needed time: "+Str(GetTickCount_()-start)+" ms"+Chr(13)
  Text$+"-------------------------------------------------"+Chr(13)
  Text$+"src="+File$+Chr(13)
  Text$+"dest="+out$+Chr(13)
  Text$+"-------------------------------------------------"+Chr(13)
  
  MessageRequester("Info",Text$,#MB_OK|#MB_ICONINFORMATION)
  *D3DDevice\Release()
  *D3DX\Release()
  *D3D\Release()
  *DX\Release()
Else
  DeleteFile(out$)
  MessageRequester("ERROR","Sorry, There was an error."+Chr(13)+"DirectX8 is needed !",#MB_ICONEXCLAMATION)
  *D3DDevice\Release()
  *D3DX\Release()
  *D3D\Release()
  *DX\Release()
  End
EndIf



DataSection
M1:
Data.l $E7FF1300
Data.l $11D396A5
Data.l $C00085AC
Data.l $2C6C24F

M2:
Data.l $1
Data.l $0
Data.l $C0
Data.l $46000000

M3:
Data.l 0
Data.l $0
Data.l $C0
Data.l $46000000


X1:
Data.l 1479896157
Data.l 1223494653
Data.l 1391773075
Data.l -567057909

X2:
Data.l 1
Data.l 0
Data.l 192
Data.l 1174405120
EndDataSection


; IDE Options = PureBasic v4.00 (Windows - x86)
; Folding = --
; UseIcon = s3dr.ico