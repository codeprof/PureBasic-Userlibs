
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"Mesh example")

S3DR_CreateZBuffer()

LoadSprite(1,"texture2.bmp",#PB_Sprite_Texture)
LoadSprite(2,"texture3.bmp",#PB_Sprite_Texture)


Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,3,-16)
S3DR_UseFog(1,0,100,RGB(220,220,255))
ball=S3DR_LoadMesh("sphere.s3dr")

S3DR_EndReal3D()
Stop3D()




Repeat 
  ExamineKeyboard()  
  
  
  Start3D()
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  
  angle.f+0.025
  
  ;Draw the sphere
  S3DR_SelectTexture(2)
  S3DR_DrawMesh(ball,-angle,1.75,0,0,0,angle)
  
  
  If KeyboardPushed(#PB_Key_Left) :S3DR_RotateCamera(0,-0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Up)   :S3DR_MoveCamera(0,0,0.5):EndIf 
  If KeyboardPushed(#PB_Key_Down) :S3DR_MoveCamera(0,0,-0.5):EndIf
  
  
  ;Draw the ground:
  S3DR_SelectTexture(1)
  ;S3DR_SetTextureCoordinates(0,0,1,0,0,1,1,1)
  For z= -100 To 100 Step 8
    For x= -100 To 100 Step 8
      S3DR_Draw3D(x-4,0,z+4,x+4,0,z+4,x-4,0,z-4,x+4,0,z-4)     
    Next
  Next  
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()  
  
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeMesh(ball); Don't forget to free the Mesh.

CloseScreen()
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 19
; Folding = -