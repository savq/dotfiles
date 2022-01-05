fpath=($fpath $ZDOTDIR);           # Same path for config and functions
autoload -Uz compinit; compinit    # "New" completion system
autoload -U promptinit; promptinit # Enable prompt themes
prompt savq                        # Set prompt

## EDITOR - Neovim
if type nvim > /dev/null 2>&1
then
  function vi {
    # When calling vi in a :terminal, open a buffer instead of a nested instance
    nvim --server "$NVIM" --remote-silent $@
  }
  alias wi='nvim -c "WikiIndex" -c "lua focus_toggle()"'
  export VISUAL='nvim'
  export EDITOR=$VISUAL
  export MANPAGER='nvim +Man!'
  export MANWIDTH=999
else
  echo "nvim not found. Use $(which vi)"
fi

## ALIASES

alias brew-tree='brew deps --graph --installed'
alias fd='find . -path ./.git -prune -o -iname'
alias l='ls -1A'
alias ll='ls -AFlh'
alias mkdir='mkdir -p'
alias rm='rm -v'
alias sym='ln -s'

alias -s git='git clone --depth=1'
alias ga='git add --update --verbose'
alias gb='git branch --verbose --verbose'
alias gc='git commit --verbose'
alias gd='git difftool'
alias ge='git checkout'
alias gf='git diff'
alias gg='git log --all --graph --oneline'
alias gr='git remote --verbose'
alias gs='git status --branch --short .'
alias gt='git difftool --staged'
alias gw='git pull'

alias cc='clang'
alias ino='arduino-cli'

alias jl='julia --project --startup-file=no --quiet'
alias pluto='jl -e "import Pluto; Pluto.run(;auto_reload_from_file=true)"'

alias js='deno'
alias serve='file_server'

alias pip='pip3'
alias py='python3 -q'
alias venv='python3 -m venv'
alias nb='jupyter notebook'

alias rsb='cargo build'
alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias lmk='latexmk'
alias lmkc='latexmk -c'
alias lmkl='latexmk -lualatex'
alias lmkx='latexmk -xelatex'
# alias tex='tectonic'


## PATH

export TEXDIR="$HOME/.latex"
PATH="$PATH:$TEXDIR/bin"

PATH="$PATH:$HOME/.cargo/bin"
source "$HOME/.cargo/env"

PATH="$PATH:$HOME/.deno/bin"

export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"


## OPTIONS

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

## Case insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'


## Notify when a command is done
function tell {
  local exit_code=$?;
  # If there are no arguments say the result of the previous command.
  if [ $# -eq 0 ]
  then
    [ $exit_code -eq 0 ] && say "Done." || say "Failed. $exit_code."
  else
    time "$@" && say "Done. $@ ." || say "Failed. $?. $@ ."
  fi
}


## Change Neovim's appereance
function theme {
  # Check if theme should change to light or dark
  local BGCOLOR;
  [ "$1" = '-l' ] && BGCOLOR='light' || BGCOLOR='dark';

  # If there's an nvim instance open, change the background
  [ -n "$NVIM" ] && nvim --server "$NVIM" --remote-send "<cmd>set bg=$BGCOLOR<cr>"
  return 0
}


## Zsh plugins
source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
ZSH_HIGHLIGHT_STYLES[comment]=fg=white ;
