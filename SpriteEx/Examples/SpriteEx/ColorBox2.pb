InitSprite()
InitKeyboard()

OpenScreen(1024,768,8,"ColorBox Test")

DisplayDirect()
For Index=0 To 255
  ColorBox(100+Index,100,1,100,Index)
Next

Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
StopDisplayDirect()
