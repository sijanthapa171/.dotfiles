#!/bin/bash

# NixOS WSL Setup Script
# This script sets up NixOS WSL with the user's configuration

set -e

echo "🚀 Setting up NixOS WSL..."

# Check if running in WSL
if ! grep -q Microsoft /proc/version 2>/dev/null; then
    echo "❌ This script is designed for WSL but doesn't appear to be running in WSL"
    exit 1
fi

# Check if NixOS is available
if ! command -v nixos-rebuild &> /dev/null; then
    echo "❌ NixOS is not available. Please install NixOS WSL first."
    exit 1
fi

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
if [ -d "$HOME/configuration" ]; then
    rm -rf "$HOME/configuration"
fi
mv /tmp/configuration "$HOME/configuration"

# Set up win32yank for clipboard integration
echo "📋 Setting up win32yank for clipboard integration..."
if command -v scoop &> /dev/null; then
    # If scoop is available on Windows, install win32yank
    echo "Installing win32yank via scoop..."
    scoop install win32yank
else
    echo "⚠️  Please install win32yank manually:"
    echo "   scoop install win32yank"
    echo "   Then add it to your PATH in the NixOS configuration"
fi

# Create a symlink to the dotfiles repository
echo "🔗 Creating symlink to dotfiles..."
if [ ! -d "$HOME/.dotfiles" ]; then
    git clone https://github.com/sijanthapa171/.dotfiles.git "$HOME/.dotfiles"
fi

# Set up additional configurations
echo "⚙️  Setting up additional configurations..."

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Set up git configuration
if [ ! -f "$HOME/.gitconfig" ]; then
    ln -sf "$HOME/.dotfiles/.config/git/config" "$HOME/.gitconfig"
fi

# Set up SSH configuration
if [ ! -d "$HOME/.ssh" ]; then
    ln -sf "$HOME/.dotfiles/.ssh" "$HOME/.ssh"
fi

echo "✅ NixOS WSL setup complete!"
echo ""
echo "🎉 Your NixOS WSL environment is ready!"
echo ""
echo "📝 Next steps:"
echo "   1. Review and customize the configuration in ~/configuration"
echo "   2. Update packages: nix flake update"
echo "   3. Apply changes: sudo nixos-rebuild switch --flake ~/configuration"
echo ""
echo "🔧 Useful commands:"
echo "   - View configuration: nvim ~/configuration/home.nix"
echo "   - Update system: sudo nixos-rebuild switch --flake ~/configuration"
echo "   - Search packages: nix search nixpkgs <package-name>"
echo ""
echo "📚 Resources:"
echo "   - NixOS Manual: https://nixos.org/manual/nixos/stable/"
echo "   - Nix Package Search: https://search.nixos.org"
echo "   - Your NixOS Config: https://github.com/sijanthapa171/nixos-wsl"
