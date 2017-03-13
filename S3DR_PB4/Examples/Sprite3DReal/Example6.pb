
InitSprite()
InitSprite3D()
InitKeyboard()

OpenWindow(1,0,0,800,600,"Example 6 (Rotating textures)",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)


S3DR_CreateZBuffer()

LoadSprite(1,"lights.bmp",#PB_Sprite_Texture)
TransparentSpriteColor(1,RGB(255,0,255))

Start3D()
S3DR_BeginReal3D()
donut=S3DR_LoadMesh("Plasma_donut4.s3dr")
S3DR_EndReal3D()
Stop3D()


Repeat 
  ExamineKeyboard()  
  
  Start3D()
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(#Black)
  
  angle.f+0.01
  
  ;Draw the donut
  S3DR_SelectTexture(1)
  S3DR_RotateTexture(angle.f) ; rotate the texture absolute 
  S3DR_DrawMesh(donut,0,0,20,angle,angle,angle)
  
  S3DR_EndReal3D()
  Stop3D()
  
  FlipBuffers()  
  
Until KeyboardPushed(#PB_Key_Escape) Or WindowEvent()=#PB_Event_CloseWindow

S3DR_FreeMesh(donut); Don't forget to free the Mesh.

CloseScreen()
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 39
; FirstLine = 12
; Folding = -