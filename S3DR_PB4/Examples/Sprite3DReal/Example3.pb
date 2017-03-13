
InitSprite()
InitSprite3D()
InitKeyboard()

OpenWindow(1,0,0,800,600,"Example 3",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)


S3DR_CreateZBuffer()

LoadSprite(1,"box.bmp",#PB_Sprite_Texture)

Repeat
  
  Start3D()
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(#Blue)
  
  S3DR_UseTransparency(#S3DR_FALSE);disable transparency
  
  S3DR_SelectTexture(1)
  
  S3DR_MoveCamera(0,-0.25,-1); move the camera relative
  
  ;Draw a cube
  S3DR_Draw3D( 10,-10, 10,-10,-10, 10, 10,-10,-10,-10,-10,-10)
  S3DR_Draw3D( 10, 10, 10,-10, 10, 10, 10,-10, 10,-10,-10, 10)
  S3DR_Draw3D(-10, 10, 10, 10, 10, 10,-10, 10,-10, 10, 10,-10)
  S3DR_Draw3D(-10, 10, 10,-10, 10,-10,-10,-10, 10,-10,-10,-10)
  S3DR_Draw3D(-10, 10,-10, 10, 10,-10,-10,-10,-10, 10,-10,-10)
  S3DR_Draw3D( 10, 10,-10, 10, 10, 10, 10,-10,-10, 10,-10, 10)
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape) Or WindowEvent()=#PB_Event_CloseWindow

S3DR_FreeZBuffer()


; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 19
; FirstLine = 11
; Folding = -