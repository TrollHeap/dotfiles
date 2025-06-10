local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Set the path to your background image
--config.window_background_image = './background/gruvbox_background.jpg'

-- Adjust the hue, saturation, and brightness of the background image
config.window_background_image_hsb = {
    brightness = 0.3, -- Darken the image
    hue = 1.0,        -- Leave hue unchanged
    saturation = 1.0, -- Leave saturation unchanged
}

-- Set the color scheme
-- config.color_scheme = "Tokyo Night"
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = 'GruvboxDarkHard'
--config.color_scheme = "Gruvbox Material (Gogh)"
config.window_background_opacity = 0.96
config.window_decorations = "RESIZE"
-- Disable the tab bar
config.enable_tab_bar = true

-- Configure the font with a fallback option
config.font = wezterm.font_with_fallback({
    --{ family = 'JetBrains Mono',   scale = 0.95 },
    --{ family = 'FiraCode Nerd Font', scale = 1.25 },
    --{ family = 'Hack Nerd Font',   scale = 1.25 },
    { family = 'GeistMono Nerd Font', scale = 0.95 },
    { family = "Symbols Nerd Font" }
})

-- === Clipboard / OSC52 / tmux interop ===
config.enable_wayland = true
config.term = "xterm-256color"
-- config.enable_kitty_keyboard = true
-- config.enable_csi_u_key_encoding = true



-- Return the configuration
return config
