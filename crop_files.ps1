## Get-ExecutionPolicy -List
# open PowerShell windows and enter following command before execute
## Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

Start-Transcript -Append $("{0:yyyyMMdd_HHmmss}.log" -f $(Get-Date))

$files = @(
    "C:\xxx\yyyy\z1.mov"
    "C:\xxx\yyyy\z2.mov"
)

foreach ($f in $files)
{
    $filename = Split-Path $f -leaf
    $filefolder = Split-Path $f -parent
    $original = Join-Path $filefolder "original"
    $newfile = Join-Path $filefolder $("c.{0}" -f $filename)

    Write-Host Processing: $f

    # crop videos and keep metadata
    ffmpeg -i $f -filter:v "crop=1080:920:0:0" -c:v libx264 -crf 17 -movflags use_metadata_tags -c:a copy $newfile

    # copy original file dates to new file
    (Get-Item -LiteralPath $newfile).CreationTime = (Get-Item -LiteralPath $f).CreationTime
    (Get-Item -LiteralPath $newfile).LastWriteTime = (Get-Item -LiteralPath $f).LastWriteTime
    (Get-Item -LiteralPath $newfile).LastAccessTime = (Get-Item -LiteralPath $f).LastAccessTime

    # move original file to another folder
    mv $f $original
}

Stop-Transcript
