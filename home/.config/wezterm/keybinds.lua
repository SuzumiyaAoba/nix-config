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
    -- Keep the Zellij-style Ctrl-t prefix.
    {
      key = 't',
      mods = 'CTRL',
      action = act.ActivateKeyTable {
        name = 'tmux',
        one_shot = false,
      },
    },
  },

  key_tables = {
    tmux = {
      { key = 'g', mods = 'CTRL', action = act.PopKeyTable },
      { key = 'Escape', action = act.PopKeyTable },
      {
        key = '-',
        action = act.SplitPane {
          direction = 'Down',
          size = { Percent = 50 },
        },
      },
      {
        key = '\\',
        action = act.SplitPane {
          direction = 'Right',
          size = { Percent = 50 },
        },
      },
      { key = 'h', action = act.ActivatePaneDirection 'Left' },
      { key = 'j', action = act.ActivatePaneDirection 'Down' },
      { key = 'k', action = act.ActivatePaneDirection 'Up' },
      { key = 'l', action = act.ActivatePaneDirection 'Right' },
      { key = 'o', action = act.ActivatePaneDirection 'Next' },
      { key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
      { key = 'n', action = act.ActivateTabRelative(1) },
      { key = 'p', action = act.ActivateTabRelative(-1) },
      { key = 'x', action = act.CloseCurrentPane { confirm = false } },
      {
        key = 'Space',
        action = act.ActivateKeyTable {
          name = 'pane',
          one_shot = false,
        },
      },
      {
        key = 'm',
        action = act.ActivateKeyTable {
          name = 'move',
          one_shot = false,
        },
      },
      {
        key = 'r',
        action = act.ActivateKeyTable {
          name = 'resize',
          one_shot = false,
        },
      },
      {
        key = 's',
        action = act.ActivateKeyTable {
          name = 'scroll',
          one_shot = false,
        },
      },
      { key = 's', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    },

    pane = {
      {
        key = 'g',
        mods = 'CTRL',
        action = act.Multiple { act.PopKeyTable, act.PopKeyTable },
      },
      { key = 'Escape', action = act.PopKeyTable },
      { key = 'F', action = act.TogglePaneZoomState },
      { key = 'f', action = act.PaneSelect },
      { key = 'Space', action = act.PaneSelect { mode = 'MoveToNewWindow' } },
    },

    move = {
      {
        key = 'g',
        mods = 'CTRL',
        action = act.Multiple { act.PopKeyTable, act.PopKeyTable },
      },
      { key = 'Escape', action = act.PopKeyTable },
      {
        key = 'r',
        action = act.Multiple {
          act.PopKeyTable,
          act.ActivateKeyTable {
            name = 'resize',
            one_shot = false,
          },
        },
      },
      { key = 'n', action = act.RotatePanes 'Clockwise' },
      { key = 'p', action = act.RotatePanes 'CounterClockwise' },
      { key = 'h', action = act.PaneSelect { mode = 'SwapWithActive' } },
      { key = 'j', action = act.PaneSelect { mode = 'SwapWithActive' } },
      { key = 'k', action = act.PaneSelect { mode = 'SwapWithActive' } },
      { key = 'l', action = act.PaneSelect { mode = 'SwapWithActive' } },
    },

    resize = {
      {
        key = 'g',
        mods = 'CTRL',
        action = act.Multiple { act.PopKeyTable, act.PopKeyTable },
      },
      { key = 'Escape', action = act.PopKeyTable },
      {
        key = 'm',
        action = act.Multiple {
          act.PopKeyTable,
          act.ActivateKeyTable {
            name = 'move',
            one_shot = false,
          },
        },
      },
      { key = 'h', action = act.AdjustPaneSize { 'Left', 3 } },
      { key = 'j', action = act.AdjustPaneSize { 'Down', 3 } },
      { key = 'k', action = act.AdjustPaneSize { 'Up', 3 } },
      { key = 'l', action = act.AdjustPaneSize { 'Right', 3 } },
      { key = 'H', action = act.AdjustPaneSize { 'Right', 3 } },
      { key = 'J', action = act.AdjustPaneSize { 'Up', 3 } },
      { key = 'K', action = act.AdjustPaneSize { 'Down', 3 } },
      { key = 'L', action = act.AdjustPaneSize { 'Left', 3 } },
    },

    scroll = {
      {
        key = 'g',
        mods = 'CTRL',
        action = act.Multiple { act.PopKeyTable, act.PopKeyTable },
      },
      { key = 'Escape', action = act.PopKeyTable },
      { key = '/', action = act.Search 'CurrentSelectionOrEmptyString' },
      { key = 'j', action = act.ScrollByLine(1) },
      { key = 'k', action = act.ScrollByLine(-1) },
      { key = 'f', mods = 'CTRL', action = act.ScrollByPage(1) },
      { key = 'b', mods = 'CTRL', action = act.ScrollByPage(-1) },
    },
  }
}
