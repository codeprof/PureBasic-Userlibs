InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"TestCollision")

S3DR_CreateZBuffer()

LoadSprite(1,"Texture2.bmp",#PB_Sprite_Texture)
LoadSprite(2,"house.bmp",#PB_Sprite_Texture)

Start3D()
S3DR_BeginReal3D()
S3DR_SetCullMode(#S3DR_NONE)
S3DR_MoveCamera(-20,3,0)
S3DR_RotateCamera(0,ACos(-1)/2,0)
S3DR_UseFog(1,0,100,RGB(220,220,255))
S3DR_EndReal3D()
Stop3D()

Repeat
  
  ExamineKeyboard()
  
  Start3D()
  
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  If KeyboardPushed(#PB_Key_Left):S3DR_RotateCamera(0,-0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf 
  
  If KeyboardPushed(#PB_Key_Up):S3DR_MoveCamera(0,0,0.5):EndIf  
  If KeyboardPushed(#PB_Key_Down):S3DR_MoveCamera(0,0,-0.5):EndIf
  
  a.f+0.01
  
  ;Draw the ground:
  S3DR_SelectTexture(1)    
  S3DR_Draw3D(-20,0,20,20,0,20,-20,0,-20,20,0,-20)
  
  
  S3DR_SelectTexture(2)
  S3DR_Draw3D(5,5*Sin(a),5,-5,5*Sin(a),5,5,5,-5,-5,5,-5)  
  
  Result=S3DR_TestCollision(-20,0,20,20,0,20,-20,0,-20,20,0,-20,5,5*Sin(a),5,-5,5*Sin(a),5,5,5,-5,-5,5,-5)
  
  S3DR_EndReal3D()
  
  Stop3D()
  
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  DrawingFont(GetStockObject_(#ANSI_FIXED_FONT))
  If Result
    DrawText(0,0,"Collision: YES")
  Else
    DrawText(0,0,"Collision: NO")
  EndIf
  StopDrawing()
  
  FlipBuffers()
  
  
Until KeyboardPushed(#PB_Key_Escape)
CloseScreen()
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 58
; FirstLine = 34
; Folding = -