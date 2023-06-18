fpath=($fpath $ZDOTDIR);           # Same path for config and functions
autoload -Uz compinit; compinit    # "New" completion system
autoload -U promptinit; promptinit # Enable prompt themes
prompt savq                        # Set prompt

## ALIASES

alias brew-tree='brew deps --graph --installed'
alias fd='find . -path ./.git -prune -o -iname'
alias l='ls -1A'
alias ll='ls -AFlh'
alias mkdir='mkdir -p'
alias rm='rm -v'
alias vi='echo "Don'\''t use vi. Use e instead."' # See below

alias -s git='git clone --depth=1'
alias ga='git add --update --verbose'
alias gb='git branch --verbose --verbose'
alias gc='git commit --verbose'
alias gd='git difftool'
# alias ge='git checkout'
# alias gf='git diff'
alias gg='git log --all --graph --oneline'
alias gr='git remote --verbose'
alias gs='git status --branch --short .'
alias gt='git difftool --staged'
# alias gw='git pull'
# alias gz='git switch'

alias jl='julia --project --startup-file=no --quiet'
alias pluto='jl -e "import Pluto; Pluto.run(;auto_reload_from_file=true)"'

alias js='deno --quiet'
alias serve='file_server'

alias -s ipynb='python3 -m jupyter notebook'
alias pip='python3 -m pip'
alias py='python3 -q'
alias venv='python3 -m venv'

# alias rsb='cargo build'
alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias lmkc='latexmk -c'
alias lmkl='latexmk -lualatex'
alias lmkx='latexmk -xelatex'
alias tw='typst watch'


## ENVIRONMENT

export LANG='en_US.UTF-8'
export LC_ALL=$LANG
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxEfEdBxGxCxDx'

export TEXDIR="$HOME/.latex"

PATH="$HOME/.latex/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.deno/bin:$PATH"


## VISUAL EDITOR

if type nvim > /dev/null 2>&1; then
  export VISUAL='nvim'
  export MANPAGER='nvim +Man!'
  function e { nvim --server "$NVIM" --remote-silent $@ } # Prevent nested nvim
else
  export VISUAL='vim'
  export MANPAGER='vim +MANPAGER --not-a-term -'
  alias e=$VISUAL
fi


## OPTIONS

# bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

setopt auto_cd
setopt interactivecomments
setopt no_case_glob
setopt noclobber
setopt prompt_subst
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove blanks from history items
setopt share_history        # Same history for all open terminals

# Case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

## Functions
autoload tell

## Plugins
source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
