# 🏠 Personal Dotfiles

A comprehensive collection of dotfiles and setup scripts for Windows and Linux environments. This repository contains configuration files, installation scripts, and customizations for a complete development environment setup.

## 🚀 Quick Start

### Windows Setup

1. **Run the initial setup script:**
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/sijanthapa171/.dotfiles/main/init.ps1")
   ```

2. **Or manually clone and run:**
   ```powershell
   git clone https://github.com/sijanthapa171/.dotfiles.git "$env:USERPROFILE\.dotfiles"
   powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\setup.ps1"
   ```

### Linux Setup

Navigate to the `linux/` directory and choose your distribution:

```bash
cd linux/
# Choose your distribution folder and run init.sh
```

### NixOS WSL Setup

For a declarative, reproducible development environment:

```powershell
# Run the dedicated NixOS WSL installer
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\installers\nixos-wsl.ps1"
```

This will:
- Download and install NixOS WSL
- Clone your NixOS configuration from [sijanthapa171/nixos-wsl](https://github.com/sijanthapa171/nixos-wsl)
- Set up integration with your dotfiles
- Install win32yank for clipboard integration

## 📁 Repository Structure

```
.dotfiles/
├── AutoHotKeys/           # AutoHotkey scripts and shortcuts
├── .config/              # Configuration files (symlinked)
│   ├── git/             # Git configuration
│   ├── nvim/            # Neovim configuration
│   ├── OhMyPosh/        # PowerShell theming
│   ├── wterminal/       # Windows Terminal settings
│   ├── ferium/          # Minecraft mod manager config
│   ├── neofetch/        # System info display
│   └── scoop/           # Scoop package manager config
├── installers/          # Installation scripts
│   ├── apps/           # Application installations
│   ├── customizations/ # UI customizations and fonts
│   ├── git.ps1         # Git and SSH setup
│   ├── nixos-wsl.ps1   # NixOS WSL setup
│   ├── others.ps1      # Miscellaneous configurations
│   └── wsl.ps1         # WSL installation
├── linux/              # Linux distribution scripts
│   ├── arch/           # Arch Linux setup
│   ├── debian/         # Debian/Ubuntu setup
│   ├── nixos/          # NixOS setup
│   └── wsl/            # WSL-specific setup
├── init.ps1            # Initial Windows setup
└── setup.ps1           # Main Windows configuration
```

## 🛠️ What Gets Installed

### Applications (Windows)
- **Development Tools:**
  - Visual Studio 2022 Community & Build Tools
  - Visual Studio Code
  - Node.js (LTS)
  - Rust & Rustup
  - Deno
  - Docker Desktop
  - MongoDB Compass
  - Postman

- **Browsers & Communication:**
  - Mozilla Firefox + Firefox PWA
  - Vencord (Discord client)

- **Utilities:**
  - KeePassXC (Password manager)
  - Spark Email Client
  - Steam
  - AutoHotkey
  - MSIX Hero & Packaging Tool

- **Package Managers:**
  - Scoop (with kubecolor, ferium)

### Customizations
- **Terminal & Shell:**
  - Oh My Posh with custom theme
  - Windows Terminal configuration
  - PowerShell updates

- **UI Enhancements:**
  - SeelenUI
  - FiraCode Nerd Fonts (all variants)

- **System Integration:**
  - AutoHotkey shortcuts for volume control and quick access
  - Symbolic links for configuration files
  - Startup script integration

### Git & SSH Setup
- Automatic SSH key generation (ed25519)
- GitHub CLI authentication
- SSH key management for authentication and signing
- Git configuration symlinking

## ⌨️ AutoHotkey Shortcuts

- `Ctrl+Alt+=` / `Ctrl+Alt+-`: Volume Up/Down
- `Ctrl+Alt+n`: Type ñ character
- `Win+t`: Open Windows Terminal
- `Win+Shift+f`: Open Firefox
- `Win+\`: Reload AutoHotkey scripts

## 🐧 Linux Support

### Supported Distributions
- **Arch Linux** - Full setup with package management
- **Debian/Ubuntu** - Apt-based installation
- **NixOS** - Nix package manager integration
- **WSL** - Windows Subsystem for Linux

### Linux Features
- Development tool installation (Rust, Node.js, Python)
- Shell configuration
- kubectl setup
- Configuration file symlinking
- Distribution-specific optimizations

### NixOS WSL Features
- Declarative system configuration with Nix
- Integration with your [NixOS WSL configuration](https://github.com/sijanthapa171/nixos-wsl)
- nixvim as the default editor
- zsh with Starship prompt
- fzf, lsd, zoxide, and broot integration
- Docker support
- win32yank for clipboard integration
- Automatic package management with flakes

## 🔧 Configuration Files

The setup creates symbolic links for:
- `.config/` directory → `.dotfiles/.config/`
- `.gitconfig` → `.dotfiles/.config/git/config`
- `.ssh/` → `.dotfiles/.ssh/`
- Windows Terminal settings
- AutoHotkey startup script

## 🚨 Prerequisites

### Windows
- Windows 10/11
- PowerShell 5.1 or higher
- Administrator privileges (for installation)
- Internet connection for winget downloads

### Linux
- Supported distribution (Arch, Debian, NixOS, WSL)
- sudo privileges
- Git installed

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/.dotfiles
git pull origin main
# Re-run setup scripts if needed
```

---

**Note:** This setup is designed for personal use and may need customization for your specific needs. Always review scripts before running them on your system.
