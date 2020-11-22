#!/bin/sh

# Install Homebrew and download formulas listed on the Brefile
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' &&
  brew bundle || { echo 'brew failed'; exit 1; }

# Create symlinks
ln -s ~/.config/nvim/vimrc   ~/.vimrc
ln -s ~/.config/zsh/.zshenv  ~/.zshenv
echo 'Created symlinks'

# Install Paq :)
git clone https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/opt/paq-nvim
