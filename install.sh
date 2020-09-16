#!/bin/zsh

# Symlinks
mkdir ~/.config
ln -s ~/.dotfiles/alacritty ~/.config/
ln -s ~/.dotfiles/git       ~/.config/
ln -s ~/.dotfiles/nvim      ~/.config/
ln -s ~/.dotfiles/zsh       ~/.config/

ln -s ~/.dotfiles/zshenv     ~/.zshenv
ln -s ~/.dotfiles/tmux.conf  ~/.tmux.conf
echo 'Created symlinks'

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &&
  brew bundle || { echo 'brew failed' ; exit 1; }

# Vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

