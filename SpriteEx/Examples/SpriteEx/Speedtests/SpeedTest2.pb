InitSprite()

OpenScreen(1024,768,16,"Speedtest CopyScreenPart() vs GrabSprite()+DisplaySprite()")
FlipBuffers()


Start=GetTickCount_()

For M=0 To 10000
  GrabSprite(1,0,0,200,50)
  DisplaySprite(1,Random(1024),Random(768))
Next

Erg2=GetTickCount_()-Start

Delay(1000)


Start=GetTickCount_()

For M=0 To 10000
  Error=CopyScreenPart(0,0,200,50,Random(1024),Random(768))
Next
Erg1=GetTickCount_()-Start


FlipBuffers()

Text$="needed time:"+Chr(13)
Text$+"CopyScreenPart() "+Str(Erg1)+" ms"+Chr(13)
Text$+"GrabSprite()+DisplaySprite() "+Str(Erg2)+" ms"

If Error
  MessageRequester("Speedtest","CopyScreenPart() is not supported ?")
  End
EndIf
 
MessageRequester("CopyScreenPart() vs GrabSprite()+DisplaySprite()",Text$)
; ExecutableFormat=Windows
; DisableDebugger
; EOF