InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(800,600,16,"S3DP_UseTransparency()")

LoadSprite(1,"Tree.bmp",#PB_Sprite_Texture)
CreateSprite3D(1,1)

Repeat

ClearScreen(128,128,128)

Start3D()

Angle+1
RotateSprite3D(1,Angle,0)

S3DP_UseTransparency(0)
DisplaySprite3D(1,50,50)
S3DP_UseTransparency(1)
DisplaySprite3D(1,250,50)

Stop3D()


StartDrawing(ScreenOutput())
DrawingMode(1)
Locate(50,150)
DrawText("Transparency OFF")
Locate(250,150)
DrawText("Transparency ON")
StopDrawing()


FlipBuffers()

ExamineKeyboard()
Until KeyboardPushed(1)



; ExecutableFormat=Windows
; EOF