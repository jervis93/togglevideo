@ECHO OFF
:: Python script

PATH=%PATH%;"%SYSTEMROOT%\System32"

download_toggle_video.py %*

echo Press any key to exit...
pause 
exit
