@echo off
REM This is a Windows batch script that merge video and audio using ffmpeg

REM %~z1, Expands %1 to the size of the file.
echo file1: %1, size: %~z1
echo file2: %2, size: %~z2

REM Use video filename for the output file
set output=%1
if %~z2 gtr %~z1 (
    set output=%2
)

set temp=%CD%\temp.mp4
ffmpeg -i %1 -i %2 -c copy %temp%

del %1
del %2
move %temp% %output%
echo output: %output%

pause
