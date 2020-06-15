#!/bin/zsh

# Symlinks
ln -s ~/.dotfiles/alacritty  ~/.config/alacritty
ln -s ~/.dotfiles/git        ~/.config/git
ln -s ~/.dotfiles/nvim       ~/.config/nvim
ln -s ~/.dotfiles/zathura    ~/.config/zathura
ln -s ~/.dotfiles/zsh        ~/.config/zsh

ln -s ~/.dotfiles/nvim/vimrc  ~/.vimrc
ln -s ~/.dotfiles/zshenv      ~/.zshenv
ln -s ~/.dotfiles/tmux.conf   ~/.tmux.conf
echo "Created symlinks"

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &&
  brew bundle || { echo 'brew bundle failed' ; exit 1; }

# Vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Jupyter
pip3 install jupyterlab &&
  pip3 install jupyterthemes &&
  jt -t onedork -vim

# p5.js
npm install -g p5-manager

