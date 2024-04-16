alias l='ls -1A'
alias ll='ls -AFlh'
alias mkdir='mkdir -p'
alias rm='rm -v'

alias ga='git add --update --verbose'
alias gb='git branch --verbose --verbose'
alias gc='git commit --verbose'
alias gd='git difftool'
alias ge='git restore'
# alias gf='git diff'
alias gg='git log --all --graph --oneline'
alias gr='git remote --verbose'
alias gs='git status --branch --short .'
alias gt='git difftool --staged'
alias gz='git switch'

alias -s git='git clone --depth=1'

alias jl='julia --project --startup-file=no --quiet'
alias pluto='julia -e "import Pluto; Pluto.run(;auto_reload_from_file=true)"'

alias js='deno --quiet'
alias serve='file_server'
alias npm='pnpm'
alias npx='pnpx'

alias py='python3 -q'
alias pip='python3 -m pip'
alias venv='python3 -m venv'
alias ipynb='python3 -m jupyter notebook'

alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias typc='typst compile --'
alias typw='typst watch --open --'

alias brew-tree='brew deps --graph --installed'


PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.deno/bin:$PATH"
PATH="/usr/local/opt/node@20/bin:$PATH" # Add node-lts to path manually


export LANG='en_US.UTF-8'
export LC_ALL=$LANG

export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxEfEdBxGxCxDx'


if type nvim > /dev/null 2>&1; then
    export VISUAL='nvim'
    export MANPAGER='nvim +Man!'
    function e { nvim --server "$NVIM" --remote-silent $@ } # Prevent nested nvim
else
    export VISUAL='vim'
    alias e=$VISUAL
fi


## Simpler `find`
function fd {
    find -E '.' -path "./.git" -prune -o -iregex ".*/$1.*"
}


## notify after long commands
function t {
    local exit_code=$?

    # If there are no arguments say the result of the previous command.
    if [ $# -eq 0 ]; then
        [ $exit_code -eq 0 ] && say -- "Done." || say -- "Failed. $exit_code."
    else
        # date '+%H:%M'
        time "$@" && say -- "Done. $@ ." || say -- "Failed. $?. $@."
    fi

    return $?
}


## Options

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

fpath=($fpath $ZDOTDIR)

## Completion
autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

## Prompt
autoload -Uz promptinit; promptinit
prompt savq
