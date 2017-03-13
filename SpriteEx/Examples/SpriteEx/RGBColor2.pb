Global Addr,Pitch,PixelFormat

Procedure MyPset(x,y,R,G,B)
  Select PixelFormat
    Case #PB_PixelFormat_15Bits
      PokeW(Addr+y*Pitch+x<<1,RGBColor(#PB_PixelFormat_15Bits,R,G,B))
    Case #PB_PixelFormat_16Bits      
      PokeW(Addr+y*Pitch+x<<1,RGBColor(#PB_PixelFormat_16Bits,R,G,B))
    Case #PB_PixelFormat_24Bits_RGB
      Color=RGBColor(#PB_PixelFormat_24Bits_RGB,R,G,B)
      Addr=Addr+y*Pitch+x*3
      PokeW(Addr,Color)
      PokeB(Addr+1,Color>>24)
    Case #PB_PixelFormat_24Bits_BGR 
      Color=RGBColor(#PB_PixelFormat_24Bits_BGR,R,G,B)
      Addr=Addr+y*Pitch+x*3
      PokeW(Addr,Color)
      PokeB(Addr+1,Color>>24)
    Case #PB_PixelFormat_32Bits_RGB  
      PokeL(Addr+y*Pitch+x<<2,RGBColor(#PB_PixelFormat_32Bits_RGB,R,G,B))
    Case #PB_PixelFormat_32Bits_BGR       
      PokeL(Addr+y*Pitch+x<<2,RGBColor(#PB_PixelFormat_32Bits_BGR,R,G,B))
  EndSelect
EndProcedure

InitSprite()
InitKeyboard()

Result=OpenScreen(1024,768,32,"RGBColor Test")
If Result=0
  Result=OpenScreen(1024,768,24,"RGBColor Test")
EndIf
If Result=0
  Result=OpenScreen(1024,768,16,"RGBColor Test")
EndIf

StartDrawing(ScreenOutput())
PixelFormat=DrawingBufferPixelFormat() 
Pitch=DrawingBufferPitch() 
Addr=DrawingBuffer() 

For y=0 To 255
  For x=0 To 255
    MyPset(200+x,200+y,255,y,x)
  Next
Next
StopDrawing()

FlipBuffers()
Repeat
  ExamineKeyboard()
Until KeyboardPushed(#PB_Key_Escape)