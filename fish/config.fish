alias l='ls -1A'
alias ll='ls -AFlh'
alias mv='mv -nv'
alias rm='trash -v'
alias todo='rg -i "fixme|note|todo"'

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

alias _gclone='echo git clone --depth=1'
abbr -a auto_clone --position command --regex '.+\.git' --function _gclone # suffix alias

alias jl='julia --project --startup-file=no --quiet'
alias pluto='jl -e "import Pluto; Pluto.run(;auto_reload_from_file=true)"'

alias js='deno --quiet'

alias py='python3 -q'
alias pip='python3 -m pip'
alias venv='python3 -m venv'
alias ipynb='python3 -m jupyter notebook'
alias serve='python3 -m http.server'

alias rsc='cargo check'
alias rsd='cargo doc --open'
alias rsr='cargo run'
alias rst='cargo test'

alias typc='typst compile --'
alias typw='typst watch --open --'

abbr -a brew-tree 'brew deps --graph --installed'
abbr -a fd-empty 'find "." -type f -empty'
abbr -a rm-dsstore 'find "." -name ".DS_Store" -type f -print -delete'

set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL $LANG
set -gx CLICOLOR 1
set -gx LSCOLORS 'gxfxcxdxbxEfEdBxGxCxDx'
set -gx LS_COLORS $LSCOLORS

if type nvim &> /dev/null
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
    function e -d 'Edit'
        nvim --server $NVIM --remote-silent $argv # Prevent nested nvim
    end
else
    set -gx VISUAL vim
    alias e=$VISUAL
end


function mkd -d 'mkdir and cd'
    mkdir -p $argv; and cd $argv
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

function notify
    printf '\e]9;%s\e\\' $argv # OSC 9
    say --rate=250 $argv
end

## notify after long commands

function _set_start_time --on-event fish_preexec
    set -g _start_time (date +'%s')
end

function _notify_long_cmd --on-event fish_postexec
    set -l laststatus $status
    set -l dt (math (date +'%s') - $_start_time)

    if [ "$dt" -ge 10 ] &&
        set cmd (string split ' ' $argv)[1]
        if not functions -q $cmd
            if [ "$laststatus" -eq 0 ]
                notify "Done. $argv"
            else
                notify "Failed. $argv"
            end
            set -g _delta ' ['$dt's]' # used in prompt
        end
    else
        set -g _delta ''
    end
end
