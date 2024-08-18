-- Additional lua modules are located under ~/.config/wezterm/
local wezterm = require 'wezterm';
local appearance = require 'appearance'
local keys = require 'keys'

local config = wezterm.config_builder()


appearance.apply_to_config(config)
keys.apply_to_config(config)


return config
