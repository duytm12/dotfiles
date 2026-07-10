local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- tab bar: top position, fancy style, Catppuccin Mocha colors
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false  -- flat style so colors apply cleanly
config.tab_max_width = 32
config.colors = {
  tab_bar = {
    background = "#181825",       -- mantle: tab bar background
    active_tab = {
      bg_color = "#b4befe",       -- lavender: active tab
      fg_color = "#1e1e2e",       -- base: text on active tab
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#313244",       -- surface0: inactive tab
      fg_color = "#a6adc8",       -- subtext0: dimmed text
    },
    inactive_tab_hover = {
      bg_color = "#45475a",       -- surface1: hover
      fg_color = "#cdd6f4",       -- text: full brightness on hover
    },
    new_tab = {
      bg_color = "#181825",       -- mantle: matches bar background
      fg_color = "#a6adc8",       -- subtext0
    },
    new_tab_hover = {
      bg_color = "#313244",       -- surface0
      fg_color = "#cdd6f4",       -- text
    },
  },
}

-- make inactive panes fade back so the focused one pops
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

local act = wezterm.action
config.keys = {
  -- Shift+Enter inserts a newline in CLI prompts instead of submitting.
  -- Terminals normally send \r for Enter regardless of Shift; this sends \n instead.
  { key = "Enter", mods = "SHIFT", action = act.SendString("\n") },

  -- split panes
  { key = "RightArrow", mods = "CTRL|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } }, -- new pane to the right
  { key = "DownArrow",  mods = "CTRL|SHIFT", action = act.SplitVertical   { domain = "CurrentPaneDomain" } }, -- new pane below

  -- close the current pane only
  { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane { confirm = true } },

  -- move between panes (cycle next / previous)
  { key = "Tab", mods = "CTRL",       action = act.ActivatePaneDirection "Next" },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection "Prev" },
}

return config
