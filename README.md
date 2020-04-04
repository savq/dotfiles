# My dotfiles

They require `git` and `curl`. I use them for:

- Homebrew
- Alacritty
- Neovim, with Vim-plug
- Tmux
- Zsh, with Antibody

I use`install.sh` to install Homebrew and Vim-plug; to run `brew bundle`;
to add symlinks; and to download some packages for various programming languages.
After that, sourcing `init.vim` and running `:PlugInstall` should install all
Vim plug-ins.
