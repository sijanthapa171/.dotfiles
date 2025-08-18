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

# Enable WSL features
Write-Host "Enabling WSL features..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart

# Update WSL
Write-Host "Updating WSL..."
wsl --update
wsl --set-default-version 2

# Ask user for WSL distribution preference
Write-Host "`nWSL Distribution Options:"
Write-Host "1. Debian (Default - Easy setup)"
Write-Host "2. NixOS (Advanced - Declarative configuration)"
Write-Host "3. Both (Install both distributions)"

$choice = Read-Host "`nChoose your WSL distribution (1-3)"

switch ($choice) {
    "1" {
        Write-Host "Installing Debian..."
        wsl --install -d Debian --web-download
    }
    "2" {
        Write-Host "Installing NixOS..."
        Install-NixOS-WSL
    }
    "3" {
        Write-Host "Installing both Debian and NixOS..."
        wsl --install -d Debian --web-download
        Install-NixOS-WSL
    }
    default {
        Write-Host "Invalid choice. Installing Debian as default..."
        wsl --install -d Debian --web-download
    }
}

Write-Host "`nWSL installation complete!"
Write-Host "Restart is recommended for optimal performance."

function Install-NixOS-WSL {
    Write-Host "Setting up NixOS WSL..."
    
    # Create NixOS directory
    $nixosDir = "$env:USERPROFILE\NixOS"
    if (!(Test-Path $nixosDir)) {
        New-Item -ItemType Directory -Path $nixosDir -Force
    }
    
    # Download NixOS WSL image
    $nixosImageUrl = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl.tar.gz"
    $nixosImagePath = "$nixosDir\nixos-wsl.tar.gz"
    
    Write-Host "Downloading NixOS WSL image..."
    try {
        Invoke-WebRequest -Uri $nixosImageUrl -OutFile $nixosImagePath
    } catch {
        Write-Error "Failed to download NixOS WSL image. Please download manually from:"
        Write-Host "https://github.com/nix-community/NixOS-WSL/releases"
        return
    }
    
    # Import NixOS WSL
    Write-Host "Importing NixOS WSL..."
    try {
        wsl --import NixOS $nixosDir $nixosImagePath --version 2
        Write-Host "NixOS WSL imported successfully!"
        
        # Set up NixOS configuration
        Setup-NixOS-Configuration
    } catch {
        Write-Error "Failed to import NixOS WSL: $_"
    }
}

function Setup-NixOS-Configuration {
    Write-Host "Setting up NixOS configuration..."
    
    # Enter NixOS and set up configuration
    $setupScript = @"
# Enter NixOS
wsl -d NixOS

# Clone the NixOS configuration
git clone https://github.com/sijanthapa171/nixos-wsl.git /tmp/configuration
cd /tmp/configuration

# Apply initial configuration
sudo nixos-rebuild switch --flake /tmp/configuration

# Move configuration to home directory
mv /tmp/configuration ~/configuration

# Exit NixOS
exit
"@
    
    # Save setup script
    $setupScriptPath = "$env:USERPROFILE\setup-nixos.ps1"
    $setupScript | Out-File -FilePath $setupScriptPath -Encoding UTF8
    
    Write-Host "NixOS WSL setup script saved to: $setupScriptPath"
    Write-Host "Run the following command to complete NixOS setup:"
    Write-Host "powershell -ExecutionPolicy Bypass -File `"$setupScriptPath`""
}