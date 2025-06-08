local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

local colors = theme.colors()
colors.background = "#000000"

return {
  term = "wezterm",
  -- Appearance
  colors = colors,
  window_frame = theme.window_frame(),
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "Symbols Nerd Font",
    "Noto Color Emoji",
  }),
  font_size = 13.0,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBlock",
  hide_mouse_cursor_when_typing = true,
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  default_prog = { "zsh" },

  -- Copy from mouse selection
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
    },
  },

  -- Only keep non-multiplexing keybindings
  keys = {
    -- Reload config (Ctrl+Shift+r)
    {
      key = "r",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ReloadConfiguration,
    },
  },
}
