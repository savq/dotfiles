CONFIG_HOME ?= $(HOME)/.config
FISH_COMPL ?= $(CONFIG_HOME)/fish/completions

install:\
	brew\
	fish\
	ghostty\
	nvim\
	rust\
	tree-sitter\
	macos


brew: Brewfile.lock.json
Brewfile.lock.json: Brewfile .brew_install.sh
	brew bundle install --cleanup --no-upgrade --file "$<"

.brew_install.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@
	type brew || /bin/bash '.brew_install.sh' && eval "$$(/opt/homebrew/bin/brew shellenv)"

.PHONY: brew-check brew-graph
brew-check:
	brew bundle check --verbose

brew-graph:
	brew deps --graph --installed


.PHONY: fish
fish:
	fish\
		-c 'set -U __fish_git_prompt_color grey'\
		-c 'set -U __fish_git_prompt_color_branch bryellow'\
		-c 'set -U __fish_git_prompt_color_merging yellow'\
		-c 'set -U __fish_git_prompt_showcolorhints 1'\
		-c 'set -U __fish_git_prompt_showdirtystate 1'\
		-c 'set -U fish_color_command --bold' \
		-c 'set -U fish_color_comment grey' \
		-c 'set -U fish_color_param normal' \
		-c 'set -U fish_color_quote brblue'\
		-c 'set -U fish_greeting'

$(FISH_COMPL):
	mkdir -pv $@


MELANGE_URL = https://raw.githubusercontent.com/savq/melange-nvim/refs/heads/master/term

ghostty: ghostty/themes/melange_dark ghostty/themes/melange_light

ghostty/themes/melange_dark:
	curl --create-dirs  --output $@ "$(MELANGE_URL)/ghostty/melange_dark"

ghostty/themes/melange_light:
	curl --create-dirs --output $@ "$(MELANGE_URL)/ghostty/melange_light"


PAQ_DIR = "$(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim"

.PHONY: nvim
nvim: $(HOME)/.editorconfig $(HOME)/.vimrc nvim/after/plugin/paq.lua
	[ -d $(PAQ_DIR) ] || git clone --depth=1 'https://github.com/savq/paq-nvim.git' $(PAQ_DIR)
	nvim --headless -c 'lua _paq_bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(CONFIG_HOME)/nvim/init.vim $@

$(HOME)/.editorconfig:
	ln -fhs $(CONFIG_HOME)/.editorconfig $@


rust: brew $(FISH_COMPL)/rustup.fish
	rustup update stable
	rustup component add rust-analyzer

$(FISH_COMPL)/rustup.fish: $(FISH_COMPL)
	rustup completions fish rustup > $@


tree-sitter: $(FISH_COMPL)/tree-sitter.fish
$(FISH_COMPL)/tree-sitter.fish: $(FISH_COMPL)
	tree-sitter complete --shell fish > $@


macos:
	./macos.sh
