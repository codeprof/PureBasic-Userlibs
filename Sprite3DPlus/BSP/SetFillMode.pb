InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(800,600,16,"S3DP_SetFillMode()")

LoadSprite(1,"TestBmp1.bmp",#PB_Sprite_Texture)
CreateSprite3D(1,1)

Repeat

ClearScreen(0,255,0)

Start3D()

Angle+1
RotateSprite3D(1,Angle,0)

S3DP_SetFillMode(1)
DisplaySprite3D(1,100,150)
S3DP_SetFillMode(2)
DisplaySprite3D(1,300,150)
S3DP_SetFillMode(3)
DisplaySprite3D(1,500,150)

Stop3D()

FlipBuffers()

ExamineKeyboard()
Until KeyboardPushed(1)


; ExecutableFormat=Windows
; EOF