function fish_prompt
    set -l status_color (test $status -eq 0 && set_color green || set_color red)
    set -l grey (set_color grey)

    # Start with colon and end with semicolon for safe copy-pasting
    echo -ns -- \
        $grey ': ' \
        (prompt_pwd) \
        $grey $_delta \
        $status_color ' ; ' \
        (set_color normal)
end
