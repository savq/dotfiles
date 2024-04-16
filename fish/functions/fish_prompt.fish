function fish_prompt
    set -l laststatus $status

    set -l dt (
        [ "$_delta" -ge "$_threshold" ];
        and string join '' -- ' [' $_delta 's] ';
        or echo ' '
    )

    set -l status_color (
        [ "$laststatus" -eq 0 ];
        and set_color green;
        or set_color red
    )

    # Start with colon and end with semicolon for safe copy-pasting
    string join '' -- \
        (set_color grey) ': ' \
        (prompt_pwd) \
        (fish_git_prompt) \
        (set_color grey) $dt \
        $status_color '; '
end
