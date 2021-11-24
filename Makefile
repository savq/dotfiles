XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
PAQ_PATH = $(XDG_DATA_HOME)/nvim/site/pack/paqs
BREW_SCRIPTS_URL = https://raw.githubusercontent.com/Homebrew/install/HEAD

.PHONY: install brew nvim symlinks \
	clean clean.brew clean.nvim clean.symlinks

install: brew nvim symlinks

brew:
	curl -fsSL '$(BREW_SCRIPTS_URL)/install.sh' > install.sh
	/bin/bash install.sh
	brew bundle --file $(XDG_CONFIG_HOME)/Brewfile

nvim:
	git clone https://github.com/savq/paq-nvim.git \
		$(PAQ_PATH)/start/paq-nvim

symlinks:
	ln -s $(XDG_CONFIG_HOME)/nvim/vimrc   $(HOME)/.vimrc
	ln -s $(XDG_CONFIG_HOME)/zsh/.zshenv  $(HOME)/.zshenv


clean: clean.brew clean.nvim clean.symlinks

clean.brew:
	curl -fsSL '$(BREW_SCRIPTS_URL)/uninstall.sh' > uninstall.sh
	/bin/bash uninstall.sh

clean.nvim:
	rm -rf $(PAQ_PATH)

clean.symlinks:
	rm $(HOME)/.vimrc
	rm $(HOME)/.zshenv