
InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(1024,768,16,"Stefan's garden")

S3DR_CreateZBuffer()

LoadSprite(1,"Texture2.bmp",#PB_Sprite_Texture)
LoadSprite(2,"tree1.bmp",#PB_Sprite_Texture)
LoadSprite(3,"house.bmp",#PB_Sprite_Texture)
LoadSprite(4,"Texture1.bmp",#PB_Sprite_Texture)

Start3D()
S3DR_BeginReal3D()

S3DR_SetCullMode(#S3DR_NONE)
S3DR_MoveCamera(-50,3,0)
S3DR_UseFog(1,0,100,RGB(220,220,255))

S3DR_EndReal3D()
Stop3D()


Repeat
  RandomSeed(1)
  
  ExamineKeyboard()
  
  
  Start3D()
  
  S3DR_BeginReal3D()
  S3DR_ClearScreenAndZBuffer(RGB(220,220,255))
  
  If KeyboardPushed(#PB_Key_Left):S3DR_RotateCamera(0,-0.025,0):EndIf
  If KeyboardPushed(#PB_Key_Right):S3DR_RotateCamera(0,0.025,0):EndIf
  
  
  If KeyboardPushed(#PB_Key_Up)
    S3DR_MoveCamera(0,0,0.5)
    CX.f=S3DR_GetCameraX()
    CZ.f=S3DR_GetCameraZ()
    
    If CX=>99 Or CX<=-99 Or CZ=>99 Or CZ<=-99 
      
      S3DR_MoveCamera(0,0,-0.5);Bewegung rückgängig machen
    EndIf
  EndIf
  
  
  If KeyboardPushed(#PB_Key_Down)
    S3DR_MoveCamera(0,0,-0.5)
    CX.f=S3DR_GetCameraX()
    CZ.f=S3DR_GetCameraZ()
    
    If CX=>99 Or CX<=-99 Or CZ=>99 Or CZ<=-99
      S3DR_MoveCamera(0,0,0.5);Bewegung rückgängig machen
    EndIf
  EndIf
  
  
  
  ;Untergrung zeichen:
  S3DR_SelectTexture(1)
  ;S3DR_SetTextureCoordinates(0,0,1,0,0,1,1,1)
  For z= -100 To 100 Step 8
    For x= -100 To 100 Step 8
      
      S3DR_Draw3D(x-4,0,z+4,x+4,0,z+4,x-4,0,z-4,x+4,0,z-4)
      
    Next
  Next
  
  
  ;Bäume zeichnen:
  S3DR_SelectTexture(2)
  For M=0 To 250
    TreeZ=Random(100)-Random(100)
    TreeX=Random(100)-Random(100)
    TreeY.f=-0.25 
    
    If ((TreeX<12 And TreeX>-12) And (TreeZ<12 And TreeZ>-12))=0
      S3DR_Draw3D(-2+TreeX,5+TreeY, 0+TreeZ,2+TreeX,5+TreeY,0+TreeZ,-2+TreeX,0+TreeY, 0+TreeZ,2+TreeX,0+TreeY,0+TreeZ)
      S3DR_Draw3D( 0+TreeX,5+TreeY,-2+TreeZ,0+TreeX,5+TreeY,2+TreeZ, 0+TreeX,0+TreeY,-2+TreeZ,0+TreeX,0+TreeY,2+TreeZ)
    EndIf
  Next
  
  
  ;Haus zeichnen:
  S3DR_SelectTexture(3)
  S3DR_Draw3D( 10, 5, 10,-10, 5, 10, 10, 0, 10,-10,0, 10)
  S3DR_Draw3D(-10, 5, 10,-10, 5,-10,-10, 0, 10,-10,0,-10)
  S3DR_Draw3D(-10, 5,-10, 10, 5,-10,-10, 0,-10, 10,0,-10)
  S3DR_Draw3D( 10, 5,-10, 10, 5, 10, 10, 0,-10, 10,0, 10)
  ;Dach:
  S3DR_SelectTexture(4)
  S3DR_Draw3D(10,5,10,-10,5,10,10,5,-10,-10,5,-10)
  
  
  S3DR_EndReal3D()
  
  Stop3D()
  
  
  StartDrawing(ScreenOutput())
  FrontColor(RGB(0,0,128))
  DrawingMode(1)
  DrawText(0,0,"X: "+StrF(S3DR_GetCameraX()))
  DrawText(0,16,"Y: "+StrF(S3DR_GetCameraY()))
  DrawText(0,32,"Z: "+StrF(S3DR_GetCameraZ()))
  StopDrawing()
  
  FlipBuffers()
  
  
Until KeyboardPushed(#PB_Key_Escape)
CloseScreen()

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 108
; FirstLine = 57
; Folding = -
; Executable = Garden.exe
; DisableDebugger