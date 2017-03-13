InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"CopyScreenPart Test")

LoadSprite(1,"image.bmp")

Repeat
  
  ClearScreen(0,0,0)
  DisplaySprite(1,0,0)
  
  X+XP
  Y+YP
  If X<=0:XP=5:EndIf
  If Y<=0:YP=5:EndIf
  
  If X>=1024:XP=-5:EndIf
  If Y>=768:YP=-5:EndIf
  
  CopyScreenPart(0,0,200,50,X-100,Y-25)
  
  FlipBuffers()
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
