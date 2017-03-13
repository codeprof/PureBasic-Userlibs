InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"CopyScreenPart Test")

LoadSprite(1,"image.bmp")



For X=0 To 3
For Y=0 To 6
DisplaySprite(1,250*X,100*Y)
Next
Next

StartSpecialFX()
RestoreScreen()
DisplayRGBFilter(0,0,1024,768,128,128,128) 
StopSpecialFX()

FlipBuffers()

Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; EOF