local wezterm = require 'wezterm';
local projects = require 'projects'

local module = {}


local function append_key_bindings(config, new_keys)
  for _, key_config in ipairs(new_keys) do
    table.insert(config.keys, key_config)
  end
end


local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end


local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 }
  }
end


local function config_settings_keys(config)
  local new_keys = {
    -- cmd + , opens this config file
    {
      key = ',',
      mods = 'SUPER',
      action = wezterm.action.SpawnCommandInNewTab {
        cwd = wezterm.home_dir,
        args = { 'vim', wezterm.config_file },
      },
    },
    -- activate copy mode or vim mode
    {
      key = 'Enter',
      mods = 'LEADER',
      action = wezterm.action.ActivateCopyMode
    },
  }
  append_key_bindings(config, new_keys)
end


local function config_cursor_movement_keys(config)
  local new_keys = {
    -- opt + left/right arrow : move cursor to left/right word
    { key = 'LeftArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bb' },
    { key = 'RightArrow', mods = 'OPT', action = wezterm.action.SendString '\x1bf' },
  }
  append_key_bindings(config, new_keys)
end


local function config_pane_control_keys(config)
  local new_keys = {
    -- split pane horizontally or vertically
    {
      key = '%',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '"',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    -- move around
    move_pane('j', 'Down'),
    move_pane('k', 'Up'),
    move_pane('h', 'Left'),
    move_pane('l', 'Right'),
    -- resize panes
    {
      key = 'r',
      mods = 'LEADER',
      action = wezterm.action.ActivateKeyTable {
        name = 'resize_panes',
        one_shot = false,
        timeout_milliseconds = 1000,
      }
    },
    -- rotate panes
    {
      key = "Space",
      mods = "LEADER",
      action = wezterm.action.RotatePanes "Clockwise"
    },
    -- show the pane selection mode, but have it swap the active and selected panes
    {
      key = '0',
      mods = 'LEADER',
      action = wezterm.action.PaneSelect {
        mode = 'SwapWithActive',
      },
    },
  }
  append_key_bindings(config, new_keys)
end


local function config_project_keys(config)
  local new_keys = {
    {
      key = 'p',
      mods = 'LEADER',
      action = projects.choose_project(),
    },
    {
      key = 'f',
      mods = 'LEADER',
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
  }
  append_key_bindings(config, new_keys)
end


function module.apply_to_config(config)
  config.leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {}
  config.key_tables = {
    resize_panes = {
      resize_pane('j', 'Down'),
      resize_pane('k', 'Up'),
      resize_pane('h', 'Left'),
      resize_pane('l', 'Right'),
    },
  }
  config_settings_keys(config)
  config_cursor_movement_keys(config)
  config_pane_control_keys(config)
  config_project_keys(config)
end


return module

