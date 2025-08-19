# 🏠 Personal Dotfiles

A comprehensive collection of dotfiles and setup scripts for Windows and Linux environments. This repository contains configuration files, installation scripts, and customizations for a complete development environment setup.

> Don't blindly use my setup. Use at your own risk!!!

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


## ⌨️ AutoHotkey Shortcuts

- `Ctrl+Alt+=` / `Ctrl+Alt+-`: Volume Up/Down
- `Ctrl+Alt+n`: Type ñ character
- `Win+t`: Open Windows Terminal
- `Win+Shift+f`: Open Firefox
- `Win+\`: Reload AutoHotkey scripts

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/.dotfiles
git pull origin main
# Re-run setup scripts if needed
```

---

**Note:** This setup is designed for personal use and may need customization for your specific needs. Always review scripts before running them on your system.
