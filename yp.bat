@echo off
REM This is a Windows batch script that performs different yt-dlp commands based on the parameters.

REM If only one parameter (Video ID) is passed, it will list available formats.
if "%2"=="" (
    yt-dlp %1 -F -v
    exit /b 0
)

REM If the second parameter is "720," it will download a high-definition 720p video.
if "%2"=="720" (
    yt-dlp %1 -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]"
    exit /b 0
)

REM If the second parameter is "1080," it will download a full high-definition 1080p video.
if "%2"=="1080" (
    yt-dlp %1 -f "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]"
    exit /b 0
)

REM If multiple parameters are passed, all parameters will be passed to yt-dlp.
yt-dlp %* -v
