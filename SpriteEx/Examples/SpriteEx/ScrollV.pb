InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"ScrollV()")

LoadSprite(1,"image.bmp")

DisplaySprite(1,320,200)

Repeat
  ScrollV(-1)
  CopyBuffer()
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; EOF