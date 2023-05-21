@echo off
chcp 65001

REM Check if the help flag is present
if "%1"=="/?" (
    call :displayHelp
    exit /b
)

REM Check if directory argument is provided
if "%~1"=="" (
  echo Please provide a directory path as a command line argument.
  exit /b 1
)

REM Read the directory argument
set "directory=%~1"

REM Check if the directory exists
if not exist "%directory%" (
  echo Directory does not exist.
  exit /b 1
)

REM Change to the specified directory
cd /d "%directory%" || (
  echo Failed to change to the specified directory.
  exit /b 1
)

REM Check if there are any files in the directory
dir /b /a-d | findstr "." >nul
if errorlevel 1 (
  echo No files found in the directory.
  exit /b 0
)

REM Read the attributes arguments
set "attributes=%~2 %~3 %~4"

REM Loop through each file in the directory
for %%F in (*) do (
  REM Check if the file is a regular file (not a directory)
  if not "%%~aF"=="d" (
    REM Update file attributes
    attrib -h -r -a "%%F" >nul

    REM Apply requested attributes
    call :applyAttributes "%%F" %attributes%
    echo Attributes updated for %%F
  )
)

exit /b

:applyAttributes
setlocal
set "file=%~1"
shift

REM Loop through each attribute argument
:loop
if "%~1"=="" goto :eof

REM Apply the current attribute to the file
if "%~1"=="hidden" (
  attrib +h "%file%" >nul
)

if "%~1"=="readonly" (
  attrib +r "%file%" >nul
)

if "%~1"=="archive" (
  attrib +a "%file%" >nul
)

shift
goto :loop


:displayHelp
echo Usage: part2.bat ^<directory^> [/?] ^<attributes^> 
echo.
echo Description: Changes the attributes of files in a directory.
echo.
echo Arguments:
echo   ^<directory^>  The path to the directory containing the files.
echo   /h           Show this help information.
echo   ^<attributes^> The attributes to set for the files. Available options: hidden, readonly, archive.
echo.
echo Example:
echo   part2.bat "C:\MyFolder" hidden readonly
exit /b
