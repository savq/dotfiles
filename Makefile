CONFIG_HOME ?= $(HOME)/.config
FISH_COMPL ?= $(CONFIG_HOME)/fish/completions

install:\
	brew\
	julia\
	nvim\
	rust\
	wezterm


brew: Brewfile.lock.json
Brewfile.lock.json: .brew_install.sh Brewfile
	type brew || /bin/bash '.brew_install.sh'
	brew bundle install --cleanup --no-upgrade --file 'Brewfile'

.brew_install.sh:
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@


WEZTERMINFO = wezterm/wezterm.terminfo

wezterm: $(WEZTERMINFO) $(FISH_COMPL)/wezterm.fish
	tic -x -o ~/.terminfo $<

$(WEZTERMINFO):
	curl 'https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo' > $@

$(FISH_COMPL)/wezterm.fish:
	wezterm shell-completion --shell fish > $@


PAQ_DIR = "$(HOME)/.local/share/nvim/site/pack/paqs/start/paq-nvim"

nvim: $(HOME)/.editorconfig $(HOME)/.vimrc nvim/lua/plugins.lua
	[ -d $(PAQ_DIR) ] || git clone --depth=1 'https://github.com/savq/paq-nvim.git' $(PAQ_DIR)
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(CONFIG_HOME)/nvim/vimrc $@

$(HOME)/.editorconfig:
	ln -fhs $(CONFIG_HOME)/.editorconfig $@


julia:
	juliaup add release


rust: $(HOME)/.cargo/bin/rust-analyzer $(FISH_COMPL)/rustup.fish
	rustup update

$(HOME)/.cargo/bin/rust-analyzer:
	rustup component add rust-analyzer
	ln -fhs $$(rustup which --toolchain stable rust-analyzer) $@

$(FISH_COMPL)/rustup.fish:
	rustup completions fish rustup > $@
