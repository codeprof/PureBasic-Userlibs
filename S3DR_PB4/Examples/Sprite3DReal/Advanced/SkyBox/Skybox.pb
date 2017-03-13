
InitSprite()
InitSprite3D()
InitKeyboard()

SetRefreshRate(60)
OpenScreen(1024,768,16,"Skybox example")

S3DR_CreateZBuffer()

LoadSprite(1,"texture2.bmp",#PB_Sprite_Texture)
LoadSprite(2,"texture10.bmp",#PB_Sprite_Texture)
LoadSprite(3,"sky.bmp",#PB_Sprite_Texture)


Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,3,-16)
S3DR_UseFog(1,0,150,RGB(220,220,255))
tree=S3DR_LoadMesh("Tree02.s3dr")

S3DR_EndReal3D()
Stop3D()




Repeat 
  ExamineKeyboard()  
  
  
  Start3D()
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  RandomSeed(1)  
  
  ;Draw trees
  S3DR_SelectTexture(2)
  For c=0 To 25
  S3DR_DrawMesh(tree,Random(100)-Random(100),0,Random(100)-Random(100),0,0,0)
  Next
  
  
  If KeyboardPushed(#PB_Key_Left) :S3DR_RotateCamera(0,-0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Up)   :S3DR_MoveCamera(0,0,0.5):EndIf 
  If KeyboardPushed(#PB_Key_Down) :S3DR_MoveCamera(0,0,-0.5):EndIf
  
  
  ;Draw the ground:
  S3DR_SelectTexture(1)
  For z= -100 To 100 Step 8
    For x= -100 To 100 Step 8
      S3DR_Draw3D(x-4,0,z+4,x+4,0,z+4,x-4,0,z-4,x+4,0,z-4)     
    Next
  Next  
  
  
  ;Draw the Skybox:
  CX.f=S3DR_GetCameraX()
  CY.f=S3DR_GetCameraY()
  CZ.f=S3DR_GetCameraZ()
  S3DR_SelectTexture(3)
  S3DR_SetTextureCoordinates(0,0,3,0,0,3,3,3); change texture coordinates
  S3DR_SetCullMode(#S3DR_CW) ; change cull mode
  S3DR_Draw3D( 100+CX,-30+CY, 100+CZ,-100+CX,-30+CY, 100+CZ, 100+CX,-30+CY,-100+CZ,-100+CX,-30+CY,-100+CZ)
  S3DR_Draw3D( 100+CX, 30+CY, 100+CZ,-100+CX, 30+CY, 100+CZ, 100+CX,-30+CY, 100+CZ,-100+CX,-30+CY, 100+CZ)
  S3DR_Draw3D(-100+CX, 30+CY, 100+CZ, 100+CX, 30+CY, 100+CZ,-100+CX, 30+CY,-100+CZ, 100+CX, 30+CY,-100+CZ)
  S3DR_Draw3D(-100+CX, 30+CY, 100+CZ,-100+CX, 30+CY,-100+CZ,-100+CX,-30+CY, 100+CZ,-100+CX,-30+CY,-100+CZ)
  S3DR_Draw3D(-100+CX, 30+CY,-100+CZ, 100+CX, 30+CY,-100+CZ,-100+CX,-30+CY,-100+CZ, 100+CX,-30+CY,-100+CZ)
  S3DR_Draw3D( 100+CX, 30+CY,-100+CZ, 100+CX, 30+CY, 100+CZ, 100+CX,-30+CY,-100+CZ, 100+CX,-30+CY, 100+CZ)
  S3DR_SetCullMode(#S3DR_CCW); restore old cull mode
  S3DR_SetTextureCoordinates(0,0,1,0,0,1,1,1); restore old texture coordinates
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()  
  
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeMesh(tree); Don't forget to free the Mesh.

CloseScreen()
; IDE Options = PureBasic v3.94 Beta 1 - Windows x86
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 78
; FirstLine = 53
; Folding = -