CONFIG_HOME ?= $(HOME)/.config
FISH_COMPL ?= $(CONFIG_HOME)/fish/completions

install:\
	brew\
	fish\
	julia\
	nvim\
	rust\
	tree-sitter\
	ghostty

.PHONY: fish nvim brew-check

brew: Brewfile.lock.json
Brewfile.lock.json: Brewfile .brew_install.sh
	brew bundle install --cleanup --no-upgrade --file "$<"

.brew_install.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@
	type brew || /bin/bash '.brew_install.sh'

brew-check:
	brew bundle check --verbose

fish:
	mkdir -pv $(FISH_COMPL)
	fish -c 'set fish_greeting' \
		-c 'set fish_color_command --bold' \
		-c 'set fish_color_param normal' \
		-c 'set fish_color_quote brblue'

PAQ_DIR = "$(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim"

nvim: $(HOME)/.editorconfig $(HOME)/.vimrc nvim/lua/plugins.lua
	[ -d $(PAQ_DIR) ] || git clone --depth=1 'https://github.com/savq/paq-nvim.git' $(PAQ_DIR)
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(CONFIG_HOME)/nvim/vimrc $@

$(HOME)/.editorconfig:
	ln -fhs $(CONFIG_HOME)/.editorconfig $@


julia: $(FISH_COMPL)/juliaup.fish
	juliaup add release

$(FISH_COMPL)/juliaup.fish:
	juliaup completions fish > $@


rust: rustup-init $(FISH_COMPL)/rustup.fish
	rustup update stable

rustup-init:
	rustup-init -y

$(FISH_COMPL)/rustup.fish:
	rustup completions fish rustup > $@


MELANGE_URL = https://raw.githubusercontent.com/savq/melange-nvim/refs/heads/master/term

ghostty: ghostty/themes/melange_dark ghostty/themes/melange_light

ghostty/themes/melange_dark:
	curl --create-dirs "$(MELANGE_URL)/ghostty/melange_dark" > $@

ghostty/themes/melange_light:
	curl --create-dirs "$(MELANGE_URL)/ghostty/melange_light" > $@


tree-sitter: $(FISH_COMPL)/tree-sitter.fish
$(FISH_COMPL)/tree-sitter.fish:
	tree-sitter complete --shell fish > $@
