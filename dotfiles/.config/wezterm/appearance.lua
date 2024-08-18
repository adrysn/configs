local wezterm = require 'wezterm';

local module = {}


local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end


local function config_screen(config)
  config.color_scheme = 'Solarized Dark Higher Contrast'
  config.window_background_opacity = 0.9
  config.macos_window_background_blur = 3
end


local function config_fonts(config)
  config.font = wezterm.font_with_fallback({
      'JetBrains Mono',
      'Menlo',
      'Apple SD 산돌고딕 Neo',
      'AppleGothic',
  })
  config.font_size = 12.3
  config.window_frame = {
    font = wezterm.font({ family = 'Berkeley Mono', weight = 'Bold' }),
    font_size = 11,
  }
end


local function config_upper_right_bar(config)

  -- wezterm.on('update-status', function(window)
  --   local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  --   local color_scheme = window:effective_config().resolved_palette
  --   local bg = color_scheme.background
  --   local fg = color_scheme.foreground
  --   window:set_right_status(wezterm.format({
  --     -- first, we draw the arrow...
  --     { Background = { Color = 'none' } },
  --     { Foreground = { Color = bg } },
  --     { Text = SOLID_LEFT_ARROW },
  --     -- then we draw our text
  --     { Background = { Color = bg } },
  --     { Foreground = { Color = fg } },
  --     { Text = ' ' .. wezterm.hostname() .. ' ' },
  --   }))
  -- end)

  wezterm.on('update-status', function(window, _)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local segments = segments_for_right_status(window)

    local color_scheme = window:effective_config().resolved_palette
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local gradient_to, gradient_from = bg
    gradient_from = gradient_to:lighten(0.2)

    local gradient = wezterm.color.gradient(
      {
        orientation = 'Horizontal',
        colors = { gradient_from, gradient_to },
      },
      #segments
    )

    local elements = {}

    for i, seg in ipairs(segments) do
      local is_first = i == 1

      if is_first then
        table.insert(elements, { Background = { Color = 'none' } })
      end
      table.insert(elements, { Foreground = { Color = gradient[i] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })

      table.insert(elements, { Foreground = { Color = fg } })
      table.insert(elements, { Background = { Color = gradient[i] } })
      table.insert(elements, { Text = ' ' .. seg .. ' ' })
    end

    window:set_right_status(wezterm.format(elements))
  end)
end


function module.apply_to_config(config)
  config_screen(config)
  config_fonts(config)
  config_upper_right_bar(config)
end


return module

