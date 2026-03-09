
@ECHO OFF
REM /* Autor: Nicolas - Analista de Sistemas | 2026 */

SETLOCAL

SET "BASEDIR=%~dp0"
IF "%BASEDIR%"=="" SET "BASEDIR=."

SET "WRAPPER_DIR=%BASEDIR%.mvn\wrapper"
SET "PROPERTIES_FILE=%WRAPPER_DIR%\maven-wrapper.properties"

IF NOT EXIST "%PROPERTIES_FILE%" (
  ECHO Erro: arquivo "%PROPERTIES_FILE%" não encontrado.
  EXIT /B 1
)

FOR /F "usebackq tokens=1,* delims==" %%A IN ("%PROPERTIES_FILE%") DO (
  IF "%%A"=="distributionUrl" SET "DIST_URL=%%B"
)

IF "%DIST_URL%"=="" (
  ECHO Erro: propriedade distributionUrl não definida em "%PROPERTIES_FILE%".
  EXIT /B 1
)

FOR %%A IN ("%DIST_URL%") DO SET "DIST_ZIP_NAME=%%~nxA"
SET "MAVEN_DIR_NAME=apache-maven-3.9.9"
SET "DIST_ZIP_PATH=%WRAPPER_DIR%\%DIST_ZIP_NAME%"
SET "MAVEN_DIR=%WRAPPER_DIR%\%MAVEN_DIR_NAME%"

IF NOT EXIST "%WRAPPER_DIR%" (
  MKDIR "%WRAPPER_DIR%" 2>NUL
)

IF NOT EXIST "%MAVEN_DIR%" (
  ECHO Baixando Maven de %DIST_URL%...

  REM Tenta usar PowerShell para download
  POWERSHELL -Command "try { Invoke-WebRequest -UseBasicParsing -Uri '%DIST_URL%' -OutFile '%DIST_ZIP_PATH%' } catch { exit 1 }"
  IF ERRORLEVEL 1 (
    ECHO Erro ao baixar Maven de %DIST_URL%.
    EXIT /B 1
  )

  ECHO Extraindo Maven para "%WRAPPER_DIR%"...
  POWERSHELL -Command "try { Expand-Archive -Path '%DIST_ZIP_PATH%' -DestinationPath '%WRAPPER_DIR%' -Force } catch { exit 1 }"
  IF ERRORLEVEL 1 (
    ECHO Erro ao extrair arquivo "%DIST_ZIP_PATH%".
    EXIT /B 1
  )
)

SET "MVN_CMD=%MAVEN_DIR%\bin\mvn.cmd"
IF NOT EXIST "%MVN_CMD%" SET "MVN_CMD=%MAVEN_DIR%\bin\mvn.bat"

IF NOT EXIST "%MVN_CMD%" (
  ECHO Erro: comando Maven não encontrado em "%MAVEN_DIR%\bin".
  EXIT /B 1
)

"%MVN_CMD%" %*

ENDLOCAL
