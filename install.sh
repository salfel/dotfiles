#! /usr/bin/bash

sudo pacman -S stow hyprpaper hyprlock hypridle ulauncher neovim waybar wl-clipboard yazi lazygit zsh-autosuggestions zsh-syntax-highlighting

# ZSH
sudo lchsh $USER

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Tmux tmp
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
