# TODO: refactor

DOTFILEDIR = $(HOME)/.config
PAQPATH = $(HOME)/.local/share/nvim/site/pack/paqs

.PHONY: install brew nvim symlinks \
	clean clean.brew clean.nvim. clean.symlinks

install: brew nvim symlinks

# # TODO: Check nix 2.4 works with MacOS 12
# nix: 
# 	curl -L https://nixos.org/nix/install | sh
# 	nix-env -iA nixpkgs.savqPackages

brew:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/master/install.sh' > install.sh
	/bin/bash install.sh
	brew bundle --file $(DOTFILEDIR)/Brewfile
	rm install.sh

nvim:
	git clone https://github.com/savq/paq-nvim.git $(PAQPATH)/start/paq-nvim

symlinks:
	ln -s $(DOTFILEDIR)/nvim/vimrc   $(HOME)/.vimrc
	ln -s $(DOTFILEDIR)/zsh/.zshenv  $(HOME)/.zshenv


clean: clean.brew clean.nvim clean.symlinks

clean.brew:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh' > uninstall.sh
	/bin/bash uninstall.sh
	rm uninstall.sh

clean.nvim:
	rm -rf $(PAQPATH)

clean.symlinks:
	rm -rf $(HOME)/.vimrc
	rm -rf $(HOME)/.zshenv
