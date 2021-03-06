
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"Rotating Cone")

S3DR_CreateZBuffer()

LoadSprite(1,"Lights.bmp",#PB_Sprite_Texture)
TransparentSpriteColor(1,RGB(255,0,255))

Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,0,-5)

;Create the cone
S3DR_StartCreateMesh()
S3DR_CreateMesh_AddTriangle(0.0,1.0,0.0,-1.0,-1.0,1.0,1.0,-1.0,1.0)
S3DR_CreateMesh_AddTriangle(0.0,1.0,0.0,1.0,-1.0,1.0,1.0,-1.0,-1.0)
S3DR_CreateMesh_AddTriangle(0.0,1.0,0.0,1.0,-1.0,-1.0,-1.0,-1.0,-1.0) 
S3DR_CreateMesh_AddTriangle(0.0,1.0,0.0,-1.0,-1.0,-1.0,-1.0,-1.0,1.0) 
S3DR_CreateMesh_AddQuad( 1,-1, 1,-1,-1, 1, 1,-1,-1,-1,-1,-1)
Cone=S3DR_StopCreateMesh()


S3DR_EndReal3D()

Sprite3DQuality(1)
Stop3D()




Repeat 
  ExamineKeyboard()  
  
  
  Start3D()
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  angle.f+0.01
  
  ;Draw the cone
  S3DR_SelectTexture(1)
  S3DR_DrawMesh(Cone,0,0,0,angle,angle,angle)

  
  If KeyboardPushed(#PB_Key_Left) :S3DR_RotateCamera(0,-0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Up)   :S3DR_MoveCamera(0,0,0.5):EndIf 
  If KeyboardPushed(#PB_Key_Down) :S3DR_MoveCamera(0,0,-0.5):EndIf

  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()  
  
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeMesh(Cone); Don't forget to free the Mesh.

CloseScreen()
; IDE Options = PureBasic v3.94 Beta 1 - Windows x86
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 10
; Folding = -