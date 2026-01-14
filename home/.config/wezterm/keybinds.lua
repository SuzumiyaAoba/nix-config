local wezterm = require 'wezterm'
local act = wezterm.action

return {
  keys = {
    { key = 'Enter', mods = 'SUPER', action = act.ToggleFullScreen },
    { key = '=', mods = 'SUPER', action = act.ResetFontSize },
    { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
    -- for Emacs
    { key = "/", mods = "CTRL", action = wezterm.action.SendString '\x1f' },
  }
}
