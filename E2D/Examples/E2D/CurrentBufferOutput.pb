

InitSprite()
InitKeyboard()

OpenScreen(800,600,16,"CurrentBufferOutput()")

StartSpecialFX()

StartDrawing(CurrentBufferOutput()) ;try ScreenOutput() 
For M=0 To 5000
  Plot(Random(800-1),Random(600-1),Random($FFFFFF))
Next
StopDrawing()

StopSpecialFX()

FlipBuffers()

Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_All)
; ExecutableFormat=Windows
; EOF