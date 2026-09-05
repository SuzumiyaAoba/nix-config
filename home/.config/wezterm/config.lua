local wezterm = require "wezterm"

local keybind = require "keybinds"

wezterm.on("update-status", function(window, _)
  local key_table = window:active_key_table()
  window:set_right_status(key_table and ("MODE: " .. key_table) or "")
end)

return {
  font = wezterm.font_with_fallback {
    "UDEV Gothic",
    "Symbols Nerd Font Mono",
  },
  font_size = 14,
  allow_square_glyphs_to_overflow_width = "Never",

  default_prog = { "zellij" },

  color_scheme = "Catppuccin Macchiato",
  window_background_opacity = 1,

  -- Zellij owns tabs/panes now; let its zjstatus bar be the only tab bar.
  enable_tab_bar = false,

  audible_bell = "Disabled",

  disable_default_key_bindings = true,
  keys = keybind.keys,
  key_tables = keybind.key_tables,

  -- NOTE: previously forced to "WebGpu" as a workaround for
  -- https://github.com/wez/wezterm/issues/6005 (texture corruption on an
  -- old nixpkgs-packaged build). Claude Code / Codex's heavy TUI repaints
  -- were triggering silent WebGpu/Metal crashes (no panic logged before
  -- the process died), so falling back to the upstream default "OpenGL".
  window_close_confirmation = 'NeverPrompt',
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
}
