
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"Example for S3DR_SetCameraRangeAndFOV() and S3DR_SetDiffuseColors()")

S3DR_CreateZBuffer()

CreateSprite(1,64,64,#PB_Sprite_Texture)
StartDrawing(SpriteOutput(1))
Box(0,0,64,64,#White)
StopDrawing()


Start3D()
S3DR_BeginReal3D()
S3DR_SetCullMode(#S3DR_NONE)
S3DR_MoveCamera(0,5,0)
S3DR_UseDither(#S3DR_TRUE)
S3DR_EndReal3D()

Stop3D()

Repeat
  
  ExamineKeyboard()
  
  Start3D()
  S3DR_BeginReal3D()
  
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  S3DR_SetCameraRangeAndFOV(1,1000,120) ;FOV is in degree
  
  S3DR_SelectTexture(1)
  S3DR_SetDiffuseColors(#Red,#Green,#White,#Blue)
  
  For c=0 To 9;Draws a Cylinder 
    a1.f=c/10*ACos(-1)*2
    a2.f=(c+1)/10*ACos(-1)*2
    T1.f=c/10
    T2.f=c/10+1/10
    S3DR_SetTextureCoordinates(T1,0,T2,0,T1,1,T2,1)
    
    X1.f=Sin(a1)*100
    Y1.f=50
    Z1.f=Cos(a1)*100
    X2.f=Sin(a2)*100
    Y2.f=50
    Z2.f=Cos(a2)*100
    
    X3.f=Sin(a1)*100
    Y3.f=0
    Z3.f=Cos(a1)*100
    X4.f=Sin(a2)*100
    Y4.f=0
    Z4.f=Cos(a2)*100
    
    S3DR_Draw3D(X1.f,Y1.f,Z1.f,X2.f,Y2.f,Z2.f,X3.f,Y3.f,Z3.f,X4.f,Y4.f,Z4.f)
  Next
  S3DR_SetTextureCoordinates(0,0,1,0,0,1,1,1)
  
  
  If KeyboardPushed(#PB_Key_Left):S3DR_RotateCamera(0,-0.02,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0, 0.02,0):EndIf
  
  If KeyboardPushed(#PB_Key_Up):S3DR_MoveCamera(0,0,1):EndIf
  If KeyboardPushed(#PB_Key_Down):S3DR_MoveCamera(0,0,-1):EndIf
  
  S3DR_SetDiffuseColors(#Green,0,0,#Green)
  
  For x=-100 To 100 Step 20
    For z=-100 To 100 Step 20      
      S3DR_Draw3D(-10+x, 0, 10+z, 10+x, 0, 10+z,-10+x, 0,-10+z, 10+x, 0,-10+z)
    Next
  Next
  
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeZBuffer()

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 5
; FirstLine = 55
; Folding = -