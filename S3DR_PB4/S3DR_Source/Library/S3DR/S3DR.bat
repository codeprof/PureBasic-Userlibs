..\..\..\Compilers\Fasm.exe S3DR.ASM
..\..\..\Compilers\Fasm.exe S3DR_LoadMesh.ASM
..\..\..\Compilers\Fasm.exe S3DR_FreeDrawMesh.ASM
..\..\..\Compilers\Fasm.exe S3DR_MeshRest.ASM
..\..\..\Compilers\Fasm.exe S3DR_TestCollision.ASM
..\..\..\Compilers\Fasm.exe S3DR_ROTATE.ASM
..\..\..\Compilers\Fasm.exe S3DR_SCROLL.ASM
..\..\..\Compilers\Fasm.exe S3DR_CompressSprite.ASM

..\..\polib.exe /out:S3DR.lib @S3DR.txt
..\..\LibraryMaker.exe S3DR.DESC
Copy S3DR ..\..\..\PureLibraries\UserLibraries\S3DR
pause
