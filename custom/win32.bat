@echo off
rem //EP added in version 0.9.22
rem must be called manually at end of build
rem contains customization tasks

set CUSTOM=content.zip
set DST=..\data
set FONTS=%DST%\fonts
set LOG=%TEMP%\custom.log

if exist "%CUSTOM%" (
	echo Custom content file %CUSTOM% found
	echo Installing custom content into target folder %DST%
	
	rem clean up fonts folder
	echo Cleaning up fonts folder %FONTS%
	
	rem save the fonts we want to keep
	move %FONTS%\default_font.ttf "%TEMP%"

	rem empty fonts folder
	del /s /q %FONTS%\*

	rem restore the fonts we want to keep
	move "%TEMP%\default_font.ttf" %FONTS%

	rem install content from archive
	echo Extracting content from archive into target
	unzip -yO -x*.icns -x__MACOSX\*.* -d -o %CUSTOM% %DST% > %LOG%

	echo Custom content has been installed
) else (
	echo Custom content file %CUSTOM% not found
)
