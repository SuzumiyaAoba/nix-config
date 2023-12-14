local wezterm = require "wezterm"

return {
  font = wezterm.font("HackGen Console NF"),
  font_size = 16,

  default_prog = { "zellij" },

  color_scheme = "Gruvbox dark, hard (base16)",
  window_background_opacity = 1,

  enable_tab_bar = false,
}

