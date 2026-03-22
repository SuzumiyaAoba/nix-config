local wezterm = require "wezterm"

local keybind = require "keybinds"

return {
  font = wezterm.font_with_fallback {
    "UDEV Gothic",
    "Symbols Nerd Font Mono",
  },
  font_size = 14,
  allow_square_glyphs_to_overflow_width = "Never",

  -- default_prog = { "zellij" },

  color_scheme = "Catppuccin Macchiato",
  window_background_opacity = 1,

  enable_tab_bar = false,

  audible_bell = "Disabled",

  disable_default_key_bindings = true,
  keys = keybind.keys,

  -- see: https://github.com/wez/wezterm/issues/6005
  front_end = "WebGpu",

  window_close_confirmation = 'NeverPrompt',
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
}
