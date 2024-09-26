CONFIG_HOME ?= $(HOME)/.config
DATA_HOME ?= $(HOME)/.local/share
FISH_COMPL ?= $(CONFIG_HOME)/fish/completions

install: \
	homebrew \
	brew \
	wezterm \
	rust \
	nvim


BREW_SCRIPT = .brew_install.sh

$(BREW_SCRIPT):
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@

homebrew: $(BREW_SCRIPT)
	type brew || /bin/bash $<

brew: Brewfile.lock.json
Brewfile.lock.json: Brewfile
	brew bundle install --cleanup --no-upgrade --file $<



WEZTERMINFO = wezterm/wezterm.terminfo

wezterm: $(WEZTERMINFO) $(FISH_COMPL)/wezterm.fish
	tic -x -o ~/.terminfo $<

$(WEZTERMINFO):
	curl 'https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo' > $@

$(FISH_COMPL)/wezterm.fish:
	wezterm shell-completion --shell fish > $@



rust: $(HOME)/.cargo/bin/rust-analyzer $(FISH_COMPL)/rustup.fish

$(HOME)/.cargo/bin/rust-analyzer:
	rustup component add rust-analyzer
	ln -fhs $$(rustup which --toolchain stable rust-analyzer) $@

$(FISH_COMPL)/rustup.fish:
	rustup completions fish rustup > $@



PAQ_DIR = "$(DATA_HOME)/nvim/site/pack/paqs/start/paq-nvim"

nvim: nvim/lua/plugins.lua $(HOME)/.vimrc
	[ -d $(PAQ_DIR) ] || git clone --depth=1 'https://github.com/savq/paq-nvim.git' $(PAQ_DIR)
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(CONFIG_HOME)/nvim/vimrc $@

$(HOME)/.editorconfig:
	ln -fhs $(CONFIG_HOME)/.editorconfig $@
