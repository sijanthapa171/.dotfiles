dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart

wsl --update
wsl --set-default-version 2
wsl --install -d Debian --web-download

Write-Host "Restart is Recomended"