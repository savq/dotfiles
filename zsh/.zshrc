fpath=($fpath $ZDOTDIR) # Same directory for user defined config. and functions
autoload -Uz compinit; compinit    # `New' completion system
autoload -U promptinit; promptinit # Enable prompt themes
prompt savq # my own prompt

# LOCALE
export LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

# COLOR
export CLICOLOR=1 LSCOLORS="exfxcxdxbxEfEdBxGxCxDx" # man ls explains the string
# Check if syntax highlighting is installed
[[ -a "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
  source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# OPTIONS
bindkey -v #Enable vi-mode
setopt auto_cd
setopt no_case_glob
setopt correct      # If you mistype a command, Zsh suggests a correction
setopt prompt_subst # For prompt theme

# COMPLETION
setopt complete_in_word
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'\
        'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' completer _expand _complete #_correct #_approximate
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
# If available, use Neovim instead of Vim
if type nvim > /dev/null 2>&1; then
  alias vi="nvim"
  export VISUAL="nvim"
  export EDITOR="$VISUAL"
fi

# ALIASES
alias rm="rm -v"  # List all deleted files
alias l="ls -AlF"
alias cc="clang"  # Make doesn't care about aliases. This is just for me
alias python="python3" pip="pip3"
alias zathura="zathura --fork"
# Prefix aliases
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


# PATH

# My LaTeX utilities: savargasqu/latex-templates
export PATH="$HOME/.tex:$PATH" 

# Cargo (for Rust)
export PATH="$HOME/.cargo/bin:$PATH" 

# Android Debug Bridge (for LineageOS)
#if [ -d "$HOME/lineage_os/platform-tools" ] ; then
# export PATH="$HOME/lineage_os/platform-tools:$PATH"
#fi

# Conda package manager
# NOTE: Conda slows down start up quite a bit,
#       so its best to keep it in a separate file
#       and call it when necessary.
#source $ZDOTDIR/conda.sh

