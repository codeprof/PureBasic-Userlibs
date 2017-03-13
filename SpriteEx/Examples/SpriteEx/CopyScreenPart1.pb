InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"CopyScreenPart Test")

LoadSprite(1,"image.bmp")

DisplaySprite(1,0,0)
CopyScreenPart(0,0,200, 50,0, 50)
;CopyScreenPart(0,0,200,100,0,100)

FlipBuffers()

Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; EOF