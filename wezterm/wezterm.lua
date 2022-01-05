local wez = require 'wezterm'

-- Color based on system (for some reason the command fails for light mode)
local _, _, exitcode = os.execute 'defaults read -g AppleInterfaceStyle'

-- FIXME
local bg = '#2A2520'
local overbg = '#352F2A'
local active   = { bg_color = bg, fg_color = '#ECE1D7' }
local inactive = { bg_color = overbg, fg_color = '#A38D78' }
local hover    = { bg_color = overbg, fg_color = '#C1A78E' }

return {
    color_scheme = exitcode == 0 and 'melange_dark' or 'melange_light',
    font = wez.font 'IBM Plex Mono',
    font_size = 14,
    force_reverse_video_cursor = true,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = 'RESIZE',

    colors = {
        tab_bar = {
            background = overbg,
            active_tab = active,
            inactive_tab = inactive,
            new_tab = inactive,
            inactive_tab_hover = hover,
            new_tab_hover = hover,
        },
    },
}
