
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"Advanced example 1")

S3DR_CreateZBuffer()

LoadSprite(1,"box.bmp",#PB_Sprite_Texture)

Start3D()
S3DR_BeginReal3D()
S3DR_MoveCamera(0,2,-10) 
S3DR_EndReal3D()
Stop3D()


Repeat
  
  ExamineKeyboard()
  
  Start3D()
  S3DR_BeginReal3D() 
   
  S3DR_ClearScreenAndZBuffer(RGB(128,128,0))
  
  If KeyboardReleased(#PB_Key_F1):Ditherenabled=1-Ditherenabled:EndIf
  If KeyboardReleased(#PB_Key_F2):Fillmode=(Fillmode)%3+1:EndIf
  If KeyboardReleased(#PB_Key_F3):Trans=1-Trans:EndIf
  If KeyboardReleased(#PB_Key_F4):Cullmode=(Cullmode)%3+1:EndIf
  
  S3DR_SetFillMode(Fillmode)
  S3DR_UseTransparency(Trans)
  S3DR_UseDither(Ditherenabled) 
  S3DR_SetCullMode(Cullmode)
  
  S3DR_SelectTexture(1)
    ;Draw a cube
  S3DR_Draw3D( 1,-1, 1,-1,-1, 1, 1,-1,-1,-1,-1,-1)
  S3DR_Draw3D( 1, 1, 1,-1, 1, 1, 1,-1, 1,-1,-1, 1)
  S3DR_Draw3D(-1, 1, 1, 1, 1, 1,-1, 1,-1, 1, 1,-1)
  S3DR_Draw3D(-1, 1, 1,-1, 1,-1,-1,-1, 1,-1,-1,-1)
  S3DR_Draw3D(-1, 1,-1, 1, 1,-1,-1,-1,-1, 1,-1,-1)
  S3DR_Draw3D( 1, 1,-1, 1, 1, 1, 1,-1,-1, 1,-1, 1)
  
  S3DR_EndReal3D()
  Stop3D()
  
  
  StartDrawing(ScreenOutput())
  DrawingMode(1)
  DrawingFont(GetStockObject_(#ANSI_FIXED_FONT))
  FrontColor(RGB(255,255,128))
  
  If Ditherenabled
  DrawText(0,0,"Dihter:       enabled  (change with F1)")
  Else
  DrawText(0,0,"Dihter:       disabled (change with F1)")
  EndIf
  
  If FillMode=#S3DR_POINT
  DrawText(0,16,"Fillmode:     POINT    (change with F2)")
  ElseIf FillMode=#S3DR_WIREFRAME
  DrawText(0,16,"Fillmode:     WIREFRAME(change with F2)")
  Else
  DrawText(0,16,"Fillmode:     SOLID    (change with F2)")
  EndIf
  
  If Trans
  DrawText(0,32,"Transparency: enabled  (change with F3)")
  Else
  DrawText(0,32,"Transparency: disabled (change with F3)")
  EndIf
  
  If Cullmode=#S3DR_NONE 
  DrawText(0,48,"Cullmode:     NONE     (change with F4)")
  ElseIf CullMode=#S3DR_CW
  DrawText(0,48,"Cullmode:     CW       (change with F4)")
  Else
  DrawText(0,48,"Cullmode:     CCW      (change with F4)")
  EndIf
  
  StopDrawing()
  
  FlipBuffers()
  
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)

S3DR_FreeZBuffer()

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 80
; FirstLine = 59
; Folding = -