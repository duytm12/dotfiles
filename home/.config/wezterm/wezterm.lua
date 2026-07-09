local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

local act = wezterm.action
config.keys = {
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
