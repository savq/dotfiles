XDG_CONFIG_HOME ?= $(HOME)/.config
ZDOTDIR = $(XDG_CONFIG_HOME)/zsh

install: \
	homebrew \
	wezterm \
	zsh \
	rust \
	nvim


BREW_SCRIPT = .brew_install.sh

homebrew: Brewfile.lock.json

$(BREW_SCRIPT):
	curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' > $@

Brewfile.lock.json: Brewfile $(BREW_SCRIPT)
	type brew || /bin/bash $(BREW_SCRIPT)
	brew bundle --file $(XDG_CONFIG_HOME)/Brewfile



WEZTERMINFO = wezterm/wezterm.terminfo

wezterm: $(WEZTERMINFO) $(ZDOTDIR)/_wezterm
	tic -x -o ~/.terminfo $<

$(WEZTERMINFO):
	curl 'https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo' > $@

$(ZDOTDIR)/_wezterm:
	wezterm shell-completion --shell zsh > $@


zsh: $(HOME)/.zshenv
$(HOME)/.zshenv:
	ln -s $(ZDOTDIR)/.zshenv $@



rust: $(HOME)/.cargo/bin/rust-analyzer $(ZDOTDIR)/_cargo $(ZDOTDIR)/_rustup

$(HOME)/.cargo/bin/rust-analyzer:
	rustup component add rust-analyzer
	ln -fhs $$(rustup which --toolchain stable rust-analyzer) $@

$(ZDOTDIR)/_cargo:
	rustup completions zsh cargo > $@

$(ZDOTDIR)/_rustup:
	rustup completions zsh rustup > $@



nvim: nvim/lua/plugins.lua $(HOME)/.vimrc
	# nvim handles cloning Paq
	nvim --headless -u NONE -c 'lua require("plugins").bootstrap()'

$(HOME)/.vimrc:
	ln -fhs $(XDG_CONFIG_HOME)/nvim/vimrc $@

$(HOME)/.editorconfig:
	ln -fhs $(XDG_CONFIG_HOME)/nvim/.editorconfig $@
