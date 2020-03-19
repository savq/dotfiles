autoload -U compinit; compinit
autoload -U promptinit; promptinit

#ANTIBODY (Plugin manager)
  source <(antibody init)
  antibody bundle < $ZDOTDIR/plugins.txt

#OPTIONS
  bindkey -v #Enable vi-mode
  setopt autocd
  setopt nocaseglob
  setopt correct

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
  #See <https://stackoverflow.com/questions/9689104/>
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8

#EDITOR
  # If available, use neovim instead of vim
  if type nvim > /dev/null 2>&1; then
      alias vim="nvim"
      export VISUAL="nvim"
      export EDITOR="$VISUAL"
  fi

#ALIASES
  alias l="ls -al"

#SUFFIX ALIASES. Use to open files without typing vim
  alias -s txt="vim "
  alias -s md="vim "
  alias -s tex="vim "
  alias -s sty="vim "
  alias -s py="vim "
  alias -s js="vim "
  alias -s rs="vim "
  alias -s hs="vim "
  alias -s rkt="vim "
  alias -s lua="vim "

# COLORS
  # a: black; b: red; c: green; d:yellow; e: blue; f: magenta; g:cyan; h: grey
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

#PROMPT SETTINGS
  zstyle :prompt:pure:path color blue
  zstyle :prompt:pure:prompt:success color blue
  PURE_PROMPT_SYMBOL='>'
  PURE_PROMPT_VICMD_SYMBOL='<'
  #prompt pure

source $ZDOTDIR/adb.sh
source $ZDOTDIR/conda.sh

