function Next([string]$title) {
  Write-Host "`n============================================================================================"
  Write-Host "                                   $title"
  Write-Host "============================================================================================`n"
}

# Config Files
Remove-Item "$env:USERPROFILE\.config"
New-Item -Path "$env:USERPROFILE\.config" -ItemType SymbolicLink -Value "$env:USERPROFILE\.dotfiles\.config"

Next "Installing apps"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\apps\index.ps1"

Next "Installing Customizations"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\customizations\index.ps1"

Next "Configuring Git"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\git.ps1"

Next "Others"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\others.ps1"

Next "Installing WSL"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\wsl.ps1"