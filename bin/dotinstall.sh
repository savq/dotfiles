#!/bin/sh

# Install Homebrew and the formulas listed in the brewfile
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' &&
  brew bundle || { echo 'brew failed'; exit 1; }

# Symlink stuff to $HOME
ln -s ~/.config/nvim/vimrc   ~/.vimrc
ln -s ~/.config/zsh/.zshenv  ~/.zshenv

# Symlink my shell scripts
ln -s ~/.config/bin/* /usr/local/bin/

echo 'Created symlinks'

