#!/bin/bash

# NixOS setup script
# This script installs and configures the NixOS environment

echo "Setting up NixOS environment..."

# Install essential packages using nix-env
echo "Installing essential packages..."
nix-env -iA nixos.curl
nix-env -iA nixos.wget
nix-env -iA nixos.zip
nix-env -iA nixos.unzip
nix-env -iA nixos.starship
nix-env -iA nixos.rustc
nix-env -iA nixos.cargo

# Install kubectl
echo "Installing kubectl..."
curl -LO /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl
rm -f /tmp/kubectl

# Create necessary directories
echo "Creating configuration directories..."
mkdir -p ~/.config
mkdir -p ~/.ssh

# Create symlinks for dotfiles
echo "Setting up symlinks..."
ln -sf ~/.dotfiles/linux/nixos/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/linux/nixos/.config ~/.config
ln -sf ~/.dotfiles/linux/nixos/.gitconfig ~/.gitconfig

# Configure git
echo "Configuring git..."
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Install additional Nix packages for development
echo "Installing development tools..."
nix-env -iA nixos.nodejs
nix-env -iA nixos.python3
nix-env -iA nixos.tmux
nix-env -iA nixos.neovim

echo "NixOS setup complete!"
echo "You may need to restart your shell or run 'source ~/.bashrc'"
