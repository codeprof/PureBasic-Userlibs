InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(320,200,16,"S3DP_UseDither()")

LoadSprite(1,"TestBmp1.bmp",#PB_Sprite_Texture)
CreateSprite3D(1,1)

Repeat

ClearScreen(128,128,128)

Start3D()

Angle+1
RotateSprite3D(1,Angle,0)

S3DP_UseDither(0)
DisplaySprite3D(1,50,50)
S3DP_UseDither(1)
DisplaySprite3D(1,150,50)

Stop3D()


StartDrawing(ScreenOutput())
DrawingMode(1)
Locate(50,150)
DrawText("Dither OFF")
Locate(150,150)
DrawText("Dither ON")
StopDrawing()


FlipBuffers()

ExamineKeyboard()
Until KeyboardPushed(1)



; ExecutableFormat=Windows
; EOF