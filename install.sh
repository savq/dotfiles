#!/bin/zsh

# Install Homebrew and download formulas listed on the Brefile
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &&
  brew bundle || { echo 'brew failed' ; exit 1; }

# Create symlinks
ln -s ~/.config/julia     ~/.julia/config
ln -s ~/.config/zshenv     ~/.zshenv
echo 'Created symlinks'

