# dotfiles

Dotfiles for:
- Installing all the programs I commonly use with Homebrew.
- Alacritty
- Neovim, with Vim-plug
- Tmux
- Zsh, with Antibody

The `install.sh` is used to install Homebrew and Vim-plug; to run `brew bundle`,
to add symlinks and to download some packages for various programming languages.
After that, sourcing `init.vim` and running `:PlugInstall` should install all
Vim plug-ins. Antibody installs plug-ins automatically.

