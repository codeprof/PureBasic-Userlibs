InitEngine3D()
InitSprite()
InitKeyboard()

OpenScreen(1024,768,16,"CopBufferEx()")

Add3DArchive("",#PB_3DArchive_FileSystem) 
SkyDome("sky_3.jpeg",60)
CreateCamera(0,0,0,50,50)
      
Repeat
ClearScreen(0,0,0)
RenderWorld() 

;FlipBuffers()
WaitForVSync()
CopyBufferEx(ScreenWidth()/2,ScreenHeight()/2)

ExamineKeyboard()
Until KeyboardPushed(#PB_KEY_ESCAPE)
; ExecutableFormat=Windows
; EOF