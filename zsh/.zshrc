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
alias tex='tectonic'

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
alias gst='git status --branch --short'
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

# Appearance
function theme() {
    # Change the current Alacritty colorscheme by defining the colorschemes in
    # separate files and renaming the imports in `alacritty.yml` when this function is called.
    [[ $1 = '-l' ]] && bg='light' || bg='dark'
    sed -E -i '' -e "s/melange_(dark|light)/melange_$bg/g" "$HOME/.config/alacritty/alacritty.yml"
}

# [ `date +'%H'` -ge 17 ] && theme || theme -l


# Zsh plugins
source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_STYLES[comment]=none

# tab multiplexer configuration: https://github.com/austinjones/tab-rs/
source "/Users/savq/Library/Application Support/tab/completion/zsh-history.zsh"
# end tab configuration
