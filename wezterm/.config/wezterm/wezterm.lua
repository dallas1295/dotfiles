local wezterm = require("wezterm")

return {
  -- Terminal backend
  -- enable_wayland = false,
  term = "wezterm",

  -- Appearance
  color_scheme = "Kanagawa Dragon (Gogh)",
  colors = {
    -- background = "#000000",
  },

  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
    "Symbols Nerd Font",
    "Noto Color Emoji",
  }),
  font_size = 13.0,
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBlock",
  hide_mouse_cursor_when_typing = true,

  -- Tab bar
  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,

  -- Default shell
  default_prog = { "zsh" },

  -- Mouse bindings
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
    },
  },

  -- Key bindings
  keys = {
    -- Reload config (Ctrl+Shift+R)
    {
      key = "r",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ReloadConfiguration,
    },
  },
}
