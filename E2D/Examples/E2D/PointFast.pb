InitSprite()
OpenScreen(800,600,16,"PointFast()")

StartDrawing(ScreenOutput())
For M=0 To 1000
  LineXY(Random(100),Random(100),Random(100),Random(100),Random($FFFFFF))
Next

For x=0 To 50
  For y=0 To 50
    Plot(x+300,y+200,PointFast(x,y));PointFast(X,Y) works like Point(X,Y).  
  Next
Next

StopDrawing()

FlipBuffers()

Delay(5000)



; ExecutableFormat=Windows
; EOF