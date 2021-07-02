fpath=($fpath $ZDOTDIR)            # same path for config and functions
autoload -Uz compinit; compinit    # `new' completion system
autoload -U promptinit; promptinit # enable prompt themes
prompt savq                        # set prompt


# EDITOR - Neovim

if type nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias wi='nvim -c "WikiIndex" -c "lua savq.toggle_zen()"'
  export VISUAL='nvim'
  export EDITOR=$VISUAL
  export MANPAGER='nvim +Man!'
  export MANWIDTH=999
fi


# ALIASES

alias l='ls -1A'
alias ll='ls -AlF'
alias rm='rm -v'
alias sym='ln -s'

alias gad='git add'
alias gcm='git commit --verbose'
alias gco='git checkout'
alias gcl='git clone --depth=1'
alias gdf='git diff'
alias gdt='git difftool'
alias glg='git log  --graph --oneline'
alias gpl='git pull'
alias gsh='git push'
alias gst='git status --branch --short'
alias gwt='git worktree'

alias cc='clang'
alias ino='arduino-cli'

alias jl='julia -q'
alias pluto='julia -q -e "using Pluto; Pluto.run()"'

alias py='python3 -q'
alias pip='pip3'
alias pyvenv='python3 -m venv'
alias serve='python3 -m http.server'

alias rsb='cargo build'
alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias lmk='latexmk'
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


# UTILITIES

# tab multiplexer configuration: https://github.com/austinjones/tab-rs/
source "/Users/savq/Library/Application Support/tab/completion/zsh-history.zsh"
# end tab configuration

# Check if syntax highlighting is installed
#[[ -a '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]] &&
source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'


# OPTIONS

setopt noclobber
setopt auto_cd
setopt no_case_glob
setopt prompt_subst
setopt interactivecomments
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxEfEdBxGxCxDx'

setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove blanks from history items
setopt share_history        # Same history for all open terminals
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[A' history-beginning-search-backward 


# COMPLETION

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # doesn't work with BSD colors :(
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# References for the `new' completion system:
# - man zshcompsys
# - User's guide Ch. 6: http://zsh.sourceforge.net/Guide/zshguide06.html#l144
