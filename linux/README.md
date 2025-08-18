# Linux Setup Scripts

This directory contains setup scripts for different Linux distributions and environments.

## Available Distributions

### Arch Linux
- **`arch/init.sh`** - Initial setup script for Arch Linux
- **`arch/setup.sh`** - Main configuration script for Arch Linux

### Debian/Ubuntu
- **`debian/init.sh`** - Initial setup script for Debian-based systems
- **`debian/setup.sh`** - Main configuration script for Debian-based systems

### NixOS
- **`nixos/init.sh`** - Initial setup script for NixOS
- **`nixos/setup.sh`** - Main configuration script for NixOS using Nix package manager

### WSL (Windows Subsystem for Linux)
- **`wsl/init.sh`** - Initial setup script for WSL environments
- **`wsl/setup.sh`** - Main configuration script for WSL with Windows integration

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Eythaann/.dotfiles.git
   cd .dotfiles/linux
   ```

2. **Choose your distribution and run the init script:**
   ```bash
   # For Arch Linux
   cd arch
   chmod +x init.sh
   ./init.sh
   
   # For Debian/Ubuntu
   cd debian
   chmod +x init.sh
   ./init.sh
   
   # For NixOS
   cd nixos
   chmod +x init.sh
   ./init.sh
   
   # For WSL
   cd wsl
   chmod +x init.sh
   ./init.sh
   ```

## What Each Script Does

### Init Scripts
- Check if running on the correct system
- Install git if not present
- Clone the dotfiles repository
- Run the corresponding setup script

### Setup Scripts
- Install essential packages and development tools
- Configure the shell environment
- Set up development tools (Rust, Node.js, Python, etc.)
- Install and configure kubectl
- Set up symlinks for configuration files
- Apply distribution-specific optimizations

## Prerequisites

- **Arch Linux**: Must be running on Arch Linux with `nix-env` available
- **Debian/Ubuntu**: Must be running on a Debian-based system with `apt` package manager
- **NixOS**: Must be running on NixOS with `nix-env` available
- **WSL**: Must be running in Windows Subsystem for Linux environment

## Customization

Each setup script can be customized by editing the corresponding `setup.sh` file. Common customizations include:

- Git user configuration
- Additional package installations
- Custom shell configurations
- Development tool preferences

## Notes

- Scripts require sudo privileges for package installation
- Some tools may require a shell restart to work properly
- WSL setup includes Windows integration features
- NixOS setup uses the Nix package manager for consistent environments
