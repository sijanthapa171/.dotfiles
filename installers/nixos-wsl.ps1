# NixOS WSL Setup Script
# This script automates the installation and configuration of NixOS WSL

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

Write-Host "🚀 NixOS WSL Setup Script"
Write-Host "========================`n"

# Check if WSL is enabled
Write-Host "🔍 Checking WSL status..."
$wslStatus = wsl --status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  WSL not detected. Enabling WSL features..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    dism.exe /online /enable-feature /featurename:HypervisorPlatform /all /norestart
    Write-Host "✅ WSL features enabled. Please restart your computer and run this script again."
    exit 1
}

# Update WSL
Write-Host "📦 Updating WSL..."
wsl --update
wsl --set-default-version 2

# Create NixOS directory
$nixosDir = "$env:USERPROFILE\NixOS"
if (!(Test-Path $nixosDir)) {
    New-Item -ItemType Directory -Path $nixosDir -Force
    Write-Host "✅ Created NixOS directory: $nixosDir"
}

# Download NixOS WSL image
$nixosImageUrl = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl.tar.gz"
$nixosImagePath = "$nixosDir\nixos-wsl.tar.gz"

Write-Host "📥 Downloading NixOS WSL image..."
try {
    if (Test-Path $nixosImagePath) {
        Write-Host "⚠️  NixOS image already exists. Skipping download."
    } else {
        Invoke-WebRequest -Uri $nixosImageUrl -OutFile $nixosImagePath -UseBasicParsing
        Write-Host "✅ NixOS WSL image downloaded successfully!"
    }
} catch {
    Write-Error "❌ Failed to download NixOS WSL image: $_"
    Write-Host "Please download manually from: https://github.com/nix-community/NixOS-WSL/releases"
    exit 1
}

# Check if NixOS WSL is already installed
$existingDistros = wsl --list --verbose 2>&1
if ($existingDistros -match "NixOS") {
    Write-Host "⚠️  NixOS WSL is already installed. Skipping import."
} else {
    # Import NixOS WSL
    Write-Host "🔧 Importing NixOS WSL..."
    try {
        wsl --import NixOS $nixosDir $nixosImagePath --version 2
        Write-Host "✅ NixOS WSL imported successfully!"
    } catch {
        Write-Error "❌ Failed to import NixOS WSL: $_"
        exit 1
    }
}

# Install win32yank for clipboard integration
Write-Host "📋 Setting up win32yank for clipboard integration..."
try {
    # Check if scoop is available
    $scoopPath = "$env:USERPROFILE\scoop\shims\scoop.ps1"
    if (Test-Path $scoopPath) {
        & $scoopPath install win32yank
        Write-Host "✅ win32yank installed via scoop"
    } else {
        Write-Host "⚠️  Scoop not found. Please install win32yank manually:"
        Write-Host "   scoop install win32yank"
    }
} catch {
    Write-Host "⚠️  Failed to install win32yank: $_"
}

# Create setup script for NixOS configuration
Write-Host "📝 Creating NixOS setup script..."
$setupScript = @"
#!/bin/bash

echo "🚀 Setting up NixOS configuration..."

# Install git if not present
if ! command -v git &> /dev/null; then
    echo "📦 Installing git..."
    nix-env -iA nixpkgs.git
fi

# Clone the NixOS configuration
echo "📥 Cloning NixOS configuration..."
if [ ! -d "/tmp/configuration" ]; then
    git clone https://github.com/sijanthapa171/nixos-wsl.git /tmp/configuration
fi

cd /tmp/configuration

# Check if flake.nix exists
if [ ! -f "flake.nix" ]; then
    echo "❌ flake.nix not found in the configuration repository"
    exit 1
fi

# Apply the configuration
echo "🔧 Applying NixOS configuration..."
sudo nixos-rebuild switch --flake /tmp/configuration

# Move configuration to home directory
echo "📁 Moving configuration to home directory..."
if [ -d "\$HOME/configuration" ]; then
    rm -rf "\$HOME/configuration"
fi
mv /tmp/configuration "\$HOME/configuration"

# Create a symlink to the dotfiles repository
echo "🔗 Creating symlink to dotfiles..."
if [ ! -d "\$HOME/.dotfiles" ]; then
    git clone https://github.com/sijanthapa171/.dotfiles.git "\$HOME/.dotfiles"
fi

# Set up additional configurations
echo "⚙️  Setting up additional configurations..."

# Create .config directory if it doesn't exist
mkdir -p "\$HOME/.config"

# Set up git configuration
if [ ! -f "\$HOME/.gitconfig" ]; then
    ln -sf "\$HOME/.dotfiles/.config/git/config" "\$HOME/.gitconfig"
fi

# Set up SSH configuration
if [ ! -d "\$HOME/.ssh" ]; then
    ln -sf "\$HOME/.dotfiles/.ssh" "\$HOME/.ssh"
fi

echo "✅ NixOS WSL setup complete!"
echo ""
echo "🎉 Your NixOS WSL environment is ready!"
echo ""
echo "📝 Next steps:"
echo "   1. Review and customize the configuration in ~/configuration"
echo "   2. Update packages: nix flake update"
echo "   3. Apply changes: sudo nixos-rebuild switch --flake ~/configuration"
"@

$setupScriptPath = "$nixosDir\setup-nixos.sh"
$setupScript | Out-File -FilePath $setupScriptPath -Encoding UTF8

Write-Host "✅ NixOS setup script created: $setupScriptPath"

# Run the NixOS setup
Write-Host "`n🔧 Running NixOS setup..."
Write-Host "This may take a few minutes..."

try {
    wsl -d NixOS bash -c "chmod +x /mnt/c/Users/$env:USERNAME/NixOS/setup-nixos.sh && /mnt/c/Users/$env:USERNAME/NixOS/setup-nixos.sh"
    Write-Host "✅ NixOS setup completed successfully!"
} catch {
    Write-Error "❌ Failed to run NixOS setup: $_"
    Write-Host "You can run the setup manually by:"
    Write-Host "wsl -d NixOS"
    Write-Host "Then run: /mnt/c/Users/$env:USERNAME/NixOS/setup-nixos.sh"
}

Write-Host "`n🎉 NixOS WSL installation complete!"
Write-Host ""
Write-Host "📝 What was installed:"
Write-Host "   ✅ NixOS WSL distribution"
Write-Host "   ✅ Your NixOS configuration from https://github.com/sijanthapa171/nixos-wsl"
Write-Host "   ✅ Integration with your dotfiles repository"
Write-Host "   ✅ win32yank for clipboard integration"
Write-Host ""
Write-Host "🚀 To start using NixOS WSL:"
Write-Host "   wsl -d NixOS"
Write-Host ""
Write-Host "📚 Useful commands:"
Write-Host "   - View configuration: nvim ~/configuration/home.nix"
Write-Host "   - Update system: sudo nixos-rebuild switch --flake ~/configuration"
Write-Host "   - Search packages: nix search nixpkgs <package-name>"
Write-Host ""
Write-Host "📖 Resources:"
Write-Host "   - NixOS Manual: https://nixos.org/manual/nixos/stable/"
Write-Host "   - Nix Package Search: https://search.nixos.org"
Write-Host "   - Your NixOS Config: https://github.com/sijanthapa171/nixos-wsl"
