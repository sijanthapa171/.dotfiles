#!/bin/bash

# NixOS initialization script
# This script sets up the basic environment for NixOS

# Ensure we're on NixOS
if ! command -v nix-env &> /dev/null; then
    echo "Error: This script must be run on a NixOS system"
    exit 1
fi

# Install git if not present
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    nix-env -iA nixos.git
fi

# Clone dotfiles repository
if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/thapasijan171/.dotfiles.git ~/.dotfiles
fi

# Navigate to NixOS setup directory
cd ~/.dotfiles/linux/nixos

# Run setup script
if [ -f "./setup.sh" ]; then
    echo "Running NixOS setup..."
    chmod +x ./setup.sh
    ./setup.sh
else
    echo "Error: setup.sh not found in ~/.dotfiles/linux/nixos"
    exit 1
fi

echo "NixOS initialization complete!"
