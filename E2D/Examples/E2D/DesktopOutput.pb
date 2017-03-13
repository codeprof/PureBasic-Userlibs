StartDrawing(DesktopOutput())
For c=0 To 10
Locate(Random(400),Random(300))
DrawText("Hello World !!!")
Next
StopDrawing()
Delay(500)

; ExecutableFormat=Windows
; EOF