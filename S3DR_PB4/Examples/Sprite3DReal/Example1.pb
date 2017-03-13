
InitSprite()
InitSprite3D()


OpenWindow(1,0,0,800,600,"Example 1 (create a depth-Buffer)",#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)

Result=S3DR_CreateZBuffer()

StartDrawing(ScreenOutput())
If Result
  DrawText(0,0,"Z-Buffer successful created.")
Else
  DrawText(0,0,"Can't create Z-Buffer.")
EndIf
StopDrawing()


FlipBuffers()

Delay(2000)

S3DR_FreeZBuffer()
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 7
; Folding = -