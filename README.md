# Dotfiles

## Setup

```sh
git clone https://github.com/savq/dotfiles.git ~/.config
cd ~/.config
make
```

### Shell: [fish](https://fishshell.com/docs/current/index.html)

- Set `fish` as [default shell](https://fishshell.com/docs/current/index.html#default-shell).


### Editor: [Neovim](https://github.com/neovim/neovim/)

- [`nvim/vimrc`](./nvim/vimrc) has a minimal setup. It's vim 8 compatible and uses no plugins.
- [`nvim/init.lua`](./nvim/init.lua) has configurations for plugins and Neovim specific features
  (tree-sitter, LSP, etc.)
