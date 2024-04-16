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

function _gclone; echo git clone --depth=1 $argv; end
abbr -a auto_clone --position command --regex ".+\.git" --function _gclone # "suffix" alias

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

abbr -a brew-tree 'brew deps --graph --installed'


fish_add_path ~/.cargo/bin
fish_add_path ~/.deno/bin
fish_add_path /usr/local/opt/node@20/bin # Add node-lts to path manually


set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL "$LANG"

set -gx CLICOLOR 1
set -gx LSCOLORS 'gxfxcxdxbxEfEdBxGxCxDx'

set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_color 'grey'
set __fish_git_prompt_color_branch 'bryellow'
set __fish_git_prompt_color_merging 'yellow'


if type nvim &> /dev/null
    set -gx VISUAL nvim
    set -gx MANPAGER "nvim +Man!"
    function e -d "Edit"
        nvim --server $NVIM --remote-silent $argv # Prevent nested nvim
    end
else
    set -gx VISUAL vim
    alias e="$VISUAL"
end


function fd -d "Simpler find"
    find -E '.' -path '.*/.git' -prune -o -iregex ".*$argv.*" -print
end


## notify after long commands

alias say_fast='say --rate=300'

function _set_start_time --on-event fish_preexec
    set -g _start_time (date +'%s')
end

function _notify_long_cmd --on-event fish_postexec
    set -l laststatus $status
    set -l _interactive_cmds e nvim man gc gd gt
    set -l dt (math $(date +'%s') - $_start_time)

    if [ "$dt" -ge 10 ] && not contains (string split ' ' $argv)[1] $_interactive_cmds
        if [ "$laststatus" -eq 0 ]
            say_fast 'Done.' $argv
        else
            say_fast 'Failed.' $laststatus $argv
        end
        set -g _delta ' ['$dt's]' # used in prompt
    else
        set -g _delta ''
    end
end
