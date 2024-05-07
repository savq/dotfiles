local wez = require 'wezterm'

local appearance = wez.gui.get_appearance() -- 'Dark' or 'Light'

local melange = appearance == 'Light' and {
    bg = '#F1F1F1',
    fg = '#54433A',
    float = '#E9E1DB',
} or {
    bg = '#2A2520',
    fg = '#ECE1D7',
    float = '#34302C',
}

local typeface = 'JuliaMono'

return {
    color_scheme = 'melange' .. appearance,
    colors = {
        tab_bar = { -- Fancy tab bar cannot be styled with TOML. See wez/wezterm#2615
            active_tab = { bg_color = melange.bg, fg_color = melange.fg },
            inactive_tab = { bg_color = melange.float, fg_color = melange.fg },
            new_tab = { bg_color = melange.float, fg_color = melange.fg },
            inactive_tab_edge = melange.fg,
        },
    },
    force_reverse_video_cursor = true, -- Fix cursor colors in nvim

    font = wez.font(typeface),

    font_rules = { -- Use a lighter weight for italicized text (but not for bold italics)
        {
            italic = true,
            intensity = 'Bold',
            font = wez.font(typeface, { weight = 'Bold', italic = true }),
        },
        {
            italic = true,
            font = wez.font(typeface, { weight = 'Light', italic = true }),
        },
    },
    harfbuzz_features = {
        'calt=0', -- Disable contextual ligatures
        'zero', -- Enable slashed zero
    },
    line_height = 1.2,

    window_decorations = 'INTEGRATED_BUTTONS',

    window_frame = {
        font = wez.font 'IBM Plex Sans',
        active_titlebar_bg = melange.float,
    },

    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    term = 'wezterm',
}
