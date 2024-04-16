XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share
ZDOTDIR = $(XDG_CONFIG_HOME)/zsh
FISHCOMP ?= $(XDG_CONFIG_HOME)/fish/completions

install: \
	homebrew \
	brew \
	wezterm \
	zsh \
	rust \
	nvim


BREW_SCRIPT = .brew_install.sh

$(BREW_SCRIPT):
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@

homebrew: $(BREW_SCRIPT)
	type brew || /bin/bash $(BREW_SCRIPT)

brew: Brewfile.lock.json
Brewfile.lock.json: Brewfile
	brew bundle install --cleanup --no-upgrade --file $(XDG_CONFIG_HOME)/Brewfile



WEZTERMINFO = wezterm/wezterm.terminfo

wezterm: $(WEZTERMINFO) $(FISHCOMP)/wezterm.fish $(ZDOTDIR)/_wezterm
	tic -x -o ~/.terminfo $<

$(WEZTERMINFO):
	curl 'https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo' > $@

$(FISHCOMP)/wezterm.fish:
	wezterm shell-completion --shell fish > $@

$(ZDOTDIR)/_wezterm:
	wezterm shell-completion --shell zsh > $@


zsh: $(HOME)/.zshenv
$(HOME)/.zshenv:
	ln -fhs $(ZDOTDIR)/.zshenv $@



rust: $(HOME)/.cargo/bin/rust-analyzer  $(FISHCOMP)/rustup.fish $(ZDOTDIR)/_cargo $(ZDOTDIR)/_rustup

$(HOME)/.cargo/bin/rust-analyzer:
	rustup component add rust-analyzer
	ln -fhs $$(rustup which --toolchain stable rust-analyzer) $@

$(FISHCOMP)/rustup.fish:
	rustup completions fish rustup > $@

$(ZDOTDIR)/_cargo:
	rustup completions zsh cargo > $@

$(ZDOTDIR)/_rustup:
	rustup completions zsh rustup > $@


PAQ_DIR = "$(XDG_DATA_HOME)/nvim/site/pack/paqs/start/paq-nvim"

nvim: nvim/lua/plugins.lua $(HOME)/.vimrc
	[ -d $(PAQ_DIR) ] || git clone --depth=1 'https://github.com/savq/paq-nvim.git' $(PAQ_DIR)
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(XDG_CONFIG_HOME)/nvim/vimrc $@

$(HOME)/.editorconfig:
	ln -fhs $(XDG_CONFIG_HOME)/.editorconfig $@
