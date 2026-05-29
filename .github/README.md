# Dotfiles and Setup

![Preview](preview.png)

This repository contains personal dotfiles and setup scripts to bootstrap a Windows and Linux development environment used by the owner. It includes PowerShell installers, AutoHotkey shortcuts, font assets, and Linux init scripts.

## Overview

- Purpose: centralize environment configuration and installer scripts for a fresh machine setup.
- Primary platform: Windows (PowerShell scripts) with support scripts for Linux (WSL and native distros).

## Quick start (Windows)

Prerequisites:

- PowerShell (Windows 10/11)
- Administrator privileges for some installer steps
- `winget`, `wsl` (if using WSL installer)

To bootstrap the machine from your user profile (example):

1. Open PowerShell as Administrator.
2. (Optional) Allow running local scripts:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

3. Run the main setup script:

```powershell
.\setup.ps1
```

The top-level `setup.ps1` will run the installers in `installers\\apps`, `installers\\customizations`, `installers\\git.ps1`, `installers\\others.ps1`, and `installers\\wsl.ps1` in sequence.

## Quick start (Linux)

For Debian-based systems (or WSL Debian):

```bash
./linux/debian/init.sh
```

This will update the system, install `git`, clone the dotfiles repo, and run the Debian-specific `setup.sh`.

## Notable behaviors and safety

- Many scripts create symbolic links from the user profile (for example linking `~/.config` or `~/.gitconfig`) — review the scripts before running.
- `git.ps1` will create SSH keys and attempt to add them via the `gh` CLI. Ensure `gh` is installed and you have network access.
- The WSL installer will enable Windows features and may require a restart.

## How to customize

- Edit the scripts in `installers/` to change behavior (apps installed, font choices, linked config files).
- Fonts and theme files are stored under `installers/customizations/assets` and `\.config` in the repo.

---
---

- `setup.ps1` — full Windows bootstrap
- `installers\\git.ps1` — git/ssh/gh configuration
- `installers\\wsl.ps1` — WSL installation
- `linux/debian/init.sh` — Debian bootstrap
