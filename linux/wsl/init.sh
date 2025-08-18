#!/bin/bash

# WSL (Windows Subsystem for Linux) initialization script
# This script sets up the basic environment for WSL

# Detect WSL environment
if ! grep -q Microsoft /proc/version 2>/dev/null; then
    echo "Warning: This script is designed for WSL but doesn't appear to be running in WSL"
    echo "Continuing anyway..."
fi

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install git if not present
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    sudo apt install -y git
fi

# Clone dotfiles repository
if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/sijanthapa171/.dotfiles.git ~/.dotfiles
fi

# Navigate to WSL setup directory
cd ~/.dotfiles/linux/wsl

# Run setup script
if [ -f "./setup.sh" ]; then
    echo "Running WSL setup..."
    chmod +x ./setup.sh
    ./setup.sh
else
    echo "Error: setup.sh not found in ~/.dotfiles/linux/wsl"
    exit 1
fi

echo "WSL initialization complete!"
