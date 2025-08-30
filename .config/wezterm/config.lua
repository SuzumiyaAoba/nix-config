local wezterm = require "wezterm"

local keybind = require "keybinds"

return {
  font = wezterm.font_with_fallback {
    -- "Monaspace Radon",
    -- "Monospace Xenon",
    -- "Monospace Krypton",
    -- "Monospace Neon",
    -- "Monaspace Argon",
    -- "0xProto",
    -- "Explex",
    -- "Explex Console",
    "Cascadia Next JP",
    "Cascadia Code NF",
    -- "HackGen Console NF"
  },
  font_size = 14,

  -- default_prog = { "zellij" },

  color_scheme = "Gruvbox dark, hard (base16)",
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

