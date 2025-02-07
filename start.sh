#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y \
  git curl wget tmux htop neofetch build-essential \
  zsh ripgrep fzf python3-pip \
  nodejs npm

# Install Neovim (latest stable)
wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O ~/nvim
chmod +x ~/nvim
sudo mv ~/nvim /usr/local/bin/nvim

# Install LazyVim environment
mkdir -p ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Install oh-my-zsh (Optional)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Python packages
pip3 install --user pynvim ranger-fm thefuck

# Set default shell to Zsh
chsh -s $(which zsh)

echo "✅ Setup complete! Restart your shell."
