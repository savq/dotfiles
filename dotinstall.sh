#!/bin/sh

# Install Homebrew and the formulas listed in the brewfile
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' &&
  brew bundle || { echo 'brew failed'; exit 1; }

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

# Symlink stuff to $HOME
ln -s ~/.config/nvim/vimrc   ~/.vimrc
ln -s ~/.config/zsh/.zshenv  ~/.zshenv

echo 'Created symlinks'

