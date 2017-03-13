InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"DisplayDirect Test")

DisplayDirect()

LoadSprite(1,"Ring.bmp")
LoadSprite(2,"Ring2.bmp")

Repeat
  DisplayTransparentSprite(1,Random(1024),Random(768))
  DisplayTransparentSprite(2,Random(1024),Random(768))
  
  Delay(25)
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)

StopDisplayDirect()
End
; ExecutableFormat=Windows
; EOF