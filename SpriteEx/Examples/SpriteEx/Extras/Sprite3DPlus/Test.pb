InitSprite()
InitSprite3D()

InitKeyboard()

OpenScreen(1024,768,16,"Sprite3DPlus Test")
LoadSprite(1,"tree.bmp",#PB_Sprite_Texture)
CreateSprite3D(1,1)

Repeat
ClearScreen(0,255,0)

Start3D()


ZoomSprite3D(1,128,128)
RotateSprite3D(1,1,1)


Sprite3DUseTransparency(1)
Sprite3DFillMode(3)
Sprite3DUseFog(0,0)
DisplaySprite3D(1,100,100,255)

Sprite3DUseTransparency(1)
Sprite3DFillMode(3)
Sprite3DUseFog(1,#red)
DisplaySprite3D(1,500,100,255)

Sprite3DUseTransparency(0)
Sprite3DFillMode(2)
Sprite3DUseFog(1,#blue)
DisplaySprite3D(1,100,400,255)

Sprite3DUseTransparency(0)
Sprite3DFillMode(1)
Sprite3DUseFog(0,0)
DisplaySprite3D(1,500,400,255)


Stop3D()

FlipBuffers()

ExamineKeyboard()
Until KeyboardPushed(#PB_KEY_ESCAPE)

; ExecutableFormat=Windows
; EOF