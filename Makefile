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

.PHONY: fish nvim

brew: Brewfile.lock.json
Brewfile.lock.json: Brewfile .brew_install.sh
	brew bundle install --cleanup --no-upgrade --file "$<"

.brew_install.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@
	type brew || /bin/bash '.brew_install.sh'


fish:
	mkdir -pv $(FISH_COMPL)
	fish\
		-c 'set -U fish_greeting'\
		-c 'set -U fish_color_command green'\
		-c 'set -U fish_color_comment white'\
		-c 'set -U fish_color_param'\
		-c 'set -U fish_color_quote blue'\
		-c 'set -U __fish_git_prompt_showcolorhints 1'\
		-c 'set -U __fish_git_prompt_showdirtystate 1'\
		-c 'set -U __fish_git_prompt_color grey'\
		-c 'set -U __fish_git_prompt_color_branch bryellow'\
		-c 'set -U __fish_git_prompt_color_merging yellow'\
		-c 'fish_add_path -U ~/.cargo/bin'\
		-c 'fish_add_path -U ~/.deno/bin'\
		-c 'fish_add_path -U /usr/local/opt/node@22/bin' # Add node LTS to path manually


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


$(FISH_COMPL)/tree-sitter.fish:
	tree-sitter complete --shell fish > $@
