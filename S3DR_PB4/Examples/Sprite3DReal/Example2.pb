
InitSprite()
InitSprite3D()
InitKeyboard()

OpenWindow(1,0,0,800,600,"Example 2 (draw texture in 3D space)",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)


S3DR_CreateZBuffer();must be called before Start3D() and S3DR_BeginReal3D()

LoadSprite(1,"box.bmp",#PB_Sprite_Texture)


Repeat
  
  Start3D()
  
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(#Blue)
  
  S3DR_UseTransparency(#S3DR_FALSE);disable transparency
  
  
  S3DR_SelectTexture(1)
  
  ;             X1  Y1  Z1  X2  Y2  Z2  X3  Y3  Z3  X4  Y4  Z4
  S3DR_Draw3D(  -1,  1, 10,  1,  1, 10, -1, -1, 10,  1, -1, 10);draws the selected sprite
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape) Or WindowEvent()=#PB_Event_CloseWindow

S3DR_FreeZBuffer()


; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 12
; Folding = -