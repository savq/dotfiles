#!/bin/sh

curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' &&
  brew bundle || { echo 'brew failed'; exit 1; }

ln -s ~/.config/nvim/.vimrc   ~/.vimrc
ln -s ~/.config/zsh/.zshenv  ~/.zshenv
echo 'Created symlinks'

