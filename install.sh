#! /usr/bin/zsh

sudo dnf install -y git curl make gcc cmake zsh stow ripgrep fzf rustup golang 

mkdir $HOME/.local/bin

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Link configs
ln -s $SCRIPT_DIR/nvim $HOME/.config/nvim
ln -s $SCRIPT_DIR/kitty $HOME/.config/kitty
ln -s $SCRIPT_DIR/tmux $HOME/.config/tmux
ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -s $SCRIPT_DIR/.p10k.zsh $HOME/.p10k.zsh
ln -s $SCRIPT_DIR/openproject.sh $HOME/.local/bin/openproject

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin
rm -rf nvim-linux64.tar.gz

# Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# ZSH
sudo lchsh $USER

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Tmux tmp
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Cargo and Rust
rustup install stable

# Nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 21

# Bun
curl -fsSL https://bun.sh/install | bash
bun install -g tailwindcss

# Go Packages
go install github.com/a-h/templ/cmd/templ@latest
go install github.com/cosmtrek/air@latest

ln -sf $SCRIPT_DIR/i3 $HOME/.config/i3
ln -sf $SCRIPT_DIR/networkmanager_dmnu $HOME/.local/bin/networkmanager_dmnu
ln -sf $SCRIPT_DIR/networkmanager-dmenu $HOME/.config/networkmanager-dmenu
ln -sf $SCRIPT_DIR/polybar $HOME/.config/polybar
