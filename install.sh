#!/bin/zsh

echo "Running install.sh"
#Symlinks
ln -s ~/.dotfiles/alacritty/  ~/.config/alacritty/
ln -s ~/.dotfiles/git/        ~/.config/git/
ln -s ~/.dotfiles/nvim/       ~/.config/nvim/

ln -s ~/.dotfiles/zsh/   ~/.config/zsh/
ln -s ~/.dotfiles/zshenv ~/.zshenv

ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
echo "Created symlinks"

#Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if [[$? -eq 0]]; then
  success = true
  brew bundle 

  raco pkg install --auto xrepl #Better repl, with dependencies (There's a lot).
  npm install -g p5-manager
else
  success = false
fi

#Install Vim-plug for Neovim
if [["$success" = true]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if [[$? -eq 0]]; then
    echo "vim-plug was installed correctly"
  fi
fi

