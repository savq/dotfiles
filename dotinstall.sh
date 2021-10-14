#!/bin/sh

echo 'Install brew and casks in Brewfile'
curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' &&
  brew bundle || { echo 'brew failed'; exit 1; }

echo 'Install nix and packages in nixpkgs/config.nix'
curl -L https://nixos.org/nix/install | sh &&
    nix-env -iA nixpkgs.savqPackages

echo 'Install Paq'
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

echo "Symlink stuff to $HOME"
ln -s ~/.config/nvim/vimrc   ~/.vimrc
ln -s ~/.config/zsh/.zshenv  ~/.zshenv

echo 'DONE'
