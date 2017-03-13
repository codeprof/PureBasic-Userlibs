
!extrn _PB_DirectX_ScreenWidth 
!extrn _PB_DirectX_ScreenHeight 
!extrn _PB_DirectX_WindowedMode 
!extrn _PB_DirectX_PrimaryBuffer 
!extrn _PB_DirectX_BackBuffer 
!extrn _PB_DDrawBase 
!extrn SpriteEx_PrimaryBuffer

Procedure AllowDisplayWindows() 
  Global _hBmp,_ScreenWidth,_ScreenHeight,_DDrawBase.IDirectDraw7,_FrontDDS.IDirectDrawSurface7,_BackDDS.IDirectDrawSurface7 
  
  _ScreenWidth=ScreenWidth()
  _ScreenHeight=ScreenHeight()
  

  If IsWindowedMode()=0 
  SwapBuffers()
  SwapBuffers()
    !MOV Eax,[_PB_DDrawBase] 
    !MOV [v__DDrawBase],Eax 
    !MOV Eax,[_PB_DirectX_BackBuffer] 
    !MOV [v__BackDDS],Eax 
    !MOV Eax,[SpriteEx_PrimaryBuffer] 
    !MOV [v__FrontDDS],Eax 

    _DDrawBase\GetGDISurface(@GDI_DDS.IDirectDrawSurface7)    
    If GDI_DDS=_BackDDS 
      _BackDDS\BltFast(0,0,_FrontDDS,0,0) 
      FlipBuffers()
    EndIf
    
  Else
    GetClientRect_(ScreenID(),@re.RECT)
    _ScreenWidth=re\right
    _ScreenHeight=re\bottom
  EndIf
  
  DC=GetDC_(ScreenID()) 
  MemDC=CreateCompatibleDC_(DC) 
  _hBmp=CreateCompatibleBitmap_(DC,_ScreenWidth,_ScreenHeight) 
  oldBmp=SelectObject_(MemDC,_hBmp) 
  BitBlt_(MemDC,0,0,_ScreenWidth,_ScreenHeight,DC,0,0,#SRCCOPY) 
  ReleaseDC_(ScreenID(),DC) 
  SelectObject_(MemDC,oldBmp)
  DeleteDC_(MemDC)
  ShowCursor_(-1)
EndProcedure

Procedure ScreenWindowCB(hWnd,Msg,wParam,lParam) 
  OldProc=GetWindowLong_(hWnd,#GWL_USERDATA) 
  Result=CallWindowProc_(OldProc,hWnd,Msg,wParam,lParam)  
  
  If Msg=#WM_PAINT Or Msg=#WM_MOVING Or Msg=#WM_MOVE Or Msg=#WM_ERASEBKGND 
    DC=GetDC_(ScreenID()) 
    MemDC=CreateCompatibleDC_(DC)
    oldBmp=SelectObject_(MemDC,_hBmp)
    BitBlt_(DC,0,0,_ScreenWidth,_ScreenHeight,MemDC,0,0,#SRCCOPY) 
    SelectObject_(MemDC,oldBmp)
    DeleteDC_(MemDC)
    ReleaseDC_(ScreenID(),DC) 
  EndIf
  ProcedureReturn Result 
EndProcedure 

Procedure MakeScreenWindow(WindowID)
  OldCB=SetWindowLong_(WindowID,#GWL_WNDPROC,@ScreenWindowCB()) 
  SetWindowLong_(WindowID,#GWL_USERDATA,OldCB) 
  SetWindowPos_(WindowID,#HWND_TOPMOST,0,0,0,0,#SWP_NOSIZE|#SWP_NOMOVE)  
EndProcedure

Procedure CloseScreenWindow(WindowID)
  SetWindowPos_(ScreenID(),#HWND_TOPMOST,0,0,0,0,#SWP_NOSIZE|#SWP_NOMOVE) 
  DestroyWindow_(WindowID) 
  SetWindowPos_(ScreenID(),#HWND_NOTOPMOST,0,0,0,0,#SWP_NOSIZE|#SWP_NOMOVE) 
EndProcedure

Procedure StopDisplayWindows()
    DC=GetDC_(ScreenID()) 
    MemDC=CreateCompatibleDC_(DC)
    oldBmp=SelectObject_(MemDC,_hBmp)
    BitBlt_(DC,0,0,_ScreenWidth,_ScreenHeight,MemDC,0,0,#SRCCOPY) 
    SelectObject_(MemDC,oldBmp)
    DeleteDC_(MemDC)
    ReleaseDC_(ScreenID(),DC) 
  DeleteObject_(_hBmp)
  ShowCursor_(-1)
EndProcedure
  

  
; ExecutableFormat=Windows
; EOF