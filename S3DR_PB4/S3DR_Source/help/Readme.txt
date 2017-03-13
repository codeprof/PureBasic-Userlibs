Sprite3DReal v1.3		29.06.05
~~~~~~~~~~~~~~~~~

Sprite3DReal is a small 3DEngine for PureBasic. 
The Sprite3DReal-Library was tested with Windows 2000 and Windows XP. 

IMPORTANT:
Use this software at your own risk.

Changes since v1.3b:
- improved CONV2S3DR.EXE checks now weather the converted file is corrupt 
- improved Sprite3DReal uses now the TnLHal-Device if available
- added optional ScaleX.f,ScaleY.f,ScaleZ.f parameters for the S3DR_DrawMesh()-command
- added ability to use software-rendering
- added S3DR_ScrollTexture(ScrollH.f,ScrollV.f)
- added S3DR_RotateTexture(Angle.f)

Changes since v1.2:
- improved S3DR_Draw3D() don't use diffusecolors if they aren't needed
- improved S3DR_SetDiffuseColors()
- improved S3DR_SetTextureCoordinates()
- improved S3DR_RotateCamera() size/speed improvement
- improved S3DR_MoveCamera() size/speed improvement
- corrected S3DR_RotateCamera() AngleX and AngleY were swapped
- corrected S3DR_GetCameraAngleX()
- corrected S3DR_GetCameraAngleY()
- corrected S3DR_DrawMesh() AngleX and AngleY were swapped (Thanks to Psychophanta)

Changes since v1.0:
- splitted Library in 5 parts.
- added sourcecode
- added mesh converter for x-files.
- added command S3DR_SetDiffuseColors()
- added command S3DR_SetCameraRangeAndFOV()
- added command S3DR_TestCollision()
- added command S3DR_LoadMesh()
- added command S3DR_DrawMesh()
- added command S3DR_FreeMesh()
- added command S3DR_StartCreateMesh()
- added command S3DR_StopCreateMesh()
- added command S3DR_CreateMesh_AddTriangle()
- added command S3DR_CreateMesh_AddQuad()
- added command S3DR_CreateMesh_SetQuadTextureCoords()
- added command S3DR_CreateMesh_SetTriangleCoords()
- added command S3DR_SetCameraPos()
- added command S3DR_SetCameraAngles()

Contact:
Email: MoebiusStefan@AOL.COM

Thanks to:(alphabetical order)
André,Neotoma,Psychophanta,Shannara