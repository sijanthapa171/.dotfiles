winget install Seelen.SeelenUI -s winget

winget install JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh.exe --config "$env:USERPROFILE\.config\OhMyPosh\theme.json"

# Windows Terminal Settings
Remove-Item "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
New-Item -Path "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -ItemType SymbolicLink -Value "$env:USERPROFILE\.dotfiles\.config\wterminal\config.json"

# Settings profile folfer
#$rutaRegistro = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
#New-ItemProperty -Path $rutaRegistro -Name Personal -Value '%USERPROFILE%\.config' -Type ExpandString -Force

~\.dotfiles\installers\customizations\fonts.ps1

# Spicetify setup for Spotify customization
~\.dotfiles\installers\customizations\spicetify.ps1