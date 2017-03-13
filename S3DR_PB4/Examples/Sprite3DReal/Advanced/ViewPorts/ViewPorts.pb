
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(800,600,16,"2 Viewports")

S3DR_CreateZBuffer()

LoadSprite(1,"Texture2.bmp",#PB_Sprite_Texture)

pl1Y.f=5
pl2Y.f=5
pl1X.f=50
pl2X.f=-50
pl1Z.f=25
pl2Z.f=-25


Repeat
  
  ExamineKeyboard()
  
  Start3D()
  S3DR_BeginReal3D() 
  S3DR_UseFog(1,0,40,RGB(220,220,255))
  
  
  
  S3DR_MoveCamera(Pl1X.f,Pl1Y.f,Pl1Z.f)
  S3DR_RotateCamera(Pl1AX.f,Pl1AY.f,Pl1AZ.f)
  
  S3DR_SetViewPort(0,0,800,300)  
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  If KeyboardPushed(#PB_Key_Left):S3DR_RotateCamera(0,-0.01,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.01,0):EndIf
  
  If KeyboardPushed(#PB_Key_Up):S3DR_MoveCamera(0,0,1):EndIf
  If KeyboardPushed(#PB_Key_Down):S3DR_MoveCamera(0,0,-1):EndIf
  
  
  S3DR_SelectTexture(1)
  For x=-100 To 100 Step 20
    For z=-100 To 100 Step 20    
      S3DR_Draw3D(-10+x, 0, 10+z, 10+x, 0, 10+z,-10+x, 0,-10+z, 10+x, 0,-10+z)
    Next
  Next
  
  
  Pl1X.f=S3DR_GetCameraX()
  Pl1Y.f=S3DR_GetCameraY()
  Pl1Z.f=S3DR_GetCameraZ()
  
  Pl1AX.f=S3DR_GetCameraAngleX()
  Pl1AY.f=S3DR_GetCameraAngleY()
  Pl1AZ.f=S3DR_GetCameraAngleZ()
  S3DR_RotateCamera(-Pl1AX,-Pl1AY,-Pl1AZ)  
  S3DR_MoveCamera(-Pl1X,-Pl1Y,-Pl1Z)
  
  
  
  
  

 
    
  S3DR_MoveCamera(Pl2X.f,Pl2Y.f,Pl2Z.f)
  S3DR_RotateCamera(Pl2AX.f,Pl2AY.f,Pl2AZ.f)
  
 S3DR_SetViewPort(0,300,800,300) 
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  If KeyboardPushed(#PB_Key_A):S3DR_RotateCamera(0,-0.01,0):EndIf
  If KeyboardPushed(#PB_Key_S):S3DR_RotateCamera(0, 0.01,0):EndIf
  
  If KeyboardPushed(#PB_Key_W):S3DR_MoveCamera(0,0,1):EndIf
  If KeyboardPushed(#PB_Key_Z):S3DR_MoveCamera(0,0,-1):EndIf
  
  
  S3DR_SelectTexture(1)
  For x=-100 To 100 Step 20
    For z=-100 To 100 Step 20    
      S3DR_Draw3D(-10+x, 0, 10+z, 10+x, 0, 10+z,-10+x, 0,-10+z, 10+x, 0,-10+z)
    Next
  Next
  

  Pl2X.f=S3DR_GetCameraX()
  Pl2Y.f=S3DR_GetCameraY()
  Pl2Z.f=S3DR_GetCameraZ()
  
  Pl2AX.f=S3DR_GetCameraAngleX()
  Pl2AY.f=S3DR_GetCameraAngleY()
  Pl2AZ.f=S3DR_GetCameraAngleZ()
  S3DR_RotateCamera(-Pl2AX,-Pl2AY,-Pl2AZ)  
  S3DR_MoveCamera(-Pl2X,-Pl2Y,-Pl2Z)

  
  
  S3DR_EndReal3D()
  Stop3D()
  
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  FrontColor(RGB(128,128,128))
  
  DrawText(0,0,"X:"+StrF(pl1X))
  DrawText(0,16,"Y:"+StrF(pl1Y))
  DrawText(0,32,"Z:"+StrF(pl1Z))
  
  DrawText(0,300,"X:"+StrF(pl2X))
  DrawText(0,316,"Y:"+StrF(pl2Y))
  DrawText(0,332,"Z:"+StrF(pl2Z))
  StopDrawing()
  
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeZBuffer()

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 108
; FirstLine = 92
; Folding = -