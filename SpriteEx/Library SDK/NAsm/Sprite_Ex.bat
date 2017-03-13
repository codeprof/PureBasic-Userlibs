..\..\Compilers\Fasm.exe Sprite_EX1.ASM Sprite_EX1.OBJ
..\..\Compilers\Fasm.exe Sprite_EX2.ASM Sprite_EX2.OBJ
..\..\Compilers\Fasm.exe Sprite_EX3.ASM Sprite_EX3.OBJ

..\lcclib /out:Sprite_EX.lib @Sprite_EX.txt
..\LibraryMaker.exe NASM\Sprite_EX.DESC
Copy ..\Sprite_EX ..\..\PureLibraries\UserLibraries\Sprite_EX
pause





