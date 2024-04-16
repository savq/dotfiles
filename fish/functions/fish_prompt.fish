function fish_prompt
    set -l laststatus $status

    # Start with colon and end with semicolon for safe copy-pasting
    string join '' -- \
        (set_color grey) ': ' \
        (prompt_pwd) \
        (set_color grey) $_delta \
        (test "$laststatus" -eq 0 && set_color green || set_color red) ' ; '
end
