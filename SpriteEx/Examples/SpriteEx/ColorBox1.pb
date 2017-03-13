InitSprite()
InitKeyboard()

Result=OpenScreen(1024,768,32,"ColorBox Test")
If Result=0
  Result=OpenScreen(1024,768,24,"ColorBox Test")
EndIf
If Result=0
  Result=OpenScreen(1024,768,16,"ColorBox Test")
EndIf

StartDrawing(ScreenOutput())
PixelFormat=DrawingBufferPixelFormat() 
StopDrawing()

Blue =RGBColor(PixelFormat,0,0,255)
Green=RGBColor(PixelFormat,0,255,0)
Red  =RGBColor(PixelFormat,255,0,0)

ColorBox(100,100,100,100,Blue)
ColorBox(200,100,100,100,Green)
ColorBox(300,100,100,100,Red)

For X=0 To 255
  ColorBox(100+X,200,1,100,RGBColor(PixelFormat,X,X,X))
Next

FlipBuffers()
Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)
