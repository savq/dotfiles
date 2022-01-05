# Dotfiles

## Setup

```sh
git clone https://github.com/savq/dotfiles.git ~/.config
cd ~/.config
make install
 ```

### Editor: [Neovim](https://github.com/neovim/neovim/)

- [`nvim/vimrc`](./nvim/vimrc) has a minimal setup. It's vim 8 compatible and uses no plugins.
- [`nvim/init.lua`](./nvim/init.lua) has configurations for plugins and Neovim specific features
  (tree-sitter, LSP, etc.)

### Shell: [Zsh](https://www.zsh.org/)

- [`zsh/.zshrc`](./zsh/.zshrc) includes aliases and some basic options.
- [`zsh/prompt_savq_setup`](./zsh/prompt_savq_setup) has a minimal prompt with git support.
- Plugins:
  - [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)


### Other stuff

* Colorscheme: [melange](https://github.com/savq/melange)
* Terminal emulator: [Wezterm](https://github.com/wez/wezterm)

