InitSprite()

OpenScreen(1024,768,16,"Speedtest Box() vs ColorBox()")
FlipBuffers()

Start=GetTickCount_()
StartDrawing(ScreenOutput())
PixelFormat=DrawingBufferPixelFormat() 
StopDrawing()
Color=RGBColor(PixelFormat,255,255,0);yellow

For M=0 To 10000
  Error=ColorBox(Random(1024),Random(768),50,50,Color)
Next
Erg1=GetTickCount_()-Start


Delay(1000)


Start=GetTickCount_()
Color=RGB(255,255,0);yellow

StartDrawing(ScreenOutput())
For M=0 To 10000
  Box(Random(1024),Random(768),50,50,Color)
Next
StopDrawing()
Erg2=GetTickCount_()-Start



FlipBuffers()

Text$="needed time:"+Chr(13)
Text$+"ColorBox() "+Str(Erg1)+" ms"+Chr(13)
Text$+"Box() "+Str(Erg2)+" ms"

If Error
  MessageRequester("Speedtest","ColorBox() is not supported ?")
  End
EndIf
 
MessageRequester("Box() vs ColorBox()",Text$)
; ExecutableFormat=Windows
; DisableDebugger
; EOF