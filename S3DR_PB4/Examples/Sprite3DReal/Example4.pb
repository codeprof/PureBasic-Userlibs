
InitSprite()
InitSprite3D()
InitKeyboard()

OpenWindow(1,0,0,800,600,"Example 4",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)


S3DR_CreateZBuffer()

LoadSprite(1,"Texture2.bmp",#PB_Sprite_Texture)
LoadSprite(2,"tree.bmp",#PB_Sprite_Texture)

Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,5,0) ; move the camera relative
S3DR_EndReal3D()
Stop3D()

Repeat
  
  ExamineKeyboard()
  
  Start3D()
  S3DR_BeginReal3D()

  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  If KeyboardPushed(#PB_Key_Left):S3DR_RotateCamera(0,-0.01,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.01,0):EndIf
  
  If KeyboardPushed(#PB_Key_Up):S3DR_MoveCamera(0,0,1):EndIf ; rotate camera relative
  If KeyboardPushed(#PB_Key_Down):S3DR_MoveCamera(0,0,-1):EndIf ; rotate camera relative
  
  
  S3DR_UseFog(1,0,100,RGB(220,220,255)); enable fog
  
  ;draw the ground:
  S3DR_SelectTexture(1)
  For x=-100 To 100 Step 20
    For z=-100 To 100 Step 20      
      S3DR_Draw3D(-10+x, 0, 10+z, 10+x, 0, 10+z,-10+x, 0,-10+z, 10+x, 0,-10+z)
    Next
  Next
  
  
  RandomSeed(5)
  ;draw a few trees
  S3DR_SelectTexture(2)
  For M=0 To 100
  TreeX.f=Random(100)-Random(100)
  TreeZ.f=Random(100)-Random(100)
  TreeY.f=2.25
  
  S3DR_DrawBillboard(TreeX,TreeY,TreeZ,5,5)
  Next
  
  
  S3DR_EndReal3D()
  Stop3D()
  
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  FrontColor(RGB(128,128,128))
  
  DrawText(0,0,"X:"+StrF(S3DR_GetCameraX()))
  DrawText(0,16,"Y:"+StrF(S3DR_GetCameraY()))
  DrawText(0,32,"Z:"+StrF(S3DR_GetCameraZ()))
  
  DrawText(0,100,"X-Angle:"+StrF(S3DR_GetCameraAngleX()))
  DrawText(0,116,"Y-Angle:"+StrF(S3DR_GetCameraAngleY()))
  DrawText(0,132,"Z-Angle:"+StrF(S3DR_GetCameraAngleZ()))
  StopDrawing()
  
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape) Or WindowEvent()=#PB_Event_CloseWindow

S3DR_FreeZBuffer()

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 19
; FirstLine = 3
; Folding = -