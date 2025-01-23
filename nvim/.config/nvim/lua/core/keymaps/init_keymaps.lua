-- Init keymaps for both config and plugins
local config_keymaps = require 'core.keymaps.config_keymaps'
local plugins_keymaps = require 'core.keymaps.plugins_keymaps'

-- Setup keymaps
config_keymaps.setup()
plugins_keymaps.setup()
