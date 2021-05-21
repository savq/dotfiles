local wez = require 'wezterm'

-- Set colors based in time of day
local h = tonumber(os.date('%H'))
if 9 <= h and h < 17 then
    color_scheme = 'melange_light'
else
    color_scheme = 'melange_dark'
end

return {
    color_scheme = color_scheme;

    font = wez.font('IBM Plex Mono');
    font_size = 16;

    window_decorations = "RESIZE";
    hide_tab_bar_if_only_one_tab = true;
}
