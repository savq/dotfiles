# Dotfiles

## Setup

```sh
git clone https://github.com/savq/dotfiles.git ~/.config
cd ~/.config
make
 ```

### Editor: [Neovim](https://github.com/neovim/neovim/)

- [`nvim/vimrc`](./nvim/vimrc) has a minimal setup. It's vim 8 compatible and uses no plugins.
- [`nvim/init.lua`](./nvim/init.lua) has configurations for plugins and Neovim specific features
  (tree-sitter, LSP, etc.)


### Shell: [Zsh](https://www.zsh.org/)

- [`zsh/.zshrc`](./zsh/.zshrc) includes aliases and some basic options.
- [`zsh/prompt_savq_setup`](./zsh/prompt_savq_setup) has a minimal prompt with git support.


### Other stuff

Listed on the [`Brewfile`](./Brewfile)
