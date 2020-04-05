autoload -U compinit; compinit
autoload -U promptinit; promptinit
autoload -Uz vcs_info # automatically retrieve version control information

#RUST
export PATH="$HOME/.cargo/bin:$PATH"

#Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#PROMPT WITH GIT SUPPORT
# TODO:
# - Show Vi-mode
# - Define nice characters for %u, %c etc
#     (Spaceship and Typewritten seem to have nice defaults)
PROMPT='%F{blue}%1~%f ' #Current directory in blue
PROMPT+='%F{magenta}${vcs_info_msg_0_}%f' #Git info in magenta
PROMPT+='%(?.%F{green}>%f.%F{red}>%f) ' # Exit code in green (0) or red (not 0)
RPROMPT='%D{%Y-%m-%d T %H:%M}' #ISO 8601

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' actionformats "[%b|%a]%u%c "
zstyle ':vcs_info:git:*' formats "%b%u%c "
precmd () { vcs_info }

#OPTIONS
bindkey -v #Enable vi-mode
setopt autocd
setopt nocaseglob
setopt correct
setopt prompt_subst

#COMPLETION
setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'l:|=* r:|=*'

#HISTORY
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove blanks from history items
# Search for entries that match what's currently typed, with arrow keys.
bindkey "^[[A" history-beginning-search-backward 
bindkey "^[[B" history-beginning-search-forward

#LOCALE
# See <https://stackoverflow.com/questions/9689104/>
export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8

#EDITOR
# If available, use neovim instead of vim
if type nvim > /dev/null 2>&1; then
  alias vi="nvim"
  alias vim="nvim"
  export VISUAL="nvim"
  export EDITOR="$VISUAL"
fi

#ALIASES
alias rm="rm -v"
alias l="ls -Al"
alias zathura="zathura --fork"

#SUFFIX ALIASES. Use to open files without typing vim
alias -s txt="vim "
alias -s md="vim "
alias -s tex="vim "
alias -s sty="vim "
alias -s lua="vim "
alias -s py="vim "
alias -s rs="vim "
alias -s rkt="vim "
alias -s js="vim "
alias -s html="vim "

#COLORS
# a: black; b: red; c: green; d:yellow; e: blue; f: magenta; g:cyan
# x: default foreground or background. Capital letter makes it bold.
#Code, color         , file
# ex , blue          , directories
# fx , magenta       , symlinks
# cx , green         , sockets
# dx , yellow        , pipes
# bx , red           , executables
# eg , blue on cyan  , block special
# ed , blue on yellow, char special
# Bx , bold red      , ex with setuid bit set
# Gx , bold cyan     , ex with sitgid bit set
# Cx , bold green    , dir writable to others with sticky
# Dx , bold yellow   , dir writable to others without sticky
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedBxGxCxDx"

# My LaTeX utilites savargasqu/latex-templates
path+="$HOME/.latex"

#source $ZDOTDIR/adb.sh
#source $ZDOTDIR/conda.sh

