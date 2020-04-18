fpath=($fpath $ZDOTDIR) # Same directory for user defined config and functions
autoload -Uz compinit; compinit
autoload -U promptinit; promptinit
prompt savq

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

# LOCALE
export LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

# Syntax highlighting plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# OPTIONS
bindkey -v #Enable vi-mode
setopt autocd
setopt nocaseglob
setopt correct
setopt prompt_subst

# COMPLETION
setopt complete_in_word
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'\
        'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:match:*' original only
# Errors allowed by _approximate increase with the length of what's typed
# <https://grml.org/zsh/zsh-lovers.html>
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# HISTORY
setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove blanks from history items
setopt share_history        # Same history for all open terminals
HISTSIZE=1000
SAVEHIST=1000
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward 

# EDITOR
# If available, use neovim instead of vim
if type nvim > /dev/null 2>&1; then
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR="$VISUAL"
fi

# ALIASES
alias rm="rm -v"
alias l="ls -AlF"

alias cc="clang"
alias python="python3"
alias pip="pip3"

alias zathura="zathura --fork"
alias -s txt="vi" \
         md="vi"  \
         tex="vi" \
         sty="vi" \
         lua="vi" \
         py="vi"  \
         rs="vi"  \
         rkt="vi" \
         js="vi"  \
         html="vi"\
         pdf="zathura"

# COLORS
# a: black; b: red; c: green; d:yellow; e: blue; f: magenta; g:cyan; x: default
#   , Color            , File
# ex, blue             , directories
# fx, magenta          , symlinks
# cx, green            , sockets
# dx, yellow           , pipes
# bx, red              , executables
# Ef, bold blue/magenta, block special
# Ed, bold blue/yellow , char special
# Bx, bold red         , ex with setuid bit set
# Gx, bold cyan        , ex with setgid bit set
# Cx, bold green       , dir writable to others with sticky
# Dx, bold yellow      , dir writable to others without sticky
export CLICOLOR=1 LSCOLORS="exfxcxdxbxEfEdBxGxCxDx"
#"exfxcxdxbx eg ed ab ag ac ad"

path+="$HOME/.latex" # LaTeX utilites: savargasqu/latex-templates
#source $ZDOTDIR/adb.sh
#source $ZDOTDIR/conda.sh

