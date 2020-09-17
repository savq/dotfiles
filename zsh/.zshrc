fpath=($fpath $ZDOTDIR) # Same directory for user defined config and functions
autoload -Uz compinit; compinit    # `New' completion system
autoload -U promptinit; promptinit # Enable prompt themes
prompt savq # my own prompt

# LOCALE
export LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

# COLOR
export CLICOLOR=1 LSCOLORS="gxfxcxdxbxEfEdBxGxCxDx" # BSD ls colors

# Check if syntax highlighting is installed
#[[ -a "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# OPTIONS
bindkey -v #Enable vi-mode
setopt auto_cd
setopt no_case_glob
setopt prompt_subst # For prompt theme

# HISTORY
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove blanks from history items
setopt share_history        # Same history for all open terminals
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward 


# COMPLETION
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' format '%d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # this doesn't work with BSD colors >:[
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# References for the `new' completion system
# man zshcompsys
# User's guide Ch. 6: <http://zsh.sourceforge.net/Guide/zshguide06.html#l144>


# EDITOR - Neovim
if type nvim > /dev/null 2>&1; then
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR="$VISUAL"
  export MANPAGER='nvim +Man!' # :help Man
  export MANWIDTH=999
fi

# ALIASES
alias l='ls -1A'
alias ll='ls -AlF'
alias rm='rm -v'

alias arduino='arduino-cli'
alias cc='clang'
alias jl='julia' pluto="julia -e 'using Pluto; Pluto.run(8000)'"
alias lua='luajit'
alias py='python3' pip='pip3' pyvenv='python3 -m venv'
alias serve='file_server'   # Deno file server

alias gcm='git commit --verbose'
alias gdd='git add'
alias gdf='git diff'
alias glg='git log'
alias gpl='git pull'
alias gsh='git push'
alias gst='git status'

# PATH
export PATH="$HOME/.cargo/bin:$HOME/.deno/bin:$PATH"

# LLVM (homebrew installed version)
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Android Debug Bridge (for LineageOS)
#if [ -d "$HOME/lineage_os/platform-tools" ] ; then
# export PATH="$HOME/lineage_os/platform-tools:$PATH"
#fi

# TODO update this after redoing templates
# export PATH="$HOME/.tex:$PATH" 

