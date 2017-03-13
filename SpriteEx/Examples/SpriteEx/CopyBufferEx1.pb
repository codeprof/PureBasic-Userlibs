InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"pseudo screenresolution 200x150")

LoadSprite(1,"image.bmp")

Repeat
  ExamineKeyboard()
  
  DisplaySprite(1,0,50)

  WaitForVSync()
  CopyBufferEx(200,150)
  
Until KeyboardPushed(#PB_Key_Escape)
; ExecutableFormat=Windows
; EOF