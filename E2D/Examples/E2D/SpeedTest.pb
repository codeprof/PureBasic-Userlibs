
InitSprite()
OpenScreen(800,600,16,"Speedtest Point() vs PointFast()")

StartSpecialFX()

StartDrawing(CurrentBufferOutput())

StartPointFast=ElapsedMilliseconds() 
For M=0 To 100000
  PointFast(0,0):PointFast(0,0):PointFast(0,0):PointFast(0,0):PointFast(0,0)
  PointFast(0,0):PointFast(0,0):PointFast(0,0):PointFast(0,0):PointFast(0,0)
Next
EndPointFast=ElapsedMilliseconds() 

StartPoint=ElapsedMilliseconds() 
For M=0 To 100000
  Point(0,0):Point(0,0):Point(0,0):Point(0,0):Point(0,0)
  Point(0,0):Point(0,0):Point(0,0):Point(0,0):Point(0,0)
Next
EndPoint=ElapsedMilliseconds() 

StopDrawing()

StopSpecialFX()


CloseScreen()

Text$="needed time:"+Chr(13)
Text$+"PointFast():     "+Str(EndPointFast-StartPointFast)+" ms"+Chr(13)
Text$+"Point()       : "+Str(EndPoint-StartPoint)+" ms"+Chr(13)
Text$+"---------------------------------------"+Chr(13)
Text$+"PointFast() is "+StrF((EndPoint-StartPoint)/(EndPointFast-StartPointFast),1)+" times faster."


MessageRequester("Point() vs PointFast()",Text$)
; ExecutableFormat=Windows
; DisableDebugger
; EOF