#!/bin/zsh

#Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if [[$? -eq 0]]; then
  success = true
  echo "Homebrew was installed correctly\nRunning 'brew bundle'"
  brew bundle 
else
  success = false
  echo "Homebrew installation FAILED!"
fi


#Install Vim-plug for Neovim
if [["$success" = true]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if [[$? -eq 0]]; then
    echo "vim-plug was installed correctly"
  fi
fi

#Symlinks
if [["$success" = true]]; then
  ln -s ~/.dotfiles/alacritty/  ~/.config/alacritty/
  ln -s ~/.dotfiles/git/  ~/.config/git/
  ln -s ~/.dotfiles/nvim/  ~/.config/nvim/
  ln -s ~/.dotfiles/zsh/  ~/.config/zsh/

  ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/.vimrc ~/.vimrc
  ln -s ~/.dotfiles/.zshenv ~/.zshenv
  echo "Created symlinks"
fi

if [["$success" = true]]; then
  #Racket
  raco install xrepl --auto #Better repl, with dependencies (There's a lot).

  #Python
  conda init zsh #Initialize base conda environment
  conda install -c conda-forge jupyterlab #Install and setup Jupyter
  conda install jupyterthemes
  jt -t gruvbox

  #Javascript
  npm install -g p5-manager
if 

