#!/bin/zsh

#Symlinks
ln -s ~/.dotfiles/alacritty/  ~/.config/alacritty/
ln -s ~/.dotfiles/git/        ~/.config/git/
ln -s ~/.dotfiles/nvim/       ~/.config/nvim/

ln -s ~/.dotfiles/zsh/   ~/.config/zsh/
ln -s ~/.dotfiles/zshenv ~/.zshenv

ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
echo "Created symlinks"

#Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    #Install programs listed on the Brewfile
    && brew bundle \
    #Install Vim-plug for Neovim
    && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    #Better repl, with dependencies (There's a lot).
    && raco pkg install --auto xrepl \
    #For p5.js
    | npm install -g p5-manager

# Initialize base conda environment
conda init zsh \
    # Install and setup Jupyter
    && conda install -c conda-forge jupyterlab \
    # Theme extension
    && conda install jupyterthemes \
    # Gruvbox dark theme w/ Vim color support
    && jt -t onedork -vim 

