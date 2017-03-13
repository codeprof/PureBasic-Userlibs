InitSprite()
InitSprite3D()
InitKeyboard()

OpenScreen(800,600,16,"S3DP_SetViewPort()")

LoadSprite(1,"TestBmp1.bmp",#PB_Sprite_Texture)
CreateSprite3D(1,1)



Repeat


ClearScreen(0,255,0)
Start3D()



ZoomSprite3D(1,800,600)
Angle+1
RotateSprite3D(1,Angle,0)

S3DP_SetViewPort(200,150,400,300)

DisplaySprite3D(1,0,0)

Stop3D()

FlipBuffers()

ExamineKeyboard()
Until KeyboardPushed(1)


; ExecutableFormat=Windows
; EOF