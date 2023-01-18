XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
PAQ_PATH = $(XDG_DATA_HOME)/nvim/site/pack/paqs
BREW_SCRIPTS_URL = https://raw.githubusercontent.com/Homebrew/install/HEAD

.PHONY: install brew nvim symlinks \
	clean clean.brew clean.nvim clean.symlinks

install: brew nvim symlinks rust

brew:
	curl -fsSL '$(BREW_SCRIPTS_URL)/install.sh' > install.sh
	/bin/bash install.sh
	brew bundle --file $(XDG_CONFIG_HOME)/Brewfile

nvim:
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

symlinks:
	ln -s $(XDG_CONFIG_HOME)/nvim/vimrc   $(HOME)/.vimrc
	ln -s $(XDG_CONFIG_HOME)/zsh/.zshenv  $(HOME)/.zshenv

rust:
	rustup completions zsh cargo > $(XDG_CONFIG_HOME)/zsh/_cargo
	rustup completions zsh rustup > $(XDG_CONFIG_HOME)/zsh/_rustup
	rustup component add rust-analyzer
	ln -s $(shell rustup which --toolchain stable rust-analyzer) $(HOME)/.cargo/bin/rust-analyzer

clean: clean.brew clean.nvim clean.symlinks clean.rust

clean.brew:
	curl -fsSL '$(BREW_SCRIPTS_URL)/uninstall.sh' > uninstall.sh
	/bin/bash uninstall.sh

clean.nvim:
	rm -rf $(PAQ_PATH)

clean.symlinks:
	rm $(HOME)/.vimrc
	rm $(HOME)/.zshenv

clean.rust:
	rm $(XDG_CONFIG_HOME)/zsh/_rustup
	rm $(XDG_CONFIG_HOME)/zsh/_cargo
