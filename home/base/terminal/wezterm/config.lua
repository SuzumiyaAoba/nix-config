local wezterm = require "wezterm"

local keybind = require "keybinds"

return {
  font = wezterm.font("HackGen Console NF"),
  font_size = 18,

  default_prog = { "zellij" },

  color_scheme = "Gruvbox dark, hard (base16)",
  window_background_opacity = 1,

  enable_tab_bar = false,

  disable_default_key_bindings = true,
  keys = keybind.keys,
}

