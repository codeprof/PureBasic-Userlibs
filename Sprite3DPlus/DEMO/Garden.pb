

InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(800,600,16,"Stefan's garden")

S3DR_CreateZBuffer()

LoadSprite(2,"Texture2.bmp",#PB_Sprite_Texture)
LoadSprite(3,"tree1.bmp",#PB_Sprite_Texture)
LoadSprite(4,"house.bmp",#PB_Sprite_Texture)
LoadSprite(5,"Texture1.bmp",#PB_Sprite_Texture)


Start3D()
S3DR_StartReal3D()

S3DP_SetCullMode(1)
S3DR_MoveCamera(-50,3,0)
S3DR_UseFog(1,0,100,RGB(220,220,255))

S3DR_StopReal3D()
Stop3D()


Repeat
RandomSeed(545)

ExamineKeyboard()

Start3D()


If KeyboardPushed(#PB_KEY_LEFT):S3DR_RotateCamera(0,-0.025,0):EndIf
If KeyboardPushed(#PB_KEY_RIGHT):S3DR_RotateCamera(0,0.025,0):EndIf


If KeyboardPushed(#PB_KEY_UP)
S3DR_MoveCamera(0,0,0.5)
CX.f=S3DR_GetCameraX()
CZ.f=S3DR_GetCameraZ()

If CX=>99 Or CX<=-99 Or CZ=>99 Or CZ<=-99 

S3DR_MoveCamera(0,0,-0.5);Bewegung rückgängig machen
EndIf
EndIf


If KeyboardPushed(#PB_KEY_DOWN)
S3DR_MoveCamera(0,0,-0.5)
CX.f=S3DR_GetCameraX()
CZ.f=S3DR_GetCameraZ()

If CX=>99 Or CX<=-99 Or CZ=>99 Or CZ<=-99
S3DR_MoveCamera(0,0,0.5);Bewegung rückgängig machen
EndIf
EndIf



S3DR_StartReal3D()



S3DR_ClearScreenAndZBuffer(RGB(220,220,255))


;Untergrung zeichen:
S3DR_UseTexture(2)
;S3DR_SetTextureCoordinates(0,0,1,0,0,1,1,1)
For Z= -100 To 100 Step 8
For X= -100 To 100 Step 8

S3DR_Draw3D(X+4,0,Z+4,X-4,0,Z+4,X+4,0,Z-4,X-4,0,Z-4)

Next
Next


;Bäume zeichnen:
S3DR_UseTexture(3)
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
S3DR_UseTexture(4)
S3DR_Draw3D( 10, 5, 10,-10, 5, 10, 10, 0, 10,-10,0, 10)
S3DR_Draw3D(-10, 5, 10,-10, 5,-10,-10, 0, 10,-10,0,-10)
S3DR_Draw3D(-10, 5,-10, 10, 5,-10,-10, 0,-10, 10,0,-10)
S3DR_Draw3D( 10, 5,-10, 10, 5, 10, 10, 0,-10, 10,0, 10)
S3DR_UseTexture(5)
S3DR_Draw3D(10,5,10,-10,5,10,10,5,-10,-10,5,-10)


S3DR_StopReal3D()


Stop3D()



StartDrawing(ScreenOutput())

DrawingMode(1)
FrontColor(0,0,255)
DrawText("X: "+StrF(S3DR_GetCameraX()))
Locate(0,16)
DrawText("Y: "+StrF(S3DR_GetCameraY()))
Locate(0,32)
DrawText("Z: "+StrF(S3DR_GetCameraZ()))
StopDrawing()





FlipBuffers()


Until KeyboardPushed(#PB_KEY_ESCAPE)
CloseScreen()

; ExecutableFormat=Windows
; Executable=C:\HELPI.exe
; EOF