#!/bin/bash

# WSL setup script
# This script installs and configures the WSL environment

echo "Setting up WSL environment..."

# Update and upgrade packages
echo "Updating and upgrading packages..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y \
  curl \
  wget \
  zip \
  unzip \
  build-essential \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release

# Install kubectl
echo "Installing kubectl..."
curl -LO /tmp/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl
rm -f /tmp/kubectl

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
fi

# Install Starship prompt
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Node.js and npm
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Install Python development tools
echo "Installing Python development tools..."
sudo apt install -y python3 python3-pip python3-venv
sudo apt install -y python3-dev

# Install additional development tools
echo "Installing development tools..."
sudo apt install -y \
  tmux \
  neovim \
  htop \
  tree \
  ripgrep \
  fd-find \
  bat \
  exa

# Create necessary directories
echo "Creating configuration directories..."
mkdir -p ~/.config
mkdir -p ~/.ssh

# Create symlinks for dotfiles
echo "Setting up symlinks..."
ln -sf ~/.dotfiles/linux/wsl/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/linux/wsl/.config ~/.config
ln -sf ~/.dotfiles/linux/wsl/.gitconfig ~/.gitconfig

# Configure git
echo "Configuring git..."
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# WSL-specific optimizations
echo "Applying WSL-specific optimizations..."

# Add WSL-specific aliases to bashrc
cat >> ~/.bashrc << 'EOF'

# WSL-specific aliases and configurations
alias explorer='explorer.exe'
alias code='code.exe'
alias notepad='notepad.exe'

# WSL path optimization
export PATH="/mnt/c/Windows/System32:$PATH"
export PATH="/mnt/c/Program\ Files/Windows\ Terminal:$PATH"

# WSL-specific environment variables
export DISPLAY=:0
export LIBGL_ALWAYS_INDIRECT=1

# Source starship prompt
eval "$(starship init bash)"
EOF

echo "WSL setup complete!"
echo "You may need to restart your shell or run 'source ~/.bashrc'"
echo "Note: Some tools like Docker may require a WSL restart to work properly"
