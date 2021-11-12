fpath=($fpath $ZDOTDIR)            # same path for config and functions
autoload -Uz compinit; compinit    # `new' completion system
autoload -U promptinit; promptinit # enable prompt themes
prompt savq                        # set prompt

# EDITOR - Neovim
if type nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias wi='nvim -c "WikiIndex" -c "lua zen.toggle()"'
  export VISUAL='nvim'
  export EDITOR=$VISUAL
  export MANPAGER='nvim +Man!'
  export MANWIDTH=999
fi

# ALIASES

alias l='ls -1AH'
alias ll='ls -AlF'
alias mkdir='mkdir -p'
alias rm='rm -v'
alias sym='ln -s'
# alias tex='tectonic'

alias gad='git add --verbose'
alias gbr='git branch --verbose'
alias gcm='git commit --verbose'
alias gco='git checkout'
alias gcl='git clone --depth=1'
alias gdf='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias glg='git log  --graph --oneline'
alias gpl='git pull'
# alias gsh='git push'
alias gst='git status --branch --short .'
alias gwt='git worktree'

alias cc='clang'
alias ino='arduino-cli'
alias fth='gforth'

alias jl='julia --startup-file=no --quiet'
alias pluto='julia --quiet -e "using Pluto; Pluto.run()"'

alias py='python3 -q'
alias pip='pip3'
alias pyvenv='python3 -m venv'
alias serve='python3 -m http.server'

alias rsb='cargo build'
alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias lmk= 'latexmk'
alias lmkc='latexmk -c'
alias lmkx='latexmk -xelatex'
alias lmkl='latexmk -lualatex'


# PATH

export TEXDIR="$HOME/.latex"
PATH="$PATH:$TEXDIR/bin"

PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.luarocks/bin"

export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"


# OPTIONS

bindkey -e
bindkey '^[[A' history-beginning-search-backward 
bindkey '^[[B' history-beginning-search-forward
export CLICOLOR=1
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LSCOLORS='gxfxcxdxbxEfEdBxGxCxDx'
setopt auto_cd
setopt interactivecomments
setopt no_case_glob
setopt noclobber
setopt prompt_subst
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove blanks from history items
setopt share_history        # Same history for all open terminals

 # case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'


# APPEARANCE
function theme() {
    # themes are defined  in separate files, so renaming the import in
    # `alacritty.yml` changes the current theme.

    # Check if theme should change to light or dark
    local bgcolor ;
    [[ $1 = '-l' ]] && bgcolor='light' || bgcolor='dark'

    # Replace second line in-place
    sed -E -i '' \
        -e "2s/melange_(dark|light)/melange_$bgcolor/g" \
        "$HOME/.config/alacritty/alacritty.yml"
}

# Automatically set theme based on current system settings. This command fails
# if light mode is active, so we check the exit code instead of the output lmao.
defaults read -g AppleInterfaceStyle &>/dev/null && theme || theme -l


# Zsh plugins
# source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
ZSH_HIGHLIGHT_STYLES[comment]=none

# tab multiplexer configuration: https://github.com/austinjones/tab-rs/
source "/Users/savq/Library/Application Support/tab/completion/zsh-history.zsh"
# end tab configuration
