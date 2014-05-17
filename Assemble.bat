::Remove unwanted text
@ECHO OFF

::Set up properties to reference later
SET BootSector=.\BootSector
SET BIN=%BootSector%\Bin
SET ASM=%BootSector%\Asm
SET ASMINC=%ASM%\Include\
SET VM=.\VM

::Assemble BootSector and add Include directory
ECHO Assembling BootSector...
ECHO.
nasm -f bin -o %BIN%\BootSector.bin -i %ASMINC% %ASM%\BootSector.asm
nasm -f bin -o %BIN%\BootLoader.bin -i %ASMINC% %ASM%\BootLoader.asm
::Catch errors and exit
IF ERRORLEVEL 1 GOTO AsmFail
::If No errors continue

::Copy Binary to the Virtual Machine directory
:AsmComplete
ECHO Assembly complete
ECHO.
ECHO Copying Binary...
ECHO.
copy /Y /b %BIN%\BootSector.bin + /b %BIN%\BootLoader.bin %VM%\BootSector.bin
::Catch errors and exit
IF ERRORLEVEL 1 GOTO CopyFail

::Run Bochs
ECHO.
ECHO Running BOCHS...
ECHO.
START bochsrc.lnk
GOTO END

::Echo fail message
:AsmFail
ECHO.
ECHO Assembly failed
ECHO.
GOTO END  

::Echo fail message
:CopyFail
ECHO.
ECHO Copy failed
ECHO.
GOTO END

:END
PAUSE