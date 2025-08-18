# Auto-Elevate to Admin if not already
function Ensure-Admin {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if (-not $isAdmin) {
        Write-Host "Elevating to Administrator..."
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = "powershell.exe"
        $psi.Arguments = "-ExecutionPolicy Bypass -File `"$PSCommandPath`""
        $psi.Verb = "runas"
        try {
            [System.Diagnostics.Process]::Start($psi) | Out-Null
        } catch {
            Write-Error "User cancelled the UAC prompt. Exiting."
        }
        exit
    }
}

# Call elevation check
Ensure-Admin

# ──────────────────────────────────────────────────────────────────────────────

function Next([string]$title) {
    Write-Host "`n============================================================================================"
    Write-Host "                                   $title"
    Write-Host "============================================================================================`n"
}

# Config Files
Next "Linking .config directory"

$configPath = "$env:USERPROFILE\.config"
$dotfilesConfig = "$env:USERPROFILE\.dotfiles\.config"

# Remove existing .config if it exists
if (Test-Path $configPath) {
    try {
        Remove-Item $configPath -Recurse -Force
        Write-Host "Removed existing .config directory."
    } catch {
        Write-Warning "Failed to remove existing .config: $_"
    }
} else {
    Write-Host ".config does not exist. Skipping removal."
}

# Create symlink
try {
    New-Item -Path $configPath -ItemType SymbolicLink -Value $dotfilesConfig
    Write-Host "Created symbolic link: .config → .dotfiles\.config"
} catch {
    Write-Warning "Failed to create symbolic link: $_"
}

# Install apps
Next "Installing apps"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\apps\index.ps1"

# Install customizations
Next "Installing Customizations"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\customizations\index.ps1"

# Git configuration
Next "Configuring Git"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\git.ps1"

# Miscellaneous
Next "Others"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\others.ps1"

# WSL installation
Next "Installing WSL"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\wsl.ps1"

# NixOS WSL installation (optional)
Write-Host "`nWould you like to install NixOS WSL as well? (y/N)"
$installNixOS = Read-Host
if ($installNixOS -eq "y" -or $installNixOS -eq "Y") {
    Next "Installing NixOS WSL"
    powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\nixos-wsl.ps1"
}
